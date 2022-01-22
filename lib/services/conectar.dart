import 'dart:developer';
import 'package:popquiz/model/model.dart';
import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://xrhyhsbetlnzksauwrvi.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODA3NTI4MywiZXhwIjoxOTUzNjUxMjgzfQ.gsz31qxeQ_h6R_93rthZwynvz1i8jNrXLz30JaFprqA';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  Future<List<ClassTemas>> getTemas() async {
    log('Leu Temas');
    final response = await client
        .from('temas')
        .select()
        .order('temasNome', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList.map((map) => ClassTemas.fromJson(map)).toList());
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  Future<List<ClassPerguntas>> getPerguntas(tema) async {
    log('Leu Perguntas');
    final response = await client
        .from('perguntas')
        .select()
        .eq('quizTema', tema)
        .order('quizPergunta', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList.map((map) => ClassPerguntas?.fromJson(map)).toList());
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  quizRespostas(String uuid, String resposta) async {
    await client
        .from('perguntas')
        .update({'quizResposta': resposta})
        .eq('quizUuId', uuid)
        .execute()
        .then((value) => log('Respostas ok'));
  }

  temasRespostas(String temasUuId, int perguntas, int respostas) async {
    await client
        .from('temas')
        .update({'temasPerguntas': perguntas, 'temasRespostas': respostas})
        .eq('temasUuId', temasUuId)
        .execute()
        .then((value) => log('Temas ok'));
  }

  Future addPerguntas(campos) async {
    ClassPerguntas novasperguntas = campos;
    Map<String, dynamic> perguntasJson = novasperguntas.toJson();
    await client
        .from('perguntas')
        .insert(perguntasJson)
        .execute()
        .then((value) => log(value.error.toString()));
  }

/*

  Future delHistorico(int idPaciente) async {
    await client
        .from('historico')
        .delete()
        .eq('hisIdPaciente', idPaciente)
        .execute();
  }

*/

}
