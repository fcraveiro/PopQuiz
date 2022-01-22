import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popquiz/model/model.dart';
import 'package:popquiz/services/conectar.dart';

class GravaResposta extends StatefulWidget {
  const GravaResposta({Key? key, required this.lista}) : super(key: key);

  final List<ClassPerguntas> lista;

  @override
  _GravaRespostaState createState() => _GravaRespostaState();
}

class _GravaRespostaState extends State<GravaResposta> {
  Conecta conectar = Conecta();
  final formKey = GlobalKey<FormState>(); //key for form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirme'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9E1B),
        actions: const [
          /*
          InkWell(
              onTap: () => {if (formKey.currentState!.validate()) {}},
              child: const Icon(FontAwesomeIcons.save)),
          const SizedBox(
            width: 15,
          ),
*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.lista.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            widget.lista[index].quizPergunta.toString(),
                            style: style(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[300],
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 3, top: 3),
                          child: Text(
                            widget.lista[index].quizResposta.toString(),
                            style: styleAzul(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 7,
                    fixedSize: const Size(100, 40),
                    primary: const Color(0xFF006075),
                    onSurface: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Menu',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 7,
                    fixedSize: const Size(100, 40),
                    primary: const Color(0xFF006075),
                    onSurface: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Editar',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 7,
                    fixedSize: const Size(100, 40),
                    primary: const Color(0xFF006075),
                    onSurface: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Gravar',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  gravaRespostas(uuid, tema, pergunta, resposta) {
    conectar.quizRespostas(uuid, resposta);
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
      color: Colors.blue[900],
      fontSize: 16,
      letterSpacing: .3,
      fontWeight: FontWeight.w400,
    );
  }
}

//    log('UuId ${uuid.toString()}');
//    log('Tema ${tema.toString()}');
//    log('Pergunta ${pergunta.toString()}');
//    log('Resposta ${resposta.toString()}');
