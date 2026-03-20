abstract class WatchlistEvent {}

class ReorderStocks extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStocks(this.oldIndex, this.newIndex);
}
