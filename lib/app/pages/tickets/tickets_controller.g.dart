// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicketsController on _TicketsControllerBase, Store {
  late final _$eventsAtom =
      Atom(name: '_TicketsControllerBase.events', context: context);

  @override
  ObservableList<EventModel> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<EventModel> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$ticketsAtom =
      Atom(name: '_TicketsControllerBase.tickets', context: context);

  @override
  ObservableFuture<List<TicketModel>> get tickets {
    _$ticketsAtom.reportRead();
    return super.tickets;
  }

  @override
  set tickets(ObservableFuture<List<TicketModel>> value) {
    _$ticketsAtom.reportWrite(value, super.tickets, () {
      super.tickets = value;
    });
  }

  @override
  String toString() {
    return '''
events: ${events},
tickets: ${tickets}
    ''';
  }
}
