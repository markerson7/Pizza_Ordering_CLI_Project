import 'dart:io';
import 'package:pizza_ordering/models/pizza.dart';
import 'package:pizza_ordering/models/order.dart';
import 'package:pizza_ordering/models/customer.dart';
import 'package:pizza_ordering/enums/meat_type.dart';
import 'package:pizza_ordering/enums/veggie_type.dart';
import 'package:pizza_ordering/enums/crust_type.dart';
import 'package:pizza_ordering/enums/topping.dart';
import 'package:pizza_ordering/enums/size.dart';
import 'package:pizza_ordering/utils/file_handler.dart';

void main(List<String> arguments) async {
  print('Welcome to the Pizza Ordering System!');
  print("==============================================");
  await FileHandler.showOrders();

  var numberOfPizzas = arguments.isNotEmpty
      ? int.tryParse(arguments[0]) ?? 1
      : 1;

  print('Enter Customer Details:');
  stdout.write('Name: ');
  final name = stdin.readLineSync()!;
  stdout.write('Address: ');
  final address = stdin.readLineSync()!;
  stdout.write('Phone: ');
  final phone = stdin.readLineSync()!;

  int deliveryChoice;
  while (true) {
    print('Choose delivery option:');
    print('  [1] Delivery');
    print('  [2] Pickup');
    stdout.write('Enter 1 or 2: ');
    final input = stdin.readLineSync()!;
    deliveryChoice = int.tryParse(input) ?? 0;
    if (deliveryChoice == 1 || deliveryChoice == 2) {
      break;
    }
    print('❗ Invalid choice. Please enter 1 or 2.');
  }

  final isDelivery = deliveryChoice == 1;

  final customer = Customer(name, address, phone);

  // ✅ Ask user how many pizzas they want
  numberOfPizzas;
  while (true) {
    stdout.write('How many pizzas do you want to order? ');
    final input = stdin.readLineSync();
    numberOfPizzas = int.tryParse(input ?? '') ?? 0;
    if (numberOfPizzas > 0) break;
    print('Please enter a valid number greater than 0.');
  }

  final pizzas = <Pizza>[];

  for (var i = 0; i < numberOfPizzas; i++) {
    print('\n--- Configuring Pizza #${i + 1} ---');

    // ✅ 1. Number of slices
    int numSlices;
    while (true) {
      stdout.write('How many slices? ');
      final input = stdin.readLineSync()!;
      numSlices = int.tryParse(input) ?? 0;
      if (numSlices > 0) break;
      print('Invalid number. Try again.');
    }

    // ✅ 2. Meat choice
    print('Choose meat type:');
    for (var i = 0; i < MeatType.values.length; i++) {
      print('  [$i] ${MeatType.values[i].name}');
    }
    stdout.write('Enter meat index: ');
    final meat = MeatType.values[int.parse(stdin.readLineSync()!)];

    // ✅ 3. Veggie choice
    print('Choose veggie type:');
    for (var i = 0; i < VeggieType.values.length; i++) {
      print('  [$i] ${VeggieType.values[i].name}');
    }
    stdout.write('Enter veggie index: ');
    final veggie = VeggieType.values[int.parse(stdin.readLineSync()!)];

    // ✅ 4. Crust type
    CrustType crust;
    while (true) {
      print('Choose crust type:');
      for (var i = 0; i < CrustType.values.length; i++) {
        print('  [$i] ${CrustType.values[i].name}');
      }
      stdout.write('Enter crust index: ');
      final input = stdin.readLineSync()!;
      final index = int.tryParse(input);
      if (index != null && index >= 0 && index < CrustType.values.length) {
        crust = CrustType.values[index];
        break;
      }
      print('❗ Invalid choice. Please enter a valid index.');
    }

    // ✅ 5. Pizza size
    print('Choose size:');
    for (var i = 0; i < Size.values.length; i++) {
      print('  [$i] ${Size.values[i].name}');
    }
    stdout.write('Enter size index: ');
    final size = Size.values[int.parse(stdin.readLineSync()!)];

    // ✅ 6. Toppings (multi-select)
    Set<Topping> toppings = {};
    while (true) {
      print('Choose toppings (enter indices separated by commas):');
      for (var i = 0; i < Topping.values.length; i++) {
        print('  [$i] ${Topping.values[i].name}');
      }
      stdout.write('Enter topping indices (e.g. 0,2,5): ');
      final input = stdin.readLineSync()!;
      try {
        final indices = input
            .split(',')
            .map((e) => int.parse(e.trim()))
            .where((index) => index >= 0 && index < Topping.values.length);
        if (indices.isNotEmpty) {
          toppings = indices.map((i) => Topping.values[i]).toSet();
          break;
        } else {
          print('❗ Please enter at least one valid topping index.');
        }
      } catch (e) {
        print('❗ Invalid input. Please enter numbers separated by commas.');
      }
    }

    // ✅ Construct and add pizza
    final pizza = Pizza.named(
      numSlices: numSlices,
      meatChoice: meat,
      vegChoice: veggie,
      crustType: crust,
      toppings: toppings,
      size: size,
    );

    pizzas.add(pizza);
  }

  final order = Order(
    customer: customer,
    pizzas: pizzas,
    isDelivery: isDelivery,
  );
  print('\n--- Order Summary ---');
  print(order.summary());

  await FileHandler.saveOrder(order.toString());
  print('Order saved to file.');

  print('Show all orders? (y/n): ');
  if (stdin.readLineSync()!.toLowerCase() == 'y') {
    await FileHandler.showOrders();
  }
}
