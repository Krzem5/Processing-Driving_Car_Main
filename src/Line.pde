class Line{
	float sx;
	float sy;
	float ex;
	float ey;



	Line(float sx,float sy,float ex,float ey){
		this.sx=sx;
		this.sy=sy;
		this.ex=ex;
		this.ey=ey;
	}



	void draw(){
		push();
		stroke(255);
		line(this.sx,this.sy,this.ex,this.ey);
		pop();
	}
}
