import 'package:flutter/material.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/paginas/editartema/editartema.dart';
import 'package:popquiz/services/conectar.dart';

class EscolheTema extends StatefulWidget {
  const EscolheTema({Key? key}) : super(key: key);

  @override
  _EscolheTemaState createState() => _EscolheTemaState();
}

class _EscolheTemaState extends State<EscolheTema> {
  Conecta conectar = Conecta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tema'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
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
                          leading: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                          title: Text(
                            post.temasNome.toString(),
                          ),
                          subtitle: Text(
                            'Perguntas : ${post.temasPerguntas.toString()}    Respostas : ${post.temasRespostas.toString()}',
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
}
