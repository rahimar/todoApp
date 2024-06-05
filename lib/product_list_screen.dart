import 'dart:async';
import 'dart:convert';

import 'package:app/add_product.dart';
import 'package:app/update_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  bool _getProductListProgress = false;

  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListProgress = true,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child:  ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _bulidProductItem(productList[index]);
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 Future<void> _getProductList() async {
    _getProductListProgress = true;
    setState(() {});
    productList.clear();
    const String ListProductUrl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';

    Uri uri = Uri.parse(ListProductUrl);
     http.Response response = await http.get(uri);


    if(response.statusCode == 200){
      final decodeData = jsonDecode(response.body);

      final jsonProductList = decodeData['data'];

      for(Map<String, dynamic> p in jsonProductList){
        Product product = Product(
            id: p['_id'] ?? '',
            productName: p['ProductName'] ?? '',
            productCode: p['ProductCode'] ?? '',
            unit: p['UnitPrice'] ?? '',
            qty: p['Qty'] ?? '',
            price: p['TotalPrice'] ?? '',
            image: p['Img'] ?? '',
        );

        productList.add(product);

      }


    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product List Failed!')),
      );
    }
    print(response.statusCode);
    print(response.body);
    _getProductListProgress = false;
    setState(() {});
 }
  Widget _bulidProductItem(Product product) {
    return ListTile(
      leading: Image.network(
        'https://images.prothomalo.com/prothomalo%2Fimport%2Fmedia%2F2016%2F05%2F18%2Fdc894f911a00bc75a08b59d62ca8327c-Neela--1-.jpg?rect=0%2C0%2C1349%2C899&auto=format%2Ccompress&fmt=webp&format=webp&w=300&dpr=1.0',
        height: 60,
      ),
      title: Text(product.productName),
      subtitle: Wrap(
        children: [
          Text('Product Price: ${product.price}'),
          Text('Quantity:${product.qty}'),
          Text('Best product item'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
             final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdateProduct(product: product,),),
              );
             if(result == true){
               _getProductList();
             }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirm(product.id);
            },
          ),
        ],
      ),
    );
  }


  void _showDeleteConfirm(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure to delete'),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: () {
                Navigator.pop(context);
                _deleteProduct(productId);
              }, child: Text('Yes, Delete')),
            ],
          );
        });
  }


  Future<void> _deleteProduct(String productId) async {
    _getProductListProgress = true;
    setState(() {});
    String deletep =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';

    Uri uri = Uri.parse(deletep);
    http.Response response = await http.get(uri);

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Delete Successfully')),
      );
      _getProductList();
    }else{
      _getProductListProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delete Add Failed!')),
      );
    }

  }


}

class Product {
  final String id;
  final String productName;
  final String productCode;
  final String unit;
  final String qty;
  final String price;
  final String image;

  Product(
  {
      required this.id,
      required this.productName,
      required this.productCode,
    required this.unit,
    required this.qty,
    required this.price,
    required this.image,
   });
}
