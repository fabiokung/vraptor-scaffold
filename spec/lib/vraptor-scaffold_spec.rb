require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe VraptorScaffold::Main do

  context "help" do
    it "should print AppGenerator" do
      AppGenerator.should_receive(:start).with(["-h"])
      Kernel.should_receive(:exit)
      VraptorScaffold::Main.execute([])
    end

    it "should print AppGenerator help when option is -h" do
      AppGenerator.should_receive(:start).with(["-h"])
      Kernel.should_receive(:exit)
      VraptorScaffold::Main.execute(["--help"])
    end

    it "should print AppGenerator help when options is --help" do
      AppGenerator.should_receive(:start).with(["-h"])
      Kernel.should_receive(:exit)
      VraptorScaffold::Main.execute(["-h"])
    end
  end

  context "new application" do
    before(:each) do
      @project_name = "vraptor-scaffold"
      @generator = mock(AppGenerator)
      AppGenerator.stub!(:new).with(@project_name, []).and_return(@generator)
      @args = ["new", @project_name]
    end 

    it "should invoke all app generator tasks when typed new" do
      @generator.should_receive(:invoke_all)
      VraptorScaffold::Main.execute(@args)
    end

    it "cannot call app generator when not typed new" do
      @args.shift
      @generator.should_not_receive(:invoke_all)
      VraptorScaffold::Main.execute(@args)
    end
  end

  context "scaffold" do
    before(:each) do
      @generator = mock(ScaffoldGenerator)
      @args = ["scaffold", "product", "name:string", "value:doulbe"]
      ScaffoldGenerator.stub!(:new).with(@args).and_return(@generator)
    end

    it "should call scaffold generator" do
      @generator.should_receive(:build)
      VraptorScaffold::Main.execute(@args)
    end
  end
end
