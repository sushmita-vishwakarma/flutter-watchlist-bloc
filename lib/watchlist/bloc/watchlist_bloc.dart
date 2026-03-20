import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/stock.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistState(_initialStocks())) {
    on<ReorderStocks>(_onReorder);
  }

  static List<Stock> _initialStocks() {
    return [
      Stock(name: "RELIANCE", exchange: "NSE", price: 1374, change: -4.5),
      Stock(name: "HDFCBANK", exchange: "NSE", price: 966, change: 0.85),
      Stock(name: "ASIANPAINT", exchange: "NSE", price: 2537, change: 6.6),
      Stock(name: "NIFTY IT", exchange: "IDX", price: 35187, change: 877),
      Stock(name: "MRF", exchange: "NSE", price: 147625, change: 550),
    ];
  }

  void _onReorder(ReorderStocks event, Emitter<WatchlistState> emit) {
    final updated = List<Stock>.from(state.stocks);

    final item = updated.removeAt(event.oldIndex);
    updated.insert(
      event.newIndex > event.oldIndex
          ? event.newIndex - 1
          : event.newIndex,
      item,
    );

    emit(WatchlistState(updated));
  }
}
