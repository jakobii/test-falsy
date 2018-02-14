# test-null
A null Checking Powershell Utility


# Getting Started

1) Clone
```bash
git clone https://github.com/jakobii/test-null.git
```

2) Import
```powershell
import-module ".\test-null\test-null.psm1"
```

3) Use
```powershell
Test-Null -Evaluate $foo
```


# Parameters
```powershell
Test-Null -Evaluate <Any> [-AsFalse <switch>] [-Verbosely <Switch>] 
```

### -Evaluate
The value that will be Evaluated as falsy.
- Falsy Values
    - [int] Zero
    - [float] Zero
    - [string] Empty
    - [string] Whitespace
    - [dbnull] SqlServer
    - [null] SqlServer

- Parameter type: **Undefined**
- Required: **True**
- Alias: **-e**

### -AsFalse
Cause Test-Null to return [bool]$False when the value provided qualifies as blank or null.
- Parameter type: **Switch**
- Required: **False**
- Alias: **-af**

### -Verbosely
Will cause Test-Null to write to the host the type that is matched if null is found.
- Parameter type: **Switch**
- Required: **False**
- Alias: **-v**

### Alias
The module will set *Test-Null* with an alias of ***tn***


# Examples
Evaluating blanks and nulls as falsy in powershell is not fun. This is a handy utility I include in almost all my scripts. These are some common situation I find myself in.

If $Foo is null perform some action.
```powershell
If(tn $Foo){
    #DO SOMETHING..
} 
```

Or Perform Some action until $Foo is no longer null.
```Powershell
do{
    #DO SOMETHING..
}
until(tn $Foo -af) 
```

Not having to worry if a string is null or emtpy is nice.
```powershell
# Powershell converts $null into an empty string "" automatically
[string]$foo = $null # A falsy value

# RETURNS [bool]False. Empty string is not equal to null.
$foo -eq $null

# RETURNS [bool]True. Empty string is Falsy to sane people.
Test-Null -Evaluate $foo
```