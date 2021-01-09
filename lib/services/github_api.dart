import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/github_repository.dart';

class GithubApi {
  static GithubApi get to => Get.find();

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com'));

  /// [since] recebe o id do repositório inicial para paginação
  /// retorna os primeiros 100 repositórios
  Future<List<GithubRepository>> getPublicRepositories([int since = 0]) async {
    try {
      final res =
          await _dio.get('/repositories', queryParameters: {'since': since});

      if (res.statusCode != 200)
        throw Exception('invalid status code ${res.statusCode}');

      List repositoriesRaw = res.data;
      return repositoriesRaw
          .map((e) => GithubRepository.fromMap(e))
          .take(100)
          .toList();
    } catch (e, stacktrance) {
      print('GithubApi.getPublicRepositories error: $e');
      print(stacktrance);
      return null;
    }
  }
}
