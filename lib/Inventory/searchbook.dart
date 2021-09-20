import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/BalanceSheet/addEntry.dart';
import 'package:ikkhuras_inventory/BalanceSheet/inputParticular.dart';
import 'package:ikkhuras_inventory/Inventory/addProduct.dart';
import 'package:ikkhuras_inventory/Inventory/productDetail.dart';
import 'package:ikkhuras_inventory/Inventory/test.dart';
// import 'package:ikkhuras_inventory/Models/balancesheet.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:provider/provider.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({Key? key, required this.city, required this.category})
      : super(key: key);
  final String city;
  final String category;
  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  ProductNameProvider productNameProvider = ProductNameProvider();
  String query = "";

  searchItem1(String query) {
    List<ProductNameModel> searchProduct =
        productNameProvider.getProductNameList.where((element) {
      return element.ProductName.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

  void initState() {
    productNameProvider =
        Provider.of<ProductNameProvider>(context, listen: false);
    productNameProvider.getProductNameData(widget.city, widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productNameProvider = Provider.of<ProductNameProvider>(context);
    productNameProvider.getProductNameData(widget.city, widget.category);
    List<ProductNameModel> _searchItem = searchItem1(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.grey.shade200,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      // Container(
      //   //width: 160,
      //   child: MaterialButton(
      //     child: Text("ADD ENTRY"),
      //     color: Colors.blue.shade100,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //         10,
      //       ),
      //     ),
      //     onPressed: () {
      //       // balanceSheetProvider.updateBalanceData(
      //       //     Balance: 0, context: context);
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (context) => AddEntry(),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      // Container(
      //   //width: 160,
      //   child: MaterialButton(
      //     child: Text("SEARCH BY BOOK NAME"),
      //     color: Colors.blue.shade100,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //         10,
      //       ),
      //     ),
      //     onPressed: () {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => ListAddress(
      //       Grandtotal: grandtotal,
      //     ),
      //   ),
      // );
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
            Container(
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.shade100,
                  // fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: "Search by Date in the inventory".toUpperCase(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
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
            // ///////////////////////////////////////////////
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            Column(
                children: _searchItem.map((e) {
              return GestureDetector(
                  onTap: () {
                    //print(e.ProductName);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            //TestPage(ProductName: e.ProductName),
                            ProductDetailPage(
                                ProductName: e.ProductName,
                                city: widget.city,
                                category: widget.category),
                      ),
                    );
                  },
                  child: SingleEntry(ProductName: e.ProductName));
            }).toList()),
            //EntryBox(),
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

  Widget SingleEntry({required String ProductName}) {
    return Column(
      children: [
        Container(
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
            ProductName,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}
