Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB179C0A8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbjIKVVv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjIKOfK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE6F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74859C433C7;
        Mon, 11 Sep 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442905;
        bh=dIUnazrLUbgUZyyWMHBHY9AHfl3AWQVgW8mx4qpTYQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qY2/2vRfg/8oTFNQBrjXKPxDUljwBMscgGtuq6oRXjE9ocUnNt7z4ZwEpZyjvxLEL
         TUu2vfZNEla70iUQaJXNaXiOapLhbynInjLhd1GlnRQkIa1zaSAfWojYP4h0mYKjow
         0uilUC9aH6UUVM15F76JlUCUyJGb6UTL9nNuv29Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Fran=C3=A7ois=20Valenduc?= <francoisvalenduc@gmail.com>,
        Alexandru Radovici <msg4alex@gmail.com>,
        Matthew Leach <dev@mattleach.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 190/737] kbuild: rust_is_available: add check for `bindgen` invocation
Date:   Mon, 11 Sep 2023 15:40:49 +0200
Message-ID: <20230911134655.890956776@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 52cae7f28ed6c3992489f16bb355f5b623f0912e ]

`scripts/rust_is_available.sh` calls `bindgen` with a special
header in order to check whether the `libclang` version in use
is suitable.

However, the invocation itself may fail if, for instance, `bindgen`
cannot locate `libclang`. This is fine for Kconfig (since the
script will still fail and therefore disable Rust as it should),
but it is pretty confusing for users of the `rustavailable` target
given the error will be unrelated:

    ./scripts/rust_is_available.sh: 21: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
    make: *** [Makefile:1816: rustavailable] Error 2

Instead, run the `bindgen` invocation independently in a previous
step, saving its output and return code. If it fails, then show
the user a proper error message. Otherwise, continue as usual
with the saved output.

Since the previous patch we show a reference to the docs, and
the docs now explain how `bindgen` looks for `libclang`,
thus the error message can leverage the documentation, avoiding
duplication here (and making users aware of the setup guide in
the documentation).

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
Reported-by: François Valenduc <francoisvalenduc@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/934
Reported-by: Alexandru Radovici <msg4alex@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/pull/921
Reported-by: Matthew Leach <dev@mattleach.net>
Closes: https://lore.kernel.org/rust-for-linux/20230507084116.1099067-1-dev@mattleach.net/
Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230616001631.463536-6-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/rust_is_available.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 0c9be438e4cd3..c965895d80b97 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -90,8 +90,28 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
 fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
+#
+# In order to do that, first invoke `bindgen` to get the `libclang` version
+# found by `bindgen`. This step may already fail if, for instance, `libclang`
+# is not found, thus inform the user in such a case.
+bindgen_libclang_output=$( \
+	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null
+) || bindgen_libclang_code=$?
+if [ -n "$bindgen_libclang_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the libclang version (used by the Rust"
+	echo >&2 "*** bindings generator) failed with code $bindgen_libclang_code. This may be caused by"
+	echo >&2 "*** a failure to locate libclang. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$bindgen_libclang_output"
+	echo >&2 "***"
+	exit 1
+fi
+
+# `bindgen` returned successfully, thus use the output to check that the version
+# of the `libclang` found by the Rust bindings generator is suitable.
 bindgen_libclang_version=$( \
-	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null \
+	echo "$bindgen_libclang_output" \
 		| grep -F 'clang version ' \
 		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
 		| head -n 1 \
-- 
2.40.1



