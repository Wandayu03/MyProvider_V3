import 'package:internet_provider/models/packageModel.dart';

sealed class PaymentType {}

class PackagePayment extends PaymentType {
  final InternetPackage package;
  PackagePayment(this.package);
}

class PulsaPayment extends PaymentType {
  final String amount;
  final String phoneNumber; // ← dari identifier
  PulsaPayment({required this.amount, required this.phoneNumber});
}