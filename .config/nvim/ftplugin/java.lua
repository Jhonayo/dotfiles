local home = os.getenv("HOME")
local jdtls = require("jdtls")

-- Nombre del proyecto basado en el directorio actual
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/nvim/jdtls/" .. project_name

-- ============================================================
-- BUNDLES CONFIGURATION (siguiendo documentación oficial)
-- ============================================================

-- 1. Primero agregamos java-debug
local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar", true),
}

-- 2. Luego agregamos java-test EXCLUYENDO los JARs problemáticos
local java_test_path = home .. "/.local/share/nvim/mason/share/java-test/*.jar"
local java_test_bundles = vim.split(vim.fn.glob(java_test_path, true), "\n")

local excluded = {
  "com.microsoft.java.test.runner-jar-with-dependencies.jar",
  "jacocoagent.jar",
}

for _, bundle in ipairs(java_test_bundles) do
  local filename = vim.fn.fnamemodify(bundle, ":t")
  if not vim.tbl_contains(excluded, filename) and bundle ~= "" then
    table.insert(bundles, bundle)
  end
end

-- 3. Capacidades para Blink y Snacks
local capabilities = require("blink.cmp").get_lsp_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Configuración principal
local config = {
  cmd = {
    home .. "/.sdkman/candidates/java/21.0.8-tem/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data",
    workspace_dir,
  },

  root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }),

  settings = {
    java = {
      home = home .. "/.sdkman/candidates/java/21.0.8-tem",
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = home .. "/.sdkman/candidates/java/17.0.16-tem",
          },
          {
            name = "JavaSE-21",
            path = home .. "/.sdkman/candidates/java/21.0.8-tem",
            default = true,
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },

  on_attach = function(client, bufnr)
    -- Verificar que nvim-dap está disponible antes de configurarlo
    local dap_ok, dap = pcall(require, "dap")
    if dap_ok then
      jdtls.setup_dap({ hotcodereplace = "auto" })
      require("jdtls.dap").setup_dap_main_class_configs()
    else
      vim.notify("nvim-dap not available, skipping DAP setup", vim.log.levels.WARN)
    end

    -- Keymaps
    local opts = { buffer = bufnr, silent = true }

    -- ============================================================
    -- DAP: Ejecutar directamente la 3ra configuración (main class)
    -- ============================================================
    if dap_ok then
      -- Ejecutar Main Class con layout 2
      vim.keymap.set("n", "<leader>cR", function()
        local configs = dap.configurations.java
        if configs and configs[3] then
          dap.run(configs[3])
          require("dapui").open({ layout = 2 })
        else
          dap.continue()
          require("dapui").open({ layout = 2 })
        end
      end, vim.tbl_extend("force", opts, { desc = "Launch Main Class" }))

      -- Toggle dapui (minimizar/maximizar)
      vim.keymap.set("n", "<leader>cx", function()
        require("dapui").toggle({ layout = 2 })
      end, vim.tbl_extend("force", opts, { desc = "Min / Max Run Console" }))

      -- Terminar debug y cerrar UI
      vim.keymap.set("n", "<leader>cX", function()
        dap.terminate()
        require("dapui").close()
      end, vim.tbl_extend("force", opts, { desc = "Terminate Run Console" }))
    end

    -- Testing (solo si DAP está disponible)
    --
    --
    --
    -- Registrar grupo de Test en which-key
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add({
        { "<leader>cT", group = "Test" },
        { "<leader>ce", group = "Extract", buffer = bufnr },
      })
    end
    if dap_ok then
      -- ============================================================
      -- Test SIN debug (solo Console - layout 2)
      -- ============================================================
      vim.keymap.set("n", "<leader>cTc", function()
        require("jdtls.dap").test_class()
        require("dapui").open({ layout = 2 })
      end, vim.tbl_extend("force", opts, { desc = "Test Class (Console)" }))

      vim.keymap.set("n", "<leader>cTm", function()
        require("jdtls.dap").test_nearest_method()
        require("dapui").open({ layout = 2 })
      end, vim.tbl_extend("force", opts, { desc = "Test Method (Console)" }))

      -- ============================================================
      -- Test CON debug (UI completa - ambos layouts)
      -- ============================================================
      vim.keymap.set("n", "<leader>cTC", function()
        require("jdtls.dap").test_class()
        require("dapui").open() -- Sin especificar layout = abre todo
      end, vim.tbl_extend("force", opts, { desc = "Debug Test Class (Full UI)" }))

      vim.keymap.set("n", "<leader>cTM", function()
        require("jdtls.dap").test_nearest_method()
        require("dapui").open() -- Sin especificar layout = abre todo
      end, vim.tbl_extend("force", opts, { desc = "Debug Test Method (Full UI)" }))
    end

    -- ============================================================
    -- JDTLS: Refactoring (Extract)
    -- ============================================================
    vim.keymap.set("n", "<leader>cev", function() -- ← crv -> cev
      jdtls.extract_variable()
    end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))

    vim.keymap.set("v", "<leader>cev", function()
      jdtls.extract_variable(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))

    vim.keymap.set("n", "<leader>cec", function() -- ← crc -> cec
      jdtls.extract_constant()
    end, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))

    vim.keymap.set("v", "<leader>cec", function()
      jdtls.extract_constant(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))

    vim.keymap.set("v", "<leader>cem", function() -- ← crm -> cem
      jdtls.extract_method(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract Method" }))
  end,
}

jdtls.start_or_attach(config)
