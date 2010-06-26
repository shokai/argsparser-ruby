require File.dirname(__FILE__) + '/spec_helper.rb'

describe "test of parsing first-arg" do
  before do
    @argv = ['foo']
    @parser = ArgsParser.parser
    @parser.parse(@argv)
  end

  it "has first-arg" do
    @parser.first.should == 'foo'
  end

  it "has not params" do
    @parser.params.size.should == 0
  end
end

describe "test of parsing params" do
  before do
    @argv = ['-x', '320',
             '-yscale', '240',
             '-debug']
    @parser = ArgsParser.parser
    @parser.comment(:debug, "debug mode")
    @parser.bind(:xscale, :x, "width")
    @parser.bind(:yscale, :y, "height")
    @first, @params = @parser.parse(@argv)
  end

  it "has not first-arg" do
    @first.should == nil
  end

  it "has params" do
    @parser.has_params([:xscale, :yscale]).should == true
    @params[:xscale].to_i.should == 320
    @params[:yscale].to_i.should == 240
  end

  it "has an option" do
    @parser.has_option(:debug).should == true
  end
end

describe "test of parsing first-arg and params" do
  before do
    @argv = ['foo',
             '-x', '320',
             '-yscale', '240',
             '-m', 'hello world',
             '-h', 
             '--output', '/path/to/output/',
             '-debug']
    @parser = ArgsParser.parser
    @parser.bind(:message, :m, "message text")
    @parser.bind(:output, :o, "path to output directory")
    @parser.comment(:debug, "debug mode")
    @parser.bind(:help, :h, "show help")
    @parser.bind(:xscale, :x, "width")
    @parser.bind(:yscale, :y, "height")
    @first, @params = @parser.parse(@argv)
  end

  it "has the first-arg" do
    @first.should == 'foo'
  end

  it "has param" do
    @parser.has_param(:message).should == true
    @parser.has_param(:output).should == true
  end

  it "has not param" do
    @parser.has_param(:m).should == false
    @parser.has_param(:o).should == false
    @parser.has_param(:help).should == false
    @parser.has_param(:name).should == false
  end

  it "has option" do
    @parser.has_option(:debug).should == true
    @parser.has_option(:help).should == true
  end

  it "has not option" do
    @parser.has_option(:h).should == false
    @parser.has_option(:m).should == false
    @parser.has_option(:message).should == false
    @parser.has_option(:output).should == false
  end

  it "has params" do
    @parser.has_params([:message, :output]).should == true
  end

  it "has not params" do
    @parser.has_params([:message, :output, :help]).should == false
  end

  it "has options" do
    @parser.has_options([:help, :debug]).should == true
  end

  it "has not options" do
    @parser.has_options([:help, :debug, :h]).should == false
  end

  it "has String in params" do
    @params[:output].should == '/path/to/output/'
  end

  it "has Number in params" do
    @params[:yscale].to_i.should == 240
    @params[:xscale].to_i.should == 320
  end

end

