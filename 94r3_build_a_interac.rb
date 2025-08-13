# 94r3_build_a_interac.rb

require 'highline/import'
require 'colorize'
require 'json'

class SecurityToolAnalyzer
  def initialize
    @tools = {}
    load_tools
  end

  def load_tools
    # Load security tools from a JSON file
    file = File.read('tools.json')
    @tools = JSON.parse(file)
  end

  def display_menu
    puts "Interactive Security Tool Analyzer".center(50)
    puts "--------------------------------------"
    puts "1. List all tools"
    puts "2. Analyze a tool"
    puts "3. Add a new tool"
    puts "4. Exit"
    print "Choose an option: "
  end

  def list_tools
    puts "Available tools:"
    @tools.each do |name, properties|
      puts "- #{name}: #{properties['description']}"
    end
  end

  def analyze_tool
    print "Enter the name of the tool to analyze: "
    tool_name = gets.chomp
    if @tools.key?(tool_name)
      tool = @tools[tool_name]
      puts "Analyzing #{tool_name}..."
      puts "Description: #{tool['description']}"
      puts "Strengths:"
      tool['strengths'].each do |strength|
        puts "- #{strength}"
      end
      puts "Weaknesses:"
      tool['weaknesses'].each do |weakness|
        puts "- #{weakness}"
      end
    else
      puts "Tool not found!"
    end
  end

  def add_tool
    print "Enter the name of the new tool: "
    tool_name = gets.chomp
    print "Enter the description of the new tool: "
    description = gets.chomp
    print "Enter the strengths of the new tool (comma-separated): "
    strengths = gets.chomp.split(',').map(&:strip)
    print "Enter the weaknesses of the new tool (comma-separated): "
    weaknesses = gets.chomp.split(',').map(&:strip)
    @tools[tool_name] = {
      'description' => description,
      'strengths' => strengths,
      'weaknesses' => weaknesses
    }
    File.write('tools.json', @tools.to_json)
    puts "Tool added successfully!"
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      case choice
      when 1
        list_tools
      when 2
        analyze_tool
      when 3
        add_tool
      when 4
        exit
      else
        puts "Invalid option. Try again!"
      end
    end
  end
end

analyzer = SecurityToolAnalyzer.new
analyzer.run