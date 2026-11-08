# VLCKit autosave correction for macOS

This package adapts [tylerjonesio/vlckit-spm](https://github.com/tylerjonesio/vlckit-spm) revision `e932bbd488872fdb74f6654d28c2f291eae03daf`. The `VLCKitSPM` library product and exported `VLCKit` module are preserved. This distribution supports **macOS 26.5 and later on arm64 only**. It provides no Intel, iOS or tvOS slices.

The binary is VLCKit 3.6.0 (`c73b779f`) with VLC `dd8bfdba`, all 49 existing VLCKit patches, and an additional backport of upstream VLC commits `b282e134` and `fd2a9dfd`. The correction makes the configuration dirty flag atomic and removes the recursive outer autosave read lock. It preserves setter updates and retries reported save errors. Official zlib `4bd9a71` and libpng `893b811` compatibility patches permit the existing source versions to build with the selected toolchain.

## Release contents

`PROVENANCE.json` identifies the binary and source archives by SHA-256. The source archive supplies the actual tracked VLCKit and patched VLC source trees, the reviewed extra patches and current recipes, retained contrib source tarballs and license notices, and Autoconf 2.71. Exact make/ninja wrappers and their tool-selection/environment records are included under `build-records/`; `BUILD-ENVIRONMENT.md` explains the host tools and path setup. Historical build records describe the build that produced the binary; they contain original local paths and are evidence, not portable build scripts. Debug symbols also retain build paths.

The source tree layout is `VLCKit/` and `VLC/`. The latter corresponds to `VLCKit/libvlc/vlc` in the upstream build layout. The existing upstream `buildMobileVLCKit.sh` drove the native build with `-x -a aarch64 -n -v`, disabled GPL/GNUv3 contrib components, pinned Autoconf 2.71 and Xcode's Python 3.9.6, and used four jobs. After native compilation, a separate Xcode 27.2 archive used `ARCHS=arm64`, `MACOSX_DEPLOYMENT_TARGET=26.5`, an explicit DerivedData path and developer signing disabled. `xcodebuild -create-xcframework` included the matching framework and dSYM. This is a provenance record, not a claim of bit-for-bit reproducible rebuilding.

The original upstream `generate.sh`, which downloads the uncorrected combined platform archive, is intentionally absent. A replacement release must use a new version and asset URL; never replace an existing release asset. GitHub release immutability must be enabled before publication. SwiftPM additionally verifies the checksum in `Package.swift`.

## Validation and signing

The controlled native regression reproduced the original lock problem and passed nine fixed cases. Eight selected app playback/lifecycle cases passed against this native payload across two isolated runs (six plus two), with normal app embedding/signing. These selected results do not establish full application CI success or prove the exact cause of any stackless CI timeout.

The distributed framework retains its original linker signature. The consuming application must perform ordinary framework embedding and signing; the package does not bypass library validation or replace the consumer's signing configuration.

## License

The original package license is retained in `LICENSE` (GNU LGPL 2.1). VLCKit/VLC and bundled components retain their own copyright notices and license texts in the source archive. This repository contains open-source dependency material only, not MediaDesk application source.
