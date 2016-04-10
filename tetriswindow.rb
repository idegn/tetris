# -*- coding: utf-8 -*-
require './board'

class TetrisWindow < Qt::Frame
  Width = 10
  Height = 20  

  slots "onTimer()"
  
  def initialize(parent = nil)
    super(parent)
    #setFrameStyle(Qt::Frame::Panel | Qt::Frame::Sunken)
    setFocusPolicy(Qt::StrongFocus)
    
    @board = Board.new(Width,Height)
    @board.generateTetrimino

    @timer = Qt::Timer.new
    connect(@timer,SIGNAL("timeout()"),self,SLOT("onTimer()"))
    @timer.start(1000)
  end

  def moveTetrimino(direction_sym)
    if direction_sym == :Down
      @board.putTetriminoOnBoard unless @board.moveTetrimino(direction_sym)
      #update
    else
      @board.moveTetrimino(direction_sym)
    end
    update #drawTetrimino #FIXME updateを上のupdateだけにしたい
  end

  def onTimer
    moveTetrimino(:Down)
  end
  
  def paintEvent(e)
    painter = Qt::Painter.new(self)
    drawBoard(painter)
    drawTetrimino(painter)
    painter.end
  end  

  def keyPressEvent(e)       
    case e.key
    when Qt::Key_Left
      moveTetrimino(:Left)
    when Qt::Key_Right
      moveTetrimino(:Right)
    when Qt::Key_Down
      moveTetrimino(:Down)
    when Qt::Key_Up
      @board.rotateTetrimino
      update#FIXME
    else
      super(e)
    end
  end

  def drawBoard(painter)
    board = @board.board #FIXME? @board.board
    board.each_index do |i| 
      board[i].each_index do |j|
        drawSquare(painter,j,i,@board.board[i][j])
      end
    end
  end
    
  def drawTetrimino(painter)
    @board.tetriminoAbsoluteCoordinate.each do |x,y|
      drawSquare(painter,y,x,@board.tetriminoShape)
    end
  end

  def drawSquare(painter,x,y,shape)
    w = [contentsRect().width() / Width,
         contentsRect().height() /Height].min

    colorTable = [0x000000, 0xCC6666, 0x66CC66, 0x6666CC,
                  0xCCCC66, 0xCC66CC, 0x66CCCC, 0xDAAA00]    
    color = Qt::Color.fromRgb(colorTable[shape])

    painter.fillRect(x*w,y*w,w,w,Qt::Brush.new(color))
  end
end
