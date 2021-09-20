import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/BalanceSheet/addEntry.dart';
import 'package:ikkhuras_inventory/BalanceSheet/inputParticular.dart';
import 'package:ikkhuras_inventory/Inventory/inventory.dart';
// import 'package:ikkhuras_inventory/Models/balancesheet.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key, required this.city, required this.category})
      : super(key: key);
  final String city;
  final String category;

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductNameProvider productNameProvider = ProductNameProvider();
  String ProductName = "";

  //  searchItem1(String ProductName) {
  //   int  searchProduct =
  //       productNameProvider.getProductNameList.where((element) {
  //     return element.ProductName.toLowerCase().compareTo(ProductName);
  //   }).toList();
  //   return searchProduct;
  // }

  searchItem1(String ProductName) {
    List<ProductNameModel> searchProduct =
        productNameProvider.getProductNameList.where((element) {
      return element.ProductName.toLowerCase() == (ProductName);
    }).toList();
    return searchProduct;
  }

  // searchItem1(String ProductName) {
  //   List<ProductNameModel> searchProduct =
  //       productNameProvider.getProductNameList.where((element) {
  //     return element.ProductName.toLowerCase().contains(ProductName);
  //   }).toList();
  //   return searchProduct;
  // }

  void initState() {
    productNameProvider =
        Provider.of<ProductNameProvider>(context, listen: false);
    productNameProvider.getProductNameData(widget.city, widget.category);
    //productNameProvider.getProductNameData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productNameProvider = Provider.of<ProductNameProvider>(context);
    productNameProvider.getProductNameData(widget.city, widget.category);
    //productNameProvider.getProductNameData();
    List<ProductNameModel> _searchItem = searchItem1(ProductName);

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
      body: Form(
        key: _formKey,
        child: Container(
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
              //////////////// ENTER PRODUCTS NAME heading  ///////////////
              Container(
                //width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.yellow.shade100,
                child: Center(
                    child: Text(
                  "ENTER BOOK NAME",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              ///////////////////////////////////////////////
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ////////////////////Text Field //////////////////////////
              TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "* Required";
                  }
                  /* else if (value != null && value.length < 6) {
              return "Password should be atleast 6 characters";
            } else if (value != null && value.length > 15) {
              return "Password should not be greater than 15 characters";
            }
            */
                  else
                    return null;
                },
                onChanged: (value) {
                  ProductName = value;
                },
                style: TextStyle(
                  fontSize: 17,
                  //color: Colors.red,
                ),
                decoration: InputDecoration(
                    // labelText: labelText,
                    // labelStyle: TextStyle(
                    //   fontSize: 17,
                    //   color: Colors.black,
                    // ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    )),
                cursorColor: Colors.blue,
              ),
              ///////////////////////////////////////////////////////
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              //////////////// Add Button  //////////////
              GestureDetector(
                onTap: () {
                  validation();
                  // productNameProvider.addProductName(
                  //     ProductName: ProductName, context: context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  color: Colors.blue.shade100,
                  child: Center(
                      child: Text(
                    "ADD",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validation() async {
    final FormState _form = _formKey.currentState!;
    if (_form.validate()) {
      // productNameProvider.addProductName(
      //     ProductName: ProductName,
      //     context: context,
      //     city: widget.city,
      //     category: widget.category);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (ctx) =>
      //         //TestPage(ProductName: e.ProductName),
      //         InventoryPage(city: widget.city, category: widget.category),
      //   ),
      // );

      List<ProductNameModel> _searchItem = searchItem1(ProductName);
      int len = _searchItem.map((e) {}).toList().length;
      // print(len);
      if (len == 0) {
        // print("Yes");
        productNameProvider.addProductName(
            ProductName: ProductName,
            context: context,
            city: widget.city,
            category: widget.category);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                //TestPage(ProductName: e.ProductName),
                InventoryPage(city: widget.city, category: widget.category),
          ),
        );
      } else {
        MySnackBar(context,
            "You already have a book with this name. Please enter new name!!!");
        print("Already");
      }
    } else {
      print("No");
    }
  }

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
}
