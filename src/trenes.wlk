

class VagonDePasajeros{
	
	var property ancho = 0
	var property largo = 0
	
	method cantDePasajeros(){
		var pasajerosQuePuedeLlevar = 0
		if(ancho <= 2.5){
			pasajerosQuePuedeLlevar = largo * 8
		}else{
			pasajerosQuePuedeLlevar = largo * 10
		}
		return pasajerosQuePuedeLlevar
	}
}

class VagonDeCarga{
	
	var property cargaMaxima
	
}

class Locomotora{
	
}

class Formacion{
	var property formacion
}