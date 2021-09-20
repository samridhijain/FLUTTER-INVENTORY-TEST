import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/Models/productdetailModel.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.search}) : super(key: key);
  final List<ProductDetailModel> search;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem1(String query) {
    List<ProductDetailModel> searchProduct = widget.search.where((element) {
      return element.Date.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductDetailModel> _searchItem = searchItem1(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.01),
          children: [
            // ListTile(
            //   title: Text("Enter Date"),
            // ),
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
                  fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: "Search by Date in the inventory",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            /////
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: Center(child: Text("Date"))),
                            Expanded(child: Center(child: Text("PreQuan"))),
                            // Expanded(child: Center(child: Text("BatchNo"))),
                            Expanded(child: Center(child: Text("Add"))),
                            Expanded(child: Center(child: Text("Distribute"))),
                            Expanded(child: Center(child: Text("QuanLeft"))),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // EntryBox(),
                  Column(
                    children: _searchItem.map((e) {
                      return SingleEntry(
                          Date: e.Date,
                          PreQuantity: e.PreQuantity,
                          // BatchNo: e.BatchNo,
                          Add: e.Add,
                          Sale: e.Sale,
                          QuantityLeft: e.QuantityLeft);
                      //Text(e.Date);
                    }).toList(),
                  )
                ],
              ),
            ),
            /////////
            //SearchProduct(name: "name", price: "price"),
            // Column(
            //   children: _searchItem.map((e) {
            //     return Text(e.Date);
            //   }).toList(),
            // )
          ],
        ),
      ),
    );
  }

  Widget SingleEntry(
      {required String Date,
      required int PreQuantity,
      // required int BatchNo,
      required int Add,
      required int Sale,
      required int QuantityLeft}) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(Date)),
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
}
