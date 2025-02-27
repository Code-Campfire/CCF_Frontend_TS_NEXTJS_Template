import js from "@eslint/js";
import type { Linter } from "eslint";

export default [
  js.configs.recommended,
  {
    rules: {
      "no-console": [0],
    },
    linterOptions: {
            reportUnusedDisableDirectives: "error"
        }
  }
] satisfies Linter.Config[];
