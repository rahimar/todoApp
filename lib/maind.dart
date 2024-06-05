import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build (BuildContext context){
    return MaterialApp(home:Home());
}
}

class Home extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Setting(),
                  ),
              );
            }, child: Text('Go to Setting')),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            }, child: Text('Go to Profile')),
          ],
        ),
      ),


    );
  }
}

class Profile extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: Text('Profile'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Back To Home')),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Setting(),
                ),
              );
            }, child: Text('Go to Setting')),
          ],
        ),
      ),


    );
  }
}

class Setting extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text('Setting'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Back')),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );}, child: Text('Go to Profile')),
          ],
        ),
      ),


    );
  }
}
