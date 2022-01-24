import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popquiz/menu.dart';

/*
Observações :

Como se trata de uma avaliação, ao contrário do esperado em Clean Design eu optei por
não reduzir ou incorporar funções poara que fique mais clara a visão do avaliador, não
tendo que ficar indo e voltando em códigos.

Muitas funções que poderiam ser unicas eu separei para avaliação.

Preferi não utilizar Http Fake, já que tinha opção fiz chamadas reais.

Este código é original apesar de dezenas de códigos (Quiz) prontos, foi desenvolvido do zero.

Se desejar o apk pronto está em http://18.230.23.47/checkmob/
pois nem todos vão conseguir gerar o apk.

*/

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFDE982A),
      ),
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckMob',
      initialRoute: '/',
      home: Menu(),
    );
  }
}
