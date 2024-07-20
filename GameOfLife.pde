int[][] grid;
int[][] nextGrid;
int cols, rows;
int cellSize = 10;
boolean paused = true;

void setup() {
  size(960, 540);
  cols = width / cellSize;
  rows = height / cellSize;
  grid = new int[cols][rows];
  nextGrid = new int[cols][rows];
  //initializeGrid();
  frameRate(20);
}

void draw() {
  background(0);
  drawGrid();
  if(!paused) updateGrid();
}

void mouseDragged() {
  if((mouseX < width && mouseX >= 0) && (mouseY < height && mouseY >= 0)){
    if(grid[mouseX / cellSize][mouseY / cellSize] == 0) grid[mouseX / cellSize][mouseY / cellSize] = 1;
  }
}

void mouseClicked() {
  if((mouseX < width && mouseX >= 0) && (mouseY < height && mouseY >= 0)){
    if(grid[mouseX / cellSize][mouseY / cellSize] == 0) grid[mouseX / cellSize][mouseY / cellSize] = 1;
    else grid[mouseX / cellSize][mouseY / cellSize] = 0;
  }
}

void keyPressed() {
  if(key == ' ') paused = !paused;
}

void initializeGrid() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      grid[x][y] = int(random(2)); // Randomly assign cells as alive (1) or dead (0)
    }
  }
}

void drawGrid() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      if (grid[x][y] == 1) {
        fill(255);
      } else {
        fill(0);
      }
      stroke(0);
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }
}

void updateGrid() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int state = grid[x][y];
      int neighbors = countNeighbors(x, y);
      
      if (state == 0 && neighbors == 3) {
        nextGrid[x][y] = 1; // Birth
      } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
        nextGrid[x][y] = 0; // Death
      } else {
        nextGrid[x][y] = state; // Stays the same
      }
    }
  }
  
  // Copy nextGrid to grid
  int[][] temp = grid;
  grid = nextGrid;
  nextGrid = temp;
}

int countNeighbors(int x, int y) {
  int sum = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int col = (x + i + cols) % cols;
      int row = (y + j + rows) % rows;
      sum += grid[col][row];
    }
  }
  sum -= grid[x][y]; // Subtract the cell itself
  return sum;
}
