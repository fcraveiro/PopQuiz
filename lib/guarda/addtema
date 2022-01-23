import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/services/conectar.dart';
import 'package:supabase/supabase.dart';

class AddTemas extends StatefulWidget {
  const AddTemas({Key? key}) : super(key: key);

  @override
  _AddTemasState createState() => _AddTemasState();
}

List listar = [];
bool temaCerto = false;
bool textCerto = false;
bool addCerto = false;
bool jaTem = false;
int numeroPerguntas = 0;

class _AddTemasState extends State<AddTemas> {
  final titleController = TextEditingController();
  Conecta conectar = Conecta();
  final TextEditingController _nomeController = TextEditingController();
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  var focusBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  );

  var outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 1,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  );

  var labelStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 14,
  );

  var style = const TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  var contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0);

  @override
  void initState() {
    listar = [];
    addCerto = false;
    textCerto = false;
    temaCerto = false;
    jaTem = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Temas'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
        actions: temaCerto && addCerto
            ? [
                InkWell(
                  onTap: () => {
                    gravarPerguntas(),
                  },
                  child: const Icon(FontAwesomeIcons.save),
                ),
                const SizedBox(
                  width: 15,
                ),
              ]
            : [],
      ),
      floatingActionButton: temaCerto
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF006075),
              onPressed: () async {
                temaCerto ? _showAddEventDialog() : const Text('');
              },
              icon: const FaIcon(FontAwesomeIcons.plus),
              label: const Text('Adicionar Perguntas'),
            )
          : const Text(''),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Center(
            child: Row(
              children: [
                Container(
                  width: 245,
                  height: 45,
                  margin: const EdgeInsets.only(left: 20),
                  child: formTema(),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 7,
                    fixedSize: const Size(85, 40),
                    primary: const Color(0xFF006075),
                    onSurface: Colors.white,
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    await lerAgora(_nomeController.text);
                    if (textCerto) {
                      jaTem
                          ? {
                              mensagem('Já Existe este Tema'),
                              setState(
                                () => {temaCerto = false},
                              ),
                            }
                          : setState(() => {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                temaCerto = true
                              });
                    }
                  },
                  child: Text(
                    'Check o Nome',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
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
                                    style: estiloAzul(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () => {
                                      setState(() {
                                        listar.remove(listar[index]);
                                        listar.isEmpty
                                            ? addCerto = false
                                            : addCerto = true;
                                      }),
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

  Widget formTema() {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: _nomeController,
        style: style,
        decoration: decoration('Tema (Minimo 4 Letras)', textCerto),
        onTap: () => {
          setState(() => temaCerto = false),
        },
        onChanged: (value) => {
          value.isEmpty || value.length < 4
              ? textCerto = false
              : {
                  textCerto = true,
                },
          setState(() {})
        },
      ),
    );
  }

  decoration(texto, textCerto) {
    return InputDecoration(
      border: InputBorder.none,
      contentPadding: contentPadding,
      labelText: texto,
      labelStyle: labelStyle,
      enabledBorder: outlineInputBorder,
      focusedBorder: focusBorder,
      suffixIcon: textCerto
          ? const Icon(
              FontAwesomeIcons.thumbsUp,
              color: Colors.green,
              size: 20,
            )
          : Icon(
              FontAwesomeIcons.times,
              color: Colors.red.shade300,
              size: 20,
            ),
    );
  }

  estiloPreto() {
    return GoogleFonts.roboto(
      fontSize: 16,
      letterSpacing: .3,
      fontWeight: FontWeight.w400,
    );
  }

  estiloAzul() {
    return GoogleFonts.roboto(
      fontSize: 16,
      color: Colors.blue[900],
      letterSpacing: .3,
      fontWeight: FontWeight.w400,
    );
  }

  gravarPerguntas() {
    for (var e in listar) {
      {
//        log(element.toString());
        numeroPerguntas++;
        ClassPerguntas classe = ClassPerguntas(
            quizUuId: null,
            quizPergunta: e,
            quizNome: _nomeController.text,
            quizResposta: null);
        conectar.addPerguntas(classe);
      }
      log(numeroPerguntas.toString());
    }

    ClassTemas testa = ClassTemas(
      temasUuId: null,
      temasNome: _nomeController.text,
      temasPerguntas: numeroPerguntas,
      temasRespostas: 0,
    );
    conectar.addTemas(testa);
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
                    FocusScope.of(context).requestFocus(FocusNode()),
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
                      mensagem('Você deve digitar a Pergunta');
                      return;
                    } else {
                      setState(() {
                        listar.add(titleController.text);
                        titleController.clear();
                        Navigator.pop(context);
                        addCerto = true;
                      });
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

  mensagem(texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFFF9E1B),
        content: Container(
          height: 25,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                texto,
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.only(bottom: 22, top: 22),
      ),
    );
  }

  Future<List<ClassTemas>> lerAgora(campo) async {
    final response = await client
        .from('temas')
        .select()
        .eq('temasNome', campo)
        .order('temasNome', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      if (dataList.isEmpty) {
        jaTem = false;
      } else {
        jaTem = true;
      }
      setState(() {
        jaTem;
      });
      return [];
    } else {
      // ignore: avoid_print
      print(response.error.toString());
    }
    throw '';
  }
}
