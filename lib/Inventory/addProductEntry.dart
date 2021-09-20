import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/BalanceSheet/addEntry.dart';
import 'package:ikkhuras_inventory/BalanceSheet/inputParticular.dart';
import 'package:ikkhuras_inventory/Inventory/addProduct.dart';
import 'package:ikkhuras_inventory/Inventory/productDetail.dart';
// import 'package:ikkhuras_inventory/Models/balancesheet.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/Models/prequantityModel.dart';
import 'package:ikkhuras_inventory/Models/productdetailModel.dart';
import 'package:ikkhuras_inventory/Models/productnameModel.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/productdetail_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:provider/provider.dart';
import 'package:date_time_format/date_time_format.dart';

class AddProductEntry extends StatefulWidget {
  const AddProductEntry(
      {Key? key,
      required this.ProductName,
      required this.city,
      required this.category})
      : super(key: key);
  final String ProductName;
  final String city;
  final String category;
  @override
  _AddProductEntryState createState() => _AddProductEntryState();
}

class _AddProductEntryState extends State<AddProductEntry> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductDetailProvider productDetailProvider = ProductDetailProvider();
  //String formattedDate = "";
  int PreQuantity = 209;
  int QuantityLeft = 0;
  //TextEditingController batchnoController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController saleController = TextEditingController();
  String DefaultDate = "";
  TextEditingController formattedDate = TextEditingController();

  void initState() {
    productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);
    productDetailProvider.getPreQuantityData(
        widget.ProductName, widget.city, widget.category);

    super.initState();
    //DateMethod();
    PreviousQuantity();
    //print(widget.ProductName);
  }

  @override
  void didChangeDependencies() {
    productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);
    productDetailProvider.getPreQuantityData(
        widget.ProductName, widget.city, widget.category);
    productDetailProvider.getProductDefaultDetailData(
        widget.ProductName, widget.city, widget.category);
    DefaultData();
    //print(formattedDate);

    PreviousQuantity();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void DefaultData() {
    //setState(() => loading = true);
    //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
    List<ProductDetailModel> Name =
        productDetailProvider.getProductDefaultDetailList;
    Name.map((e) {
      setState(() {
        DefaultDate = e.Date;
      });
    }).toList();

    //print(DefaultDate);
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        //print(selectedDate.format('Y-m-d'));
        // formattedDate = selectedDate.format('Y-m-d');
        // print(formattedDate);
        formattedDate.text = selectedDate.format('Y-m-d').toString();
        print(formattedDate.text);
      });
  }

  // void DateMethod() {
  //   DateTime dateTime = DateTime.now();
  //   setState(() {
  //     //formattedDate = dateTime.format('M j, Y');

  //     formattedDate = dateTime.format('Y-m-d');
  //   });

  //print(formattedDate.toString());
  //String formattedDate = dateTime.format('D, M j, H:i');
  //}

  void PreviousQuantity() {
    //productDetailProvider.getProductDefaultDetailData(widget.ProductName);
    List<PreQuantityModel> Name = productDetailProvider.getPreQuantityList;

    Name.map((e) {
      setState(() {
        PreQuantity = e.PreQuantity;
      });
    }).toList();
  }

  // DateTime selectedDate = DateTime.now();
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2000, 1),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       print(selectedDate.format('Y-m-d'));
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    productDetailProvider = Provider.of<ProductDetailProvider>(context);
    productDetailProvider.getPreQuantityData(
        widget.ProductName, widget.city, widget.category);
    //productDetailProvider.getProductDetailData(widget.ProductName);

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
      //             user = auth.currentUser!;
      //             print(user.email);
      //             productDetailProvider.addProductDetail(
      //                 ProductName: widget.ProductName,
      //                 Date: formattedDate,
      //                 PreQuantity: PreQuantity,
      //                 // BatchNo: int.parse(batchnoController.text),
      //                 Add: int.parse(addController.text),
      //                 Sale: int.parse(saleController.text),
      //                 QuantityLeft: QuantityLeft,
      //                 Email: user.email,
      //                 context: context,
      //                 city: widget.city);
      //             ////////////
      //             productDetailProvider.updateDefaultProductDetail(
      //                 ProductName: widget.ProductName,
      //                 Date: formattedDate,
      //                 PreQuantity: PreQuantity,
      //                 // BatchNo: int.parse(batchnoController.text),
      //                 Add: int.parse(addController.text),
      //                 Sale: int.parse(saleController.text),
      //                 QuantityLeft: QuantityLeft,
      //                 Email: user.email,
      //                 city: widget.city,
      //                 context: context);
      //             ////////////
      //             productDetailProvider.updatePreQuantity(
      //                 ProductName: widget.ProductName,
      //                 QuantityLeft: QuantityLeft,
      //                 context: context,
      //                 city: widget.city);
      //             //validation();
      //             // productDetailProvider.addProductDetail(
      //             //     ProductName: widget.ProductName,
      //             //     Date: formattedDate,
      //             //     PreQuantity: PreQuantity,
      //             //     BatchNo: int.parse(batchnoController.text),
      //             //     Add: int.parse(addController.text),
      //             //     Sale: int.parse(saleController.text),
      //             //     QuantityLeft: QuantityLeft,
      //             //     context: context);
      //             // ////////////
      //             // productDetailProvider.addDefaultProductDetail(
      //             //     ProductName: widget.ProductName,
      //             //     Date: formattedDate,
      //             //     PreQuantity: PreQuantity,
      //             //     BatchNo: int.parse(batchnoController.text),
      //             //     Add: int.parse(addController.text),
      //             //     Sale: int.parse(saleController.text),
      //             //     QuantityLeft: QuantityLeft,
      //             //     context: context);
      //             // ////////////
      //             // productDetailProvider.updatePreQuantity(
      //             //     ProductName: widget.ProductName,
      //             //     QuantityLeft: QuantityLeft,
      //             //     context: context);
      //             // // balanceSheetProvider.updateBalanceData(
      //             // //     Balance: 0, context: context);
      //             // // Navigator.of(context).push(
      //             // //   MaterialPageRoute(
      //             // //     builder: (context) =>
      //             // //         ProductDetailPage(ProductName: widget.ProductName),
      //             // //   ),
      //             // // );
      //           },
      //         ),
      //       ),
      //       // Container(
      //       //   //width: 160,
      //       //   child: MaterialButton(
      //       //     child: Text("SEARCH BY DATE"),
      //       //     color: Colors.blue.shade100,
      //       //     shape: RoundedRectangleBorder(
      //       //       borderRadius: BorderRadius.circular(
      //       //         10,
      //       //       ),
      //       //     ),
      //       //     onPressed: () {
      //       //       // Navigator.of(context).push(
      //       //       //   MaterialPageRoute(
      //       //       //     builder: (context) => ListAddress(
      //       //       //       Grandtotal: grandtotal,
      //       //       //     ),
      //       //       //   ),
      //       //       // );
      //       //     },
      //       //   ),
      //       // ),
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
                horizontal: MediaQuery.of(context).size.height * 0.01),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // Center(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       // Text("${selectedDate.toLocal()}".split(' ')[0]),
              //       SizedBox(
              //         height: 20.0,
              //       ),
              //       RaisedButton(
              //         onPressed: () => _selectDate(context),
              //         child: Text('Select date'),
              //       ),
              //     ],
              //   ),
              // ),
              // TextField(
              //   //focusNode: AlwaysDisabledFocusNode(),
              //   controller: formattedDate,
              //   onTap: () {
              //     _selectDate(context);
              //   },
              // ),
              Center(
                child: Text(
                  "Product Book: ${widget.ProductName}".toUpperCase(),
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
              ////////////////Text Field///////////////////////////
              Center(
                child: Text(
                  "Previous Quantity: $PreQuantity",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // DateTextfieldBox(
              //   labelText: "Date",
              //   initialvalue: formattedDate,
              // ),
              TextfieldBox1(labelText: "Date", controller: formattedDate),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // TextfieldBox(
              //     labelText: "Batch No", controller: batchnoController),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
              TextfieldBox(
                labelText: "Add (+)",
                controller: addController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextfieldBox(
                  labelText: "Distribute (-)", controller: saleController),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ///////////Calculate////////////////////
              MaterialButton(
                child: Text("Add Entry".toUpperCase()),
                color: Colors.blue.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                onPressed: () {
                  validation();
                },
              ),
              ///////////////////////////////////////////////
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Center(
                child: Text(
                  "Quantity Left is: $QuantityLeft",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "($PreQuantity + ${addController.text}) - ${saleController.text})",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
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
      // print("Yes");
      // int add = int.parse(addController.text);
      // int sale = int.parse(saleController.text);
      // setState(() {
      //   QuantityLeft = (PreQuantity + add) - sale;
      // });

      // String t = '2021-08-15';
      // DateTime dt = DateTime.parse(t);
      DateTime ft = DateTime.parse(formattedDate.text);
      DateTime dt = DateTime.parse(DefaultDate);
      //DefaultDate
      // print(formattedDate);
      //DateTime f = DateTime.now().subtract(Duration(days: 1));
      //DateTime f = dt.subtract(Duration(days: 1));
      //print(f.isBefore(dt));
      if (dt.isBefore(ft)) {
        print("Yes");
        int add = int.parse(addController.text);
        int sale = int.parse(saleController.text);
        setState(() {
          QuantityLeft = (PreQuantity + add) - sale;
        });

        //////////////////////////////----------

        user = auth.currentUser!;
        print(user.email);
        productDetailProvider.addProductDetail(
            ProductName: widget.ProductName,
            Date: formattedDate.text,
            PreQuantity: PreQuantity,
            // BatchNo: int.parse(batchnoController.text),
            Add: int.parse(addController.text),
            Sale: int.parse(saleController.text),
            QuantityLeft: QuantityLeft,
            Email: user.email,
            context: context,
            city: widget.city,
            category: widget.category);
        ////////////
        productDetailProvider.updateDefaultProductDetail(
            ProductName: widget.ProductName,
            Date: formattedDate.text,
            PreQuantity: PreQuantity,
            // BatchNo: int.parse(batchnoController.text),
            Add: int.parse(addController.text),
            Sale: int.parse(saleController.text),
            QuantityLeft: QuantityLeft,
            Email: user.email,
            city: widget.city,
            category: widget.category,
            context: context);
        ////////////
        productDetailProvider.updatePreQuantity(
            ProductName: widget.ProductName,
            QuantityLeft: QuantityLeft,
            context: context,
            category: widget.category,
            city: widget.city);
        //validation();
        // productDetailProvider.addProductDetail(
        //     ProductName: widget.ProductName,
        //     Date: formattedDate,
        //     PreQuantity: PreQuantity,
        //     BatchNo: int.parse(batchnoController.text),
        //     Add: int.parse(addController.text),
        //     Sale: int.parse(saleController.text),
        //     QuantityLeft: QuantityLeft,
        //     context: context);
        // ////////////
        // productDetailProvider.addDefaultProductDetail(
        //     ProductName: widget.ProductName,
        //     Date: formattedDate,
        //     PreQuantity: PreQuantity,
        //     BatchNo: int.parse(batchnoController.text),
        //     Add: int.parse(addController.text),
        //     Sale: int.parse(saleController.text),
        //     QuantityLeft: QuantityLeft,
        //     context: context);
        // ////////////
        // productDetailProvider.updatePreQuantity(
        //     ProductName: widget.ProductName,
        //     QuantityLeft: QuantityLeft,
        //     context: context);
        // // balanceSheetProvider.updateBalanceData(
        // //     Balance: 0, context: context);
        // // Navigator.of(context).push(
        // //   MaterialPageRoute(
        // //     builder: (context) =>
        // //         ProductDetailPage(ProductName: widget.ProductName),
        // //   ),
        // // );

      } else {
        MySnackBar(context, "Please Check your Date.....");
      }

      // productDetailProvider.addProductDetail(
      //     ProductName: widget.ProductName,
      //     Date: formattedDate,
      //     PreQuantity: PreQuantity,
      //     BatchNo: int.parse(batchnoController.text),
      //     Add: int.parse(addController.text),
      //     Sale: int.parse(saleController.text),
      //     QuantityLeft: QuantityLeft,
      //     context: context);
      // ////////////
      // productDetailProvider.addDefaultProductDetail(
      //     ProductName: widget.ProductName,
      //     Date: formattedDate,
      //     PreQuantity: PreQuantity,
      //     BatchNo: int.parse(batchnoController.text),
      //     Add: int.parse(addController.text),
      //     Sale: int.parse(saleController.text),
      //     QuantityLeft: QuantityLeft,
      //     context: context);
      // ////////////
      // productDetailProvider.updatePreQuantity(
      //     ProductName: widget.ProductName,
      //     QuantityLeft: QuantityLeft,
      //     context: context);
      // balanceSheetProvider.updateBalanceData(
      //     Balance: 0, context: context);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         ProductDetailPage(ProductName: widget.ProductName),
      //   ),
      // );
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

  Widget TextfieldBox({
    required String labelText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      validator: (value) {
        final n = num.tryParse(value!);
        if (value != null && value.isEmpty) {
          return "* Required";
        } else if (n == null) {
          return '"$value" is not a valid number';
        } else
          return null;
      },
      //initialValue: initialvalue, //cannot use intialvalue and controller together
      controller: controller,
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
    );
  }

  Widget TextfieldBox1({
    required String labelText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      validator: (value) {
        final n = num.tryParse(value!);
        // if (value != null && value.isEmpty) {
        //   return "* Required";
        // } else if (n == null) {
        //   return '"$value" is not a valid number';
        // } else
        //   return null;

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
      //initialValue: initialvalue, //cannot use intialvalue and controller together
      onTap: () {
        _selectDate(context);
      },
      controller: controller,
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
    );
  }

  // Widget DateTextfieldBox({
  //   required String labelText,
  //   String? initialvalue,
  //   //required TextEditingController controller,
  // }) {
  //   return TextFormField(
  //     validator: (value) {
  //       if (value != null && value.isEmpty) {
  //         return "* Required";
  //       }
  //       /* else if (value != null && value.length < 6) {
  //             return "Password should be atleast 6 characters";
  //           } else if (value != null && value.length > 15) {
  //             return "Password should not be greater than 15 characters";
  //           }
  //           */
  //       else
  //         return null;
  //     },
  //     onTap: () => _selectDate(context),
  //     onChanged: (value) {
  //       setState(() {
  //         formattedDate = value;
  //       });
  //     },
  //     initialValue: initialvalue,
  //     // controller: controller,
  //     obscureText: false,
  //     style: TextStyle(
  //       fontSize: 17,
  //       //color: Colors.red,
  //     ),
  //     decoration: InputDecoration(
  //         labelText: labelText,
  //         labelStyle: TextStyle(
  //           fontSize: 17,
  //           color: Colors.black,
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(15),
  //           borderSide: BorderSide(
  //             width: 1.5,
  //             color: Colors.blue,
  //           ),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(15),
  //           borderSide: BorderSide(
  //             width: 1,
  //             color: Colors.black,
  //           ),
  //         )),
  //     cursorColor: Colors.blue,
  //   );
  // }

  // Widget EntryBox() {
  //   List<ProductNameModel> Name = productNameProvider.getProductNameList;
  //   return Column(
  //       children: Name.map((e) {
  //     return GestureDetector(
  //         onTap: () {
  //           // Navigator.of(context).push(
  //           //   MaterialPageRoute(
  //           //       builder: (ctx) => DetailPage(
  //           //             Productid: e.Productid,
  //           //             Productname: e.Productname,
  //           //             Productsummary: e.Productsummary,
  //           //             Productoriginalprice: e.Productoriginalprice,
  //           //             Productdiscountprice: e.Productdiscountprice,
  //           //             Productimage: e.Productimage,
  //           //             Productimage2: e.Productimage2,
  //           //             Productimage3: e.Productimage3,
  //           //             Productimage4: e.Productimage4,
  //           //             Productbenefits: e.Productbenefits,
  //           //             Productdetail: e.Productdetail,
  //           //           )),
  //           // );
  //         },
  //         child: SingleEntry(ProductName: e.ProductName));
  //   }).toList());
  // }

  // Widget SingleEntry(
  //     {required String Date,
  //     required int PreQuantity,
  //     required int BatchNo,
  //     required int Add,
  //     required int Sale,
  //     required int QuantityLeft}) {
  //   return Column(
  //     children: [
  //       Container(
  //         color: Colors.white,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Expanded(child: Text(Date)),
  //             Expanded(child: Text(PreQuantity.toString())),
  //             Expanded(child: Text(BatchNo.toString())),
  //             Expanded(child: Text(Add.toString())),
  //             Expanded(child: Text(Sale.toString())),
  //             Expanded(child: Text(QuantityLeft.toString())),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.01,
  //       ),
  //     ],
  //   );
  // }
}
