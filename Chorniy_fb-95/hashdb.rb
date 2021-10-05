require_relative "modules.rb"
include T1

class DB
    attr_accessor :col, :row
    
    def initialize(hash)
      self.col = hash[:col]
      self.row = hash[:row]
    end
    
    def Is4
        if self.col == 4
            return true
        end
        return false
    end
    
    def insert()
        puts "inserted"
        return true
    end
    
    def delete()
        puts "deleted"
        return true
    end
    
    def select()
        puts "selected"
    end

end

cmd = "start"
while (!cmd.include? "exit;")

    #sleep(4)
    #system "cls"
    puts"\ndb is open"
    cmd = gets(';').gsub("\n",' ').gsub(/\s+/, ' ').chomp
    print("\n")
    
    T1.create(cmd) if (cmd.match(/create/i))  
    
    T1.insert(cmd) if (cmd.match(/insert/i))  

    T1.delete(cmd) if (cmd.match(/delete/i))
    
    T1.select(cmd) if (cmd.match(/select/i))

end