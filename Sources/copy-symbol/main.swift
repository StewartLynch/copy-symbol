#!/usr/bin/env swift
//
//  copy-symbol.swift
//  Created by Ortwin Gentz on 08.09.25.
//

// Usage: ./copy-symbol <sf-symbol-name> [-size N]
// Example: ./copy-symbol heart.fill -size 256

import Foundation
import AppKit

@available(macOS 11.0, *)
func main() {
	let args = CommandLine.arguments
	guard args.count >= 2 else {
		fputs("Usage: \(args[0]) <sf-symbol-name> [-size N]\n", stderr)
		exit(2)
	}
	
	let symbolName = args[1]
	
	// Default maximum dimension (in pixels)
	var maxDim: Int = 100
	
	// Parse optional -size flag
	if args.count >= 4, args[2] == "-size", let n = Int(args[3]), n > 0 {
		maxDim = n
	}
	
	guard let baseImage = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil) else {
		fputs("Error: couldn’t create SF Symbol image for '\(symbolName)'.\n", stderr)
		exit(3)
	}
	
	// Compute scaled pixel size preserving aspect ratio
	let origSize = baseImage.size
	let scale = min(CGFloat(maxDim) / origSize.width,
					CGFloat(maxDim) / origSize.height)
	let finalWidth = Int(round(origSize.width * scale))
	let finalHeight = Int(round(origSize.height * scale))
	
	// Create bitmap with exact pixel dimensions
	guard let rep = NSBitmapImageRep(
		bitmapDataPlanes: nil,
		pixelsWide: finalWidth,
		pixelsHigh: finalHeight,
		bitsPerSample: 8,
		samplesPerPixel: 4,
		hasAlpha: true,
		isPlanar: false,
		colorSpaceName: .deviceRGB,
		bytesPerRow: 0,
		bitsPerPixel: 0
	) else {
		fputs("Error: failed to create bitmap.\n", stderr)
		exit(4)
	}
	
	// Draw into bitmap
	NSGraphicsContext.saveGraphicsState()
	if let ctx = NSGraphicsContext(bitmapImageRep: rep) {
		NSGraphicsContext.current = ctx
		ctx.cgContext.setFillColor(NSColor.clear.cgColor)
		ctx.cgContext.fill(CGRect(x: 0, y: 0,
								  width: finalWidth,
								  height: finalHeight))
		baseImage.draw(in: CGRect(x: 0, y: 0,
								  width: finalWidth,
								  height: finalHeight),
					   from: .zero,
					   operation: .sourceOver,
					   fraction: 1.0)
	}
	NSGraphicsContext.restoreGraphicsState()
	
	guard let pngData = rep.representation(using: .png, properties: [:]) else {
		fputs("Error: failed to encode PNG.\n", stderr)
		exit(5)
	}
	
	// Copy PNG to clipboard
	let pb = NSPasteboard.general
	pb.clearContents()
	pb.setData(pngData, forType: .png)
	
	print("Copied SF Symbol '\(symbolName)' as PNG \(finalWidth)×\(finalHeight) px (aspect preserved).")
}

if #available(macOS 11.0, *) {
	main()
} else {
	fputs("This tool requires macOS 11 or later.\n", stderr)
	exit(1)
}
