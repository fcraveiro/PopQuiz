import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/paginas/editartema/editartema.dart';
import 'package:popquiz/services/conectar.dart';
import 'package:popquiz/services/constantes.dart';
import 'package:supabase/supabase.dart';

class EscolheTema extends StatefulWidget {
  const EscolheTema({Key? key}) : super(key: key);

  @override
  _EscolheTemaState createState() => _EscolheTemaState();
}

bool jaTem = false;

class _EscolheTemaState extends State<EscolheTema> {
  final client = SupabaseClient(supabaseUrl, supabaseKey);
  final titleController = TextEditingController();
  Conecta conectar = Conecta();

  @override
  void initState() {
    jaTem = false;
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
              _showAddEventDialog(),
            },
            child: const Icon(
              FontAwesomeIcons.plus,
              size: 19,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: FutureBuilder(
        future: conectar.getTemas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClassTemas>> snapshot) {
          if (snapshot.hasData) {
            List<ClassTemas>? posts = snapshot.data;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView(
                children: posts!
                    .map(
                      (ClassTemas post) => Container(
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(post.temasPerguntas.toString()),
                          ),
                          title: Text(
                            post.temasNome.toString(),
                          ),
                          subtitle: Text(
                            'Respostas : ${post.temasRespostas.toString()}',
                          ),
                          trailing: InkWell(
                            onTap: () => deletarTudo(
                              post.temasUuId.toString(),
                              post.temasNome.toString(),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.trash,
                              size: 19,
                            ),
                          ),
                          onTap: () => {
                            responder(post),
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  responder(ClassTemas posts) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => EditarTema(
              posts: posts,
            ),
          ),
        )
        .then((_) => setState(() {}));
  }

  deletarTudo(String uuid, String nome) async {
    setState(() {
      conectar.delTema(uuid);
      conectar.delPerguntas(nome);
    });
  }

  criarTema(String nome) async {
    ClassTemas classe = ClassTemas(
        temasUuId: null, temasNome: nome, temasPerguntas: 0, temasRespostas: 0);
    setState(() {
      conectar.addTemas(classe);
    });
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

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 12,
              title: const Text('Temas'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Nome do Tema'),
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
                      gravaTema();
                    }),
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

  gravaTema() async {
    if (titleController.text.isEmpty) {
      mensagem(context, 'Você Deve Digitar o Nome do Tema');
      return;
    } else {
      await lerAgora(titleController.text);
      jaTem
          ? mensagem(context, 'Este Tema Já Existe')
          : setState(() {
              ClassTemas testa = ClassTemas(
                temasUuId: null,
                temasNome: titleController.text,
                temasPerguntas: 0,
                temasRespostas: 0,
              );
              conectar.addTemas(testa);
              titleController.clear();
              Navigator.pop(context);
            });
    }
  }
}
