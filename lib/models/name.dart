import 'package:flutter_bloc/flutter_bloc.dart';

// o estado é uma unica String
// poderia ser um perfil com diversos valores.
class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);
  void chage(String name) => emit(name);
}
