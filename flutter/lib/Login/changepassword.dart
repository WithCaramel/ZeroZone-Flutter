import 'dart:ffi';

import 'package:flutter/material.dart';
import 'login.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zerozone/server.dart';

class changePasswordPage extends StatefulWidget {

  final String email;
  const changePasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {

  final _formKey2 = new GlobalKey<FormState>();

  final TextEditingController _pass = new TextEditingController();
  final TextEditingController _checkPass = new TextEditingController();

  changePassword(String pass) async {
    if(_formKey2.currentState!.validate()){
      var url = Uri.http('${serverHttp}:8080', '/members/password');

      print(widget.email);

      final data = jsonEncode({'email': widget.email, 'newPassword': pass});

      var response = await http.patch(url, body: data, headers: {'Accept': 'application/json', "content-type": "application/json"} );

      print(response.statusCode);
      print("pass: ${pass}");
      print("data: ${data}");

      print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');

      if (response.statusCode == 200) {
        print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');

        var body = jsonDecode(response.body);

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);

      }
      else {
        print('error : ${response.reasonPhrase}');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xffF3F4F6),
              Color(0xffEFF4FA),
              Color(0xffECF4FE),
            ],
            stops: [0.3, 0.7, 0.9, ],
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: new Form(
                key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:80.0, bottom: 50.0),
                      child: Center(
                        child: Text(
                          '???????????? ??????',
                          style: new TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xff4478FF) ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Text(
                        '????????? ????????????',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff95979A), width: 2.0),
                            ),
                            hintText: '????????? ??????????????? ???????????????.'
                        ),
                        validator: (value) => value!.isEmpty ? '????????? ??????????????? ????????? ?????????.' : null,
                        controller: _pass,
                      ),
                      height: 40,
                      width: 240,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      margin: EdgeInsets.only(top: 25.0, bottom: 5.0),
                      child: Text(
                        '???????????? ??????',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff95979A), width: 2.0),
                            ),
                            hintText: '????????? ??????????????? ?????? ???????????????.'
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "??????????????? ???????????? ???????????????.";
                          }
                          else if(value  != _pass.text){
                            return "??????????????? ???????????? ????????????.";
                          }
                          return null;
                        },
                        controller: _checkPass,
                      ),
                      height: 40,
                      width: 240,
                    ),

                    Container(
                      margin: EdgeInsets.only(top:70.0, bottom: 10.0),
                      child: new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4478FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: new Text(
                          '???    ???',
                          style: new TextStyle(fontSize: 18.0, color: Color(0xffFFFFFF), ),
                        ),
                        onPressed: (){
                          changePassword(_pass.text);
                        },
                      ),
                      height: 45,
                    ),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('??????????????? ???????????????????'),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                            },
                            child: Text(
                              '?????????',
                              style: TextStyle(color: Color(0xff4478FF)),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                )
            ),
          ),
        ),
      )
    );
  }
}
