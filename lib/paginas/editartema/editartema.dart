import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/services/conectar.dart';

class EditarTema extends StatefulWidget {
  const EditarTema({Key? key, required this.posts}) : super(key: key);

  final ClassTemas posts;

  @override
  _EditarTemaState createState() => _EditarTemaState();
}

class _EditarTemaState extends State<EditarTema> {
  Conecta conectar = Conecta();
  final titleController = TextEditingController();

  final formKey = GlobalKey<FormState>(); //key for form

  List<ClassPerguntas> lista = [];

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
              _showAddEventDialog(),

/*
                    setState(() {
                      ClassPerguntas classe = ClassPerguntas(
                          quizUuId: null,
                          quizPergunta: 'Nova Pergunta 5',
                          quizNome: widget.posts.temasNome,
                          quizResposta: '');
                      conectar.addPerguntas(classe);
                    }),

*/
            },
            child: const Icon(
              FontAwesomeIcons.plus,
              size: 19,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.amber,
          ),
          Expanded(
            child: FutureBuilder(
              future: conectar.getPerguntas(widget.posts.temasNome),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ClassPerguntas>> snapshot) {
                if (snapshot.hasData) {
                  List<ClassPerguntas>? lista = snapshot.data;
                  return Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: ListView.builder(
                        itemCount: lista!.length,
                        itemBuilder: (__, index) {
                          return Container(
                            height: 45,
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Colors.grey[200],
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lista[index].quizPergunta.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    letterSpacing: .2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {
                                    deletarPergunta(lista[index].quizUuId),
                                    setState(() {}),
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

  deletarPergunta(uuid) async {
    await conectar.delPergunta(uuid);
    setState(() {});
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
                        ClassPerguntas classe = ClassPerguntas(
                            quizUuId: null,
                            quizPergunta: titleController.text,
                            quizNome: widget.posts.temasNome,
                            quizResposta: '');
                        conectar.addPerguntas(classe);
                      });
                    }

                    /*
                     else {



                      setState(() {
                        listar.add(titleController.text);
                        titleController.clear();
                        Navigator.pop(context);
                        addCerto = true;
                      });
                    }

                    */
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
}

//    log('UuId ${uuid.toString()}');
//    log('Tema ${tema.toString()}');
//    log('Pergunta ${pergunta.toString()}');
//    log('Resposta ${resposta.toString()}');

/*


                          TextFormField(
                            initialValue: posts[index].quizResposta == null
                                ? ''
                                : posts[index].quizResposta.toString(),
                            validator: (value) {
                              {
                                posts[index].quizResposta = value.toString();
                                lista = posts;
                                gravaRespostas(
                                    posts[index].quizUuId.toString(),
                                    posts[index].quizNome.toString(),
                                    posts[index].quizPergunta.toString(),
                                    posts[index].quizResposta.toString());
                              }
                            },
                          ),

                          */
/*


      
      FutureBuilder(
        future: conectar.getPerguntas(widget.posts.temasNome),
        builder: (BuildContext context,
            AsyncSnapshot<List<ClassPerguntas>> snapshot) {
          if (snapshot.hasData) {
            List<ClassPerguntas>? posts = snapshot.data;
            return Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: ListView.builder(
                  itemCount: posts!.length,
                  itemBuilder: (__, index) {
                    return Container(
                      height: 80,
                      margin: const EdgeInsets.only(bottom: 15),
                      color: Colors.grey[200],
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            posts[index].quizPergunta.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              letterSpacing: .2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFormField(
                            initialValue: posts[index].quizResposta == null
                                ? ''
                                : posts[index].quizResposta.toString(),
                            validator: (value) {
                              {
                                posts[index].quizResposta = value.toString();
                                lista = posts;
                                gravaRespostas(
                                    posts[index].quizUuId.toString(),
                                    posts[index].quizNome.toString(),
                                    posts[index].quizPergunta.toString(),
                                    posts[index].quizResposta.toString());
                              }
                            },
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



*/