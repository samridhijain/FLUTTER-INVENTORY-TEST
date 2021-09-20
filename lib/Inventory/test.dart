// import 'package:flutter/material.dart';
// import 'package:ikkhuras_inventory/Inventory/inventory.dart';
// import 'package:ikkhuras_inventory/Models/productdetailModel.dart';
// import 'package:ikkhuras_inventory/Providers/productdetail_provider.dart';
// import 'package:ikkhuras_inventory/loading.dart';
// import 'package:provider/provider.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({Key? key, required this.ProductName}) : super(key: key);
//   final String ProductName;
//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   ProductDetailProvider productDetailProvider = ProductDetailProvider();
//   bool loading = false;

//   void initState() {
//     //print(widget.ProductName);
//     productDetailProvider =
//         Provider.of<ProductDetailProvider>(context, listen: false);
//     //productDetailProvider.getProductDetailData();
//     productDetailProvider.getProductDetailData(widget.ProductName);
//     //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
//     // productDetailProvider.getProductDetailData("Oil");
//     //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
//     // setState(() => loading = true);
//     super.initState();
//     //DefaultData();
//     //print(widget.ProductName);
//     // setState(() {
//     //   loading = false;
//     //   print("false");
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     productDetailProvider = Provider.of<ProductDetailProvider>(context);
//     // productDetailProvider.getProductDetailData();
//     productDetailProvider.getProductDetailData(widget.ProductName);
//     // productDetailProvider.getProductDetailData("Oil");
//     //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: Colors.transparent,
//         child: ListView(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.height * 0.01),
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             Center(
//               child: Text(
//                 "Product Name: ${widget.ProductName}".toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.02,
//             ),
//             EntryBox(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget EntryBox() {
//     List<ProductDetailModel> Name = productDetailProvider.getProductDetailList;
//     // List<ProductDetailModel> Name =
//     //     productDetailProvider.getProductDefaultDetailList;
//     return Column(
//         children: Name.map((e) {
//       return SingleEntry(
//           Date: e.Date,
//           PreQuantity: e.PreQuantity,
//           BatchNo: e.BatchNo,
//           Add: e.Add,
//           Sale: e.Sale,
//           QuantityLeft: e.QuantityLeft);
//     }).toList());
//   }

//   Widget SingleEntry(
//       {required String Date,
//       required int PreQuantity,
//       required int BatchNo,
//       required int Add,
//       required int Sale,
//       required int QuantityLeft}) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(child: Text(Date)),
//               Expanded(child: Text(PreQuantity.toString())),
//               Expanded(child: Text(BatchNo.toString())),
//               Expanded(child: Text(Add.toString())),
//               Expanded(child: Text(Sale.toString())),
//               Expanded(child: Text(QuantityLeft.toString())),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.01,
//         ),
//       ],
//     );
//   }
// }
