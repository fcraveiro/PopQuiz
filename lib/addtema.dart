import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/services/conectar.dart';

class AddTemas extends StatefulWidget {
  const AddTemas({Key? key}) : super(key: key);

  @override
  _AddTemasState createState() => _AddTemasState();
}

List listar = [];

class _AddTemasState extends State<AddTemas> {
  final titleController = TextEditingController();
  Conecta conectar = Conecta();

//  late List<ClassPerguntas> lista;

  @override
  void initState() {
    listar = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Temas'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
        actions: [
          InkWell(
            onTap: () => {
              gravarPerguntas(),
            },
            child: const Icon(FontAwesomeIcons.save),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: const Color(0xFF006075),
        onPressed: () {
          _showAddEventDialog();
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 7,
              fixedSize: const Size(100, 40),
              primary: const Color(0xFF006075),
              onSurface: Colors.white,
            ),
            onPressed: () {
              _showAddEventDialog();
            },
            child: Text(
              'Temas',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: listar.isNotEmpty
                ? ListView.builder(
                    itemCount: listar.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 30,
                                  color: Colors.grey[200],
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    listar[index].toString(),
                                    style: styleAzul(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () => {
                                      log(listar.toString()),
                                      listar.remove(listar[index]),
                                      setState(() {}),
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.grey[500],
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Text(''),
          ),
        ],
      ),
    );
  }

  style() {
    return GoogleFonts.roboto(
      fontSize: 16,
      letterSpacing: .3,
      fontWeight: FontWeight.w400,
    );
  }

  styleAzul() {
    return GoogleFonts.roboto(
      fontSize: 16,
      color: Colors.blue[900],
      letterSpacing: .3,
      fontWeight: FontWeight.w400,
    );
  }

  gravarPerguntas() {
    for (var element in listar) {
      {
        log(element.toString());
        ClassPerguntas teste = ClassPerguntas(
            quizUuId: null,
            quizTema: 'c36c4a94-fdf4-4f27-8c2e-626da25e0e32',
            quizPergunta: element,
            quizResposta: null);
        conectar.addPerguntas(teste);
      }
    }
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 12,
              title: const Text('Perguntas'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController,
                      hint: 'Descrição da Pergunta'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => {
                    titleController.clear(),
                    Navigator.pop(context),
                  },
                  style: TextButton.styleFrom(
                    primary: const Color(0xFF006075),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: const Color(0xFF006075),
                  ),
                  child: Text(
                    'Adicionar',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFFFF9E1B),
                          content: Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'Você deve digitar a Pergunta',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          duration: const Duration(seconds: 3),
                          padding: const EdgeInsets.only(bottom: 22, top: 22),
                        ),
                      );
                      //Navigator.pop(context);
                      return;
                    } else {
                      listar.add(titleController.text);
                      titleController.clear();
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                ),
              ],
            ));
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber, width: 1.0),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
      ),
    );
  }
}
