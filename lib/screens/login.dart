
import 'package:flutter/material.dart';
import 'package:sqflite_crud/model/user_model.dart';
import 'package:sqflite_crud/screens/home.dart';
import 'package:sqflite_crud/screens/signup.dart';
import 'package:sqflite_crud/util/db_helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true; //by default password is hide
  IconData icon = Icons.visibility; // by default icon is visible
  var dbHelper = DBHelper.instance;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children:  <Widget>[
            const SizedBox(height: 100,),
            Text('$errorMessage'),

            const SizedBox(height: 15.0,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email here',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            const SizedBox(height: 15.0,),
            TextField(
              controller: passwordController,
              obscureText: showPassword,
              decoration:  InputDecoration(
                  border:const  OutlineInputBorder(),
                  hintText: 'Enter Password here',
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: ()
                      {
                        setState(() {
                          if(showPassword)
                          {
                            showPassword = false;
                            icon = Icons.visibility_off;
                          }
                          else
                          {
                            showPassword = true;
                            icon = Icons.visibility;
                          }
                        });
                      },
                      icon:  Icon(icon)
                  )
              ),
            ),
            const SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async
                    {
                      if( emailController.text.trim() != '' || passwordController.text.trim() != '') {
                        setState(() {
                          errorMessage = '';
                        });
                        bool exist = await dbHelper.authenticateUser(email: emailController.text, password: passwordController.text);
                        if(exist)
                          {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                          }
                        else
                          {
                            showSnackBar('Wrong username or password');
                          }
                      }
                      else
                      {
                        setState(() {
                          errorMessage = 'All fields required';
                        });
                      }
                    },
                    child: const Text('Login')
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    child: const Text('Sign Up')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showSnackBar(String message)
  {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
}
