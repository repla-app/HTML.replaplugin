module Repla::HTML
  class Controller

    def initialize(delegate = nil, file)
      @delegate = delegate
      @delegate.load_file(file) if @delegate
    end

    def file=(file)
      @delegate.load_file(file) if @delegate
    end

  end
end
