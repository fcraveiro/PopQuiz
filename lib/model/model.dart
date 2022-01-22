class ClassPerguntas {
  String? quizUuId;
  String quizNome;
  String quizPergunta;
  String? quizResposta;

  ClassPerguntas({
    required this.quizUuId,
    required this.quizNome,
    required this.quizPergunta,
    required this.quizResposta,
  });

  factory ClassPerguntas.fromJson(Map<String, dynamic> map) {
    return ClassPerguntas(
      quizUuId: map['quizUuId'.toString()],
      quizNome: map['quizNome'.toString()],
      quizPergunta: map['quizPergunta'],
      quizResposta: map['quizResposta'],
    );
  }

  Map<String, dynamic> toJson() => {
        'quizPergunta': quizPergunta,
        'quizNome': quizNome,
        'quizResposta': quizResposta,
      };
}

class ClassTemas {
  String temasUuId;
  String temasNome;
  int temasPerguntas;
  int temasRespostas;

  ClassTemas({
    required this.temasUuId,
    required this.temasNome,
    required this.temasPerguntas,
    required this.temasRespostas,
  });

  factory ClassTemas.fromJson(Map<String, dynamic> map) {
    return ClassTemas(
      temasUuId: map['temasUuId'.toString()],
      temasNome: map['temasNome'.toString()],
      temasPerguntas: map['temasPerguntas'.toString()],
      temasRespostas: map['temasRespostas'.toString()],
    );
  }
}
