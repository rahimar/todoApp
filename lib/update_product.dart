import 'dart:convert';

import 'package:app/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitTEController = TextEditingController();
  final TextEditingController _qtyTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName;
    _unitTEController.text = widget.product.unit;
    _qtyTEController.text = widget.product.qty;
    _totalTEController.text = widget.product.price;
    _imageTEController.text = widget.product.image;
    _codeTEController.text = widget.product.productCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
                ElevatedButton(

                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _updateProduct();
                      }
                    },
                    child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Map<String, dynamic> inputData = {
      "Img" : _imageTEController.text.trim(),
      "ProductName" : _nameTEController.text,
      "ProductCode" : _codeTEController.text,
      "Qty" : _qtyTEController.text,
      "TotalPrice": _totalTEController.text,
      "UnitPrice": _unitTEController.text,

    };
    String updatep =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

    Uri uri = Uri.parse(updatep);
    http.Response response = await http.post(uri,
      body: jsonEncode(inputData),
      headers: {'content-type':'application/json'},
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Update Successfully')),
      );
      Navigator.pop(context, true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Add Failed!')),
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
