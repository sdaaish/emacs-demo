(dap-register-debug-template
 "My Project :: Console App"
 (list :type "python"
       :request "launch"
       :name "My Project :: Console App"
       :program "${workspaceFolder}/myapp/__main__.py"
       :cwd "${workspaceFolder}"
       :args '("--some-arg" "value" "some-positional-arg")
       :env '(("DEBUG" . "1") ("LOG_LEVEL" . "debug"))))
