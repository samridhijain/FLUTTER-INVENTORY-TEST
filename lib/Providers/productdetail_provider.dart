import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/Models/prequantityModel.dart';
import 'package:ikkhuras_inventory/Models/productdetailModel.dart';
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

class ProductDetailProvider with ChangeNotifier {
  //////////////// List of Previous Quantity  /////////////////
  List<PreQuantityModel> PreQuantity = [];

  Future<void> getPreQuantityData(
      String ProductName, String city, String category) async {
    List<PreQuantityModel> newList = [];
    QuerySnapshot PreQuantitySnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        // .collection(ProductName)
        // .orderBy("Date", descending: true)
        // .get();
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc("prequantity")
        .collection("PreviousQuantity")
        .get();
    PreQuantitySnapshot.docs.forEach(
      (element) {
        PreQuantityModel PreQuantityData = PreQuantityModel(
            PreQuantity: (element.data() as dynamic)['PreQuantity']);

        newList.add(PreQuantityData);
      },
    );
    PreQuantity = newList;
    notifyListeners();
  }

  List<PreQuantityModel> get getPreQuantityList {
    return PreQuantity;
  }
//////////////// Update of Previous Quantity  /////////////////

  void updatePreQuantity({
    required String ProductName,
    required int QuantityLeft,
    required String city,
    required String category,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc("prequantity")
        .collection("PreviousQuantity")
        .doc("prequantityid");
    documentReference.update(
      {
        "PreQuantity": QuantityLeft,
      },
    );
    //MySnackBar(context, "Entry Updated.....");
  }

//////////////// List of ProductName /////////////////
  List<ProductDetailModel> ProductDetail = [];

  Future<void> getProductDetailData(
      String ProductName, String city, String category) async {
    List<ProductDetailModel> newList = [];
    QuerySnapshot ProductDetailSnapshot = await FirebaseFirestore.instance
        // .collection("Homepage")
        // .doc("E9nCOdovDKD3Ymp4QOUA")
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .orderBy("Date", descending: true)
        .get();

    ProductDetailSnapshot.docs.forEach(
      (element) {
        ProductDetailModel ProductDetailData = ProductDetailModel(
          Add: (element.data() as dynamic)['Add'],
          // BatchNo: (element.data() as dynamic)['BatchNo'],
          PreQuantity: (element.data() as dynamic)['PreQuantity'],
          QuantityLeft: (element.data() as dynamic)['QuantityLeft'],
          Sale: (element.data() as dynamic)['Sale'],
          Date: (element.data() as dynamic)['Date'],
          Email: (element.data() as dynamic)['Email'],
        );

        newList.add(ProductDetailData);
      },
    );
    ProductDetail = newList;
    notifyListeners();
  }

  List<ProductDetailModel> get getProductDetailList {
    return ProductDetail;
  }

//////////////// List of Default ProductName /////////////////
  List<ProductDetailModel> ProductDefaultDetail = [];

  Future<void> getProductDefaultDetailData(
      String ProductName, String city, String category) async {
    List<ProductDetailModel> newList = [];
    QuerySnapshot ProductDefaultDetailSnapshot =
        await FirebaseFirestore.instance
            // .collection("Homepage")
            // .doc("E9nCOdovDKD3Ymp4QOUA")
            // .collection(ProductName)
            // .orderBy("Date", descending: true)
            // .get();
            .collection(city)
            .doc("categoryid")
            .collection(category)
            .doc(city + "id")
            .collection(ProductName)
            .doc("default")
            .collection("Default")
            .get();
    ProductDefaultDetailSnapshot.docs.forEach(
      (element) {
        ProductDetailModel ProductDefaultDetailData = ProductDetailModel(
          Add: (element.data() as dynamic)['Add'],
          // BatchNo: (element.data() as dynamic)['BatchNo'],
          PreQuantity: (element.data() as dynamic)['PreQuantity'],
          QuantityLeft: (element.data() as dynamic)['QuantityLeft'],
          Sale: (element.data() as dynamic)['Sale'],
          Date: (element.data() as dynamic)['Date'],
          Email: (element.data() as dynamic)['Email'],
        );

        newList.add(ProductDefaultDetailData);
      },
    );
    ProductDefaultDetail = newList;
    notifyListeners();
  }

  List<ProductDetailModel> get getProductDefaultDetailList {
    return ProductDefaultDetail;
  }

  //////////////////////////////////////////////////
  ////////////////////Add Product Detail Data in Firebase////////////////////////
  void addProductDetail({
    required String ProductName,
    required String Date,
    required int PreQuantity,
    //required int BatchNo,
    required int Add,
    required int Sale,
    required int QuantityLeft,
    required String? Email,
    required String city,
    required String category,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc(Date);
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.set(
      {
        "Date": Date,
        "PreQuantity": PreQuantity,
        // "BatchNo": BatchNo,
        "Add": Add,
        "Sale": Sale,
        "QuantityLeft": QuantityLeft,
        "Email": Email,
      },
    );
    MySnackBar(context, "New Entry Added.....");
  }

  ////////////////////Update Product Detail Data in Firebase////////////////////////
  void updateProductDetail({
    required String ProductName,
    required String Date,
    // required int PreQuantity,
    // required int BatchNo,
    required int Add,
    required int Sale,
    required int QuantityLeft,
    required String? Email,
    required String city,
    required String category,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection(city)
        .doc("categoryid")
        .collection(category)
        .doc(city + "id")
        .collection(ProductName)
        .doc(Date);
    // .collection("ClosingBalance")
    // .doc("balanceid");
    // .doc(Cartid)
    documentReference.update(
      {
        // "Date": Date,
        // "PreQuantity": PreQuantity,
        // "BatchNo": BatchNo,
        "Add": Add,
        "Sale": Sale,
        "QuantityLeft": QuantityLeft,
        "Email": Email,
      },
    );
    MySnackBar(context, "Entry Updated.....");
  }

////////////////////Add default Product Detail Data in Firebase////////////////////////
  // void addDefaultProductDetail({
  //   required String ProductName,
  //   required String Date,
  //   required int PreQuantity,
  //   // required int BatchNo,
  //   required int Add,
  //   required int Sale,
  //   required int QuantityLeft,
  //   required String city,
  //   required String? Email,
  //   required BuildContext context,
  // }) async {
  //   DocumentReference documentReference = await FirebaseFirestore.instance
  //       .collection(city)
  //       .doc(city + "id")
  //       .collection(ProductName)
  //       .doc("default")
  //       .collection("Default")
  //       .doc("defaultid");
  //   // .collection("ClosingBalance")
  //   // .doc("balanceid");
  //   // .doc(Cartid)
  //   documentReference.set(
  //     {
  //       "Date": Date,
  //       "PreQuantity": PreQuantity,
  //       //"BatchNo": BatchNo,
  //       "Add": Add,
  //       "Sale": Sale,
  //       "QuantityLeft": QuantityLeft,
  //       "Email": Email,
  //     },
  //   );
  //   //MySnackBar(context, " Entry Updated.....");
  // }

////////////////////Update default Product Detail Data in Firebase////////////////////////
  void updateDefaultProductDetail({
    required String ProductName,
    required String Date,
    required int PreQuantity,
    // required int BatchNo,
    required int Add,
    required int Sale,
    required int QuantityLeft,
    required String? Email,
    required String city,
    required String category,
    required BuildContext context,
  }) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
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
    documentReference.update(
      {
        "Date": Date,
        "PreQuantity": PreQuantity,
        // "BatchNo": BatchNo,
        "Add": Add,
        "Sale": Sale,
        "QuantityLeft": QuantityLeft,
        "Email": Email,
      },
    );
    // MySnackBar(context, "New Entry Added.....");
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
