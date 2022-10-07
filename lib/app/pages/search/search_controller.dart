import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  @observable
  int value = 0;

  @observable
  TextEditingController search = TextEditingController();

  @action
  void increment() {
    value++;
  }
}
