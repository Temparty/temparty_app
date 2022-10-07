import 'package:mobx/mobx.dart';

part 'ticket_controller.g.dart';

class TicketController = _TicketControllerBase with _$TicketController;

abstract class _TicketControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
