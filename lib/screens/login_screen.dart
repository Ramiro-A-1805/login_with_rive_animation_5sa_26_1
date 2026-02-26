import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async'; //3.1 Importa el Timer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  // crear el cerebro de la animacion
  StateMachineController? _controller;
  //SMI: State Machine Input
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;

//2.1 Variable para el recorrido de la mirada
  SMINumber? _numlook;


  //1.1) Crear variables para FocusNode
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //3.2 Timer para detener la mirada
  Timer? _typingDebounce;

  //1.2) Listener para FocusNode(Oyentes/chismosos)
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        //verifica que sea nulo
        if (_isHandsUp != null) {
          // manos abajo en el email
          _isHandsUp!.change(false);
          //2.2 mirada neutral
          _numlook?.value = 50.0;
        }
      }
    });
    _passwordFocusNode.addListener(() {
      //manos arriba en password
      if (_isHandsUp != null) {
        _isHandsUp!.change(_passwordFocusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      //Evita que se quite espacio del nudge
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_bear.riv',
                  stateMachines: const ['Login Machine'],
                  //Al iniciar la animacion
                  onInit: (artboard) {
                    _controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine',
                    );

                    //verifica que inicio bien
                    if (_controller == null) return;
                    // agrega el controlador al tablero/escenario
                    artboard.addController(_controller!);
                    _isChecking = _controller!.findSMI('isChecking') as SMIBool?;
                    _isHandsUp = _controller!.findSMI('isHandsUp') as SMIBool?;
                    _trigSuccess = _controller!.findSMI('trigSuccess') as SMITrigger?;
                    _trigFail = _controller!.findSMI('trigFail') as SMITrigger?;
                    //2.3 vincular numLook
                    _numlook = _controller!.findSMI('numLook');
                  },
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                //1.3 Asignar FocusNode al Textfield
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    //No tapes los ojos al ver email
                    //_isHandsUp!.change(false);
                  
                  }
                  //Si isChecking no es nulo
                  if (_isChecking == null) return;
                  // activar el modo chismoso
                  _isChecking!.change(true);
                  //2.4 Implementar numLook
                  //Ajustes de limites de 0 a 100
                  //80 como medida de calibracion
                  final look = (value.length/80.0*100.0)
                  .clamp(0.0, 100.0); //Clamp es el rango (Abrazadera)
                  _numlook?.value = look;

                  //3.3 Debounce: si vuelve a teclear, reinicia el contador
                  // cancelar cualquier timer existente
                  _typingDebounce?.cancel();
                  // crear un nuevo timer
                  _typingDebounce = Timer(
                    const Duration(seconds: 1), () {
                      //Si se cierra la pantalla, quita el contador
                      if (!mounted) return;
                      //Mirada neutra
                      _isChecking?.change(false);
                    }
                  );

                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                focusNode: _passwordFocusNode,
                obscureText: _obscureText,
                onChanged: (value) {
                  if (_isChecking != null) {
                    _isChecking!.change(false);
                  }
                  if (_isHandsUp != null) {
                    _isHandsUp!.change(true);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  //1.4 Liberar memoria/recursos al salir de la pantalla
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _typingDebounce?.cancel();
    super.dispose();
  }
}