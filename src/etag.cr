require "./etag/*"

{% if flag?(:without_openssl) %}
  require "digest/sha1"
{% else %}
  require "base64"
  require "openssl/sha1"
{% end %}

module Etag
  extend self

  private EMPTY_ENTITY_ETAG = self.etag("", force: true)

  # Generate tag based on file stat
  #
  # ```
  # Etag.etag File.lstat("./README.md")
  # # => "\"a19-582e0568"\"
  #
  # # or weak
  #
  # Etag.etag File.lstat("./README.md", weak: true)
  # # => "W/\"a19-582e0568"\"
  # ```
  def etag(stat : File::Stat, *, weak = false) : String
    mtime_hex = stat.mtime.epoch.to_s(16)
    size_hex = stat.size.to_s(16)

    "#{weak ? "W/" : ""}\"#{size_hex}-#{mtime_hex}\""
  end

  # Generate tag based on file entity
  #
  # ```
  # Etag.etag File.read("./README.md")
  # # => "\"a19-UDMQYeZ+VMk+2Fv11x6Mu/JkktE\""
  #
  # # or weak
  #
  # Etag.etag File.read("./README.md")
  # # => "W/\"a19-UDMQYeZ+VMk+2Fv11x6Mu/JkktE\""
  # ```
  def etag(entity : String, *, weak = false, force = false) : String
    if entity.size == 0 && !force
      return "#{weak ? "W/" : ""}#{EMPTY_ENTITY_ETAG}"
    end

    hash = sha1(entity)
    hash = hash.gsub(/=+$/, "")

    len_hex = entity.size.to_s(16)

    "#{weak ? "W/" : ""}\"#{len_hex}-#{hash}\""
  end

  private def sha1(str : String) : String
    {% if flag?(:without_openssl) %}
      Digest::SHA1.base64digest(str)
    {% else %}
      Base64.strict_encode(OpenSSL::SHA1.hash(str))
    {% end %}
  end
end
