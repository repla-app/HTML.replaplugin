module Repla
  module HTML
    # Controller
    class Controller
      def initialize(file, delegate = nil)
        @delegate = delegate
        @delegate.load_file(file) if @delegate
      end

      def reload
        @delegate.reload
      end
    end
  end
end
