class RotRect{
	PVector tl;
	PVector tr;
	PVector bl;
	PVector br;



	RotRect(float x,float y,float w,float h,float a){
		this.tl=new PVector((-w/2*cos(a))-(-h/2*sin(a))+x,(-h/2*cos(a))+(-w/2*sin(a))+y);
		this.tr=new PVector((-w/2*cos(a))-(h/2*sin(a))+x,(h/2*cos(a))+(-w/2*sin(a))+y);
		this.bl=new PVector((w/2*cos(a))-(-h/2*sin(a))+x,(-h/2*cos(a))+(w/2*sin(a))+y);
		this.br=new PVector((w/2*cos(a))-(h/2*sin(a))+x,(h/2*cos(a))+(w/2*sin(a))+y);
	}



	void draw(){
		push();
		noStroke();
		fill(0,0,230);
		ellipseMode(CENTER);
		ellipse(this.tl.x,this.tl.y,5,5);
		ellipse(this.tr.x,this.tr.y,5,5);
		ellipse(this.bl.x,this.bl.y,5,5);
		ellipse(this.br.x,this.br.y,5,5);
		pop();
	}
}
