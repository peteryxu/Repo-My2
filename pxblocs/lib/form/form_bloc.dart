import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  MyFormState get initialState => MyFormState.initial();

  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    print(transition);
  }


  @override
  Stream<MyFormState> mapEventToState(
    MyFormEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield currentState.copyWith(
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      );
    }
    if (event is PasswordChanged) {
      yield currentState.copyWith(
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
      );
    }
    if (event is FormSubmitted) {
      yield currentState.copyWith(formSubmittedSuccessfully: true);
    }
    if (event is FormReset) {
      yield MyFormState.initial();
    }
  }

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}

@immutable
abstract class MyFormEvent extends Equatable {
  MyFormEvent([List props = const []]) : super(props);
}

class EmailChanged extends MyFormEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends MyFormEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class FormSubmitted extends MyFormEvent {
  @override
  String toString() => 'FormSubmitted';
}

class FormReset extends MyFormEvent {
  @override
  String toString() => 'FormReset';
}

@immutable
class MyFormState extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final bool formSubmittedSuccessfully;

  bool get isFormValid => isEmailValid && isPasswordValid;

  MyFormState({
    @required this.email,
    @required this.isEmailValid,
    @required this.password,
    @required this.isPasswordValid,
    @required this.formSubmittedSuccessfully,
  }) : super([
          email,
          isEmailValid,
          password,
          isPasswordValid,
          formSubmittedSuccessfully,
        ]);

  factory MyFormState.initial() {
    return MyFormState(
      email: '',
      isEmailValid: false,
      password: '',
      isPasswordValid: false,
      formSubmittedSuccessfully: false,
    );
  }

  MyFormState copyWith({
    String email,
    bool isEmailValid,
    String password,
    bool isPasswordValid,
    bool formSubmittedSuccessfully,
  }) {
    return MyFormState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      formSubmittedSuccessfully:
          formSubmittedSuccessfully ?? this.formSubmittedSuccessfully,
    );
  }

  @override
  String toString() {
    return '''MyFormState {
      email: $email,
      isEmailValid: $isEmailValid,
      password: $password,
      isPasswordValid: $isPasswordValid,
      formSubmittedSuccessfully: $formSubmittedSuccessfully
    }''';
  }
}


