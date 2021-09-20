import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ikkhuras_inventory/HomePage/homepage.dart';
import 'package:ikkhuras_inventory/Models/balancesheetModel.dart';
import 'package:ikkhuras_inventory/PDF/pdfPage.dart';
import 'package:ikkhuras_inventory/Providers/balancesheet_provider.dart';
import 'package:ikkhuras_inventory/Providers/inputoutput_provider.dart';
import 'package:ikkhuras_inventory/Providers/productdetail_provider.dart';
import 'package:ikkhuras_inventory/Providers/productname_provider.dart';
import 'package:ikkhuras_inventory/StartingPage/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceSheetProvider>(
          create: (context) => BalanceSheetProvider(),
        ),
        ChangeNotifierProvider<InputOutputProvider>(
          create: (context) => InputOutputProvider(),
        ),
        ChangeNotifierProvider<ProductNameProvider>(
          create: (context) => ProductNameProvider(),
        ),
        ChangeNotifierProvider<ProductDetailProvider>(
          create: (context) => ProductDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IkkhuRas Inventory',
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //return Login();
              if (snapshot.hasData) {
                return HomePage();
                // return ProductScreen(categoryoption: "Oil");
              } else {
                return Login();
              }
            }),
      ),
    );
  }
}
