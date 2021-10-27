
import 'package:flutter/material.dart';
import 'package:sqflite_crud/model/user_model.dart';
import 'package:sqflite_crud/util/db_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var usernameController = TextEditingController();
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
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Username here',
                labelText: 'Username',
                prefixIcon: Icon(Icons.person)
              ),
            ),
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
            ElevatedButton(
                onPressed: (){
                  if(usernameController.text.trim() != '' || emailController.text.trim() != '' || passwordController.text.trim() != '') {
                    setState(() {
                      errorMessage = '';
                    });
                    var user = User(username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text);
                    dbHelper.insert("users", user.toJson());
                  }
                  else
                    {
                      setState(() {
                        errorMessage = 'All fields required';
                      });
                    }
                },
                child: const Text('Create Account')
            )
          ],
        ),
      ),
    );
  }
}
