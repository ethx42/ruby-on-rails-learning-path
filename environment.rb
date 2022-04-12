module Environment
  class Depot
    attr_accessor :packs

    def initialize
      @packs = {
        simple_transportation_pack: {
          intelligence: [:cellphone],
          items: [:medipack, :chevy_versa]
        },
        standard_transportation_pack: {
          intelligence: [:cellphone, :antenna],
          arsenal: [:colt_1911],
          items: [:handcuffs, :mediapack, :chemistry, :chevy_versa]
        },
        simple_mission_pack: {
          intelligence: [:infopack, :laptop, :cellphone, :antenna],
          arsenal: [:colt_1911],
          items: [:handcuffs, :mediapack, :chemistry, :financial]
        },
        standard_mission_pack: {
          intelligence: [:infopack, :laptop, :cellphone, :antenna],
          arsenal: [:remington_870, :colt_1911, :machete, :hatchet],
          items: [:handcuffs, :mediapack, :chemistry, :financial]
        }
      }
    end
  end

  class Control
    attr_accessor :missions

    statuses = [:active, :paused, :aborted, :failed, :accomplished]
    
    def initialize
      @missions = Hash.new
    end

    def new_mission(name:, objective:, pack:)
      @missions[name] = {
        objective: objective,
        pack: pack,
        status: :active
      }
    end
		
    statuses.each do |status|
			define_method("set_mission_to_#{status}") do |mission|
				@missions[mission][:status] = status
			end
    end
  end

  class Human
    attr_accessor :id, :name, :personal_data, :professional_data

    data_type = [:personal, :professional]

    def initialize(name:)
      @id = self.object_id
      @name = name
    end

    data_type.each do |type|
      define_method("set_#{type}_data") do |args|
      
        case type
        when :personal
          @personal_data = {
            surname: args[:surname],
            age: args[:age],
            country: args[:country],
            language: args[:language],
            marital_status: args[:marital_status],
            children: args[:children]
          }
        when :professional
          @professional_data = {
            position: args[:position],
            occupation: args[:occupation],
            skills: args[:skills],
            observations: args[:observations]
          }
        end
      end
    end

    class Worker < Human
      attr_accessor:standard_shift, :extra_shift
      
      def set_shift
        @standard_shift = {
          id: self.object_id,
          hours: 8,
          payment: 8,
          facility: nil,
          status: nil
        }

        @extra_shift = {
          id: self.object_id,
          hours: nil,
          payment: nil,
          facility: nil,
          status: nil
        }
      end
    end
  end
end
