# setup-tcmalloc GitHub Action
![badge](https://github.com/kaeawc/setup-tcmalloc/actions/workflows/commit.yml/badge.svg)

This action downloads, installs, and caches tcmalloc. Subsequent workflow steps should automatically benefit from tcmalloc replacing the default malloc, which can free up native memory left otherwise unusable by fragmentation.

## Supported Platforms

- `linux`

## Unsupported Platforms

- `macos`: Requires tcmalloc to be built with arm64e target architecture for M1/M2/M3.
- `windows` 

## Example
```yaml
jobs:
  build_your_app:

    # Add typical environment setup steps for node/java/python etc before tcmalloc
    
    - name: Set up tcmalloc
      uses: kaeawc/setup-tcmalloc@v0.0.3

    # Any processes run (bash, java, golang, python, etc) will benefit from using tcmalloc automatically.
    - name: Build Application
      run: make
    
```

## Inputs
| Argument | Description | Default | Required |
|----------|-------------|---------|---------|
| tcmalloc-version    | The version of tcmalloc to be used | 5.3.0 | yes |

## Verification

You can use the scripts located in `./scripts/$platform/verify.sh` for the relevant platform
to verify a given PID is running with tcmalloc preloaded.
