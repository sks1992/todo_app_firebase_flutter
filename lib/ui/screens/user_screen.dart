import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_project/core/controller/user_controller.dart';

import '../widgets/text_input.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Flutter MySQL CRUD Demo",
            style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.userList.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  itemCount: _controller.userList.length,
                  itemBuilder: (context, index) {
                    var user = _controller.userList[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(8),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("User Name: ${user.userName}"),
                                  Text("Email: ${user.email}"),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _controller.showEditDialog(user.uid,
                                            user.userName, user.email, index);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        _controller.deleteUser(index);
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(_controller.userNameController.text,
              _controller.emailController.text);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.blue),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void showDialog(String userName, String email) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "",
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextInput(
                controller: _controller.userNameController,
                labelText: 'User Name',
              ),
              TextInput(
                controller: _controller.emailController,
                labelText: 'Email',
              ),
              Obx(
                () => _controller.isLoading.value
                    ? const LinearProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _controller.userNameController.text = "";
                              _controller.emailController.text = "";
                              Get.back();
                            },
                            child: const Text("Close"),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _controller.addUser();
                              },
                              child: const Text("Add User")),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
