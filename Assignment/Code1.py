def update_table_with_foreign_keys(rs, table1, table2):
    foreign_key = get_primary_key(get_table_definition(rs, table2))
    for i in range(len(rs)):
        line = rs[i]
        if line.startswith(table1 + "("):
            line = line.replace(")", "," + foreign_key + ")")
            rs[i] = line
            break
    return rs

def get_primary_key(table_definition):
    parts = table_definition.split("(")
    attributes = parts[1].replace(")", "")
    return attributes.split(",")[0]

def get_table_definition(rs, table_name):
    for line in rs:
        if line.startswith(table_name + "("):
            return line
    return None

def update_table_with_primary_keys(rs, table1, table2):
    primary_key1 = get_primary_key(get_table_definition(rs, table1))
    for i in range(len(rs)):
        line = rs[i]
        if line.startswith(table2 + "("):
            line = line.replace(")", "," + primary_key1 + ")")
            rs[i] = line
            break
    return rs

def update_table_with_foreign_key(rs, table1, table2):
    foreign_key = get_primary_key(get_table_definition(rs, table2))
    for i in range(len(rs)):
        line = rs[i]
        if line.startswith(table1 + "("):
            line = line.replace(")", "," + foreign_key + ")")
            rs[i] = line
            break
    return rs

def create_new_table(rs, table_name, primary_key1, primary_key2):
    foreign_key1 = get_primary_key(get_table_definition(rs, primary_key1)) if get_table_definition(rs, primary_key1) else primary_key1
    foreign_key2 = get_primary_key(get_table_definition(rs, primary_key2)) if get_table_definition(rs, primary_key2) else primary_key2
    table_definition = f"{table_name}({foreign_key1},{foreign_key2})"
    rs.append(table_definition)
    return rs

def get_first_word(attribute):
    words = attribute.split(",")
    return words[0]

rs = []
relations = []

with open("Input1.txt", "r") as reader:
    lines = reader.readlines()
    is_table_section = False
    is_relation_section = False

    for line in lines:
        line = line.strip()

        if line == "":
            continue

        if line == "Table:":
            is_table_section = True
            is_relation_section = False
            continue

        if line == "Relation:":
            is_table_section = False
            is_relation_section = True
            continue

        if is_table_section:
            rs.append(line)
        elif is_relation_section:
            relations.append(line)

for relation in relations:
    parts = relation.split()
    table1 = parts[0]
    relationship = parts[1]
    table2 = parts[2]

    if relationship == "1-1":
        rs = update_table_with_foreign_keys(rs, table1, table2)
    elif relationship == "d":
        rs = update_table_with_primary_keys(rs, table1, table2)
    elif relationship == "1-N":
        rs = update_table_with_foreign_key(rs, table1, table2)
    elif relationship == "N-N":
        table3 = get_first_word(parts[3].replace("(", "").replace(")", ""))
        rs = create_new_table(rs, table3, table1, table2)

unique_tables = set()
result = []

for line in rs:
    table_name = line.split("(")[0]
    if table_name not in unique_tables:
        unique_tables.add(table_name)
        result.append(line)

with open("Output1.txt", "w") as writer:
    for line in result:
        writer.write(line + "\n")
