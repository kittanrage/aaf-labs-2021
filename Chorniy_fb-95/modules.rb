BUCKETS = 401

class Tables

    attr_accessor :table, :col, :row, :key, :value
    @@all = []
    
    def initialize(table, col, row, value)
        @table = table.to_s
        @col = col.to_s
        @row = row
        @value = value.to_s
        @key = @table.codepoints.join.to_i * @value.codepoints.join.to_i * @col.codepoints.join.to_i % BUCKETS
        @@all << self
    end

    def value=(newvalue)
        @value = newvalue
    end

    def row=(newrow)
        @row = newrow
    end

    def self.all
        @@all
    end

    def table
        @table
    end

    def col
        @col
    end

    def row
        @row
    end

    def key
        @key
    end

    def value
        @value
    end
    
    def self.print_all#(name)
        @@all.each do |col| 
            p col.key #if col.value == name
        end
    end

    def self.find_by(tbl, value, col)
        key = tbl.codepoints.join.to_i * value.codepoints.join.to_i * col.codepoints.join.to_i % BUCKETS
        tmp = @@all.find{|col| col.key == key}
        @@all.each do |col| 
            p col.value if col.row == tmp.row 
        end
    end

end

module T1

    #@rows = {}

    def condparser(cmd)
        cond = cmd.to_s.split(/\s(?=(\b(or|and)\b\s\(.*\)))/i).uniq
        cond.each do |n|
            cond.delete(n) if n.match(/^\w+$/)
        end
        i = 0
        cond.each do |n|
            cond[i] = n.split(/[\(\)]/) - [nil, '']
            i += 1
        end
        cond[0].unshift(nil)
        cond.each do |n|
            cond.delete(n) if n.length() != 2
        end
        p cond
        return cond
    end

    def create(cmd)

        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/(create)(?=\s\w+\s\()/)
            puts "there are no arguments! \ntry to use brackets in a correct way"
        else
            tbl = cmd.match(/(?<=create\s)\w+/i).to_s
            cols = cmd.scan(/(?<=\()(.*?)(?=\,)|(?<=\,)(.*?)(?=\,)|(?<=\,)(.*?)(?=\))/i) - [nil, '']
            #@rows[tbl] = [cols, 0]
            ic = []
            for col in 0..cols.length() - 1
                cols[col] -= [nil]
                cols[col] = cols[col][0].to_s.gsub(/^\s/, '').split(/(\s(?=indexed))/) - [nil, '', ' ']
                ic[col] = cols[col][0] if cols[col][1].to_s.match(/indexed/i)
            end
            ic -= [nil]
            #p Tables.all
            puts"there are #{cols.length.to_s} columns"
            puts"indexed columns are: #{ic}" if ic.length != 0
        end
        #p @rows
    end
    
    def insert(cmd)
    
        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/(insert)(?=\s\w+\s\()|(insert)(?=\s\w+\s\w+\s\()/)
            puts"there are no arguments! \ntry to use brackets"
        else
            tbl = cmd.match(/(?<=insert\s)\w+/i).to_s
            tbl = cmd.match(/(?<=insert\sinto\s)\w+/i).to_s if tbl.match(/into/i)
            #@rows[tbl][1] += 1
            puts tbl
            values = cmd.gsub(/^(.*?)\(|^\s/, '').split(/[\,\)\()]/) - [nil, '', ' ']
            #p values
            # i = 0
            # @rows[tbl][0].each do |n| 
            #     n = Tables.new(tbl, n.to_s.match(/\w+/), @rows[tbl][1], values[i])
            #     i += 1
            # end
            #p Tables.all
            p values
            puts"1 row with #{values.length.to_s} values added to table #{tbl.to_s}"
        end
        #puts @rows
    end
    
    def delete(cmd)
    
        tbl = cmd.match(/(?<=delete\s)\w+/i).to_s
        tbl = cmd.match(/(?<=delete\sfrom\s)\w+/i).to_s if tbl.match(/from/i)
        #@rows[tbl] -= 1
        puts tbl
        if !tbl.match(/\w+/)
            puts"error occured"
        else
            if !cmd.match(/where/i)
                puts"table #{tbl} deleted"
            else
                if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/delete.+where/) || cmd.match(/(?<=\)\s)\b(?!and|or\b)\w+(?=\s\()/i)
                    puts"there are no arguments! \ntry to use brackets"
                else
                    cols = cmd.match(/(?<=select\s)(.*?)(?=\sfrom)/i).to_s.split(/[\s\,]/) - [nil, '']
                    p cols
                    cnd = condparser(cmd.match(/\(.*\)/).to_s)
                    p cnd
                end
            end
            #puts @rows
        end
    
    end
    
    def select(cmd)
    
        tbl = cmd.match(/(?<=from\s)\w+/i).to_s
        if (cmd.match(/(?<=select\s)\*(?=\sfrom)/i))
            puts"all columns in table " + tbl + " selected"
        else
            if !cmd.match(/where/i)
                puts"table #{tbl} selected"
            else
                if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/select.+from.+where/) || cmd.match(/(?<=\)\s)\b(?!and|or\b)\w+(?=\s\()/i)
                    puts"there are no arguments! \ntry to use brackets correctly"
                else
                    cols = cmd.match(/(?<=select\s)(.*?)(?=\sfrom)/i).to_s.split(/[\s\,]/) - [nil, '']
                    p cols
                    cnd = condparser(cmd.match(/\(.*\)/).to_s)
                    p cnd
                end
            end
        end
        #Tables.print_all
        #Tables.find_by(tbl, 'green', 'color')
        #puts @rows    
    end

end