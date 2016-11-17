# Etag

[![Linux Build][travis-image]][travis-url]
[![Shards version][shards-image]][shards-url]


Library to generate HTTP ETags (*RFC 7232*).


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  etag:
    github: SuperPaintman/etag
```


--------------------------------------------------------------------------------

## Usage

```crystal
require "etag"

# === Based on file stat ===
Etag.etag File.lstat("./README.md")
# => "\"a19-582e0568"\"

# or weak

Etag.etag File.lstat("./README.md", weak: true)
# => "W/\"a19-582e0568"\"

# === Based on file entity ===
Etag.etag File.read("./README.md")
# => "\"a19-UDMQYeZ+VMk+2Fv11x6Mu/JkktE\""

# or weak

Etag.etag File.read("./README.md")
# => "W/\"a19-UDMQYeZ+VMk+2Fv11x6Mu/JkktE\""
```


or with including:

```crystal
require "etag"
include Etag

etag File.read("./README.md")
# => "W/\"a19-UDMQYeZ+VMk+2Fv11x6Mu/JkktE\""

# ...
```


--------------------------------------------------------------------------------

## Test

```sh
crystal spec
```


--------------------------------------------------------------------------------

## Contributing

1. Fork it (<https://github.com/SuperPaintman/etag/fork>)
2. Create your feature branch (`git checkout -b feature/<feature_name>`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin feature/<feature_name>`)
5. Create a new Pull Request


--------------------------------------------------------------------------------

## Contributors

- [SuperPaintman](https://github.com/SuperPaintman) SuperPaintman - creator, maintainer


--------------------------------------------------------------------------------

## API
[Docs][docs-url]


--------------------------------------------------------------------------------

## Changelog
[Changelog][changelog-url]


--------------------------------------------------------------------------------

## License

[MIT][license-url]


[license-url]: LICENSE
[changelog-url]: CHANGELOG.md
[docs-url]: https://superpaintman.github.io/etag/
[travis-image]: https://img.shields.io/travis/SuperPaintman/etag/master.svg?label=linux
[travis-url]: https://travis-ci.org/SuperPaintman/etag
[shards-image]: https://img.shields.io/github/tag/superpaintman/etag.svg?label=shards
[shards-url]: https://github.com/superpaintman/etag

