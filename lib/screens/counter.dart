import 'package:bytebank/components/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Exemplo de contador utilizando Bloc
// Em duas variações

//Classe responsavel pelo gerenciar o state do type ? - Cubit<?>
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // inicial state
  void increment() =>
      emit(state + 1); //emit: notifica os build a mudança no state
  void decrement() => emit(state - 1);
}

// Classe que cria o contador e prove o Cubit
// todo mundo vai ter em seu context acesso ao CounterCubit
class CounterConteiner extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Juntar o state(Cubit) com a view (StatelessWidget)
      // colocando no context o Cubit
      create: (_) => CounterCubit(), // Provendo um Cubit para os filhos
      child: CounterView(), // apenas um filho a view
    );
  }
}

// Classe faz a View, a ideia é fazer o sistema gerenciar o estado
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
        // BlocBuilder - cria um widget baseado em um Bloc, <Cubit, type>
        // Quando o Bloc  notifica(emit), então o build tem que ser redesenhado
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            // state type
            return Text(
              '$state',
              style: textTheme.headline2,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            // accesando o context solicitando(read) o CounterCubit
            onPressed: () => context.read<CounterCubit>().increment(),
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            // accesando o context solicitando(read) o CounterCubit
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
