import 'dart:io';

class FileHandler {
  static const String fileName = 'pizza_orders.json';

  static Future<void> saveOrder(String orderString) async {
    final file = File(fileName);
    await file.writeAsString('$orderString\n', mode: FileMode.append);
  }

  static Future<void> showOrders() async {
    final file = File(fileName);
    if (await file.exists()) {
      final contents = await file.readAsString();
      print('--- All Orders ---');
      print(contents);
    } else {
      print('No past orders found.');
    }
  }
}
