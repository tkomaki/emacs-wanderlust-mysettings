
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;概要
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;メール自体はfetchmail+procmailでPOPでメール吸い取り&Mailディレクトリに振り分け。
;;wanderlustではメールの送信と受信済みのメール閲覧のみ行う。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Mailディレクトリ設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq elmo-maildir-folder-path "~/Mail/")
(setq wl-default-folder "+inbox")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;SMTP設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq wl-smtp-connection-type 'ssl)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-server "メールサーバ")
(setq wl-local-domain "ローカルドメイン")
(setq wl-smtp-posting-port ポート番号)
(setq wl-smtp-posting-user "ユーザ名")
(setq wl-from "From設定")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 基本設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;開いたら最大化
(set-frame-parameter nil 'fullscreen 'maximized)
;;(set-frame-parameter nil 'fullscreen 'fullboth)
(toggle-frame-maximized)


;;送信済みフォルダ設定
(setq wl-fcc "+outbox")

;;ドラフト(草稿)ファイル指定
(setq wl-draft-folder "+draft")

;;ゴミ箱指定
(setq wl-trash-folder "+trash")

;;ヘッダーの表示指定
(setq wl-message-ignored-field-list '(".*:")
wl-message-visible-field-list '("^To:" "^Subject:" "^From:" "^Date:" "^Cc:" "^Message-ID:" "^X-Mailer:")
wl-message-sort-field-list    '("^From:" "^To:" "^Cc:" "^Date:" "^Message-ID:" "^X-Mailer:" "^Subject:" ))

;;関係する全ての人に返信
(setq wl-draft-reply-without-argument-list
'(("Followup-To" . (nil nil ("Followup-To")))
("Newsgroups" . (nil nil ("Newsgroups")))
("Mail-Followup-To" . (("Mail-Followup-To") nil ("Newsgroups")))
("Reply-To" . (("Reply-To") ("To" "Cc") nil))
("From" . (("From") ("To" "Cc") ("Newsgroups")))
))

;;返信時のヘッダに相手の名前を入れない
(setq wl-draft-reply-use-address-with-full-name nil)

;;でかいメッセージを分割して送信しない
(setq mime-edit-split-message nil)

;;警告無しに開けるメールサイズの最大値 (デフォルト:30K)
(setq elmo-message-fetch-threshold 500000)

;;送信する前に確認
(setq wl-interactive-send t)

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;選択で即時コピーする
(setq mouse-drag-copy-region t)

;; 送信メールは自動で既読に
(setq wl-fcc-force-as-read t)

;;to,fromが長いと省略されるので省略を無効化
(setq wl-message-use-header-narrowing nil)

