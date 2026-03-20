import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
  title: const Text(
    "My Watchlist",
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
  backgroundColor: Colors.black,
  elevation: 0,
),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            return ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                context
                    .read<WatchlistBloc>()
                    .add(ReorderStocks(oldIndex, newIndex));
              },
              children: [
                for (int i = 0; i < state.stocks.length; i++)
Container(
  key: ValueKey(state.stocks[i].name),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  decoration: BoxDecoration(
    color: const Color(0xFF1E1E1E),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.stocks[i].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            state.stocks[i].exchange,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹${state.stocks[i].price}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${state.stocks[i].change}%",
            style: TextStyle(
              color: state.stocks[i].change >= 0
                  ? Colors.greenAccent
                  : Colors.redAccent,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  ),
)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.stocks[i].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.stocks[i].exchange,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.stocks[i].price.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${state.stocks[i].change}%",
                              style: TextStyle(
                                color: state.stocks[i].change >= 0
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
