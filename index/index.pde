Car car;
Track track;
void setup() {
  size(1200, 800);
  //fullScreen();
  track=new Track("track_data");
  car=new Car(119, 265, track);
}
void draw() {
  background(0);
  track.draw();
  push();
  car.update();
  car.draw();
  pop();
}
