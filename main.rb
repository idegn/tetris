# -*- coding: utf-8 -*-
require 'Qt'
require './tetriswindow'

Qt::Application.new(ARGV) do
  TetrisWindow.new do
    show
  end
  exec
end