;;User-Agentを短く
(setq wl-generate-mailer-string-function 'wl-generate-user-agent-string-1)

;;右クリック可能にする [ここから]

;; 右クリックを有効にする
(when window-system
;; 右ボタンの割り当て(押しながらの操作)をはずす。
(global-unset-key [down-mouse-3])
;; マウスの右クリックメニューを出す(押して、離したときにだけメニューが出る)
(defun bingalls-edit-menu (event)
(interactive "e")
(popup-menu menu-bar-edit-menu))
(global-set-key [mouse-3] 'bingalls-edit-menu))

;;右クリック可能にする [ここまで]


;; ダブルクォートで囲まれたFromもエンコードする(本来はRFC2047違反)
(mime-set-field-decoder 'From nil 'eword-decode-and-unfold-unstructured-field-body)
(mime-set-field-decoder 'To nil 'eword-decode-and-unfold-unstructured-field-body)









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 高速化(POPだと意味がない？)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;popで読んだメッセージをキャッシュする
(setq elmo-pop3-use-cache t)

;;フォルダに移動したときに最初のメッセージを先読み
(setq wl-auto-prefetch-first t)

;;先読みするメッセージの数
(setq wl-message-buffer-prefetch-depth 80)
;;保持するバッファの数
(setq wl-message-buffer-cache-size 100)

;;先読みするメッセージの容量制限を無制限にする
(setq wl-message-buffer-prefetch-threshold nil)
















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 表示周り設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;サマリの表示幅を切り詰めない
(setq wl-summary-width nil)

;;emacsのメニューバーを表示しない
(menu-bar-mode 0)

;;emacsのツールバーを表示しない
(tool-bar-mode 0)

;;Subject が変わってもスレッドを切らない
(setq wl-summary-divide-thread-when-subject-changed nil)


;;画面を普通のメーラみたいにフォルダとか表示
(setq wl-stay-folder-window t)
(setq  wl-message-window-size '(10 . 14))

;;フォルダの表示幅調整
(setq wl-folder-window-width 35)

;;サマリーモードの表示指定
(setq wl-summary-line-format "%[%1@%T%P %] [No.%-5n%]%[%-6S%]%[%Y/%M/%D (%W) %h:%m%] %[%tFrom%]%40(%c%f%) %[Subject%]%130(%s%)")

;; HTMLファイルは表示しない。
;(setq mime-setup-enable-inline-html nil)

;;サマリモードに入った直後に最下部にカーソルを移動する
(add-hook 'wl-summary-prepared-hook 'wl-summary-display-bottom)
(add-hook 'wl-summary-sync-update 'wl-summary-display-bottom)

;;subject全て表示
(setq wl-summary-subject-function 'identity)


;; 初期設定は t。Non-nil なら、サマリを終了するときに次のフォルダに移動。
(setq wl-summary-exit-next-move nil)

;;次のメッセージに進むとき未読に飛ぶ
(setq wl-summary-move-order 'unread)

;; スレッド表示のインデントを無制限にする。
(setq wl-summary-indent-length-limit nil)
(setq wl-summary-width nil)

;;スレッド表示をデフォルトでしない
(setq wl-summary-default-view 'sequence)
(setq wl-thread-insert-opened nil)

;; メールを書くときはフル画面にする
(setq wl-draft-reply-buffer-style 'full)

;;マウスのスクロールをスムーズに
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;;スクロールした際のカーソルの移動行数
(setq scroll-conservatively 1)

;;サマリー色調整
(set-face-foreground 'wl-highlight-summary-normal-face "black" )
(set-face-foreground 'wl-highlight-summary-new-face "blue" )
(set-face-foreground 'wl-highlight-summary-unread-face "blue" )
(set-face-foreground 'wl-highlight-summary-thread-top-face "black" )
;;folder色調整
(set-face-foreground 'wl-highlight-folder-unknown-face "black" )
(set-face-foreground 'wl-highlight-folder-zero-face "black" )
(set-face-foreground 'wl-highlight-folder-few-face "black" )
(set-face-foreground 'wl-highlight-folder-many-face "black" )
(set-face-foreground 'wl-highlight-folder-unread-face "red" )
(set-face-foreground 'wl-highlight-folder-killed-face "black" )
(set-face-foreground 'wl-highlight-folder-opened-face "black" )
(set-face-foreground 'wl-highlight-folder-closed-face "black" )


;;gとかで移動するときにリモート(%)ではなくてローカルフォルダ(+)の一覧をだす。
(setq wl-default-spec "+")

;;draftを作成する際新しいフレームで開く
(setq wl-draft-use-frame t)






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;フォント設定周り設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;フォントを等幅フォントに変更
(set-face-attribute 'default nil :family "Menlo" :height 120)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (font-spec :family "Hiragino Kaku Gothic ProN"))
(add-to-list 'face-font-rescale-alist
             '(".*Hiragino Kaku Gothic ProN.*" . 1.2))







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;キーバインド周りの設定
;;デフォルトのキーバインド覚えたくないので変更
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 全部既読にするコマンドがcだけでできると怖いのではずす
(define-key wl-summary-mode-map "c" nil)

;; サマリーモードでctrl+kで全部既読にする
(define-key wl-summary-mode-map "\C-k" 'wl-summary-mark-as-read-all)

;;sとaキーでフォルダ移動できるように(サマリーモードでは現在のフォルダを脱出)
(define-key wl-folder-mode-map "s" 'wl-folder-next-entity)
(define-key wl-folder-mode-map "a" 'wl-folder-prev-entity)
(define-key wl-summary-mode-map "s" 'wl-summary-exit)
(define-key wl-summary-mode-map "a" 'wl-summary-exit)

;;サマリーモードでjで次のメールにjで進むように(vim風)
(define-key wl-summary-mode-map "j" 'wl-summary-next)
;;サマリーモードでkで前のメールにkで戻るように(vim風)
(define-key wl-summary-mode-map "k" 'wl-summary-prev)

;;サマリーモードでGで最新メール(一番下のメールに移動/vim風)
(define-key wl-summary-mode-map "G" 'wl-summary-display-bottom)
;;サマリーモードでgで最新メール(一番上のメールに移動/vim風)
(define-key wl-summary-mode-map "g" 'wl-summary-display-top)

;;フォルダモードでjで次のフォルダにjで進むように(vim風)
(define-key wl-folder-mode-map "j" 'wl-folder-next-entity)
;;フォルダモードでkで前のフォルダにkで戻るように(vim風)
(define-key wl-folder-mode-map "k" 'wl-folder-prev-entity)
;;フォルダモードでoでサマリモードにいく(フォルダ開く)
(define-key wl-folder-mode-map "o" 'wl-folder-jump-to-current-entity)

;;ctrl+fか/でサマリーモード/フォルダモードでメール検索
(define-key wl-summary-mode-map "\C-f" 'wl-summary-virtual)
(define-key wl-folder-mode-map "\C-f" 'wl-folder-virtual)

(define-key wl-summary-mode-map "/" 'wl-summary-virtual)
(define-key wl-folder-mode-map "/" 'wl-folder-virtual)

;;サマリーモードでメールに移動
(define-key wl-summary-mode-map "o" 'wl-summary-jump-to-current-message)

;;ctrl+rでメールをシンク(表示アップデート)
(define-key wl-summary-mode-map "\C-r" 'wl-summary-sync-update)
;;ctrl+rでメールをシンク(表示アップデート)
(define-key wl-folder-mode-map "\C-r" 'wl-folder-sync-current-entity)

;;ctrl+tで返信メール作成
(define-key wl-summary-mode-map "\C-t" 'wl-summary-reply-with-citation)

;;ctrl+hでヘッダー全て表示
(define-key wl-summary-mode-map "\C-h" 'wl-summary-toggle-all-header)

;;ドラフトバッファ(メール作成画面)でCtrl+sで送信する
(define-key wl-draft-mode-map "\C-s" 'wl-draft-send-and-exit)



