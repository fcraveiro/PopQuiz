import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/services/conectar.dart';
import 'package:popquiz/services/constantes.dart';

class EditarTema extends StatefulWidget {
  const EditarTema({Key? key, required this.posts}) : super(key: key);

  final ClassTemas posts;

  @override
  _EditarTemaState createState() => _EditarTemaState();
}

List<ClassPerguntas> lista = [];
List<ClassPerguntas> listar = [];

int tipo = 0;
int perguntasTotal = 0;
int contador = 0;

class _EditarTemaState extends State<EditarTema> {
  Conecta conectar = Conecta();
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form

  @override
  void initState() {
    perguntasTotal = 0;
    contador = widget.posts.temasRespostas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tema'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
        actions: [
          InkWell(
            onTap: () => {
              _showAddEventDialog(1, 'Perguntas'),
            },
            child: const Icon(
              FontAwesomeIcons.plus,
              size: 19,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () => {
              deletarTudo(lista),
            },
            child: const Icon(
              FontAwesomeIcons.trash,
              size: 19,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 45,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  widget.posts.temasNome,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    letterSpacing: .2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () => {
                    _showAddEventDialog(2, 'Temas'),
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.edit,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: conectar.getPerguntas(widget.posts.temasNome),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ClassPerguntas>> snapshot) {
                if (snapshot.hasData) {
                  List<ClassPerguntas>? lista = snapshot.data;
                  listar = lista!;
                  perguntasTotal = listar.length;
                  return Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (__, index) {
                          return Container(
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Colors.grey[200],
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  height: 25,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    lista[index].quizPergunta.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      letterSpacing: .2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {
                                    perguntasTotal--,
                                    deletarPergunta(
                                        lista[index].quizUuId,
                                        lista[index].quizResposta,
                                        perguntasTotal),
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _showAddEventDialog(tipo, texto) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 12,
              title: Text(texto),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Descrição'),
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
                    if (tipo == 1) {
                      perguntasTotal++;
                      recebePerguntas(perguntasTotal);
                    }
                    if (tipo == 2) {
                      recebeTema();
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

  deletarPergunta(uuid, resposta, total) async {
    await conectar.delPergunta(uuid);
    await conectar.updateTotalPerguntas(
        widget.posts.temasUuId.toString(), total);
    if (resposta != null && resposta != '') {
      contador--;
      await conectar.updateTotalRespostas(
          widget.posts.temasNome.toString(), contador);
    }
    setState(() {});
  }

  deletarTudo(tema) async {
    for (var e in listar) {
      {
        tema = e.quizNome;
        await conectar.delPergunta(e.quizUuId.toString());
      }
    }
    await conectar.delTema(widget.posts.temasUuId.toString());
    Navigator.pop(context);
  }

  recebePerguntas(total) {
    if (titleController.text.isEmpty) {
      mensagem(context, 'Você deve digitar a Pergunta');
      return;
    } else {
      setState(() {
        ClassPerguntas classe = ClassPerguntas(
            quizUuId: null,
            quizPergunta: titleController.text,
            quizNome: widget.posts.temasNome,
            quizResposta: '');
        conectar.addPerguntas(classe);
        conectar.updateTotalPerguntas(widget.posts.temasUuId.toString(), total);
      });
      titleController.clear();
      Navigator.pop(context);
    }
  }

  recebeTema() {
    if (titleController.text.isEmpty) {
      mensagem(context, 'Você deve digitar o Tema');
      return;
    } else {
      setState(() {
        conectar.updatePerguntas(
            widget.posts.temasNome.toString(), titleController.text);
        conectar.updateTema(
            widget.posts.temasUuId.toString(), titleController.text);
        widget.posts.temasNome = titleController.text;
      });
      titleController.clear();
      Navigator.pop(context);
    }
  }
}
