module T1

    def create(cmd)

        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/create\s\w+/i)
            puts "there are no arguments! \ntry to use brackets in a correct way"
        else
            tbl = cmd.match(/(?<=create\s)\w+/i).to_s
            cols = cmd.scan(/(?<=\()(.*?)(?=\,)|(?<=\,)(.*?)(?=\,)|(?<=\,)(.*?)(?=\))/i) - [nil, '']
            ic = Array.new
            for col in 0..cols.length() - 1
                cols[col] -= [nil]
                cols[col] = cols[col][0].to_s.split(/[\s\,]/) - [nil, '']
                ic[col] = cols[col][0] if cols[col][1].to_s.match(/indexed/i)
            end
            puts"there are #{cols.length.to_s} columns"
            puts"indexed columns are: #{ic}"
        end
    
    end
    
    def insert(cmd)
    
        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/insert\s\w+/)
            puts"there are no arguments! \ntry to use brackets"
        else
            tbl = cmd.match(/(?<=insert\s)\w+/i).to_s
            tbl = cmd.match(/(?<=insert\sinto\s)\w+/i).to_s if tbl.match(/into/i)
            puts tbl
            values = cmd.gsub(/^(.*?)\(/, '').split(/[\s\,\"\)\;]/) - [nil, '']
            puts values
            puts"1 row with #{values.length.to_s} values added to table #{tbl.to_s}"
        end
    
    end
    
    def delete(cmd)
    
        tbl = cmd.match(/(?<=delete\s)\w+/i).to_s
        tbl = cmd.match(/(?<=delete\sfrom\s)\w+/i).to_s if tbl.match(/from/i)
        puts tbl
        if !tbl.match(/\w+/)
            puts"error occured"
        else
            if !cmd.match(/where/i)
                puts"table #{tbl} deleted"
            else
                if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/delete.+where/)
                    puts"there are no arguments! \ntry to use brackets"
                else
                    cnd = cmd.scan(/\((.*?)\)/)
                    puts cnd
                end
            end
        end
    
    end
    
    def select(cmd)
    
        tbl = cmd.match(/(?<=from\s)\w+/i).to_s
        if (cmd.match(/(?<=select\s)\*(?=\sfrom)/i))
            puts"entire table " + tbl + " selected"
        else
            if !cmd.match(/where/i)
                puts"table #{tbl} selected"
            else
                if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/select.+from.+where/)
                    puts"there are no arguments! \ntry to use brackets"
                else
                    cols = cmd.match(/(?<=select\s)(.*?)(?=\sfrom)/i).to_s.split(/[\s\,]/) - [nil, '']
                    puts cols
                    cnd = cmd.scan(/\((.*?)\)/)
                    puts cnd
                end
            end
        end
    
    end

end