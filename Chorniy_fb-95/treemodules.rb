class Node    
    attr_accessor :key, :value, :left, :right, :parent, :color

    def initialize(key, calue)
        @key = key
        @value = value  
        @parent = nil 
        @left = nil 
        @right = nil 
        @color = 1 
    end
end

class Tree
    
    attr_accessor :TNULL, :root

    def initialize()
        @TNULL = Node.new(0, 0)
        @TNULL.color = 0
        @TNULL.left = nil
        @TNULL.right = nil
        @root = @TNULL
    end

    def insert(key, value) 
        
        node = Node.new(key, value)
        node.parent = nil
        node.value = value
        node.left = @TNULL
        node.right = @TNULL
        node.color = 1 
        
        node2 = nil
        node1 = @root
        
        while node1 != @TNULL 
            node2 = node1
            if node.value < node1.value 
                node1 = node1.left
            else
                node1 = node1.right
            end
        end
               
        node.parent = node2

        if node2 == nil 
            @root = node
        elsif node.value < node2.value 
            node2.left = node
        else
            node2.right = node
        end
        
        if node.parent == nil 
            node.color = 0
            return
        end
        
        if node.parent.parent == nil 
            return
        end
        
        while node.parent.color == 1 
            if node.parent == node.parent.parent.right 
                node1 = node.parent.parent.left 
                if node1.color == 1 
                    
                    node1.color = 0
                    node.parent.color = 0
                    node.parent.parent.color = 1
                    node = node.parent.parent
                else
                    if node == node.parent.left 
                        
                        node = node.parent
                        right_rotate(node)
                    end
                    
                    node.parent.color = 0
                    node.parent.parent.color = 1
                    left_rotate(node.parent.parent)
                end
            else
                node1 = node.parent.parent.right 
                
                if node1.color == 1 
                    
                    node1.color = 0
                    node.parent.color = 0
                    node.parent.parent.color = 1
                    node = node.parent.parent 
                else
                    if node == node.parent.right 
                        
                        node = node.parent
                        left_rotate(node)
                    end
                    
                    node.parent.color = 0
                    node.parent.parent.color = 1
                    right_rotate(node.parent.parent)
                end
            end
            if node == @root 
                break
            end
        end
        @root.color = 0

    end

    def search(node, value) 
        if node == @TNULL || value == node.value 
            return node
        end
        
        if value < node.value 
            return search(node.left, value)
        end
        return search(node.right, value)
    end

    def getkey(node) 
        return search(@root, node)
    end  

    def delhelper(node, value) 
        
        node3 = @TNULL
        while node != @TNULL 
            if node.value == value 
                node3 = node
            end
            
            if node.value <= value 
                node = node.right
            else
                node = node.left
            end
        end
        
        if node3 == @TNULL 
            puts("Couldn't find value in the tree")
            return
        end
        
        node2 = node3
        y_original_color = node2.color
        if node3.left == @TNULL 
            node1 = node3.right
            swap(node3, node3.right)
        elsif (node3.right == @TNULL) 
            node1 = node3.left
            swap(node3, node3.left)
        else
            node2 = minimum(node3.right)
            y_original_color = node2.color
            node1 = node2.right
            if node2.parent == node3 
                node1.parent = node2
            else
                swap(node2, node2.right)
                node2.right = node3.right
                node2.right.parent = node2
            end
            
            swap(node3, node2)
            node2.left = node3.left
            node2.left.parent = node2
            node2.color = node3.color
        end
        if y_original_color == 0 
        while node1 != @root && node1.color == 0 
            if node1 == node1.parent.left 
                nodep = node1.parent.right
                if nodep.color == 1 
                    
                    nodep.color = 0
                    node1.parent.color = 1
                    left_rotate(node1.parent)
                    nodep = node1.parent.right
                end
                
                if nodep.left.color == 0 && nodep.right.color == 0 
                    
                    nodep.color = 1
                    node1 = node1.parent
                else
                    if nodep.right.color == 0 
                        
                        nodep.left.color = 0
                        nodep.color = 1
                        right_rotate(nodep)
                        nodep = node1.parent.right
                    end
                    
                    
                    nodep.color = node1.parent.color
                    node1.parent.color = 0
                    nodep.right.color = 0
                    left_rotate(node1.parent)
                    node1 = @root
                end
            else
                nodep = node1.parent.left
                if nodep.color == 1 
                    
                    nodep.color = 0
                    node1.parent.color = 1
                    right_rotate(node1.parent)
                    nodep = node1.parent.left
                end
                
                if nodep.left.color == 0 && nodep.right.color == 0 
                    
                    nodep.color = 1
                    node1 = node1.parent
                else
                    if nodep.left.color == 0 
                        
                        nodep.right.color = 0
                        nodep.color = 1
                        left_rotate(nodep)
                        nodep = node1.parent.left 
                    end
                    
                    
                    nodep.color = node1.parent.color
                    node1.parent.color = 0
                    nodep.left.color = 0
                    right_rotate(node1.parent)
                    node1 = @root
                end
            end
        end
        node1.color = 0
        end
    end 

    def delete_node(value) 
        delhelper(@root, value)
    end

    def swap(node1, node2) 
        if node1.parent == nil 
            @root = node2
        elsif node1 == node1.parent.left 
            node1.parent.left = node2
        else
            node1.parent.right = node2
        end
        node2.parent = node1.parent
    end
    
    def minimum(node) 
        while node.left != @TNULL 
            node = node.left
        end
        return node
    end   
    
    def left_rotate(node1) 
        node2 = node1.right
        node1.right = node2.left
        if node2.left != @TNULL 
            node2.left.parent = node1
        end
        
        node2.parent = node1.parent
        if node1.parent == nil 
            @root = node2
        elsif node1 == node1.parent.left 
            node1.parent.left = node2
        else
            node1.parent.right = node2
        end
        node2.left = node1
        node1.parent = node2
    end
      
    def right_rotate(node1) 
        node2 = node1.left
        node1.left = node2.right
        if node2.right != @TNULL 
            node2.right.parent = node1
        end
        
        node2.parent = node1.parent
        if node1.parent == nil 
            @root = node2
        elsif node1 == node1.parent.right 
            node1.parent.right = node2
        else
            node1.parent.left = node2
        end
        node2.right = node1
        node1.parent = node2
    end
    
