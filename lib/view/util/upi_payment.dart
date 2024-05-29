// ignore: file_names
import 'package:upi_india/upi_india.dart';

class UpiPayment {
  Future<UpiResponse> initiatePayment() async {
    UpiIndia upi = UpiIndia();
    List<UpiApp>? apps;

    try {
      apps = await upi.getAllUpiApps(mandatoryTransactionId: false);
      if (apps.isNotEmpty) {
        UpiApp selectedApp = apps[0]; // You can change this to select a different UPI app
        UpiResponse response = await upi.startTransaction(
          app: selectedApp,
          receiverUpiId: "----------------------",
          receiverName: '.......................',
          transactionRefId: 'YourTransactionId',
          transactionNote: 'Thanks for supporting! Radhe Radhe',
          amount: 100.00,
        );
        return response;
      } else {
        throw UpiIndiaAppNotInstalledException(); // No UPI apps available
      }
    } catch (e) {
      rethrow; // Handle errors
    }
  }
}
