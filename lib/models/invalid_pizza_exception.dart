class InvalidPizzaException implements Exception {
  final String message;
  InvalidPizzaException(this.message);

  @override
  String toString() => 'InvalidPizzaException: $message';
}
