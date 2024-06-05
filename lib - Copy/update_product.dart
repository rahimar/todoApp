import 'package:flutter/material.dart';
class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitTEController = TextEditingController();
  final TextEditingController _qtyTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
