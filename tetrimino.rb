# -*- coding: utf-8 -*-
class Tetrimino
  # NoShape = 0
  # ZShape = 1
  # SShape = 2
  # LineShape = 3
  # TShape = 4
  SquareShape = 5
  # LShape = 6
  # MirroredLShape = 7

  Directions = {
    Left: [0,-1],
    Right: [0,1],
    Down: [1,0]}
  
  CoordsTable = [
                 [ [ 0, 0 ],   [ 0, 0 ],   [ 0, 0 ],   [ 0, 0 ] ],
                 [ [ 0, -1 ],  [ 0, 0 ],   [ -1, 0 ],  [ -1, 1 ] ],
                 [ [ 0, -1 ],  [ 0, 0 ],   [ 1, 0 ],   [ 1, 1 ] ],
                 [ [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ],   [ 0, 2 ] ],
                 [ [ -1, 0 ],  [ 0, 0 ],   [ 1, 0 ],   [ 0, 1 ] ],
                 [ [ 0, 0 ],   [ 1, 0 ],   [ 0, 1 ],   [ 1, 1 ] ],
                 [ [ -1, -1 ], [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ] ],
                 [ [ 1, -1 ],  [ 0, -1 ],  [ 0, 0 ],   [ 0, 1 ] ] ]
  
  attr_reader :shape

  def initialize(width,board)
    @shape = Kernel.rand(7) + 1
    @coords = CoordsTable[@shape]
    @board = board
    @width = width
    @x,@y = 0,@width/2
  end

  def rotate   #def rotateRight
    tmp = @coords.map{|x,y| [-y,x]}
    if canMove?(tmp) and @shape != SquareShape
      @coords = tmp
      absoluteCoordinate
    else
      nil
    end    
  end

  def move(direction_sym)
    direction = Directions[direction_sym]    
    if canMove?(@coords.map{|x,y| [x+direction[0] , y+direction[1]] })
      @x,@y = @x+direction[0],@y+direction[1]
      absoluteCoordinate
    else
      nil
    end    
  end

  def absoluteCoordinate
    @coords.map{|x,y| [@x+x,@y+y]}
  end
  
  def canMove?(coords)    
    coords.all? do |x,y|
      tx = @x + x
      ty = @y + y
      #p @board
      (0..(@width-1)).include? ty and (0..(@board.count-1)).include? tx and@board[tx][ty] == 0
    end
  end

end
