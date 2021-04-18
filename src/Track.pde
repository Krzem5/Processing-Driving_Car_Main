class Track{
	PVector[][] el;



	Track(String fn){
		JSONArray json=loadJSONArray(fn+".json");
		this.el=new PVector[json.size()][];
		for (int i=0;i<json.size();i++){
			PVector[] b=new PVector[json.getJSONArray(i).size()];
			JSONArray k=json.getJSONArray(i);
			for (int j=0;j<k.size();j++){
				JSONObject p=k.getJSONObject(j);
				b[j]=new PVector(p.getInt("x"),p.getInt("y"));
			}
			this.el[i]=b;
		}
	}



	void draw(){
		push();
		stroke(255);
		noFill();
		for (PVector[] b:this.el){
			beginShape();
			for (PVector v:b){
				vertex(v.x,v.y);
			}
			endShape(CLOSE);
		}
		pop();
	}



	Line[] get_lines(){
		int idx=0;
		for (PVector[] b:this.el){
			idx+=b.length;
		}
		Line[] o=new Line[idx];
		idx=0;
		for (int i=0;i<this.el.length;i++){
			for (int j=0;j<this.el[i].length;j++){
				o[idx]=new Line(this.el[i][j].x,this.el[i][j].y,this.el[i][(j+1)%this.el[i].length].x,this.el[i][(j+1)%this.el[i].length].y);
				idx++;
			}
		}
		return o;
	}
}
