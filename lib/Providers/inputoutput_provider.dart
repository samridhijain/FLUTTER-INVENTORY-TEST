import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/inputoutputModel.dart';

// MySnackBar(BuildContext context, value) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
// }

MySnackBar(BuildContext context, value) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(value),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

class InputOutputProvider with ChangeNotifier {
//////////////// List of Input Sheet /////////////////
  List<InputOutputModel> Input = [];

  Future<void> getInputData(String BalanceID) async {
    List<InputOutputModel> newList = [];
    QuerySnapshot InputSnapshot = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc(BalanceID)
        .collection("InputData")
        .get();

    InputSnapshot.docs.forEach(
      (element) {
        InputOutputModel InputData = InputOutputModel(
          Particular: (element.data() as dynamic)['Particular'],
          Amount: (element.data() as dynamic)['Amount'],
          Email: (element.data() as dynamic)['Email'],
        );

        newList.add(InputData);
      },
    );
    Input = newList;
    notifyListeners();
  }

  List<InputOutputModel> get getInputList {
    return Input;
  }

//   //////////////////////////////////////////////////
  ////////////////////Add Input Data in Firebase////////////////////////
  void addInputData({
    required String BalanceID,
    required int Amount,
    required String Particular,
    required String? Email,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc(BalanceID)
        .collection("InputData")
        .doc();
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "Particular": Particular,
        "Amount": Amount,
        "Email": Email,
      },
    );
    MySnackBar(context, "Entry Added.....");
  }

//   //////////////////////////////////////////

//////////////// List of Output Sheet /////////////////
  List<InputOutputModel> Output = [];

  Future<void> getOutputData(String BalanceID) async {
    List<InputOutputModel> newList = [];
    QuerySnapshot OutputSnapshot = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc(BalanceID)
        .collection("OutputData")
        .get();

    OutputSnapshot.docs.forEach(
      (element) {
        InputOutputModel OutputData = InputOutputModel(
          Particular: (element.data() as dynamic)['Particular'],
          Amount: (element.data() as dynamic)['Amount'],
          Email: (element.data() as dynamic)['Email'],
        );

        newList.add(OutputData);
      },
    );
    Output = newList;
    notifyListeners();
  }

  List<InputOutputModel> get getOutputList {
    return Output;
  }

//   //////////////////////////////////////////////////
  ////////////////////Add Output Data in Firebase////////////////////////
  void addOutputData({
    required String BalanceID,
    required int Amount,
    required String Particular,
    required String? Email,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc(BalanceID)
        .collection("OutputData")
        .doc();
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "Particular": Particular,
        "Amount": Amount,
        "Email": Email,
      },
    );
    MySnackBar(context, "Entry Added.....");
  }
}
