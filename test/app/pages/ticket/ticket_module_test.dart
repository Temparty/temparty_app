import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temparty/app/pages/ticket/ticket_module.dart';

void main() {

  setUpAll(() {
    initModule(TicketModule());
  });
}