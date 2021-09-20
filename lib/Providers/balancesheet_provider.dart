import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/prebalanceModel.dart';

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

class BalanceSheetProvider with ChangeNotifier {
  //////////////// List of Default Balance Sheet /////////////////
  List<BalanceSheetModel> DefaultBalanceSheet = [];

  Future<void> getDefaultBalanceSheetData(city) async {
    List<BalanceSheetModel> newList = [];
    QuerySnapshot DefaultBalanceSheetSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        .collection("DefaultBalanceSheet")
        .doc("DefaultBalanceSheetid")
        .collection(city)
        // .doc("defaultid")
        //.orderBy("Date", descending: true)
        .get();

    DefaultBalanceSheetSnapshot.docs.forEach(
      (element) {
        BalanceSheetModel DefaultBalanceSheetData = BalanceSheetModel(
          Balance: (element.data() as dynamic)['Balance'],
          PreBalance: (element.data() as dynamic)['PreBalance'],
          Date: (element.data() as dynamic)['Date'],
          Input: (element.data() as dynamic)['Input'],
          Output: (element.data() as dynamic)['Output'],
          BalanceID: (element.data() as dynamic)['BalanceID'],
          Email: (element.data() as dynamic)['Email'],
          Name: (element.data() as dynamic)['Name'],
          Paticular: (element.data() as dynamic)['Paticular'],
        );

        newList.add(DefaultBalanceSheetData);
      },
    );
    DefaultBalanceSheet = newList;
    notifyListeners();
  }

  List<BalanceSheetModel> get getDefaultBalanceSheetList {
    return DefaultBalanceSheet;
  }

////////////////////Update Default Balance Sheet Data in Firebase////////////////////////
  void updateDefaultBalanceData({
    required int Balance,
    required int? PreBalance,
    required int Input,
    required int Output,
    required String Date,
    required String? Email,
    required String Name,
    required String Paticular,
    required String city,
    required String BalanceID,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("DefaultBalanceSheet")
        .doc("DefaultBalanceSheetid")
        .collection(city)
        .doc("defaultid");
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.update(
      {
        "Balance": Balance,
        "PreBalance": PreBalance,
        "Input": Input,
        "Output": Output,
        "Date": Date,
        "BalanceID": BalanceID,
        "Email": Email,
        "Name": Name,
        "Paticular": Paticular,
      },
    );
    // MySnackBar(context, "Entry Added.....");
  }

//////////////// List of Balance Sheet /////////////////
  List<BalanceSheetModel> BalanceSheet = [];

  Future<void> getBalanceSheetData(city) async {
    List<BalanceSheetModel> newList = [];
    QuerySnapshot BalanceSheetSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        .collection("BalanceSheet")
        .doc("balancesheetid")
        .collection(city)
        .orderBy("Date", descending: true)
        .get();

    BalanceSheetSnapshot.docs.forEach(
      (element) {
        BalanceSheetModel BalanceSheetData = BalanceSheetModel(
          Balance: (element.data() as dynamic)['Balance'],
          PreBalance: (element.data() as dynamic)['PreBalance'],
          Date: (element.data() as dynamic)['Date'],
          Input: (element.data() as dynamic)['Input'],
          Output: (element.data() as dynamic)['Output'],
          BalanceID: (element.data() as dynamic)['BalanceID'],
          Email: (element.data() as dynamic)['Email'],
          Name: (element.data() as dynamic)['Name'],
          Paticular: (element.data() as dynamic)['Paticular'],
        );

        newList.add(BalanceSheetData);
      },
    );
    BalanceSheet = newList;
    notifyListeners();
  }

  List<BalanceSheetModel> get getBalanceSheetList {
    return BalanceSheet;
  }

  //////////////////////////////////////////////////
  ////////////////////Add Balance Sheet Data in Firebase////////////////////////
  void addBalanceData({
    required int Balance,
    required int PreBalance,
    required int Input,
    required int Output,
    required String Date,
    required String Name,
    required String Paticular,
    required String? Email,
    required String BalanceID,
    required BuildContext context,
    required String city,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc("balancesheetid")
        .collection(city)
        .doc(Date);
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "Balance": Balance,
        "PreBalance": PreBalance,
        "Input": Input,
        "Output": Output,
        "Date": Date,
        "Name": Name,
        "Paticular": Paticular,
        "BalanceID": BalanceID,
        "Email": Email,
      },
    );
    // MySnackBar(context, "Entry Added.....");
  }

