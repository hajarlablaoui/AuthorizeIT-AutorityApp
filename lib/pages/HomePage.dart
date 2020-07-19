import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/pages/accepted.dart';
import 'package:flutterprojects/pages/refused.dart';
import 'package:http/http.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutterprojects/shared/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String scanResult = '';
  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
    setState(()  {
      scanResult = cameraScanResult;
    });
    Map data = jsonDecode(scanResult);

   try{
     Response response= await get("https://my-json-server.typicode.com/iGX10/AuthorizeIT-MkeddemApp/citoyens?cin="+data['cin']);
     List responseData= jsonDecode(response.body);
     if(response.statusCode==200){
       if(responseData.length!=0){
         Navigator.pushNamed(context, '/accepted',arguments: {
           'nom': data['nom'],
           'prenom':data['prenom']
         });
       }
       else{
         Navigator.pushNamed(context, '/refused',arguments: {
           'error': "Citoyen Non Autorisé!"
         });

       };
     }
     else{
       Navigator.pushNamed(context, '/refused',arguments: {
         'error': "Problème au niveau du serveur"
       });
     }
   }
   catch(e){
     Navigator.pushNamed(context, '/refused',arguments: {
     'error':e.toString()
     });

   }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themePrimaryColor,
      appBar: AppBar(
        title: Text('AuthorizeIT',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: themePrimaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Appuyer dans ci-dessous pour scanner un code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 30),
            FlatButton(
              color: themePrimaryColor,
              child: Image(
                image: AssetImage('assets/qr-code.png'),
                height: 100,
                width: 100,
              ),
              onPressed: scanQRCode,
            )
          ],
        ),
      ),
    );
  }



}



