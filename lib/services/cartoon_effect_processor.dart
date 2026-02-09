import 'dart:typed_data';
import 'package:image/image.dart' as img;

class CartoonEffectProcessor {
  /// Applies Simpson style cartoon effect
  static img.Image applySimpsonsStyle(img.Image image) {
    // Apply color posterization for Simpsons yellow/bright colors
    img.Image result = img.Image.from(image);
    
    // Reduce color palette to bright yellows, blues, oranges
    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        final pixel = result.getPixelSafe(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();
        
        // Quantize colors to Simpsons palette
        final quantized = _quantizeToSimpsons(r, g, b);
        result.setPixelRgba(x, y, quantized[0], quantized[1], quantized[2], 255);
      }
    }
    
    // Apply edge detection
    return _applyEdgeDetection(result);
  }

  /// Applies Naruto style cartoon effect
  static img.Image applyNarutoStyle(img.Image image) {
    img.Image result = img.Image.from(image);
    
    // Apply orange/black color scheme
    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        final pixel = result.getPixelSafe(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();
        
        final quantized = _quantizeToNaruto(r, g, b);
        result.setPixelRgba(x, y, quantized[0], quantized[1], quantized[2], 255);
      }
    }
    
    return _applyEdgeDetection(result);
  }

  /// Applies Disney style cartoon effect
  static img.Image applyDisneyStyle(img.Image image) {
    img.Image result = img.Image.from(image);
    
    // Apply softer, pastel color scheme
    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        final pixel = result.getPixelSafe(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();
        
        final quantized = _quantizeToDisney(r, g, b);
        result.setPixelRgba(x, y, quantized[0], quantized[1], quantized[2], 255);
      }
    }
    
    // Apply softer edge detection for Disney
    return _applySoftEdgeDetection(result);
  }

  /// Quantize color to Simpsons palette (bright yellows, blues, oranges)
  static List<int> _quantizeToSimpsons(int r, int g, int b) {
    final brightness = (r + g + b) ~/ 3;
    
    if (r > 200 && g > 150 && b < 100) return [255, 200, 0]; // Yellow
    if (r > 150 && g < 100 && b < 100) return [200, 50, 0];   // Orange/Red
    if (r < 100 && g < 100 && b > 150) return [0, 100, 200];  // Blue
    if (brightness > 200) return [255, 255, 255];              // White
    if (brightness < 50) return [0, 0, 0];                     // Black
    
    return [200, 200, 200]; // Gray
  }

  /// Quantize color to Naruto palette (oranges and blacks)
  static List<int> _quantizeToNaruto(int r, int g, int b) {
    final brightness = (r + g + b) ~/ 3;
    
    if (r > 180 && g > 100 && b < 100) return [255, 140, 0];  // Orange
    if (r > 150 && g > 80 && b < 80) return [220, 100, 0];    // Dark Orange
    if (brightness > 200) return [255, 255, 200];              // Light yellow
    if (brightness < 60) return [20, 20, 20];                  // Dark black
    
    return [150, 100, 50]; // Brown
  }

  /// Quantize color to Disney palette (pastel colors)
  static List<int> _quantizeToDisney(int r, int g, int b) {
    final brightness = (r + g + b) ~/ 3;
    
    if (r > g && r > b) return [230, 150, 150]; // Pastel red
    if (g > r && g > b) return [150, 230, 150]; // Pastel green
    if (b > r && b > g) return [150, 150, 230]; // Pastel blue
    if (brightness > 200) return [255, 255, 255]; // White
    if (brightness < 50) return [50, 50, 50]; // Dark gray
    
    return [200, 180, 150]; // Pastel beige
  }

  /// Apply edge detection filter
  static img.Image _applyEdgeDetection(img.Image image) {
    return img.sobel(image);
  }

  /// Apply soft edge detection for Disney style
  static img.Image _applySoftEdgeDetection(img.Image image) {
    // Use a softer edge detection approach
    return img.gaussianBlur(image, 2);
  }

  /// Extract person from image using background removal
  static img.Image extractPerson(img.Image image) {
    // Simplified background removal - in production, use ML Kit or similar
    img.Image result = img.Image.from(image);
    
    final centerX = image.width ~/ 2;
    final centerY = image.height ~/ 2;
    
    // Simple depth-based approach: keep center, fade edges
    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        final distFromCenter = ((x - centerX) * (x - centerX) + (y - centerY) * (y - centerY)) / 
            ((centerX * centerX) + (centerY * centerY));
        
        if (distFromCenter > 0.7) {
          // Fade to transparent/white background
          final pixel = result.getPixelSafe(x, y);
          result.setPixelRgba(x, y, 255, 255, 255, (255 * (1 - distFromCenter)).toInt());
        }
      }
    }
    
    return result;
  }

  /// Apply pixelation effect
  static img.Image applyPixelation(img.Image image, int pixelSize) {
    if (pixelSize <= 1) return image;
    
    img.Image pixelated = img.Image(
      width: image.width,
      height: image.height,
    );
    
    for (int y = 0; y < image.height; y += pixelSize) {
      for (int x = 0; x < image.width; x += pixelSize) {
        final pixel = image.getPixelSafe(x, y);
        
        for (int py = 0; py < pixelSize && y + py < image.height; py++) {
          for (int px = 0; px < pixelSize && x + px < image.width; px++) {
            pixelated.setPixelRgba(
              x + px,
              y + py,
              pixel.r.toInt(),
              pixel.g.toInt(),
              pixel.b.toInt(),
              255,
            );
          }
        }
      }
    }
    
    return pixelated;
  }

  /// Adjust image quality by compression
  static List<int> adjustQuality(img.Image image, int quality) {
    // JPEG compression with quality parameter (0-100)
    return img.encodeJpg(image, quality: quality);
  }
}