// Author: Your Name (Registration Number)
import '../enums/meat_type.dart';
import '../enums/veggie_type.dart';
import '../enums/crust_type.dart';
import '../enums/topping.dart';
import '../enums/size.dart';
import 'invalid_pizza_exception.dart';

class Pizza {
  int _numSlices;
  MeatType _meatChoice;
  VeggieType _vegChoice;
  CrustType _crustType;
  Set<Topping> _toppings;
  Size _size;

  // Default Constructor
  Pizza()
    : _numSlices = 8,
      _meatChoice = MeatType.PEPPERONI,
      _vegChoice = VeggieType.MUSHROOM,
      _crustType = CrustType.THIN,
      _toppings = {Topping.CHEESE},
      _size = Size.MEDIUM;

  // Parameterized Constructor
  Pizza.named({
    required int numSlices,
    required MeatType meatChoice,
    required VeggieType vegChoice,
    required CrustType crustType,
    required Set<Topping> toppings,
    required Size size,
  }) : _numSlices = numSlices,
       _meatChoice = meatChoice,
       _vegChoice = vegChoice,
       _crustType = crustType,
       _toppings = toppings,
       _size = size;

  // Getters and Setters with Validation
  int get numSlices => _numSlices;
  set numSlices(int value) {
    if (value < 1)
      throw InvalidPizzaException('Number of slices must be at least 1.');
    _numSlices = value;
  }

  MeatType get meatChoice => _meatChoice;
  set meatChoice(MeatType value) => _meatChoice = value;

  VeggieType get vegChoice => _vegChoice;
  set vegChoice(VeggieType value) => _vegChoice = value;

  CrustType get crustType => _crustType;
  set crustType(CrustType value) => _crustType = value;

  Set<Topping> get toppings => _toppings;
  set toppings(Set<Topping> value) {
    if (value.isEmpty)
      throw InvalidPizzaException('At least one topping is required.');
    _toppings = value;
  }

  Size get size => _size;
  set size(Size value) => _size = value;

  double calculatePrice() {
    double basePrice = 10.0;
    basePrice += 2; // +$2 for meat
    basePrice += 1; // +$1 for veggie
    basePrice += 0.5 * _toppings.length;

    switch (_crustType) {
      case CrustType.THIN:
        basePrice += 0;
        break;
      case CrustType.THICK:
        basePrice += 1;
        break;
      case CrustType.STUFFED:
        basePrice += 3;
        break;
      case CrustType.GLUTEN_FREE:
        basePrice += 2;
        break;
    }

    double multiplier;
    switch (_size) {
      case Size.SMALL:
        multiplier = 1.0;
        break;
      case Size.MEDIUM:
        multiplier = 1.5;
        break;
      case Size.LARGE:
        multiplier = 1.8;
        break;
    }

    return basePrice * multiplier;
  }

  @override
  String toString() {
    return 'Pizza(numSlices: $_numSlices, meat: $_meatChoice, veg: $_vegChoice, crust: $_crustType, toppings: $_toppings, size: $_size, price: \$${calculatePrice().toStringAsFixed(2)})';
  }
}
