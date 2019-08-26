// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$LoginStore on _LoginStore, Store {
  final _$valuesAtom = Atom(name: '_LoginStore.values');

  @override
  Map<String, dynamic> get values {
    _$valuesAtom.context.enforceReadPolicy(_$valuesAtom);
    _$valuesAtom.reportObserved();
    return super.values;
  }

  @override
  set values(Map<String, dynamic> value) {
    _$valuesAtom.context.conditionallyRunInAction(() {
      super.values = value;
      _$valuesAtom.reportChanged();
    }, _$valuesAtom, name: '${_$valuesAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic startLoading() {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.startLoading();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic stopLoading({String error, bool complete}) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.stopLoading(error: error, complete: complete);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }
}
