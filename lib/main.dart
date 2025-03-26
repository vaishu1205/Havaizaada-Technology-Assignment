import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/product_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'screens/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()..add(FetchProducts())),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductPage(),
      ),
    );
  }
}
