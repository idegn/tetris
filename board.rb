# -*- coding: utf-8 -*-
require './tetrimino'
class Board

  attr_reader :board

  def initialize(width,height)
    @width = width
    @height = height
    @board = Array.new(height){Array.new(width, 0)}
  end

  def generateTetrimino
    @movingTetrimino = Tetrimino.new(@width, @board)    
  end  
  
  def removeLines
    @board.reject! {|row| not row.include?(0)}
    (@height - @board.count).times do
      @board.unshift(Array.new(@width,0))
    end
  end

  def safe?
    @movingTetrimino.absoluteCoordinate.all? do |arr|
      not arr.any?{|i| i < 0}
    end
  end

  def moveTetrimino(direction_sym)
    @movingTetrimino.move(direction_sym)
  end

  def rotateTetrimino #命名
    @movingTetrimino.rotate
  end

  def tetriminoAbsoluteCoordinate #命名
    @movingTetrimino.absoluteCoordinate
  end

  def tetriminoShape #命名
    @movingTetrimino.shape
  end
  
  def putTetriminoOnBoard
    if safe?
      #p @movingTetrimino.absoluteCoordinate
      @movingTetrimino.absoluteCoordinate.each do |x,y|
        @board[x][y] = @movingTetrimino.shape
      end
      #p @board
      removeLines
      generateTetrimino
      true
    else
      gameOver
    end
  end

  def gameOver
    puts "GameOver" #FIXME
    exit(0)#FIXME
  end
end