  //////////////// List of Date  Sheet /////////////////
  List<BalanceSheetModel> DateBalanceSheet = [];

  Future<void> getDateBalanceSheetData(city, Date) async {
    List<BalanceSheetModel> newList = [];
    QuerySnapshot DateBalanceSheetSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        .collection("BalanceSheet")
        .doc("balancesheetid")
        .collection(city)
        .doc(Date)
        .collection("Data")
        .orderBy("BalanceID", descending: true)
        .get();

    DateBalanceSheetSnapshot.docs.forEach(
      (element) {
        BalanceSheetModel DateBalanceSheetData = BalanceSheetModel(
          Balance: (element.data() as dynamic)['Balance'],
          PreBalance: (element.data() as dynamic)['PreBalance'],
          Date: (element.data() as dynamic)['Date'],
          Input: (element.data() as dynamic)['Input'],
          Output: (element.data() as dynamic)['Output'],
          BalanceID: (element.data() as dynamic)['BalanceID'],
          Email: (element.data() as dynamic)['Email'],
          Name: (element.data() as dynamic)['Name'],
          Paticular: (element.data() as dynamic)['Paticular'],
        );

        newList.add(DateBalanceSheetData);
      },
    );
    DateBalanceSheet = newList;
    notifyListeners();
  }

  List<BalanceSheetModel> get getDateBalanceSheetList {
    return DateBalanceSheet;
  }

  //////////////////////////////////////////////////
  ////////////////////Add Date Balance Sheet Data in Firebase////////////////////////
  void addDateBalanceData({
    required int Balance,
    required int PreBalance,
    required int Input,
    required int Output,
    required String Date,
    required String Name,
    required String Paticular,
    required String BalanceID,
    required String? Email,
    required BuildContext context,
    required String city,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc("balancesheetid")
        .collection(city)
        .doc(Date)
        .collection("Data")
        .doc();

    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "Balance": Balance,
        "PreBalance": PreBalance,
        "Input": Input,
        "Output": Output,
        "Date": Date,
        "Name": Name,
        "Paticular": Paticular,
        "BalanceID": BalanceID,
        "Email": Email,
      },
    );
    MySnackBar(context, "Entry Added");
  }

////////////////////Update Balance Sheet Data in Firebase////////////////////////
  void updateBalanceData({
    required int Balance,
    required int PreBalance,
    required int Input,
    required int Output,
    required String Date,
    required String Name,
    required String Paticular,
    required String? Email,
    required BuildContext context,
    required String BalanceID,
    required String city,
    //String BalanceID,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("BalanceSheet")
        .doc("balancesheetid")
        .collection(city)
        .doc(Date);

    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.update(
      {
        "Balance": Balance,
        "PreBalance": PreBalance,
        "Input": Input,
        "Output": Output,
        "Date": Date,
        "Name": Name,
        "Paticular": Paticular,
        "BalanceID": BalanceID,
        "Email": Email,
      },
    );
    // MySnackBar(context, "Balance Updated.....");
  }

//////////////// List of Closing Balance /////////////////
  List<PreBalanceModel> ClosingBalance = [];

  Future<void> getClosingBalanceData(city) async {
    List<PreBalanceModel> newList = [];
    QuerySnapshot ClosingBalanceSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        .collection("ClosingBalance")
        .doc("id")
        .collection(city)
        // .doc("prebalanceid");
        // .doc("prebalanceid")

        .get();

    ClosingBalanceSnapshot.docs.forEach(
      (element) {
        PreBalanceModel ClosingBalanceData = PreBalanceModel(
            PreBalance: (element.data() as dynamic)['PreBalance']);

        newList.add(ClosingBalanceData);
      },
    );
    ClosingBalance = newList;
    notifyListeners();
  }

  List<PreBalanceModel> get getClosingBalanceList {
    return ClosingBalance;
  }

  ////////////////////Update ClosingBalance in Firebase////////////////////////
  void updatePreviousBalance({
    required int PreBalance,
    required BuildContext context,
    required String city,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        // .collection("BalanceSheet")
        // .doc("balance")
        .collection("ClosingBalance")
        .doc("id")
        .collection(city)
        .doc("prebalanceid");
    // .doc(Cartid)
    documentReference.update(
      {
        "PreBalance": PreBalance,
      },
    );
    //MySnackBar(context, "Address deleted.....");
  }
  //////////////////////////////////////////
}
