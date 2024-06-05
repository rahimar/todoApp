import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_page.dart';

class GalarytListScreen extends StatefulWidget {
  const GalarytListScreen({super.key});

  @override
  State<GalarytListScreen> createState() => _GalaryListScreenState();
}

class _GalaryListScreenState extends State<GalarytListScreen> {

  bool _getGalleryListProgress = false;

  List<Gallery> galleryList = [];

  @override
  void initState() {
    super.initState();
    _getGalleryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery List'),
      ),
      body: Visibility(
        visible: _getGalleryListProgress = true,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child:  ListView.separated(
          itemCount: galleryList.length,
          itemBuilder: (context, index) {
            return _bulidGalleryItem(galleryList[index]);
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),

    );
  }

 Future<void> _getGalleryList() async {
   _getGalleryListProgress = true;
    setState(() {});
    galleryList.clear();
    const String ListGUrl =
        'https://jsonplaceholder.typicode.com/photos';

    Uri uri = Uri.parse(ListGUrl);
     http.Response response = await http.get(uri);


    if(response.statusCode == 200){
      final decodeData = jsonDecode(response.body);

      final jsonGList = decodeData;

      for(Map<String, dynamic> p in jsonGList){
        Gallery gallery = Gallery(
            id: p['id'] ?? '',
          title: p['title'] ?? '',
          albumId: p['albumId'] ?? '',
          url: p['url'] ?? '',
          thumbnailUrl: p['thumbnailUrl'] ?? '',
        );

        galleryList.add(gallery);

      }


    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery List Failed!')),
      );
    }
    print(response.statusCode);
    print(response.body);
   _getGalleryListProgress = false;
    setState(() {});
 }
  Widget _bulidGalleryItem(Gallery gallery) {
    return ListTile(
      leading: Image.network(
        gallery.url,
        height: 60,
      ),
      title: RawMaterialButton(
    onPressed: () {
      Navigator.push(
      context,
        MaterialPageRoute(
        builder: (context) => DetailsPage(
            title: gallery.title,
             index: gallery.id,
             imagePath: gallery.url,
             details: gallery.title,
          ),
        ),
      );
    },
    child: Text(gallery.title),
      ),

    );
  }





}

class Gallery {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Gallery(
  {
      required this.id,
      required this.albumId,
      required this.title,
    required this.url,
    required this.thumbnailUrl,
   });
}
