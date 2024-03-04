
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http_crud_using_provider_and_app_structure/src/common/service/network_service.dart';

import '../../data/models/product_model.dart';

class ProductFormController extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<Product> items = [];
  bool isLoading = false;

  Future<void> create() async {
    Product product = Product(
      name: nameController.text.trim(),
      description: descController.text.trim(),
      price: priceController.text.trim(),
    );
    final response = await NetworkService.POST(NetworkService.apiOfProducts, product.toJson());
    if (response != null) {
      nameController.clear();
      descController.clear();
      priceController.clear();
      log("Successfully posted");
    } else {
      log("Failed to add product");
    }
  }


  Future<void> readPosts() async{
    items = await NetworkService.readPosts();
    notifyListeners();
  }

  void initState(BuildContext context){
    readPosts().then((value) {
      isLoading = true;
      notifyListeners();
    });
  }


}