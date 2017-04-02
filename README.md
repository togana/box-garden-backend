box-garden-backend
====

# TODO

- セットアップが遅いので並列処理できるようにしたい
- パラメータ指定のバリデーション
- REST APIの提供(ビルドと実行)
- ログの確認ができる機構の用意

# 必須

- docker 1.13+
- docker-machine 0.10+
- docker-compose 1.11+

# セットアップ

```
$ ./script/init.sh
```

# 関数のビルド

パラメータ

- box名は必須 `/boxs/box名` に存在する必要あり
- タグ名の初期値はlatest

```
$ ./script/build.sh {box名} {タグ名}
```

# 関数の実行

パラメータ

- box名は必須 `/boxs/box名` に存在する必要あり
- タグ名の初期値はlatest

```
$ ./script/task.sh {box名} {タグ名}
```

# 環境削除

```
$ ./script/remove.sh
```
