enum CartoonStyle {
  Simpsons,
  Naruto,
  Disney,
}

class CartoonStyleOptions {
  final CartoonStyle style;
  final DisplayOption displayOption;

  CartoonStyleOptions({required this.style, required this.displayOption});
}

enum DisplayOption {
  Person,
  Background,
  Full,
}