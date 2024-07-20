static int grainSize = 10;

int rows, cols;
boolean[][] cellState;
boolean[][] nextState;

void setup() {
  size(960, 540);
  //fullScreen();
  noStroke();
  rows = height / grainSize;
  cols = width / grainSize;
  cellState = new boolean[rows][cols];
  nextState = new boolean[rows][cols];
}

void draw() {
  background(0);
  
  if(mousePressed){
    int cellX = mouseX / grainSize;
    int cellY = mouseY / grainSize;
    if (cellX < cols && cellX >= 0 && cellY < rows && cellY >= 0) cellState[cellY][cellX] = true;
  }
  
  // Clear the nextState array
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      nextState[r][c] = false;
    }
  }

  // Update cell states
  for (int r = rows - 1; r >= 0; r--) {
    for (int c = 0; c < cols; c++) {
      if (cellState[r][c]) {
        if (r < rows - 1 && !cellState[r + 1][c]) {
          nextState[r + 1][c] = true; // Move sand grain down if the cell below is empty
        } else {
          int dir = (random(2) < 1) ? -1 : 1; // Randomly choose left (-1) or right (1) direction
          if (r < rows - 1 && c + dir >= 0 && c + dir < cols && !cellState[r + 1][c + dir]) {
            nextState[r + 1][c + dir] = true; // Move sand grain diagonally down-left or down-right if possible
          } else {
            nextState[r][c] = true; // Keep sand grain in place if it can't move down or diagonally
          }
        }
      }
    }
  }

  // Swap cellState and nextState arrays
  boolean[][] temp = cellState;
  cellState = nextState;
  nextState = temp;

  // Draw cells
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if (cellState[r][c]) fill(220, 200, 150);
      else fill(0);
      rect(c * grainSize, r * grainSize, grainSize, grainSize);
    }
  }
}
