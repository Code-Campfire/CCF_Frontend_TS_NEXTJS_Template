// @ts-check
import js from "@eslint/js";
import tseslint from 'typescript-eslint';

const config = {
  ...js.configs.recommended,
  linterOptions: {
    reportUnusedDisableDirectives: "error",
  },
  languageOptions: {
    parserOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
    },
  },
  rules: {
    "no-console": "off",
  },
};

// Define ignored patterns
// const ignores = ["node_modules/", ".next/", "dist/"];

// Separate config for TypeScript files
const tsConfig = {
  files: ["**/*.ts", "**/*.tsx"],
  ignores: ["node_modules/", "**/.next/", "dist/"],
};

tseslint.config(
 tseslint.configs.eslintRecommended,
 tseslint.configs.recommended,
 tseslint.configs.recommendedTypeChecked,
 {
   languageOptions: {
     parserOptions: {
       projectService: true,
       tsconfigRootDir: import.meta.dirname,
     },
   },
 },
);
export default [{ ...config }, tsConfig];




 

