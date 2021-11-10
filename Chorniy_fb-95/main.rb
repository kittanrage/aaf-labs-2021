require_relative "treemodules.rb"
include T1

cmd = "start"
while (!cmd.include? "exit")

    #sleep(4)
    #system "cls"
    puts"\ndb is open"
    cmd = gets(';').gsub("\n",' ').gsub(/\s+/, ' ').chomp.tr('!@#$%^&<>|\\/;','')
    if !cmd.match(/\b(create)\b|\b(insert)\b|\b(select)\b|\b(delete)\b|\b(exit)\b/)
        cmd = '' 
        puts 'there are no commands in your query'
    end
    print("\n")
    
    T1.create(cmd) if (cmd.match(/create/i))  
    
    T1.insert(cmd) if (cmd.match(/insert/i))  

    T1.delete(cmd) if (cmd.match(/delete/i))
    
    T1.select(cmd) if (cmd.match(/select/i))

end