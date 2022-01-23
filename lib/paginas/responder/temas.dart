import 'package:flutter/material.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/paginas/responder/respostas.dart';
import 'package:popquiz/services/conectar.dart';

class Temas extends StatefulWidget {
  const Temas({Key? key}) : super(key: key);

  @override
  _TemasState createState() => _TemasState();
}

class _TemasState extends State<Temas> {
  Conecta conectar = Conecta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas'),
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
                          onTap: () => responder(post.temasUuId.toString(),
                              post.temasNome.toString()),
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

  responder(String temaEscolhido, String temaNome) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => Respostas(
                  temaEscolhido: temaEscolhido,
                  temaNome: temaNome,
                )))
        .then((_) => setState(() {}));
  }
}
