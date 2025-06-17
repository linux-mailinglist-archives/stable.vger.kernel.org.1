Return-Path: <stable+bounces-154561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C248CADDAFC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A3F400954
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847626C38E;
	Tue, 17 Jun 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELkJAsqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8960156C6F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183090; cv=none; b=NOM0oMGXQ6CtHM5kHe6C7JQ4FWjZmFCR170KMpc8p3KHknHLMnyi4HRUwzBPx5jvi4uBEIs91Ki2ZrVuk4b64avu6/wcv673fdQ9HMF+FUog3wpi4R+T9IChpdNv1iJQYqz2/mrlF+FKTDrJfenWvb3ARrlhps0Qy/mRIqP+jwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183090; c=relaxed/simple;
	bh=Re2G0rsv1w8g7EwzGfmZUj+Bx7UxxILQdP8WeE/p0FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9V6VWOan9x8+aNqdJ1+vo0TSGa3kUedu+4s2NrYdfqxrYWPxix6RQvd7zgizUGhIh4HuWuUaZe8q6IOeX4tr7B8lK+Io2/zRlPrcDzK+8cBFdX0R3wHQPb9lYknT/iZVP/9dWeQKCEK6THTRjTAKkBXfBy+VTzxXWb6WQmDxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELkJAsqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18259C4CEE3;
	Tue, 17 Jun 2025 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750183089;
	bh=Re2G0rsv1w8g7EwzGfmZUj+Bx7UxxILQdP8WeE/p0FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELkJAsqVDHYGss0KoQeWASDTjich8FQGXwwK3nUzz0XgJOSDr0kCYHu+iKZll5Uvt
	 HkHjh961TjBRcKna6utnNKBd0ZPP0P50hswe/P14x7ZkVHS2UfTVzXto0+vHhnIcU8
	 0yWVIGBPWvmXafvVWh+8CNl3SQ3vqz4dwHLzdtepLBH6WqDtmaZ4kzk3axLZXL5RQg
	 zyVvN/H7apOv8bwn9G7/zjWSxY631CSwTaxh4B8bxS+ZgWg8abEFu0Vz0/nmSgv8dt
	 H2SXQq7f/ZqjdHyYHzPq3A6eFjvDYihuWGT6BKZu24EU0GnXfWctXQqMohsjsg83vx
	 NvDjzK7Q1wXgA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Fiona Behrens <me@Kloenk.dev>,
	Nicolas Schier <n.schier@avm.de>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.12.y 1/2] kbuild: rust: add rustc-min-version support function
Date: Tue, 17 Jun 2025 19:57:59 +0200
Message-ID: <20250617175800.1865653-1-ojeda@kernel.org>
In-Reply-To: <2025061734-shale-reliably-8969@gregkh>
References: <2025061734-shale-reliably-8969@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ac954145e1ee3f72033161cbe4ac0b16b5354ae7 upstream.

Introduce `rustc-min-version` support function that mimics
`{gcc,clang}-min-version` ones, following commit 88b61e3bff93
("Makefile.compiler: replace cc-ifversion with compiler-specific macros").

In addition, use it in the first use case we have in the kernel (which
was done independently to minimize the changes needed for the fix).

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Fiona Behrens <me@Kloenk.dev>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/kbuild/makefiles.rst | 14 ++++++++++++++
 arch/arm64/Makefile                |  2 +-
 scripts/Makefile.compiler          |  4 ++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 7964e0c245ae..81607ce40759 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -656,6 +656,20 @@ cc-cross-prefix
             endif
     endif
 
+$(RUSTC) support functions
+--------------------------
+
+rustc-min-version
+  rustc-min-version tests if the value of $(CONFIG_RUSTC_VERSION) is greater
+  than or equal to the provided value and evaluates to y if so.
+
+  Example::
+
+    rustflags-$(call rustc-min-version, 108500) := -Cfoo
+
+  In this example, rustflags-y will be assigned the value -Cfoo if
+  $(CONFIG_RUSTC_VERSION) is >= 1.85.0.
+
 $(LD) support functions
 -----------------------
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 19a4988621ac..88029d38b3c6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,7 +48,7 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
-ifeq ($(call test-ge, $(CONFIG_RUSTC_VERSION), 108500),y)
+ifeq ($(call rustc-min-version, 108500),y)
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none-softfloat
 else
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none -Ctarget-feature="-neon"
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index c6cd729b65cb..68fdebb657ae 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -67,6 +67,10 @@ gcc-min-version = $(call test-ge, $(CONFIG_GCC_VERSION), $1)
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
 clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 
+# rustc-min-version
+# Usage: rustc-$(call rustc-min-version, 108500) += -Cfoo
+rustc-min-version = $(call test-ge, $(CONFIG_RUSTC_VERSION), $1)
+
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-- 
2.50.0


