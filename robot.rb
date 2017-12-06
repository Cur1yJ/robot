# Recently as an interview I was asked to create a Ruby program that would move a robot around a 10 by 10 grid
#
# A Robot Object for moving around the grid
# Author: Michael Lungo
# November 12th, 2014
#
# robot.rb
#
# Define our Robot class
#
# NOTE: North/South represents the Y axis, and East/West represent the X axis

class Robot

  # Instance variables
  attr_accessor :x, :y, :direction

  # Load our object
  def initialize( x, y, direction )
    # Check that our coordinates are valid numbers
    if is_number?( x ) && is_number?( y )
      @x = x
      @y = y
    end

    # Check that our direction is a valid direction
    if direction.downcase == "north" or direction.downcase == "south" or direction.downcase == "east" or direction.downcase == "west"
      @direction = direction
    end
  end

  # The starting point before issueing any commands
  def self.get_user_input( robot )
    puts "The robot is currently located at #{robot.x}, #{robot.y} and is facing #{robot.direction}."
    puts ""
    puts "What would you like to do?"
    puts ""
    puts "Commands you can use: move, left, right, report, place and exit."

    # Detect what command was typed
    STDOUT.flush
    command = gets.chomp

    # We downcase the command so it is case insensitive
    case command.downcase
      when "move"
        robot.move
      when "left"
        robot.left
      when "right"
        robot.right
      when "report"
        robot.report
      when "place"
        p "place"
        robot.place
      when "exit"
        puts ""
        puts "Robot is being put away for today. Good-bye!"
        puts ""
        abort
      # command not recognized
      else
        puts ""
        puts "ERROR! Command not recognized!"
        puts ""
        Robot.get_user_input( robot )
    end
  end

  # Move our robot 1 space in the current direction he is facing
  def move
    case self.direction.downcase
      when "north"
        if self.y + 1 < 11
          self.y = self.y + 1
          moved = true
        else
          moved = false
        end
      when "south"
        if self.y - 1 > 0
          self.y = self.y - 1
          moved = true
        else
          moved = false
        end
      when "east"
        if self.x + 1 < 11
          self.x = self.x + 1
          moved = true
        else
          moved = false
        end
      when "west"
        if self.x - 1 > 0
          self.x = self.x - 1
          moved = true
        else
          moved = false
        end
    end

    puts ""
    if moved
      puts "Moved 1 space #{direction}"
    else
      puts "ERROR! Moving robot in that direction would make him fall of the grid! Please turn him around"
    end
    puts ""

    Robot.get_user_input( self )
  end

  # Method to turn our robot 90 degrees counter-clockwise
  def left
    case self.direction.downcase
      when "north"
        self.direction = "west"
      when "south"
        self.direction = "east"
      when "east"
        self.direction = "north"
      when "west"
        self.direction = "south"
    end

    puts ""
    puts "TURNED LEFT SUCCESSFULLY!"
    puts ""
    Robot.get_user_input( self )
  end

  # Method to turn our robot 90 degrees clockwise
  def right
    case self.direction.downcase
      when "north"
        self.direction = "east"
      when "south"
        self.direction = "west"
      when "east"
        self.direction = "south"
      when "west"
        self.direction = "north"
    end

    puts ""
    puts "TURNED RIGHT SUCCESSFULLY!"
    puts ""
    Robot.get_user_input( self )
  end

  # Method to get current location and position of robot
  def report
    puts ""
    Robot.get_user_input( self )
  end

  # Method to place our robot in a custom spot
  def place
    # Get x and make sure it is a number on our grid
    puts ""
    puts "Value for X:"
    STDOUT.flush
    x = gets.chomp
    if (1..10).include?( x.to_i )
      self.x = x.to_i
    else
      puts ""
      puts "INVALID VALUE FOR X! Please try again"
      self.place
    end

    puts ""
    puts "Value for Y:"
    STDOUT.flush
    y = gets.chomp
    if (1..10).include?( y.to_i )
      self.y = y.to_i
    else
      puts ""
      puts "INVALID VALUE FOR Y! Please try again"
      self.place
    end

    # Get direction and make sure it is a valid direction
    puts ""
    puts "Which direction to face? (North, South, East, West):"
    STDOUT.flush
    direction = gets.chomp
    if ["north", "east", "south", "west" ].include?( direction )
      self.direction = direction
      puts ""
      puts "THE ROBOT HAS BEEN PLACED SUCCESSFULLY!"
      puts ""
      Robot.get_user_input( self )
    else
      puts ""
      puts "INVALID DIRECTION! Please try again"
      self.place
    end
  end

  def is_number?( number )
    true if Float( number ) rescue false
  end
end


@robot = Robot.new( 1, 1, "north" )
Robot.get_user_input( @robot )
