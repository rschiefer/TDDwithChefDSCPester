class WebsiteBindings
    @bindings = []
    def initialize(bindings)
        @bindings = bindings
    end
    def to_psobject()
        bindings = Array.new()
        @bindings.each do |b|
            bindings.push("(new-ciminstance -classname MSFT_xWebBindingInformation -Namespace root/microsoft/Windows/DesiredStateConfiguration -Property @{Protocol='#{b[:protocol]}';IPAddress='#{b[:ip]}';Port=#{b[:port]}} -ClientOnly)")
        end
        "[ciminstance[]](#{bindings.join(',')})"
    end
    def get_self()
        self
    end
end unless defined?(WebsiteBindings)