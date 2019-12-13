# cowsay-action

[![Actions Status](https://github.com/Code-Hex/cowsay-action/workflows/.github/workflows/main.yml/badge.svg)](https://github.com/Code-Hex/cowsay-action)

```
 _________________
< github action!! >
 -----------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

## Synopsis

Create Your Workflow

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    name: A test job to cowsay
    steps:
    - name: output the message on actions result
      uses: Code-Hex/cowsay-action@v1
      with:
        message: | # Support multi-lines
          This is cowsay
          Hello, World!!
    - name: cowsay on the comment
      uses: Code-Hex/cowsay-action@v1
      with:
        message: 'Hello, World with random'
        cow: 'random' # If specified, it shows random ascii art.
        cowsay_on_comment: true
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    - name: output pipeline
      id: cowsay_output_id # You want id
      uses: Code-Hex/cowsay-action@v1
      with:
        message: 'Hello, World'
        cow: 'gopher' # ascii art list: https://github.com/Code-Hex/Neo-cowsay/tree/master/cows
        cowsay_to_output: 'cowsay'
    - name: print output
      run: |
        echo "${{ steps.cowsay_output_id.outputs.cowsay }}"
```

## Inputs

- `message` - (Required) the message. what does the cowsay.
- `cow` - (Optional) specify the [cowfile](https://github.com/Code-Hex/Neo-cowsay/tree/master/cows).
  - default: `default`
  - if you specify `random`, cowsay shows by random ascii-art.
- `cowsay_on_comment` - (Optional) boolean. if true, cowsay shows on the github comment.
  - this input needs to set the `GITHUB_TOKEN` environment variable.
- `cowsay_to_output` - (Optional) specify the [output_id](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/metadata-syntax-for-github-actions#outputs).
