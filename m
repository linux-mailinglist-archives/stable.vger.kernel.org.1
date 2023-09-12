Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69079BB81
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377878AbjIKW3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbjIKOfF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037AF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7BC433C8;
        Mon, 11 Sep 2023 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442900;
        bh=p6Dv32QShCOcVuFpNE2K83FbC9qDsDt3QBL+vkYkdUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBbTYNckjqSDVcXRlPbO32dwV/2oJhjDkJx5dggpc99GK4/tHx6bDiV51SU+j/M0c
         1S2NJPA8nuedbXBgB1zENa+jwGM2ukFrHzTzDPsUB9hZFFseJyksHWbdWw87SAZW3d
         WX0n4ySxLyY6BDzoPKNakrQbG6v9omomRaLnj4sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 188/737] kbuild: rust_is_available: remove -v option
Date:   Mon, 11 Sep 2023 15:40:47 +0200
Message-ID: <20230911134655.830121712@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d824d2f98565e7c4cb1b862c230198fbe1a968be ]

The -v option is passed when this script is invoked from Makefile,
but not when invoked from Kconfig.

As you can see in scripts/Kconfig.include, the 'success' macro suppresses
stdout and stderr anyway, so this script does not need to be quiet.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230109061436.3146442-1-masahiroy@kernel.org
[ Reworded prefix to match the others in the patch series. ]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Link: https://lore.kernel.org/r/20230616001631.463536-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Stable-dep-of: dee3a6b819c9 ("kbuild: rust_is_available: fix version check when CC has multiple arguments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile                     |  4 +-
 scripts/rust_is_available.sh | 96 +++++++++++++++---------------------
 2 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/Makefile b/Makefile
index 212d1c7e4a1a3..41ac4ce7f8e58 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,7 +1289,7 @@ prepare0: archprepare
 # All the preparing..
 prepare: prepare0
 ifdef CONFIG_RUST
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
 	$(Q)$(MAKE) $(build)=rust
 endif
 
@@ -1825,7 +1825,7 @@ $(DOC_TARGETS):
 # "Is Rust available?" target
 PHONY += rustavailable
 rustavailable:
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v && echo "Rust is available!"
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh && echo "Rust is available!"
 
 # Documentation target
 #
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index aebbf19139709..f43a010eaf305 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -2,8 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Tests whether a suitable Rust toolchain is available.
-#
-# Pass `-v` for human output and more checks (as warnings).
 
 set -e
 
@@ -23,21 +21,17 @@ get_canonical_version()
 
 # Check that the Rust compiler exists.
 if ! command -v "$RUSTC" >/dev/null; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust compiler '$RUSTC' could not be found."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust compiler '$RUSTC' could not be found."
+	echo >&2 "***"
 	exit 1
 fi
 
 # Check that the Rust bindings generator exists.
 if ! command -v "$BINDGEN" >/dev/null; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
+	echo >&2 "***"
 	exit 1
 fi
 
@@ -53,16 +47,14 @@ rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
 rust_compiler_min_cversion=$(get_canonical_version $rust_compiler_min_version)
 if [ "$rust_compiler_cversion" -lt "$rust_compiler_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust compiler '$RUSTC' is too old."
-		echo >&2 "***   Your version:    $rust_compiler_version"
-		echo >&2 "***   Minimum version: $rust_compiler_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust compiler '$RUSTC' is too old."
+	echo >&2 "***   Your version:    $rust_compiler_version"
+	echo >&2 "***   Minimum version: $rust_compiler_min_version"
+	echo >&2 "***"
 	exit 1
 fi
-if [ "$1" = -v ] && [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
+if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
 	echo >&2 "***"
 	echo >&2 "*** Rust compiler '$RUSTC' is too new. This may or may not work."
 	echo >&2 "***   Your version:     $rust_compiler_version"
@@ -82,16 +74,14 @@ rust_bindings_generator_min_version=$($min_tool_version bindgen)
 rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
 rust_bindings_generator_min_cversion=$(get_canonical_version $rust_bindings_generator_min_version)
 if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
-		echo >&2 "***   Your version:    $rust_bindings_generator_version"
-		echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
+	echo >&2 "***   Your version:    $rust_bindings_generator_version"
+	echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
+	echo >&2 "***"
 	exit 1
 fi
-if [ "$1" = -v ] && [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
+if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
 	echo >&2 "***"
 	echo >&2 "*** Rust bindings generator '$BINDGEN' is too new. This may or may not work."
 	echo >&2 "***   Your version:     $rust_bindings_generator_version"
@@ -110,13 +100,11 @@ bindgen_libclang_min_version=$($min_tool_version llvm)
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
 bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
 if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
-		echo >&2 "***   Your version:    $bindgen_libclang_version"
-		echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
+	echo >&2 "***   Your version:    $bindgen_libclang_version"
+	echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
+	echo >&2 "***"
 	exit 1
 fi
 
@@ -125,21 +113,19 @@ fi
 #
 # In the future, we might be able to perform a full version check, see
 # https://github.com/rust-lang/rust-bindgen/issues/2138.
-if [ "$1" = -v ]; then
-	cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
-	if [ "$cc_name" = Clang ]; then
-		clang_version=$( \
-			LC_ALL=C "$CC" --version 2>/dev/null \
-				| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
-		)
-		if [ "$clang_version" != "$bindgen_libclang_version" ]; then
-			echo >&2 "***"
-			echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
-			echo >&2 "*** version does not match Clang's. This may be a problem."
-			echo >&2 "***   libclang version: $bindgen_libclang_version"
-			echo >&2 "***   Clang version:    $clang_version"
-			echo >&2 "***"
-		fi
+cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
+if [ "$cc_name" = Clang ]; then
+	clang_version=$( \
+		LC_ALL=C "$CC" --version 2>/dev/null \
+			| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
+	)
+	if [ "$clang_version" != "$bindgen_libclang_version" ]; then
+		echo >&2 "***"
+		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
+		echo >&2 "*** version does not match Clang's. This may be a problem."
+		echo >&2 "***   libclang version: $bindgen_libclang_version"
+		echo >&2 "***   Clang version:    $clang_version"
+		echo >&2 "***"
 	fi
 fi
 
@@ -150,11 +136,9 @@ rustc_sysroot=$("$RUSTC" $KRUSTFLAGS --print sysroot)
 rustc_src=${RUST_LIB_SRC:-"$rustc_sysroot/lib/rustlib/src/rust/library"}
 rustc_src_core="$rustc_src/core/src/lib.rs"
 if [ ! -e "$rustc_src_core" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Source code for the 'core' standard library could not be found"
-		echo >&2 "*** at '$rustc_src_core'."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Source code for the 'core' standard library could not be found"
+	echo >&2 "*** at '$rustc_src_core'."
+	echo >&2 "***"
 	exit 1
 fi
-- 
2.40.1



