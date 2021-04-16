class Track {
  PVector[][] edges;
  Track(String fn) {
    this.edges=this.from_file(fn);
  }
  PVector[][] from_file(String fn) {
    JSONArray json=loadJSONArray(fn+".json");
    PVector[][] data=new PVector[json.size()][];
    for (int i=0; i<json.size(); i++) {
      PVector[] border=new PVector[json.getJSONArray(i).size()];
      JSONArray b=json.getJSONArray(i);
      for (int j=0; j<b.size(); j++) {
        JSONObject p=b.getJSONObject(j);
        border[j]=new PVector(p.getInt("x"), p.getInt("y"));
      }
      data[i]=border;
    }
    return data;
  }
  Line[] get_lines() {
    int idx=0;
    for (PVector[] b : this.edges) {
      idx+=b.length;
    }
    Line[] lines=new Line[idx];
    idx=0;
    for (int i=0; i<this.edges.length; i++) {
      for (int j=0; j<this.edges[i].length; j++) {
        lines[idx]=new Line(this.edges[i][j].x, this.edges[i][j].y, this.edges[i][(j+1)%this.edges[i].length].x, this.edges[i][(j+1)%this.edges[i].length].y);
        idx++;
      }
    }
    return lines;
  }
  void draw() {
    push();
    stroke(255);
    noFill();
    for (PVector[] border : this.edges) {
      beginShape();
      for (PVector v : border) {
        vertex(v.x, v.y);
      }
      endShape(CLOSE);
    }
    pop();
  }
}
