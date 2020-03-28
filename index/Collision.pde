class Line {
  float sx, sy, ex, ey;
  Line(float sx, float sy, float ex, float ey) {
    this.sx=sx;
    this.sy=sy;
    this.ex=ex;
    this.ey=ey;
  }
  void draw() {
    push();
    stroke(255);
    line(this.sx, this.sy, this.ex, this.ey);
    pop();
  }
}
class RotRect {
  PVector tl, tr, bl, br;
  RotRect(float x, float y, float w, float h, float a) {
    this.tl=new PVector((-w/2*cos(a))-(-h/2*sin(a))+x, (-h/2*cos(a))+(-w/2*sin(a))+y);
    this.tr=new PVector((-w/2*cos(a))-(h/2*sin(a))+x, (h/2*cos(a))+(-w/2*sin(a))+y);
    this.bl=new PVector((w/2*cos(a))-(-h/2*sin(a))+x, (-h/2*cos(a))+(w/2*sin(a))+y);
    this.br=new PVector((w/2*cos(a))-(h/2*sin(a))+x, (h/2*cos(a))+(w/2*sin(a))+y);
  }
  void draw() {
    push();
    noStroke();
    fill(0, 0, 230);
    ellipseMode(CENTER);
    ellipse(this.tl.x, this.tl.y, 5, 5);
    ellipse(this.tr.x, this.tr.y, 5, 5);
    ellipse(this.bl.x, this.bl.y, 5, 5);
    ellipse(this.br.x, this.br.y, 5, 5);
    pop();
  }
}
boolean collisionLineLine(Line l1, Line l2) {
  return (((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1);
}
PVector intersectionLineLine(Line l1, Line l2) {
  if (collisionLineLine(l1, l2)==true) {
    return new PVector(l1.sx+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ex-l1.sx)), l1.sy+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ey-l1.sy)));
  }
  return null;
}
boolean collisionLineRotRect(Line l, RotRect r) {
  return (collisionLineLine(l, new Line(r.tl.x, r.tl.y, r.bl.x, r.bl.y))||collisionLineLine(l, new Line(r.tr.x, r.tr.y, r.br.x, r.br.y))||collisionLineLine(l, new Line(r.tl.x, r.tl.y, r.tr.x, r.tr.y))||collisionLineLine(l, new Line(r.bl.x, r.bl.y, r.br.x, r.br.y)));
}
