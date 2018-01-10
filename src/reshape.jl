export stack

function stack(t::NextTable, by = pkeynames(t); select = excludecols(t, by), value = :value, variable = :variable)
    (by != pkeynames(t)) && return stack(reindex(t, by, select); value = value, variable = variable)    
    
    valuecols = columns(t, select)
    valuecol = vec([valuecol[i] for valuecol in valuecols, i in 1:length(t)])

    labels = keys(valuecols)
    labelcol = vec([label for label in labels, i in 1:length(t)])
    
    bycols = map(arg -> repeat(arg, inner = length(valuecols)), columns(t, by))
    convert(NextTable, Columns(bycols), Columns(labelcol, valuecol, names = [variable, value]))
end