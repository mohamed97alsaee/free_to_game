import 'package:free_to_game/screens/register_screen.dart';

import '../services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_to_game/main.dart';
import 'package:free_to_game/providers/auth_provider.dart';
import 'package:free_to_game/widgets/main_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deviceNameController = TextEditingController();

  Api api = Api();

  bool hidePassword = true;
  bool formIsValid = false;

  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, child) {
      return Scaffold(
        // floatingActionButton: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //         onPressed: () {
        //           api.get("https://www.freetogame.com/api/games", {});
        //         },
        //         icon: const Icon(Icons.download)),
        //     IconButton(
        //         onPressed: () {
        //           api.post();
        //         },
        //         icon: const Icon(Icons.download)),
        //     IconButton(
        //         onPressed: () {
        //           api.put();
        //         },
        //         icon: const Icon(Icons.download)),
        //     IconButton(
        //         onPressed: () {
        //           api.delete();
        //         },
        //         icon: const Icon(Icons.download))
        //   ],
        // ),

        appBar: AppBar(
          title: const Text("LOGIN"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: loginForm,
            onChanged: () {
              setState(() {
                formIsValid = loginForm.currentState!.validate();
              });
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone";
                    }
                    if (value.length != 10) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text("Phone"), hintText: "enter phone"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: hidePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 8) {
                      return "Password must be more than 8 charcters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(hidePassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off)),
                      label: const Text("Password"),
                      hintText: "enter passwors"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: deviceNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your device name";
                    }
                    if (value.length < 3) {
                      return "Please enter valid device name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text("Device Name"),
                      hintText: "enter device name"),
                ),
                const SizedBox(
                  height: 32,
                ),
                MainButton(
                    text: "LOGIN",
                    color: Colors.orange,
                    txtcolor: Colors.white,
                    isActive: formIsValid,
                    onPressd: () {
                      Provider.of<AuthProvider>(context, listen: false).login({
                        "phone": phoneController.text,
                        "password": passwordController.text,
                        "device_name": deviceNameController.text
                      }).then((returnedData) {
                        if (returnedData.first) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const ScreenRouter()),
                              (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(returnedData.last),
                          ));
                        }
                      });
                    },
                    isLoading: authConsumer.isLoading),
                const SizedBox(
                  height: 16,
                ),
                MainButton(
                    text: "Create Account",
                    color: Colors.orange,
                    txtcolor: Colors.white,
                    isActive: true,
                    onPressd: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    isLoading: false)
              ],
            ),
          ),
        ),
      );
    });
  }
}
