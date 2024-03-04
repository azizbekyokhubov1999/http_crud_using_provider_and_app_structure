import 'package:flutter/material.dart';
import 'package:http_crud_using_provider_and_app_structure/src/feature/controllers/home_controller.dart';
import 'package:http_crud_using_provider_and_app_structure/src/feature/controllers/product_form_controller.dart';
import 'package:http_crud_using_provider_and_app_structure/src/feature/view/pages/home_page.dart';
import 'package:http_crud_using_provider_and_app_structure/src/feature/view/pages/product_form_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
       ChangeNotifierProvider(create: (context) => HomeController()),
       ChangeNotifierProvider(create: (context) => ProductFormController()),
        ],
      child: MaterialApp(
        title: 'Structure demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/product_form': (context) => ProductForm(),
        },
      ),
    );
  }
}