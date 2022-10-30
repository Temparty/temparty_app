import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:temparty/app/pages/profile/edit/edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class EditPage extends StatefulWidget {
  final String title;
  const EditPage({Key? key, this.title = 'EditPage'}) : super(key: key);
  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  final EditController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Observer(
        builder: (context) {
          final user = controller.user.value;
          controller.name.text = user?.displayName ?? "";
          controller.bio.text = user?.bio ?? "";
          controller.date.text = user?.birthday ?? "";
          if (user != null) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: 140,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/temparty.png'),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Center(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const BackButton(),
                                        const Text(
                                          'Editar perfil',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await controller.updateAccount();
                                              Modular.to.pop();
                                            },
                                            icon: const Icon(Icons.done))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Stack(
                                              children: [
                                                ClipOval(
                                                  child: Material(
                                                      color: Colors.transparent,
                                                      child: user.profileImage == null
                                                          ? InkWell(
                                                              child: SizedBox(
                                                                width: 128,
                                                                height: 128,
                                                                child: Image.asset(
                                                                  'assets/images/avatar.jpg',
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              child: FadeInImage.memoryNetwork(
                                                                placeholder: kTransparentImage,
                                                                image: user.profileImage!,
                                                                fit: BoxFit.cover,
                                                                width: 128,
                                                                height: 128,
                                                              ),
                                                            )),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: ClipOval(
                                                    child: Container(
                                                      padding: const EdgeInsets.all(9),
                                                      decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 50,
                                                            spreadRadius: 10,
                                                            offset: Offset(8, 12),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.deepPurple,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            _showModalBottomSheet(context);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: TextFormField(
                                            controller: controller.name,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.account_circle),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              labelText: 'nome e sobrenome',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: TextFormField(
                                            controller: controller.bio,
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(150),
                                            ],
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.description),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              labelText: 'Bio',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: TextFormField(
                                            controller: controller.date,
                                            keyboardType: TextInputType.datetime,
                                            decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.calendar_month),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                labelText: 'data de nascimento',
                                                hintText: 'dd/mm/yyyy'),
                                          ),
                                        ),
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                                            child: TextFormField(
                                              initialValue: user.email,
                                              enabled: false,
                                              readOnly: true,
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.email_rounded),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                labelText: 'email@exemplo.com',
                                              ),
                                            ),
                                          ),
                                          onTap: () => Fluttertoast.showToast(
                                            msg:
                                                'Não é possível fazer alterações no email no momento.',
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: (controller.user.value?.profileImage != null)
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Escolha sua foto de perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      controller.imageFromCamera();
                      Modular.to.pop();
                    },
                    label: const Text("Abrir câmera"),
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      controller.imageFromGallery();
                      Modular.to.pop();
                    },
                    label: const Text("Escolher foto existente"),
                    icon: const Icon(
                      Icons.photo,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  (controller.user.value?.profileImage != null)
                      ? ElevatedButton.icon(
                          onPressed: () async {
                            await controller.deleteProfileImage();
                            Modular.to.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent, // Background color
                          ),
                          label: const Text("Remover foto atual"),
                          icon: const Icon(
                            Icons.delete,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        )
                ],
              ),
            ),
          );
        });
  }
}
