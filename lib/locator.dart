import 'package:get_it/get_it.dart';
import 'package:sparrowconnected_homework/core/services/authservices.dart';
import 'package:sparrowconnected_homework/core/services/newservices.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => NewServices());
}
