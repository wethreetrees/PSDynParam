BeforeDiscovery {
    # Setup parameter test cases
    $parameterTestCases = @(
        @{
            Name      = 'ParameterAst'
            Mandatory = $true
            Type      = [System.Management.Automation.Language.ParameterAst[]]
        }
    )

    # Setup custom function test cases
}

Describe "Get-DynamicFunctionPipelineParameterName Unit Tests" -Tag Unit {

    BeforeAll {
        $moduleProjectPath = $PSScriptRoot | Split-Path -Parent | Split-Path -Parent
        $moduleName        = (Get-Item $moduleProjectPath).BaseName
        # Remove all versions of the module from the session. Pester can't handle multiple versions.
        Get-Module $ModuleName | Remove-Module -Force
        Import-Module $moduleProjectPath\dist\$ModuleName -ErrorAction Stop -Force
    }

    Context "Parameter Tests" {

        BeforeAll {
            # Executing this in the module scope since private functions are not available
            $commandInfo = InModuleScope -ModuleName Dynamic -ScriptBlock { Get-Command -Name 'Get-DynamicFunctionPipelineParameterName' }
        }

        It 'Should have [<Type>] parameter [<Name>] ' -TestCases $parameterTestCases {
            $commandInfo | Should -HaveParameter $Name -Type $Type
            if ($Mandatory) {
                $commandInfo | Should -HaveParameter $Name -Mandatory
            } else {
                $commandInfo | Should -HaveParameter $Name -Not -Mandatory
            }
        }

    }

    # Context "Use case" {

    #     BeforeAll {

    #     }

    #     It "Should have some result" {
    #         Assertion
    #     }

    # }
    # ...

}

Describe "Get-DynamicFunctionPipelineParameterName Integration Tests" -Tag Integration {

    # Context "Use case" {

    #     BeforeAll {

    #     }

    #     It "Should have some result" {
    #         Assertion
    #     }

    # }
    # ...

}

