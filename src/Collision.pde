boolean collision_line_line(Line l1,Line l2) {
	return (((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))>=0&&((l1.ex-l1.sx)*(l1.sy-l2.sy)-(l1.ey-l1.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))<=1);
}



PVector intersection_line_line(Line l1,Line l2) {
	if (collision_line_line(l1,l2)==true) {
		return new PVector(l1.sx+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ex-l1.sx)),l1.sy+(((l2.ex-l2.sx)*(l1.sy-l2.sy)-(l2.ey-l2.sy)*(l1.sx-l2.sx))/((l2.ey-l2.sy)*(l1.ex-l1.sx)-(l2.ex-l2.sx)*(l1.ey-l1.sy))*(l1.ey-l1.sy)));
	}
	return null;
}



boolean collision_line_rot_rect(Line l,RotRect r) {
	return (collision_line_line(l,new Line(r.tl.x,r.tl.y,r.bl.x,r.bl.y))||collision_line_line(l,new Line(r.tr.x,r.tr.y,r.br.x,r.br.y))||collision_line_line(l,new Line(r.tl.x,r.tl.y,r.tr.x,r.tr.y))||collision_line_line(l,new Line(r.bl.x,r.bl.y,r.br.x,r.br.y)));
}
