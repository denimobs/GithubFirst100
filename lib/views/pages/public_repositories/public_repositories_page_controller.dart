import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/github_repository.dart';
import '../../../services/github_api.dart';
import '../../../services/network_service.dart';
import '../../../utils/toasts.dart';
import 'widgets/confirmation_dialog.dart';

class PublicRepositoriesPageController extends GetxController
    with SingleGetTickerProviderMixin {
  static PublicRepositoriesPageController get to => Get.find();

  final _githubApi = GithubApi.to;
  final _networkService = NetworkService.to;

  final _rxRepositories = Rx<List<GithubRepository>>();
  List<GithubRepository> get repositories => _rxRepositories.value;
  set _repositories(List<GithubRepository> value) =>
      _rxRepositories.value = value;

  final _rxError = Rx<ControllerError>();
  ControllerError get error => _rxError.value;
  set _error(ControllerError value) => _rxError.value = value;

  final _rxState = ControllerState.initial.obs;
  ControllerState get state => _rxState.value;
  set _state(ControllerState value) => _rxState.value = value;

  AnimationController networkMessageAnimController;

  @override
  void onInit() {
    super.onInit();

    networkMessageAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    ever(_networkService.rxIsOnline, (isOnline) {
      if (isOnline) {
        networkMessageAnimController.reverse();
        if (state == ControllerState.initial) fetchRepositories();
      } else {
        networkMessageAnimController.forward();
      }
    });

    if (_networkService.isOnline) {
      fetchRepositories();
    } else {
      networkMessageAnimController.forward();
    }
  }

  Future<void> fetchRepositories() async {
    // impede que uma requisição seja feita enquanto houver outra em progresso,
    // impede problemas como a segunda requisição terminar antes da primeira
    if (state == ControllerState.loading) return;

    if (_networkService.isOffline)
      return Toasts.showWarningToast('Sem conexão com a internet');

    _state = ControllerState.loading;

    final res = await _githubApi.getPublicRepositories(0);

    if (res != null) {
      _error = null;
      _state = ControllerState.hasData;
      _repositories = res;
    } else {
      _error = ControllerError.unexpected;
      _state = ControllerState.hasError;
    }
  }

  Future<void> refreshRepositories() async {
    if (_networkService.isOffline)
      return Toasts.showWarningToast('Sem conexão com a internet');

    final res = await _githubApi.getPublicRepositories(0);
    if (res != null) {
      _repositories = res;
    } else {
      Toasts.showErrorToast('Ocorreu um erro inesperado');
    }
  }

  void selectRepository(GithubRepository repository) async {
    final confirm =
        await Get.dialog(ConfirmationDialog(repository.htmlUrl)) ?? false;

    if (confirm) launch(repository.htmlUrl);
  }
}

enum ControllerState { initial, loading, hasData, hasError }
enum ControllerError { unexpected, network }
