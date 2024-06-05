import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitTEController = TextEditingController();
  final TextEditingController _qtyTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewProductProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Product Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                TextFormField(
                  controller: _codeTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Code',
                    labelText: 'Code',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Product Code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                TextFormField(
                  controller: _unitTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Unit Price',
                    labelText: 'Unit Price',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Product Unit Price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                TextFormField(
                  controller: _qtyTEController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Qty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                TextFormField(
                  controller: _totalTEController,
                  decoration: InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Product Price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                TextFormField(
                  controller: _imageTEController,
                  decoration: InputDecoration(
                    hintText: 'Image',
                    labelText: 'Image',
                  ),
                  validator: (String? value){
                    if(value ==null || value.trim().isEmpty){
                      return 'Write Your Product Image';
                    }
                    return null;
                  },
                ),
                const SizedBox(height:16),
                Visibility(
                  visible: _addNewProductProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(

                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _addProduct();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _addProduct() async {
    _addNewProductProgress = true;
    setState(() {});
    const String addProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Map<String, dynamic> inputData = {
      "Img" : _imageTEController.text.trim(),
      "ProductName" : _nameTEController.text,
      "ProductCode" : _codeTEController.text,
      "Qty" : _qtyTEController.text,
      "TotalPrice": _totalTEController.text,
      "UnitPrice": _unitTEController.text,

    };

    Uri uri = Uri.parse(addProductUrl);
    http.Response response = await http.post(uri,
        body: jsonEncode(inputData),
         headers: {'content-type':'application/json'},
    );
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    _addNewProductProgress = false;
    setState(() {});
    if(response.statusCode == 200){
      _nameTEController.clear();
      _codeTEController.clear();
      _unitTEController.clear();
      _totalTEController.clear();
      _qtyTEController.clear();
      _imageTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product Add Successfully')),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Add Failed!')),
      );
    }
  }


  @override
  void dispose(){
    _nameTEController.dispose();
    _unitTEController.dispose();
    _qtyTEController.dispose();
    _totalTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }


}


