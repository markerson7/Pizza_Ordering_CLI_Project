import 'pizza.dart';
import 'customer.dart';
import 'dart:convert';

class Order {
  static int _idCounter = 1;
  final int orderId;
  final Customer customer;
  final List<Pizza> pizzas;
  final bool isDelivery;
  final DateTime dateTime;

  Order({
    required this.customer,
    required this.pizzas,
    required this.isDelivery,
  }) : orderId = _idCounter++,
       dateTime = DateTime.now();

  double get totalPrice {
    double subtotal = pizzas.fold(
      0,
      (sum, pizza) => sum + pizza.calculatePrice(),
    );
    if (pizzas.length > 1) {
      subtotal *= 0.95;
    }
    return subtotal;
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'customer': customer.toJson(),
    'isDelivery': isDelivery,
    'dateTime': dateTime.toIso8601String(),
    'pizzas': pizzas.map((p) => p.toString()).toList(),
    'totalPrice': totalPrice,
  };

  String summary() {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('ORDER ID: $orderId');
    buffer.writeln('Customer: ${customer.name}');
    buffer.writeln('Address: ${customer.address}');
    buffer.writeln('Phone: ${customer.phoneNumber}');
    buffer.writeln('Date/Time: $dateTime');
    buffer.writeln('Delivery: $isDelivery');
    buffer.writeln('\nPizzas:');
    for (var i = 0; i < pizzas.length; i++) {
      buffer.writeln('  ${i + 1}. ${pizzas[i]}');
    }
    double subtotal = pizzas.fold(
      0,
      (sum, pizza) => sum + pizza.calculatePrice(),
    );
    double discount = (pizzas.length > 1) ? 0.05 * subtotal : 0.0;
    double total = (pizzas.length > 1) ? subtotal * 0.95 : subtotal;

    buffer.writeln('\nSubtotal: \$${subtotal.toStringAsFixed(2)}');
    buffer.writeln('Discount: \$${discount.toStringAsFixed(2)}');
    buffer.writeln('TOTAL: \$${total.toStringAsFixed(2)}');

    return buffer.toString();
  }

  @override
  String toString() => jsonEncode(toJson());
}
