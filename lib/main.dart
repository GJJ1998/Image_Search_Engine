import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'imageScreen.dart';

void main() => runApp(MyApp());

String search;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(   
      debugShowCheckedModeBanner: false,   
      title: 'Images',      
      theme: ThemeData(       
        primarySwatch: Colors.cyan,
        fontFamily: 'Nunito',
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController t1 = new TextEditingController();    

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(       
        title: Center(
          child: Text(
            'Images',  
            style: TextStyle(
              color: Colors.white
            ),        
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Row(
                children: <Widget>[
                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(      
                          controller: t1,                       
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 18.0
                          ),         
                          decoration: InputDecoration(  
                            labelStyle: TextStyle(
                              fontSize: 20.0
                            ),                   
                            labelText: 'Image Search :',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),                        
                            ),                      
                          ),
                          onChanged: (String val){
                            search = val;
                          },
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(                
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        ),
                      color: Colors.cyan,
                      height: 50.0,
                      splashColor: Colors.cyan[100],
                      onPressed: (){
                        // search = t1.text;
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            // builder: (context) => t1.text.isNotEmpty?ImageScreen(text: t1.text,):MyError(),
                            builder: (context) => t1.text.isNotEmpty?ImageScreen():MyError(),
                            ),
                          // MaterialPageRoute(builder: (context) => ImageScreen())
                          );
                      },
                    ),
                  ),                      
                  // IconButton(
                  //   icon: IconTheme(
                  //     child: Icon(Icons.search),
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
          ),
        ),
      ),
    );
  }
}

class MyError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Nunito',
        brightness: Brightness.dark    
      ),
      home: Scaffold(          
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Error',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error ...',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0                
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Please Enter Valid Input',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0                
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}


class ImageScreen extends StatelessWidget {

  // static String text = mn.search.isNotEmpty?mn.search:'flower';
  // final String text;
  // ImageScreen();

  @override
  Widget build(BuildContext context) {
    // print(text);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Nunito',        
        brightness: Brightness.dark
      ),
      home: ImagesRepresentaion(),
    );
  }
}

class ImagesRepresentaion extends StatefulWidget {

  // final String text;
  // ImagesRepresentaion({this.text});

  _ImagesRepresentaionState createState() => _ImagesRepresentaionState();
}

class _ImagesRepresentaionState extends State<ImagesRepresentaion> {

  // _ImagesRepresentaionState({this.text});
  // final String text; 
  List myData = [];
  // var json = JsonDecoder('assets/file.json');
  // static String text = mn.search.isNotEmpty?mn.search:'flower';
  String url = 'https://pixabay.com/api/?key=11036060-ac3552a3165fbbe2e29c0a30e&q=$search&image_type=photo';
  // List myData;
  // try {
    
  Future<String> makeRequest() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
      );
      setState(() {
          var extractedData = json.decode(response.body);
          myData = extractedData["hits"];                
            });
    // var extractedData = json.decode(response.body);
    // myData = extractedData["hits"];  
    // List data;
    // myData = (response.body)  
    // print(response.body);  
    // var extractData = jsonDecode(response.body);
    // myData = JsonDecoder(response.body['hits']);
    // myData = extractData["hits"];
    // print(extractData);
    return response.toString();
  }
  // } catch (e) {
  // }
  // Future<String> makeRequest() async{
  //   var response = await http.get(
  //     Uri.encodeFull(url),
  //     headers: {"Accept": "application/json"}
  //     );
  //     setState(() {
  //         var extractedData = json.decode(response.body);
  //         myData = extractedData["hits"];                
  //           });
  //   // var extractedData = json.decode(response.body);
  //   // myData = extractedData["hits"];  
  //   // List data;
  //   // myData = (response.body)  
  //   // print(response.body);  
  //   // var extractData = jsonDecode(response.body);
  //   // myData = JsonDecoder(response.body['hits']);
  //   // myData = extractData["hits"];
  //   // print(extractData);
  //   return response.toString();
  // }

  @override
    void initState() {
      // 
      super.initState();
      this.makeRequest();
    }

  @override
  Widget build(BuildContext context) {
    // try {
      return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  '$search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  )
                ),
            ),
            body: 
            // FutureBuilder(
              // future: DefaultAssetBundle.of(context).loadString('assets/file.json'),
              // builder: (BuildContext context, AsyncSnapshot snapshot) {

                // var data = jsonDecode(snapshot.data.toString());
                // List myData = data["hits"];

                // print(MyData);
                // return 
                ListView.builder(                
                  itemBuilder: (BuildContext context, int index) {
                    // makeRequest();
                    // var data = json.decode(makeRequest().toString());
                    // List myData = data["hits"];
                    return Container(
                        padding: EdgeInsets.all(8.0),            
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Text(
                                      myData[index]["user"][0],
                                      style: TextStyle(
                                        fontSize: 20.0
                                      ),
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      myData[index]["user"],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.cyan
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(myData[index]["largeImageURL"])
                              // child: Image.asset('assets/jaquar.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,                  
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.cyan,
                                    size: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        myData[index]["favorites"].toString(),
                                        style: TextStyle(
                                          color: Colors.cyan,
                                          // fontFamily: 'Nunito',
                                          fontSize: 20.0                            
                                        ),
                                        ),
                                    ),
                                    // VerticalDivider(),
                                    Icon(
                                      Icons.file_download,
                                      color: Colors.cyan,
                                      size: 30.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          myData[index]["downloads"].toString(),
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            // fontFamily: 'Nunito',
                                            fontSize: 20.0                            
                                          ),
                                          ),
                                      ),
                                      // VerticalDivider(),
                                    Icon(
                                      Icons.format_size,
                                      color: Colors.cyan,
                                      size: 30.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          myData[index]["webformatHeight"].toString() + 'X' + myData[index]["webformatWidth"].toString(),
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            // fontFamily: 'Nunito',
                                            fontSize: 20.0                            
                                          ),
                                          ),
                                      ),
                                      
                                ],
                              ),
                            ),
                          Divider(
                            height: 3.0,
                          ),
                          ],
                        ),   
                        // child: Image.asset(
                        //   'assets/jaquar.jpg'
                        // ),
                      );
                  },                
                  itemCount: myData.length,
                  // itemCount: myData.length,
                ),          
          ); 
  }
}
// class ImageScreen extends StatefulWidget {
//   _ImageScreenState createState() => _ImageScreenState();
// echo "# Image_Search_Engine" >> README.md
// git init
// git add .
// git commit -m "first commit"
// git remote add origin https://github.com/GJJ1998/Image_Search_Engine.git
// git push -u origin master

// }

// class _ImageScreenState extends State<ImageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//             title: Text('image'),
//           ),
//           body: Container(
//             padding: EdgeInsets.all(32.0),
//             child: Center(
//               child: Column(
//                 children: <Widget>[],
//               ),
//             ),
//           ),
//         );
    
//   }
// }
  