

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

}

class VagonDeCarga{
	
	var property cargaMaxima = 0
	
	method pesoMaximo(){
		return cargaMaxima + 160
	}
	
	method cantDePasajeros() = 0
}

class Locomotora{
	var property pesoMaximo = 0
	var property pesoQuePuedeArrastrar = 0
	var property velocidadMaxima = 0
	
	method arrastreUtil() = pesoQuePuedeArrastrar - pesoMaximo
}

class Formacion{
	var property vagones = []
	var property locomotoras = []
	
	var property formacion = vagones + locomotoras
	
	method vagonesLivianos(){
		return formacion.count {vagon => vagon.pesoMaximo() < 2500}
	}
	
	method velocidadMaxima() = locomotoras.min{locomotora => locomotora.velocidadMaxima()}.velocidadMaxima()
	
	method esEficiente() = locomotoras.all {locomotora => locomotora.pesoQuePuedeArrastrar() >= locomotora.pesoMaximo() * 5}
	
	method puedeMoverse() = locomotoras.sum {locomotora => locomotora.arrastreUtil()} >= vagones.sum {vagon => vagon.pesoMaximo()}
	
	method kilosDeEmpujeQueFaltanParaMoverse(){
		var kilosDeEmpujeQueFaltan = 0
			if(not self.puedeMoverse()){
				kilosDeEmpujeQueFaltan = vagones.sum {vagon => vagon.pesoMaximo()} - locomotoras.sum {locomotora => locomotora.arrastreUtil()} 
			}
			
			return kilosDeEmpujeQueFaltan
	}
	
	method vagonMasPesado() = vagones.max {vagon => vagon.pesoMaximo()}
	
	method esCompleja() = formacion.size() > 20 or formacion.sum {vagonesYLocomotoras => vagonesYLocomotoras.pesoMaximo() > 10000}
	
	method buscarLocomotora(listaLocomotoras) {
     	return listaLocomotoras.find { locomotora => locomotora.arrastreUtil() >= self.kilosDeEmpujeQueFaltanParaMoverse() }
     }
	
	method agregarLocomotora(listaLocomotoras) = locomotoras.add(self.buscarLocomotora(listaLocomotoras))
	
	method estaBienArmada() = self.puedeMoverse()
	
	method totalDePasajeros() = vagones.sum { vagon => vagon.pasajerosTotales() }
	
	method hayUnBanioCada50Pasajeros() = self.pasajerosTotales() / 50 >= 1
	
    method sonTodosVagonesLivianos() {
    	return vagones.all { vagon => vagon.vagonesLivianos() }
    }
}

class Deposito {

	var property formaciones = []
	var property locomotorasSueltas = []
	
	method vagonesMasPesados() = formaciones.map {formacion => formacion.vagonMasPesado()}.asSet()
	
	method necesitaConductorExpermientado() = formaciones.any {formacion => formacion.esCompleja()}
	
	method agregarLocomotoraAFormacion(formacion) {
	  return if( not formacion.puedeMoverse()) formacion.agregarLocomotora(locomotorasSueltas) else {}
 	}	
}

class FormacionesDeCortaDistancia inherits Formacion {
	override method estaBienArmada() {
		return super() and not self.esCompleja()
	}
	override method velocidadMaxima() = 60
}

class FormacionesDeLargaDistancia inherits Formacion {
	var property uneDosCiudades
	override method estaBienArmada() {
		return super() and self.hayUnBanioCada50Pasajeros()
	}
	
	override method velocidadMaxima() = if ( uneDosCiudades ) 200 else 150
}

class FormacionesDeAltaVelocidad inherits FormacionesDeLargaDistancia {
	override method estaBienArmada() {
		return self.velocidadMaxima() >= 250 and self.sonTodosVagonesLivianos()
	}
}
