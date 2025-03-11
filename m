Return-Path: <stable+bounces-124099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A241EA5CFA4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE70C7A79A0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677D264631;
	Tue, 11 Mar 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQhCeqyp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89B264627;
	Tue, 11 Mar 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722238; cv=none; b=XsoFhQZ20NHUO41MAo6QkOnwB58MMZ7U8+WkUVMNOmsW0NWz5AzIf3gJYgK2GqP8u0oZ3KDPZDBQ4zmmZrubbRygLYAdwDuFYthhM5ueAm+qKKnkhQg6yVsukQvcx9PeC4MKaDWGvM16qXovguMqTPB97qReaDb36zsZ833bu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722238; c=relaxed/simple;
	bh=s488wFx5aTMKVQsqgNol6mUlN0cq/CNqyWNbSJffAq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npsXJeIOEHC/sI3SpZS022ip9Mtou7fKrXM7F7W4CeCqnJzzxGAWKAggNEc+N2wR9qV0GiGicjsVJVQfv9E/Xw/vLwSL1gDdWmfziwp5PxLyXKYfE6oNOjmiEjU32mjY3lPivLm9O8rIsMVEGTvT79k1tJPMGLt5sIjZPL8BjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQhCeqyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AAAC4CEEF;
	Tue, 11 Mar 2025 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722238;
	bh=s488wFx5aTMKVQsqgNol6mUlN0cq/CNqyWNbSJffAq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mQhCeqyph82Cg2ZwpYdd1k7nkOUcXAegm3Ck1mJcGRLEmBJoxZ49UGDYQzkmtmlsG
	 7LUyW1tCtYTR7P6MKuZGulF+m8zAyHNjGUpDZZ9lOC579dX3TuAjU1mTPqe205kY8t
	 2E+bDZKZ1rwB+fmP0yv3Q6h7v2y/DhDA5g2+88vUYS3y7HGqi00w7aI7xxfBFFZWFl
	 zTFk5D4Wm7EV3xo4vomEbRC3d2s/vi7IiidUjKzXY2kxs5AkMbI6sXBz3kkky4CAo8
	 78ubUEW5qPeKmEODKZxzdktonaFfsztlHgsf9Qeko+5b/NhuCjxNw1n53rDZyahQ+o
	 pFzCZQ4CFhsMg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 11 Mar 2025 20:43:42 +0100
Subject: [PATCH 1/2] ARM: Require linker to support KEEP within OVERLAY for
 DCE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-arm-fix-vectors-with-linker-dce-v1-1-ec4c382e3bfd@kernel.org>
References: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
In-Reply-To: <20250311-arm-fix-vectors-with-linker-dce-v1-0-ec4c382e3bfd@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Christian Eggers <ceggers@arri.de>, Arnd Bergmann <arnd@arndb.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Yuntao Liu <liuyuntao12@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601; i=nathan@kernel.org;
 h=from:subject:message-id; bh=s488wFx5aTMKVQsqgNol6mUlN0cq/CNqyWNbSJffAq8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkXJlV2GovpTBT86pTRJnX/AlvNY7+QFxmeUgf39bjuU
 U99Ib+uo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyE5THD/5jN38IN3Q41PXob
 WTvl9EcNozk9WYqH/jUurNrRHCs6eyvDP4WwnBQeodO7Dwg3PD9jvPG3zWb2heZtnjazLPbF7bB
 u4QEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

ld.lld prior to 21.0.0 does not support using the KEEP keyword within an
overlay description, which may be needed to avoid discarding necessary
sections within an overlay with '--gc-sections', which can be enabled
for the kernel via CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.

Disallow CONFIG_LD_DEAD_CODE_DATA_ELIMINATION without support for KEEP
within OVERLAY and introduce a macro, OVERLAY_KEEP, that can be used to
conditionally add KEEP when it is properly supported to avoid breaking
old versions of ld.lld.

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/381599f1fe973afad3094e55ec99b1620dba7d8c
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig                   | 2 +-
 arch/arm/include/asm/vmlinux.lds.h | 6 ++++++
 init/Kconfig                       | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 835b5f100e92..f3f6b7a33b79 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -121,7 +121,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index d60f6e83a9f7..0f8ef1ed725e 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -34,6 +34,12 @@
 #define NOCROSSREFS
 #endif
 
+#ifdef CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY
+#define OVERLAY_KEEP(x)		KEEP(x)
+#else
+#define OVERLAY_KEEP(x)		x
+#endif
+
 /* Set start/end symbol names to the LMA for the section */
 #define ARM_LMA(sym, section)						\
 	sym##_start = LOADADDR(section);				\
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..fc994f5cd5db 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -129,6 +129,11 @@ config CC_HAS_COUNTED_BY
 	# https://github.com/llvm/llvm-project/pull/112636
 	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
 
+config LD_CAN_USE_KEEP_IN_OVERLAY
+	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
+	# https://github.com/llvm/llvm-project/pull/130661
+	def_bool LD_IS_BFD || LLD_VERSION >= 210000
+
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 

-- 
2.48.1


