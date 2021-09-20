import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/BalanceSheet/addEntry.dart';
import 'package:ikkhuras_inventory/BalanceSheet/inputParticular.dart';
import 'package:ikkhuras_inventory/Inventory/addProduct.dart';
import 'package:ikkhuras_inventory/Inventory/inventory.dart';
import 'package:ikkhuras_inventory/Inventory/productDetail.dart';
import 'package:ikkhuras_inventory/Inventory/test.dart';
// import 'package:ikkhuras_inventory/Models/balancesheet.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:provider/provider.dart';

class BookCategory extends StatefulWidget {
  const BookCategory({Key? key, required this.city}) : super(key: key);
  final String city;
  //final String category = "abc";
  @override
  _BookCategoryState createState() => _BookCategoryState();
}

class _BookCategoryState extends State<BookCategory> {
  ProductNameProvider productNameProvider = ProductNameProvider();

  // void initState() {
  //   productNameProvider =
  //       Provider.of<ProductNameProvider>(context, listen: false);
  //   productNameProvider.getProductNameData(widget.city, widget.category);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // productNameProvider = Provider.of<ProductNameProvider>(context);
    // productNameProvider.getProductNameData(widget.city, widget.category);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.grey.shade200,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Container(
      //         //width: 160,
      //         child: MaterialButton(
      //           child: Text("ADD ENTRY"),
      //           color: Colors.blue.shade100,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(
      //               10,
      //             ),
      //           ),
      //           onPressed: () {
      //             // balanceSheetProvider.updateBalanceData(
      //             //     Balance: 0, context: context);
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => AddEntry(),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       Container(
      //         //width: 160,
      //         child: MaterialButton(
      //           child: Text("SEARCH BY DATE"),
      //           color: Colors.blue.shade100,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(
      //               10,
      //             ),
      //           ),
      //           onPressed: () {
      //             // Navigator.of(context).push(
      //             //   MaterialPageRoute(
      //             //     builder: (context) => ListAddress(
      //             //       Grandtotal: grandtotal,
      //             //     ),
      //             //   ),
      //             // );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.02),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Text(
                "SELECT YOUR CATEGORY",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            //////////////// Add Products Button  ///////////////
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (ctx) => AddProductPage(
            //           city: widget.city,
            //           category: widget.category,
            //         ),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.blue.shade100,
            //       border: Border.all(
            //         color: Colors.black,
            //         width: 1.0,
            //       ),
            //       // borderRadius: BorderRadius.circular(20),
            //     ),
            //     //width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height * 0.1,
            //     //color: Colors.blue.shade100,
            //     child: Center(
            //         child: Text(
            //       "ADD BOOKS",
            //       style: TextStyle(
            //         fontSize: 19.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     )),
            //   ),
            // ),
            ///////////////////////////////////////////////
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            //EntryBox(),
            SingleEntry(CategoryName: "संस्कृत भाषा में टीका ग्रंथ"),
            SingleEntry(CategoryName: "हिंदी में अनुवादित ग्रंथ"),
            SingleEntry(CategoryName: "पद्यानुवाद"),
            SingleEntry(CategoryName: "प्रवचन ग्रंथ"),
            SingleEntry(CategoryName: "संस्कृत भाषा में मौलिक काव्य ग्रंथ"),
            SingleEntry(CategoryName: "प्राकृत भाषा में मौलिक काव्य ग्रंथ"),
            SingleEntry(CategoryName: "अन्य मौलिक कृतियां"),
            SingleEntry(CategoryName: "संकलन"),
            SingleEntry(CategoryName: "अंग्रेजी भाषा में पुस्तकें आदि"),
          ],
        ),
      ),
    );
  }

  // Widget EntryBox() {
  //   List<ProductNameModel> Name = productNameProvider.getProductNameList;
  //   return Column(
  //       children: Name.map((e) {
  //     return GestureDetector(
  //         onTap: () {
  //           //print(e.ProductName);
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (ctx) =>
  //                   //TestPage(ProductName: e.ProductName),
  //                   ProductDetailPage(
  //                       ProductName: e.ProductName,
  //                       city: widget.city,
  //                       category: widget.category),
  //             ),
  //           );
  //         },
  //         child: SingleEntry(ProductName: e.ProductName));
  //   }).toList());
  // }

  Widget SingleEntry({required String CategoryName}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            //print(e.ProductName);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    //TestPage(ProductName: e.ProductName),
                    InventoryPage(city: widget.city, category: CategoryName),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              //borderRadius: BorderRadius.circular(20),
            ),
            //width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            //color: Colors.yellow.shade100,
            child: Center(
                child: Text(
              CategoryName,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}
