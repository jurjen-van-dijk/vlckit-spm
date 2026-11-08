// swift-tools-version: 5.7
//
//  Package.swift
//  MediaDesk
//
//  Created by Jurjen van Dijk & Codex on 14/01/2023.
//  Copyright © 2026 From Beyond. All rights reserved.
//
// Adapted from tylerjonesio/vlckit-spm at e932bbd under LGPL-2.1.
// See LICENSE for the retained upstream license.

import PackageDescription

let package = Package(
    name: "vlckit-spm",
    platforms: [.macOS("26.5")],
    products: [.library(name: "VLCKitSPM", targets: ["VLCKitSPM"])],
    targets: [
        .binaryTarget(
            name: "VLCKit",
            url: "https://github.com/jurjen-van-dijk/vlckit-spm/releases/download/3.6.0-autosave.1/VLCKit-macos-arm64-3.6.0-autosave.1.xcframework.zip",
            checksum: "89687e3ce1afd9956d3e53d09c940c4fb08484796aaf4a7d10d20c0da471b65f"
        ),
        .target(
            name: "VLCKitSPM",
            dependencies: [.target(name: "VLCKit")],
            linkerSettings: [.linkedFramework("Foundation"), .linkedLibrary("iconv")]
        )
    ]
)
