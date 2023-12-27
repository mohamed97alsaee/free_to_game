import 'package:flutter/material.dart';
import 'package:free_to_game/providers/auth_provider.dart';
import 'package:free_to_game/widgets/main_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  TextEditingController deviceNameController = TextEditingController();

  bool hidePassword = true;
  bool formIsValid = false;

  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Create Account"),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Name";
                      }
                      if (value.length < 2) {
                        return "Please enter valid name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("Name"), hintText: "enter name"),
                  ),
                  const SizedBox(
                    height: 16,
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
                    controller: passwordConfirmationController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: hidePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password confirmation";
                      }
                      if (value.length < 8) {
                        return "Password must be more than 8 charcters";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
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
                      text: "Create",
                      color: Colors.orange,
                      txtcolor: Colors.white,
                      isActive: formIsValid,
                      onPressd: () {
// {
//     "name":"Karima",
//     "phone":"0920909989",
//     "password":"12345678",
//     "password_confirmation":"12345678",
//     "device_name":"iphone"
// }

                        Provider.of<AuthProvider>(context, listen: false)
                            .register({
                          "name": nameController.text,
                          "phone": phoneController.text,
                          "password": passwordController.text,
                          "password_confirmation":
                              passwordConfirmationController.text,
                          "device_name": deviceNameController.text
                        }).then((returnedData) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(returnedData.last),
                          ));
                        });
                      },
                      isLoading: authConsumer.isLoading),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
