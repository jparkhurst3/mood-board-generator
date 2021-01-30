//Scenarios for prototype
  //user uploads 3 photos
  //user clicks "create board"
  //user sees board
//Scenarios for final proj
  //mood board includes color pallete
  //user can save board as image
  //user sees menu & choses settings
//Stretch goals
  //user can remove an image from list of photos
  //user can go back and edit settings
  //user can upload variable number of photos
  
//PALETTE COLORS RETRIEVAL NOT WORKING - PULLED COLORS MANUALLY FROM SAMPLE PHOTOS

PFont myFont;

boolean menuShowing = true;
boolean moodBoardShowing = false;

PShape square, square2; //both buttons
PShape paletteSquare1, paletteSquare2, paletteSquare3;
boolean rectOver = false;
boolean rectOver2 = false;

int uploadButtonX = 400;
int uploadButtonY = 750;
int uploadButtonSizeW = 400; //make generic since it's being used for both buttons
int uploadButtonSizeH = 100;
color uploadButtonColor;
boolean uploadButtonPressed = false;

int createBoardX = 400;
int createBoardY = 900;
color createBoardColor;
boolean createBoardPressed = false;

color backgroundColor;
color palette1, palette2, palette3; 

boolean imageUploaded;
boolean doneUploading = false;
int imageCount = 0;
PImage image1, image2, image3;
PImage rainbow;
color rainbowColor;
int image1W, image1H, image2W, image2H, image3W, image3H;
int image1Center, image2Center, image3Center;


void setup() {
  size(1200, 1600);
  backgroundColor = (255);
  uploadButtonColor = color(0,0,255);
  createBoardColor = color(0,255,0);
  
  background(backgroundColor);
  
  square = createShape(RECT, 0, 0, uploadButtonSizeW, uploadButtonSizeH);
  square.setFill(uploadButtonColor);
  square.setStroke(false);
  
  square2 = createShape(RECT, 0, 0, uploadButtonSizeW, uploadButtonSizeH);
  square2.setFill(createBoardColor);
  square2.setStroke(false);
  
  myFont = createFont("Lucida Sans", 32);
  textFont(myFont);
  
  //TEST
  //rainbow = loadImage("kitten.jpg");
  //rainbow.resize(0,500);
  //rainbowColor = rainbow.get(rainbow.height/2, rainbow.width/2);
  
  palette1 = color(222, 158, 86);
  palette2 = color(100, 109, 114);
  palette3 = color(0, 93, 40);
  
  paletteSquare1 = createShape(RECT, 0, 0, 160, 350);
  paletteSquare1.setFill(palette1);
  paletteSquare1.setStroke(false);
  paletteSquare2 = createShape(RECT, 0, 0, 160, 350);
  paletteSquare2.setFill(palette2);
  paletteSquare2.setStroke(false);
  paletteSquare3 = createShape(RECT, 0, 0, 160, 350);
  paletteSquare3.setFill(palette3);
  paletteSquare3.setStroke(false);
}

void draw() { 
  update(mouseX, mouseY);
  
  if (menuShowing) {
    //image(rainbow, 0, 0);
    //fill(rainbowColor);
    //rect(20,20,100,100);
    if (uploadButtonPressed) {
      selectInput("Select a file to process:", "fileSelected");
      uploadButtonPressed = false;
    }
    if (imageCount == 1) { 
      background(backgroundColor);
      textSize(42);
      fill(0); 
      text("IMAGES UPLOADED: 1", 385, 1300);
    } else if (imageCount == 2) { 
      background(backgroundColor);
      textSize(42);
      fill(0); 
      text("IMAGES UPLOADED: 2", 385, 1300);
    } else if (imageCount == 3) { 
      background(backgroundColor);
      textSize(42);
      fill(0); 
      text("IMAGES UPLOADED: 3", 380, 1300);
    }
    fill(uploadButtonColor);
    shape(square, uploadButtonX, uploadButtonY);
    textSize(42);
    fill(255); 
    text("UPLOAD PHOTO", 435, 815); //+(30, 115) from button
    
    textSize(64);
    fill(0);
    text("MOOD BOARD CREATOR", 220, 100);
    
    textSize(36);
    fill(0);
    text("Upload three images to create your Mood Board.", 180, 200);
    
    if (imageCount == 3) {
      fill(createBoardColor);
      shape(square2, createBoardX, createBoardY);
      textSize(42);
      fill(255); 
      text("CREATE BOARD", 440, 970); //+(30, 115) from button
    }
  } 
  
  if (moodBoardShowing) {
    background(backgroundColor);
    image(image1, image1Center, 25);
    image(image2, image2Center, 425); 
    image(image3, image3Center, 825);
    
    fill(palette1);
    shape(paletteSquare1, 200, 1225);
    noStroke();
    fill(palette2);
    shape(paletteSquare2, 520, 1225);
    noStroke();
    fill(palette3);
    shape(paletteSquare3, 840, 1225);
    noStroke();
  }
}

void update(int x, int y) {
  if ( overRect(uploadButtonX, uploadButtonY, uploadButtonSizeW, uploadButtonSizeH) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
  if ( overRect(createBoardX, createBoardY, uploadButtonSizeW, uploadButtonSizeH) ) {
    rectOver2 = true;
  } else {
    rectOver2 = false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  if (rectOver) {
    uploadButtonPressed = true;
  }
  if (rectOver2) {
    moodBoardShowing = true;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if (imageCount == 0) {
      image1 = loadImage(selection.getAbsolutePath());
      imageCount++;
    } else if (imageCount == 1) {
      image2 = loadImage(selection.getAbsolutePath());
      imageCount++;
    } else if (imageCount == 2) {
      image3 = loadImage(selection.getAbsolutePath());
      imageCount++;
      doneUploading = true;
      formatPhotos(image1, image2, image3);
      //getPalette(image1, image2, image3);
    } 
  }
}

void formatPhotos(PImage image1, PImage image2, PImage image3) {
    image1.resize(0, 350);
    image2.resize(0, 350);
    image3.resize(0,350); 
    
    image1H = image1.height;
    image1W = image1.width;
    image2H = image2.height;
    image2W = image2.width;
    image3H = image3.height;
    image3W = image3.width;
    
    image1Center = (1200-image1W)/2;
    image2Center = (1200-image2W)/2;
    image3Center = (1200-image3W)/2;
}  

//void getPalette(PImage img1, PImage img2, PImage img3) {
//    //loadPixels();
//    img1.loadPixels();
//    palette1 = image1.get(600,100);
//    println(palette1);
//    img2.loadPixels();
//    palette2 = image2.get(10,10);
//    img3.loadPixels();
//    palette3 = image3.get(10,10);
//    println("palette calculated");
//}  
