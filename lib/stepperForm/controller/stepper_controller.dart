// import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
import 'package:task2/Submitted/View/Submitted.dart';

class StepperController extends GetxController {
  var currentStep = 0.obs;
  var fnameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var street1Controller = TextEditingController().obs;
  var street2Controller = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var countryController = TextEditingController().obs;
  var pincodeController = TextEditingController().obs;
  var paymentController = TextEditingController().obs;
  final razorpay = Razorpay();
  var listState = [
    StepState.indexed,
    StepState.editing,
    StepState.complete,
  ];
  // final razorPayKey = dotenv.get("rzp_test_lGQ8AvSEjQyqPa");
  // final razorPaySecret = dotenv.get("q8PaTqvkU3dlTMkrLYCOLaiX");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void pay() {
    var option = {
      'key': "rzp_test_lGQ8AvSEjQyqPa",
      'amount': num.parse(paymentController.value.text) * 100,
      'name': 'Meri Company',
      'order': {
        "id": "order_${getRandomString(6)}",
        "entity": "order",
        "amount": num.parse(paymentController.value.text) * 100,
        "amount_paid": 0,
        "amount_due": num.parse(paymentController.value.text) * 100,
        "currency": "INR",
        "receipt": "Receipt #20",
        "status": "created",
        "attempts": 0,
        "notes": {"key1": "value1", "key2": "value2"},
        "created_at": 1572502745
      },
      'Description': 'Payment',
      'timeout': 60,
      'prefill': {
        'contact': phoneController.value.text,
        'email': emailController.value.text
      }
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  RxList<Step> getStep() {
    return <Step>[
      Step(
          state: currentStep.value == 0
              ? listState[1]
              : currentStep > 0
                  ? listState[2]
                  : listState[0],
          title: const Text("Basic Info"),
          content: Column(children: [
            TextField(
                controller: fnameController.value,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: phoneController.value,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: emailController.value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
          ])),
      Step(
          state: currentStep.value == 1
              ? listState[1]
              : currentStep > 1
                  ? listState[2]
                  : listState[0],
          title: const Text("Address"),
          content: Column(children: [
            TextField(
                controller: street1Controller.value,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Address 1",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: street2Controller.value,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Address 2",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: cityController.value,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "City",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: pincodeController.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Pincode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: stateController.value,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "State",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: countryController.value,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Country",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0)))),
          ])),
      Step(
          title: const Text("Payment"),
          content: Column(
            children: [
              TextField(
                  controller: paymentController.value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "How much you are willing to contribute",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.0)))),
            ],
          ))
    ].obs;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Get.snackbar("Yayy", "Payment Successfull");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Get.snackbar("Error", "Payment Failed",
        snackPosition: SnackPosition.BOTTOM);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
