class Car{
	PVector pos;
	PVector vel;
	PVector acc;
	Track t;
	float dir;
	int w,h;
	NeuralNetwork nn;



	Car(int x,int y,Track t){
		this.pos=new PVector(x,y);
		this.dir=0;
		this.vel=new PVector(0,0);
		this.acc=new PVector(0,0);
		this.w=15;
		this.h=35;
		this.t=t;
		this.nn=new NeuralNetwork(10,15,2,0.01);
	}



	Car(int x,int y,Track t,JSONObject nn_data){
		this.pos=new PVector(x,y);
		this.dir=0;
		this.vel=new PVector(0,0);
		this.acc=new PVector(0,0);
		this.w=15;
		this.h=35;
		this.t=t;
		this.nn=new NeuralNetwork(nn_data);
	}



	void update(){
		float[] dt=this.line_collisions();
		push();
		textAlign(CENTER,CENTER);
		noStroke();
		ellipseMode(CENTER);
		textFont(createFont("Consolas",13));
		int i=0;
		int CIRCLE_WIDTH=40,CIRCLE_GAP=20,W=800;
		for (float n:dt){
			float b;
			colorMode(HSB,360,100,100);
			fill(map(n,0,1,100,0),100,100);
			b=brightness(color(map(n,0,1,100,0),100,100));
			if (n<0){
				fill(0,0,30);
				b=brightness(color(0,0,30));
			}
			ellipse((W-(8*CIRCLE_WIDTH+7*CIRCLE_GAP))/2+CIRCLE_WIDTH/2+(CIRCLE_WIDTH+CIRCLE_GAP)*i,700,CIRCLE_WIDTH,CIRCLE_WIDTH);
			fill(0,0,0);
			if (b<50){
				fill(0,0,100);
			}
			text(nf(n,1,1),(W-(8*CIRCLE_WIDTH+7*CIRCLE_GAP))/2+CIRCLE_WIDTH/2+(CIRCLE_WIDTH+CIRCLE_GAP)*i,700);
			i++;
		}
		pop();
		float[] data=new float[10];
		data[0]=this.vel.x/6;
		data[1]=this.vel.y/6;
		for (i=0;i<8;i++){
			data[i+2]=dt[i];
		}
		float[] p=this.nn.predict(data);
		this.pos.add(this.vel);
		this.vel.add(new PVector(p[0],p[1]).mult(6));
		this.vel.limit(6);
		this.dir=this.vel.heading()+HALF_PI;
		push();
		translate(800,0);
		this.nn.draw(data,400,800);
		pop();
	}



	void draw(){
		new RotRect(this.pos.x,this.pos.y,this.w,this.h,this.dir).draw();
		push();
		translate(this.pos.x,this.pos.y);
		rotate(this.dir);
		rectMode(CENTER);
		noStroke();
		fill(220,20,30);
		rect(0,0,this.w,this.h,7,7,3.5,3.5);
		pop();
	}



	float[] line_collisions(){
		int LEN=125;
		float[] data=new float[8];
		Line[] tl=this.t.get_lines();
		for (Line k:tl){
			if (collision_line_rot_rect(k,new RotRect(this.pos.x,this.pos.y,this.w,this.h,this.dir))==true){
				noLoop();
			}
		}
		for (float a=0;a<=TWO_PI-QUARTER_PI;a+=QUARTER_PI){
			Line l=new Line(this.pos.x,this.pos.y,this.pos.x+LEN*cos(a),this.pos.y+LEN*sin(a));
			push();
			strokeWeight(0.25);
			l.draw();
			pop();
			float minDist=LEN+1;
			PVector intersection=new PVector(-1,-1);
			for (Line k:tl){
				if (intersection_line_line(k,l)!=null&&this.pos.dist(intersection_line_line(k,l))<minDist){
					intersection=intersection_line_line(k,l);
					minDist=this.pos.dist(intersection_line_line(k,l));
				}
			}
			if (minDist<LEN+1){
				push();
				ellipseMode(CENTER);
				noStroke();
				colorMode(HSB,360,100,100);
				fill(map(this.pos.dist(intersection),0,LEN,0,100),100,100);
				ellipse(intersection.x,intersection.y,8,8);
				pop();
			}
			data[round(a/QUARTER_PI)]=map(minDist,0,LEN,1,0);
			if (minDist==LEN+1){
				data[round(a/QUARTER_PI)]=-1;
			}
		}
		return data;
	}
}
