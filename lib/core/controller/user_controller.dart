import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project/core/constants/helper.dart';
import 'package:todo_project/core/model/user_model.dart';
import 'package:todo_project/core/services/firebase_services.dart';
import 'package:uuid/uuid.dart';

import '../../ui/widgets/text_input.dart';

class UserController extends GetxController with StateMixin<List<UserModel>> {
  late TextEditingController userNameController;
  late TextEditingController emailController;

  var isLoading = false.obs;
  final userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    userNameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    emailController.dispose();
  }

  void addUser() async {
    hideKeyboard();
    isLoading.value = true;
    var model = UserModel(
        uid: const Uuid().v1(),
        userName: userNameController.text,
        email: emailController.text);
    userList.add(model);
    await FirestoreMethods().uploadUser(model.uid, model.userName, model.email);
    isLoading.value = true;
    userNameController.text = "";
    emailController.text = "";
    Get.back();
  }

  void deleteUser(int index) {
    userList.removeAt(index);
  }

  void showEditDialog(String userId, String userName, String email, int index) {
    userNameController.text = userName;
    emailController.text = email;
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "",
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextInput(
                controller: userNameController,
                labelText: 'User Name',
              ),
              TextInput(
                controller: emailController,
                labelText: 'Email',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      userNameController.text = "";
                      emailController.text = "";
                      Get.back();
                    },
                    child: const Text("Close"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var model = UserModel(
                            uid: userId,
                            userName: userNameController.text,
                            email: emailController.text);
                        userList[index] = model;
                        userNameController.text = "";
                        emailController.text = "";
                        hideKeyboard();
                        Get.back();
                      },
                      child: const Text("Add User")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
