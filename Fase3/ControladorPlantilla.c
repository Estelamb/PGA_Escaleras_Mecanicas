//---------------------------------------------------
// �NICAS VARIABLES DISPONIBLES PARA UTILIZAR:
int y0; //Salida del controlador en el instante k
int y1=0; //Salida del controlador en el instante k-1
int y2=0; //Salida del controlador en el instante k-2
int y3=0; //Salida del controlador en el instante k-3
int y4=0; //Salida del controlador en el instante k-4

int x0; //Entrada al controlador en el instante k
int x1=0; //Entrada al controlador en el instante k-1
int x2=0; //Entrada al controlador en el instante k-2
int x3=0; //Entrada al controlador en el instante k-3

int e;
//---------------------------------------------------


//---------------------------------------------------
//C�DIGO EJECUTABLE: 
while (1==1) {
	//Error del sistema: 
	e=entrada-salida; //entrada y salida son variables globales
	
	/////////////////////////
	//INICIO C�DIGO DE ALUMNO
    
    x0 = e;
    y0 = 0.9953*y1 + 4.8538*x0 - 4.3443*x1;
    y1 = y0;
    x1 = x0;

	//FIN C�DIGO DE ALUMNO
	/////////////////////////
	
	//Retardo de ejecuci�n del bucle:
	delay(T); //T es una variable global
}
//---------------------------------------------------
