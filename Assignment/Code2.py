from itertools import combinations

def find_closure(attributes, dependencies):
    closure = set(attributes)
    changed = True
    while changed:
        changed = False
        for dependency in dependencies:
            if dependency[0].issubset(closure) and not dependency[1].issubset(closure):
                closure.update(dependency[1])
                changed = True
    return closure

def find_superkeys(dependencies):
    attributes = set()
    for dependency in dependencies:
        attributes.update(dependency[0])

    all_superkeys = set()

    for i in range(1, len(attributes) + 1):
        for combo in combinations(attributes, i):
            current_key = set(combo)
            current_closure = find_closure(current_key, dependencies)

            satisfies_all_dependencies = all(dep[1].issubset(current_closure) for dep in dependencies)

            if satisfies_all_dependencies:
                all_superkeys.add(tuple(sorted(current_key)))

    return [set(superkey) for superkey in all_superkeys]

def find_fewest_attributes_superkeys(superkeys):
    if not superkeys:
        return []

    min_length = min(len(superkey) for superkey in superkeys)
    fewest_attributes_superkeys = [superkey for superkey in superkeys if len(superkey) == min_length]
    
    return fewest_attributes_superkeys

def find_closure_and_print(X, dependencies):
    closure = find_closure(X, dependencies)
    return closure

# Read input from Input2.txt
with open("Input2.txt", "r") as input_file:
    lines = input_file.readlines()

# Parse functional dependencies and X value
dependencies = []
for line in lines[1:]:
    if line.strip().startswith("X="):
        X = set(line.strip()[2:].split(','))
    else:
        dep_parts = line.strip().split("->")
        dependencies.append((set(dep_parts[0].split(',')), set(dep_parts[1].split(','))))

# Find all superkeys
superkeys = find_superkeys(dependencies)

# Find superkeys with fewest attributes
fewest_attributes_superkeys = find_fewest_attributes_superkeys(superkeys)

# Find closure of X
X_closure = find_closure_and_print(X, dependencies)

# Write results to Output2.txt
with open("Output2.txt", "w") as output_file:
    output_file.write(f"(X={','.join(X)})+ = {X_closure}\n\nKey:\n")
    for superkey in fewest_attributes_superkeys:
        output_file.write(f"{superkey}\n")
