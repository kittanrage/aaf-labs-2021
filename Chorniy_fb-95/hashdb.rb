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

#db struct

cmd = "start"
while (!cmd.include? "exit;")
    #system "cls"
    puts"db is open"

    cmd = gets(';').gsub("\n",' ').gsub(/\s+/, ' ').chomp                               #deleting spaces and newlines
    tokens = cmd.split(/[\s\,]/) - [nil, '']                                            #cleaning after empty elements
    #print tokens
    print("\n")

    if (cmd.match(/create/i))                                                           #create
        puts("table \""+tokens[1]+"\" created")                                         #table name
        fc = cmd.match(/(?<=\()\w+/).to_s                                               #first column name
        lc = cmd.match(/\w+(?=\))/).to_s                                                #last column name
        oc = cmd.match(/\(\w+\w\)/).to_s.tr('()', '')                                   #if one column

        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/)
            puts ("there are no arguments! \ntry to use brackets")
        else
            if oc != ''
                puts("there is only one column in table and its name is "+ oc)
            else
                ca =  tokens.find_index(lc + ');') - tokens.find_index('(' + fc) + 1
                puts("first column is " + fc + " and the last column is " + lc)
                puts("there are " + ca.to_s + " columns")
            end
        end
    end

    if (cmd.match(/insert/i))
        puts cmd
    end

    if (cmd.match(/delete/i))
        puts cmd
    end

    if (cmd.match(/select/i))
        puts cmd
    end

end