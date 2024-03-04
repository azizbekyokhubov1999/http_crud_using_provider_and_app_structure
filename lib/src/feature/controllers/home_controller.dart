import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/service/network_service.dart';
import '../../data/models/product_model.dart';

class HomeController extends ChangeNotifier{

  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  bool isLoading = false;
  List<Product> items = [];

  Future<void> getAllProducts() async {
    String? result = await NetworkService.GET(NetworkService.apiOfProducts);
    items = productFromJson(result!);
    isLoading = true;
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final updatedProduct = {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price,
    };

    await NetworkService.PUT('${NetworkService.apiOfProducts}/${product.id}', updatedProduct);
    await getAllProducts();
  }


  Future<void> deleteProduct(String productId) async {
    await NetworkService.DELETE('${NetworkService.apiOfProducts}/$productId');
   await getAllProducts();
  }


  void initState(BuildContext context){
    getAllProducts();
  }


  Future<void> editUserInfo(BuildContext context, String? id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Update Product Info',
                    style: TextStyle(
                      color: Color.fromRGBO(99, 7, 181, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Name:',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(158, 118, 194, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    height: 40,
                    child: TextField(
                      controller: updateNameController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only( left: 14),
                        hintText: 'name',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(99, 7, 181, 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(158, 118, 194, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6,
                              offset: Offset(0, 2)
                          )
                        ]
                    ),
                    height: 40,
                    child: TextField(
                      controller: updateDescController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5, left: 14),
                          hintText: 'description',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(99, 7, 181, 1)
                          )
                      ),
                    ),

                  )
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Price: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(158, 118, 194, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6,
                              offset: Offset(0, 2)
                          )
                        ]
                    ),
                    height: 40,
                    child: TextField(
                      controller: updatePriceController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5, left: 14),
                          hintText: 'price',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(99, 7, 181, 1)
                          )
                      ),
                    ),
                  )
                ],
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: MaterialButton(
                  onPressed: () async {
                    Product product = Product(
                        id: id,
                        name: updateNameController.text.trim(),
                        description: updateDescController.text.trim(),
                        price: updatePriceController.text.trim()
                    );
                    await updateProduct(product).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  color: const Color.fromRGBO(99, 7, 181, 1),
                  child: const Text('Update',
                    style: TextStyle(color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}