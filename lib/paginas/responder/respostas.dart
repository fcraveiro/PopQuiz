import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/paginas/responder/gravarrespostas.dart';
import 'package:popquiz/services/conectar.dart';

class Respostas extends StatefulWidget {
  const Respostas(
      {Key? key, required this.temaEscolhido, required this.temaNome})
      : super(key: key);

  final String temaEscolhido;
  final String temaNome;

  @override
  _RespostasState createState() => _RespostasState();
}

class _RespostasState extends State<Respostas> {
  Conecta conectar = Conecta();
  final formKey = GlobalKey<FormState>(); //key for form

  List<ClassPerguntas> lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.temaNome),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
        actions: [
          InkWell(
              onTap: () => {
                    if (formKey.currentState!.validate())
                      {
                        verRespostas(lista),
                      }
                  },
              child: const Icon(FontAwesomeIcons.save)),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: FutureBuilder(
        future: conectar.getPerguntas(widget.temaNome),
        builder: (BuildContext context,
            AsyncSnapshot<List<ClassPerguntas>> snapshot) {
          if (snapshot.hasData) {
            FocusScope.of(context).requestFocus(FocusNode());
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
/*
                                gravaRespostas(
                                    posts[index].quizUuId.toString(),
                                    posts[index].quizNome.toString(),
                                    posts[index].quizPergunta.toString(),
                                    posts[index].quizResposta.toString());

                                    */
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
    );
  }

  gravaRespostas(uuid, tema, pergunta, resposta) {
//    conectar.quizRespostas(uuid, resposta);
  }

  verRespostas(lista) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GravaResposta(
          lista: lista,
        ),
      ),
    );
  }
}

//    log('UuId ${uuid.toString()}');
//    log('Tema ${tema.toString()}');
//    log('Pergunta ${pergunta.toString()}');
//    log('Resposta ${resposta.toString()}');
