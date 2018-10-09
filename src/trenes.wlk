

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
	
	method pesoMaximo(){
		return self.cantDePasajeros() * 80
	}
	
	method esLocomotora() = false
}

class VagonDeCarga{
	
	var property cargaMaxima = 0
	
	method pesoMaximo(){
		return cargaMaxima + 160
	}
	
	method cantDePasajeros() = 0
	
	method esLocomotora() = false
}

class Locomotora{
	var property pesoMaximo = 0
	var property pesoQuePuedeArrastrar = 0
	var property velocidadMaxima = 0
	
	method arrastreUtil() = pesoQuePuedeArrastrar - pesoMaximo
	method esLocomotora() = true
}

class Formacion{
	var property vagones = []
	
	method vagonesLivianos(){
		return vagones.count {vagon => vagon.pesoMaximo() < 2500}
	}
	
	method velocidadMaxima() = vagones.filter {vagon => 
		vagon.esLocomotora()
	}.min{locomotora => locomotora.velocidadMaxima()}.velocidadMaxima()
	
	method esEficiente() = 
}

