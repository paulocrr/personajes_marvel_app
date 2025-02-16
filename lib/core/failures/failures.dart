sealed class Failure {
  final String mesanje;

  Failure({required this.mesanje});
}

class FallaDesconocida extends Failure {
  FallaDesconocida() : super(mesanje: 'Error desconocido');
}

class FallaParametros extends Failure {
  FallaParametros() : super(mesanje: 'Error el los parametros enviados');
}

class FallaServidor extends Failure {
  FallaServidor() : super(mesanje: 'Error en el servidor');
}

class FallaDeAutorizacion extends Failure {
  FallaDeAutorizacion()
    : super(mesanje: 'Error en los parametros de autorizacion');
}

class FallaEnLaConeccion extends Failure {
  FallaEnLaConeccion() : super(mesanje: 'Usted no tiene internet');
}
