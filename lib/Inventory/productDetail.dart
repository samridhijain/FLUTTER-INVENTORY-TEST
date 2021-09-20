import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/BalanceSheet/addEntry.dart';
import 'package:ikkhuras_inventory/BalanceSheet/inputParticular.dart';
import 'package:ikkhuras_inventory/Inventory/addProduct.dart';
import 'package:ikkhuras_inventory/Inventory/addProductEntry.dart';
import 'package:ikkhuras_inventory/Inventory/inventory.dart';
import 'package:ikkhuras_inventory/Inventory/search.dart';
// import 'package:ikkhuras_inventory/Models/balancesheet.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/productdetailModel.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/productdetail_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:ikkhuras_inventory/loading.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(
      {Key? key,
      required this.ProductName,
      required this.city,
      required this.category})
      : super(key: key);
  final String ProductName;
  final String city;
  final String category;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductDetailProvider productDetailProvider = ProductDetailProvider();

  String DefaultDate = "";
  int DefaultSale = 0;
  int DefaultAdd = 0;
  int DefaultPreQuantity = 0;
  // int DefaultBatchNo = 0;
  int DefaultQauntityLeft = 0;
  int Sale = 0;
  int Add = 0;
  int QuantityLeft = 0;

  bool loading = false;

  void initState() {
    //print(widget.ProductName);
    productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);
    productDetailProvider.getProductDetailData(
        widget.ProductName, widget.city, widget.category);
    //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
    // productDetailProvider.getProductDetailData("Oil");
    //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
    // setState(() => loading = true);
    super.initState();
    //DefaultData();
    //print(widget.ProductName);
    // setState(() {
    //   loading = false;
    //   print("false");
    // });
  }

  @override
  void didChangeDependencies() {
    //print(widget.ProductName);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    productDetailProvider.getProductDefaultDetailData(
        widget.ProductName, widget.city, widget.category);
    DefaultData();
  }

  @override
  Widget build(BuildContext context) {
    productDetailProvider = Provider.of<ProductDetailProvider>(context);
    productDetailProvider.getProductDetailData(
        widget.ProductName, widget.city, widget.category);
    // productDetailProvider.getProductDetailData("Oil");
    productDetailProvider.getProductDefaultDetailData(
        widget.ProductName, widget.city, widget.category);
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            bottomNavigationBar: Container(
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    //width: 160,
                    child: MaterialButton(
                      child: Text("ADD NEW ENTRY"),
                      color: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AddProductEntry(
                              ProductName: widget.ProductName,
                              city: widget.city,
                              category: widget.category,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    //width: 160,
                    child: MaterialButton(
                      child: Text("SEARCH BY DATE"),
                      color: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      onPressed: () {
                        // DateTime date1 = DateTime.now();
                        // print(date1);
                        //DateTime.parse(date1.toDate().toString());
                        //String s = '1984–04–02';
                        // DateTime parseDt = DateTime.parse(strDt);
                        // print(parseDt);
                        // String t = '2021-08-15';
                        // DateTime dt = DateTime.parse(t);
                        // DateTime f = DateTime.now().subtract(Duration(days: 1));
                        // print(f.isBefore(dt));
                        //print(dt); // 2020-01-02 03:04:05.000

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Search(
                                search:
                                    productDetailProvider.getProductDetailList),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.01),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        "Book Name: ${widget.ProductName}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    //////////////// Add New Entry Button  ///////////////
                    // GestureDetector(
                    //   onTap: () {
                    //     // setState(() {
                    //     //   loading = true;
                    //     //   print("true");
                    //     // });
                    //     //setState(() => loading = true);
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (ctx) =>
                    //             AddProductEntry(ProductName: widget.ProductName),
                    //       ),
                    //     );
                    //     //setState(() => loading = false);
                    //   },
                    //   child: Container(
                    //     //width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 0.1,
                    //     color: Colors.blue.shade100,
                    //     child: Center(
                    //         child: Text(
                    //       "ADD NEW ENTRY",
                    //       style: TextStyle(
                    //         fontSize: 17.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     )),
                    //   ),
                    // ),
                    // ///////////////////////////////////////////////
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ////////////// Current Data ////////////////////////
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      //color: Colors.yellow.shade100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date : $DefaultDate".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              // Text(
                              //   "Batch no : $DefaultBatchNo".toUpperCase(),
                              //   style: TextStyle(
                              //     fontSize: 15.0,
                              //     //fontWeight: FontWeight.bold,
                              //     color: Colors.red,
                              //   ),
                              // ),
                              Text(
                                "Previous Quantity : $DefaultPreQuantity"
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          // Text(
                          //   "Previous Quantity : $DefaultPreQuantity"
                          //       .toUpperCase(),
                          //   style: TextStyle(
                          //     fontSize: 15.0,
                          //     // fontWeight: FontWeight.bold,
                          //     color: Colors.red,
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AddTextfieldBox(
                                labelText: "Add (+) : $DefaultAdd",
                                // initialvalue: DefaultAdd,
                              ),
                              SaleTextfieldBox(
                                labelText: "Distribute (-) : $DefaultSale",
                                // initialvalue: DefaultSale
                              ),
                            ],
                          ),
                          MaterialButton(
                            color: Colors.blue.shade100,
                            onPressed: () {
                              validation();
                              // int add = int.parse(addController.text);
                              // int sale = int.parse(saleController.text);
                              // setState(() {
                              //   QuantityLeft =
                              //       (DefaultPreQuantity + Add) - Sale;
                              // });
                              // productDetailProvider.updateProductDetail(
                              //     ProductName: widget.ProductName,
                              //     Date: DefaultDate,
                              //     Add: Add,
                              //     Sale: Sale,
                              //     QuantityLeft: QuantityLeft,
                              //     context: context);
                              // productDetailProvider.updateDefaultProductDetail(
                              //     ProductName: widget.ProductName,
                              //     Date: DefaultDate,
                              //     Add: Add,
                              //     Sale: Sale,
                              //     QuantityLeft: QuantityLeft,
                              //     context: context);
                            },
                            child: Text(
                              "UPDATE",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                //color: Colors.red,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Quantity Left : $QuantityLeft",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    //////////////////-------------/////////////////////////////
                    ////////Product detail Sheet//////
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),

                      // color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          Card(
                            color: Colors.blue.shade100,
                            elevation: 15.0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(child: Center(child: Text("Date"))),
                                  Expanded(
                                      child: Center(child: Text("PreQuan"))),
                                  // Expanded(
                                  //     child: Center(child: Text("BatchNo"))),
                                  Expanded(child: Center(child: Text("Add"))),
                                  Expanded(
                                      child: Center(child: Text("Distribute"))),
                                  Expanded(
                                      child: Center(child: Text("QuanLeft"))),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          EntryBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void DefaultData() {
    //setState(() => loading = true);
    //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
    List<ProductDetailModel> Name =
        productDetailProvider.getProductDefaultDetailList;
    Name.map((e) {
      setState(() {
        DefaultDate = e.Date;
        DefaultSale = e.Sale;
        DefaultAdd = e.Add;
        // DefaultBatchNo = e.BatchNo;
        DefaultPreQuantity = e.PreQuantity;
        DefaultQauntityLeft = e.QuantityLeft;
      });
    }).toList();
    // print(DefaultAdd);
    // print(DefaultDate);
    // print(DefaultSale);
    // setState(() => loading = false);
  }

  Widget EntryBox() {
    List<ProductDetailModel> Name = productDetailProvider.getProductDetailList;
    // List<ProductDetailModel> Name =
    //     productDetailProvider.getProductDefaultDetailList;
    return Column(
        children: Name.map((e) {
      return SingleEntry(
        Date: e.Date,
        PreQuantity: e.PreQuantity,
        // BatchNo: e.BatchNo,
        Add: e.Add,
        Sale: e.Sale,
        QuantityLeft: e.QuantityLeft,
        Email: e.Email,
      );
    }).toList());
  }

  void validation() async {
    final FormState _form = _formKey.currentState!;
    if (_form.validate()) {
      print("Yes");
      setState(() {
        QuantityLeft = (DefaultPreQuantity + Add) - Sale;
      });
      user = auth.currentUser!;
      productDetailProvider.updateProductDetail(
          ProductName: widget.ProductName,
          Date: DefaultDate,
          Add: Add,
          Sale: Sale,
          QuantityLeft: QuantityLeft,
          Email: user.email,
          context: context,
          city: widget.city,
          category: widget.category);
      productDetailProvider.updateDefaultProductDetail(
          ProductName: widget.ProductName,
          Date: DefaultDate,
          Add: Add,
          Sale: Sale,
          QuantityLeft: QuantityLeft,
          Email: user.email,
          context: context,
          city: widget.city,
          PreQuantity: DefaultPreQuantity,
          category: widget.category);
      productDetailProvider.updatePreQuantity(
          ProductName: widget.ProductName,
          QuantityLeft: QuantityLeft,
          context: context,
          city: widget.city,
          category: widget.category);
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

  Widget SingleEntry({
    required String Date,
    required int PreQuantity,
    //required int BatchNo,
    required int Add,
    required int Sale,
    required int QuantityLeft,
    required String Email,
  }) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: GestureDetector(
                child: Text(Date),
                onTap: () {
                  MySnackBar(context, "Data Updated by: $Email");
                  //print(Email);
                },
              )),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.0,
              ),
              Expanded(child: Text(PreQuantity.toString())),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.0,
              ),
              //Container(child: VerticalDivider(color: Colors.red)),
              // Expanded(child: Text(BatchNo.toString())),
              // VerticalDivider(
              //   color: Colors.black,
              //   thickness: 1.0,
              // ),
              Expanded(child: Text(Add.toString())),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.0,
              ),
              Expanded(child: Text(Sale.toString())),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.0,
              ),
              Expanded(child: Text(QuantityLeft.toString())),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }

  Widget AddTextfieldBox({
    required String labelText,
    //int? initialvalue,
    //required TextEditingController controller,
  }) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        validator: (value) {
          final n = num.tryParse(value!);
          if (value != null && value.isEmpty) {
            return "* Required";
          } else if (n == null) {
            return '"$value" is not a valid number';
          } else
            return null;
        },
        onChanged: (value) {
          setState(() {
            Add = int.parse(value);
          });
        },
        // initialValue: initialvalue.toString(),
        // controller: controller,
        obscureText: false,
        style: TextStyle(
          fontSize: 17,
          //color: Colors.red,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
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
    );
  }

  Widget SaleTextfieldBox({
    required String labelText,
    //int? initialvalue,
    //required TextEditingController controller,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        validator: (value) {
          final n = num.tryParse(value!);
          if (value != null && value.isEmpty) {
            return "* Required";
          } else if (n == null) {
            return '"$value" is not a valid number';
          } else
            return null;
        },
        onChanged: (value) {
          setState(() {
            Sale = int.parse(value);
          });
        },
        // initialValue: initialvalue.toString(),
        // controller: controller,
        obscureText: false,
        style: TextStyle(
          fontSize: 17,
          //color: Colors.red,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
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
    );
  }
}
