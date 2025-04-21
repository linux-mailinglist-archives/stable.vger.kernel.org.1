Return-Path: <stable+bounces-134789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772DA95119
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F41891E46
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6E2641CC;
	Mon, 21 Apr 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYWR0HOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D63FC7
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239115; cv=none; b=r+BhIJzn2cAT1RFXG8sOuXLWDgIvfK3xA1u54T4gb8uAWgyy4Wdp9mNZ7AxAkjAq2Tfa7SbUfKYFZkg7NcO1jhctWpgIhTVAce5LMaxXqmvVSsL+uiyyPkH7Jb6AtEdTBMgPXRXgNlK7Oj/iSl+hKyXAUlqFe8kOlVro10WN/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239115; c=relaxed/simple;
	bh=OgYFZIl67iUDWlA93Ufw3NTQz4OGPSfdOavv1CWXvmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quKXJ8PlFL7J12xiznqfPcgJ1+6WD9nSeOYJ//pvkiYq8qEj3+Ft/e1LGKVNZVNhRaoyRwdf7LjlkmRt+ltcTQdeLroHiAebvTb8abbS4L7KotAdLPb4SECZvWN2oHDTaVZfwMks4/MzJdTx5woAlqFpF+qqhaX+MXWtNVpyxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYWR0HOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC8C4CEE4;
	Mon, 21 Apr 2025 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745239113;
	bh=OgYFZIl67iUDWlA93Ufw3NTQz4OGPSfdOavv1CWXvmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYWR0HOgMOa8AZvBnBv3DN4DuuOBMazyGVh33SWFCTwbB0I6knSkBASkndd7TV5PV
	 zPQASDtIWpc05t/IecYPBLb02y+7bsMiEkuhIaPX4Dm5KfSSjJhc8bOtTBrd2H3som
	 TljUFa9v4tPUyY66GRt8brYgGE58BlJjUfCjOlqLBUU6gf+gPWr01En/vkGlXEafal
	 xXz8qDugqBf8Vri3J16geWOVknxp7cvtu1ORBuiPq316qWdkf+FbSxaTizKWNV03Fa
	 W2SNtyAg7uHwYKF5Y16zC8YWhgkKGFlWVz6PdOfrUHe/we7vocXyTsuuZzW+RFKdu6
	 1yyN04ES6B9Fw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Fischer <kernel@o1oo11oo.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.14.y] scripts: generate_rust_analyzer: Add ffi crate
Date: Mon, 21 Apr 2025 14:38:27 +0200
Message-ID: <20250421123827.3147434-1-ojeda@kernel.org>
In-Reply-To: <2025042132-everglade-smasher-1ef2@gregkh>
References: <2025042132-everglade-smasher-1ef2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Fischer <kernel@o1oo11oo.de>

commit 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6 upstream.

Commit d072acda4862 ("rust: use custom FFI integer types") did not
update rust-analyzer to include the new crate.

To enable rust-analyzer support for these custom ffi types, add the
`ffi` crate as a dependency to the `bindings`, `uapi` and `kernel`
crates, which all directly depend on it.

Fixes: d072acda4862 ("rust: use custom FFI integer types")
Signed-off-by: Lukas Fischer <kernel@o1oo11oo.de>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250404125150.85783-2-kernel@o1oo11oo.de
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Fixed conflicts. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/generate_rust_analyzer.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index adae71544cbd..f2ff0f954236 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -97,6 +97,12 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         ["core", "compiler_builtins"],
     )
 
+    append_crate(
+        "ffi",
+        srctree / "rust" / "ffi.rs",
+        ["core", "compiler_builtins"],
+    )
+
     def append_crate_with_generated(
         display_name,
         deps,
@@ -116,9 +122,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "exclude_dirs": [],
         }
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
+    append_crate_with_generated("bindings", ["core", "ffi"])
+    append_crate_with_generated("uapi", ["core", "ffi"])
+    append_crate_with_generated("kernel", ["core", "macros", "build_error", "ffi", "bindings", "uapi"])
 
     def is_root_crate(build_file, target):
         try:
-- 
2.49.0


