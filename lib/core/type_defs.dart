import 'package:fpdart/fpdart.dart';

import 'core.dart';

//*Either que regresara un error o un dato de tipo genericos
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