end

class Table
    attr_accessor :name, :cols, :values, :forest, :head
    @@counter = 1
    
    def initialize(name, cols)
        @name = name
        @cols = cols
        @forest = {}
        @head = {}
        cols.each do |c|
            @forest[name + c] = Tree.new()
        end
    end

    def insertdata(name, values)
        @head[@@counter] = values
        values.each do |c|
            c = c.codepoints.join.to_i
        end
        if @cols.length != values.length
            puts 'error' 
        else
            for col in 0..cols.length() - 1
                @forest[name + @cols[col]].insert(@@counter, values[col])
            end
        end
        @@counter += 1
    end

    def getbykey(key)
        p @head[key]
    end

end

module T1

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
            ic = []
            for col in 0..cols.length() - 1
                cols[col] -= [nil]
                cols[col] = cols[col][0].to_s.gsub(/^\s/, '').split(/(\s(?=indexed))/) - [nil, '', ' ']
                cols[col] = cols[col][0]
                ic[col] = cols[col][0] if cols[col][1].to_s.match(/indexed/i)
            end
            $tbl = Table.new(tbl, cols)
            ic -= [nil]
            puts"there are #{cols.length.to_s} columns"
            puts"indexed columns are: #{ic}" if ic.length != 0
        end
    end
    
    def insert(cmd)
    
        if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/(insert)(?=\s\w+\s\()|(insert)(?=\s\w+\s\w+\s\()/)
            puts"there are no arguments! \ntry to use brackets"
        else
            tbl = cmd.match(/(?<=insert\s)\w+/i).to_s
            tbl = cmd.match(/(?<=insert\sinto\s)\w+/i).to_s if tbl.match(/into/i)
            puts tbl
            values = cmd.gsub(/^(.*?)\(|^\s/, '').split(/[\,\)\()]/) - [nil, '', ' ']
            i = 0
            $tbl.insertdata(tbl, values)
            p values
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
                if cmd.match(/\(\)/) || !cmd.match(/\(/) || !cmd.match(/\)/) || !cmd.match(/^.+?(?=\()/).to_s.match(/delete.+where/) || cmd.match(/(?<=\)\s)\b(?!and|or\b)\w+(?=\s\()/i)
                    puts"there are no arguments! \ntry to use brackets"
                else
                    cols = cmd.match(/(?<=select\s)(.*?)(?=\sfrom)/i).to_s.split(/[\s\,]/) - [nil, '']
                    p cols
                    cnd = condparser(cmd.match(/\(.*\)/).to_s)
                    p cnd
                end
            end
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
    end

end