import 'dart:developer';
import 'package:popquiz/model/model.dart';
import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://xrhyhsbetlnzksauwrvi.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODA3NTI4MywiZXhwIjoxOTUzNjUxMjgzfQ.gsz31qxeQ_h6R_93rthZwynvz1i8jNrXLz30JaFprqA';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  Future<List<ClassTemas>> getTemas() async {
    final response = await client
        .from('temas')
        .select()
        .order('temasNome', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList.map((map) => ClassTemas.fromJson(map)).toList());
    }
    return [];
  }

  Future<List<ClassPerguntas>> getPerguntas(tema) async {
    final response = await client
        .from('perguntas')
        .select()
        .eq('quizNome', tema)
        .order('quizPergunta', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList.map((map) => ClassPerguntas?.fromJson(map)).toList());
    }
    return [];
  }

  quizRespostas(String uuid, String resposta) async {
    await client
        .from('perguntas')
        .update({'quizResposta': resposta})
        .eq('quizUuId', uuid)
        .execute()
        .then((value) => log(value.error.toString()));
  }
/*
  temasRespostas(String temasUuId, int perguntas, int respostas) async {
    await client
        .from('temas')
        .update({'temasPerguntas': perguntas, 'temasRespostas': respostas})
        .eq('temasUuId', temasUuId)
        .execute()
        .then((value) => log('Temas ok'));
  }
*/

  updateTema(String temasUuId, String temasNome) async {
    await client
        .from('temas')
        .update({'temasNome': temasNome})
        .eq('temasUuId', temasUuId)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  updateTotalPerguntas(String temasUuId, int perguntas) async {
    await client
        .from('temas')
        .update({'temasPerguntas': perguntas})
        .eq('temasUuId', temasUuId)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  updateTotalRespostas(String temasNome, int respostas) async {
    await client
        .from('temas')
        .update({'temasRespostas': respostas})
        .eq('temasNome', temasNome)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  updatePerguntas(
    String nomeAtual,
    String novoNome,
  ) async {
    await client
        .from('perguntas')
        .update({'quizNome': novoNome})
        .eq('quizNome', nomeAtual)
        .execute()
        .then((value) => log(value.error.toString()));
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

  Future addTemas(campos) async {
    ClassTemas novosTemas = campos;
    Map<String, dynamic> novosTemasJson = novosTemas.toJson();
    await client
        .from('temas')
        .insert(novosTemasJson)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  Future delPergunta(String uuid) async {
    await client
        .from('perguntas')
        .delete()
        .eq('quizUuId', uuid)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  Future delPerguntas(String nome) async {
    await client
        .from('perguntas')
        .delete()
        .eq('quizNome', nome)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  Future delTema(String uuid) async {
    await client
        .from('temas')
        .delete()
        .eq('temasUuId', uuid)
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
