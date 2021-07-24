## What's difference between import vs. require?

  - `alias App.Module1.Module2, as: Shorten, warn: false` to shorten module name and avoid name collision.
  - `import App.ModuleName, only: [function: arity], except: [other_func: arity]` to import all `functions` and `macros` from a given module.
  - `require App.Module`: you must `require` Module before invoking its macros. Because: macro functions is being evaluated during compilation, if you want to use it, you need to compile it first. This exactly what `require/2` does.
  - `import/2` vs. `require/2`:  In fact, `import` uses `require` in the background to compile module (as import can expose both functions and macros in that module), but `import` makes it possiblle to skip module name when invoking a function or macro. So, `require/2` is for macros, and can avoid name collision.
  - The `use` macro allows you to *inject* code in the current module. `use App.Module` is equivalent to `require App.Module` *and* `App.Module.__using__`. See example in a phoenix project e.g. in Controller and View module `use AppWeb, :controller`, and `use AppWeb, :view` --> just open `app_web.ex` to see the code.

Reference: https://curiosum.com/blog/alias-import-require-use-in-elixir