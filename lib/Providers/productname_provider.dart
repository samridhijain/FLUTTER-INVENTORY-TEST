import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';

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

class ProductNameProvider with ChangeNotifier {
//////////////// List of ProductName /////////////////
  List<ProductNameModel> ProductName = [];

  Future<void> getProductNameData(city, category) async {
    List<ProductNameModel> newList = [];
    QuerySnapshot ProductNameSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        //.collection("Product")
        //.orderBy("Date", descending: true)
        // .collection("Inventory")
        // .doc("id")
        .collection(city)
        .doc("categoryid")
        .collection(category)
        // .doc()
        .get();

    ProductNameSnapshot.docs.forEach(
      (element) {
        ProductNameModel ProductNameData = ProductNameModel(
            ProductName: (element.data() as dynamic)['ProductName']);

        newList.add(ProductNameData);
      },
    );
    ProductName = newList;
    notifyListeners();
  }

  List<ProductNameModel> get getProductNameList {
    return ProductName;
  }

  //////////////////////////////////////////////////
  ////////////////////Add Product Name Data in Firebase////////////////////////
  void addProductName({
    required String ProductName,
    required String city,
    required String category,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        // .collection("Inventory")
        // .doc("id")
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc();
    // await FirebaseFirestore.instance.collection("Product").doc();
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "ProductName": ProductName,
        "ProductID": documentReference.id,
      },
    );

    //FirebaseFirestore.instance.collection(ProductName).doc().set();

    DocumentReference documentReference2 = await FirebaseFirestore.instance
        // .collection("Inventory")
        // .doc("id")
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc("prequantity")
        .collection("PreviousQuantity")
        .doc("prequantityid");
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference2.set(
      {
        "PreQuantity": 0,
        "PreQuantityID": documentReference2.id,
      },
    );

    DocumentReference documentReference3 = await FirebaseFirestore.instance
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc("default")
        .collection("Default")
        .doc("defaultid");
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference3.set(
      {
        "Date": "2021-01-01",
        "PreQuantity": 0,
        //"BatchNo": BatchNo,
        "Add": 0,
        "Sale": 0,
        "QuantityLeft": 0,
        "Email": "",
      },
    );

    MySnackBar(context, "Product Added.....");
  }

  // ////////////////////Update ClosingBalance in Firebase////////////////////////
  // void updateBalanceData({
  //   required int Balance,
  //   required BuildContext context,
  // }) async {
  //   DocumentReference documentReference = await FirebaseFirestore.instance
  //       // .collection("BalanceSheet")
  //       // .doc("balance")
  //       .collection("ClosingBalance")
  //       .doc("balanceid");
  //   // .doc(Cartid)
  //   documentReference.update(
  //     {
  //       "Balance": Balance,
  //     },
  //   );
  //   //MySnackBar(context, "Address deleted.....");
  // }
  // //////////////////////////////////////////
}
