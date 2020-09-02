import 'package:flutter/material.dart';

class TresEnRaya extends StatefulWidget{
  @override
  State createState() {
    return TresEnRayaEstado();
  }
}
enum EstadoJuego{
  inicio,
  jugar1,
  jugar2,
  finGano1,
  finGano2,
  finEmpate
}
enum EstadoBotonCuadrado{
  noMarcado,
  marcado1,
  marcado2,
}

class TresEnRayaEstado extends State<TresEnRaya>{
  final String tituloInicio = 'Tres en Raya';
  final String tituloJugar1 = 'Tres en Raya (1)';
  final String tituloJugar2 = 'Tres en Raya (2)';
  final String tituloFinGano1 = 'Finalizado Ganador (1)';
  final String tituloFinGano2 = 'Finalizado Ganador (2)';
  final String tituloFinEmpate = 'Finalizado Empate';
  final Color colorInicio = Colors.blue;
  final Color colorJugador1 = Colors.orange;
  final Color colorJugador2 = Colors.green;
  final Color colorNoMarcado = Colors.grey;
  final IconData iconoPlay = Icons.play_arrow;
  final IconData iconoParar = Icons.stop;
  EstadoJuego estadoJuego = EstadoJuego.inicio;
  List<BotonCuadrado> listaBotones = [];


  TresEnRayaEstado(){
       inicializarListaBotones();
  }
  bool coprobarPosiciones(int pos1, int pos2, int pos3, EstadoBotonCuadrado estadoBoton){
   return ((listaBotones[pos1].estado == estadoBoton) &&
        (listaBotones[pos2].estado == estadoBoton) &&
        (listaBotones[pos3].estado == estadoBoton));
  }
  bool comprobarFin(EstadoBotonCuadrado estadoBoton){
    //Comprobar Jusgador
    return coprobarPosiciones(0,1,2,estadoBoton) ||
        coprobarPosiciones(3,4,5,estadoBoton) ||
        coprobarPosiciones(6,7,8,estadoBoton) ||
        coprobarPosiciones(0,3,6,estadoBoton) ||
        coprobarPosiciones(1,4,7,estadoBoton) ||
        coprobarPosiciones(2,5,8,estadoBoton) ||
        coprobarPosiciones(0,4,8,estadoBoton) ||
        coprobarPosiciones(2,4,6,estadoBoton);
  }
  bool todosPulsados(){
    bool resultado = true;
    for(int i= 0; i < 9; i ++) {
      resultado = resultado && listaBotones[i].estado!= EstadoBotonCuadrado.noMarcado;
    };
    return resultado;
  }

  void botonCuadradoPulsado(int posicion, EstadoBotonCuadrado estado){
    if
    ((estado == EstadoBotonCuadrado.noMarcado) &&
    ((estadoJuego==EstadoJuego.jugar1) ||
    (estadoJuego == EstadoJuego.jugar2))){
      setState(() {
        listaBotones[posicion] = BotonCuadrado(posicion,
            estadoJuego==EstadoJuego.jugar1 ? EstadoBotonCuadrado.marcado1 : EstadoBotonCuadrado.marcado2,
            this.botonCuadradoPulsado);
          estadoJuego = estadoJuego == EstadoJuego.jugar1 ? EstadoJuego.jugar2 : EstadoJuego.jugar1;
          if (comprobarFin(EstadoBotonCuadrado.marcado1))
            estadoJuego = EstadoJuego.finGano1;
          else if (comprobarFin(EstadoBotonCuadrado.marcado2))
            estadoJuego = EstadoJuego.finGano2;
          else if (todosPulsados())
            estadoJuego = EstadoJuego.finEmpate;
      });
    }
  }
  void inicializarListaBotones(){
    this.listaBotones = [];
    for(int i=0;i<9;i++){
      listaBotones.add(BotonCuadrado(i, EstadoBotonCuadrado.noMarcado,this.botonCuadradoPulsado));
    }
  }
  AppBar getAppBar(){
    String titulo;
    Color colorAppbar;
    IconData iconoBotonAppBar;
    switch(estadoJuego){
      case EstadoJuego.inicio:
        titulo = tituloInicio;
        colorAppbar = colorInicio;
        iconoBotonAppBar = iconoPlay;
        break;
      case EstadoJuego.jugar1:
        titulo = tituloJugar1;
        colorAppbar = colorJugador1;
        iconoBotonAppBar = iconoParar;
        break;
      case EstadoJuego.jugar2:
        titulo = tituloJugar2;
        colorAppbar = colorJugador2;
        iconoBotonAppBar = iconoParar;
        break;
      case EstadoJuego.finGano1:
        titulo = tituloFinGano1;
        colorAppbar = colorInicio;
        iconoBotonAppBar = iconoPlay;
        break;
      case EstadoJuego.finGano2:
        titulo = tituloFinGano2;
        colorAppbar = colorInicio;
        iconoBotonAppBar = iconoPlay;
        break;
      case EstadoJuego.finEmpate:
        titulo = tituloFinEmpate;
        colorAppbar = colorInicio;
        iconoBotonAppBar = iconoPlay;
        break;
    }
    return AppBar(
      title: Text(titulo),
      backgroundColor: colorAppbar,
      actions: <Widget>[
        IconButton(
          icon: Icon(iconoBotonAppBar),
          onPressed: (){
            setState(() {
              if  ((estadoJuego==EstadoJuego.jugar1) ||
                  (estadoJuego==EstadoJuego.jugar2)){
                estadoJuego=EstadoJuego.inicio;
              } else {
                estadoJuego=EstadoJuego.jugar1;
              }
              inicializarListaBotones();
            });

          },
        )
      ],
    );
  }

  Container getBotonesCuadrados(){
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              listaBotones[0],
              listaBotones[1],
              listaBotones[2],
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              listaBotones[3],
              listaBotones[4],
              listaBotones[5],
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              listaBotones[6],
              listaBotones[7],
              listaBotones[8],
            ],
          )
        ],
      )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBotonesCuadrados(),
    );
  }
}

class BotonCuadrado extends StatelessWidget{
  final Color colorJugador1 = Colors.orange;
  final Color colorJugador2 = Colors.green;
  final Color colorNoMarcado = Colors.grey;
  EstadoBotonCuadrado estado;
  int posicion;
  Function(int, EstadoBotonCuadrado) funcionPulsado;

  BotonCuadrado(this.posicion,this.estado, this.funcionPulsado){
    print('Constructor boton cuadrado');
    print(this.estado);
  }

  Color getColor(){
    Color elColor = colorNoMarcado;
    if (estado == EstadoBotonCuadrado.marcado1)
      elColor = colorJugador1;
    if (estado == EstadoBotonCuadrado.marcado2)
      elColor = colorJugador2;
    return elColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        width: 100,
        color: getColor(),
      ),
      onTap: (){
        this.funcionPulsado(posicion,estado);
      },
    );
  }
}



