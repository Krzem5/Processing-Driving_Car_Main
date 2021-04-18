Car c;
Track t;



void setup(){
	size(1200,800);
	t=new Track("track_data");
	c=new Car(119,265,t);
}



void draw(){
	background(0);
	t.draw();
	push();
	c.update();
	c.draw();
	pop();
}
