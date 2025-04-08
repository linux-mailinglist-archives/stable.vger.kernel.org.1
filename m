Return-Path: <stable+bounces-128853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCAA7F92D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408953A9F83
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0652641C0;
	Tue,  8 Apr 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T52E43h1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43B263C6B
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103807; cv=none; b=V3w0ubAGu6ntH05BxK7KlPvWQFKYa50aSc8xiuCjTx+/2e7Jdlj8rllyohWW/EgB2G9pLcgPXSFBqiGeos/8CNL6WJB2AV1ryOt8xMbF3l/88s8N7xKFZxeEd/Xkm6OA5p1WKzs+kkGI6Gx6RqemlTZkxD/BcBJnParI8puv6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103807; c=relaxed/simple;
	bh=KoSBQqt6ptex2YXl/Cs/5W1uAfwvEKSsyrIfWAVv/FE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gzq/GLqryRELy2UiRzknFf7orEXIs1wfzdhEosvMt0RVo7wJIWh6Xg/2HwwLdwzQlI4BV58+i+HhYHSpigIfh3sFAbvTm6xhIgJmDr5bZ73K1RlMQyut0p67hetWIlptJRHgdk9+OGa735kTznRMlya27ja4mtNClUEwwlNKJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T52E43h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB2C4CEE8;
	Tue,  8 Apr 2025 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744103806;
	bh=KoSBQqt6ptex2YXl/Cs/5W1uAfwvEKSsyrIfWAVv/FE=;
	h=Subject:To:Cc:From:Date:From;
	b=T52E43h1OtOj4yGMlrn7rGlzRLxHmsfNqWjOz5OeyWuy2EMpHjcLHbqkih9kfpsNA
	 VdwU95oCmDcyT8m6cd/ApZLWpJNrkYfmDBgxjLZ4cu5yCCFKbO6UYDOEqyLiQO3J9t
	 SoDxTHyG13Fjy0oafpnMBRspaFXPXU8SCBl0X4j8=
Subject: FAILED: patch "[PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY" failed to apply to 6.12-stable tree
To: nathan@kernel.org,linus.walleij@linaro.org,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 11:15:05 +0200
Message-ID: <2025040805-goal-richness-0c23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e7607f7d6d81af71dcc5171278aadccc94d277cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040805-goal-richness-0c23@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7607f7d6d81af71dcc5171278aadccc94d277cd Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 20 Mar 2025 22:33:49 +0100
Subject: [PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY
 for DCE

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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202dbd17ad2f..25ed6f1a7c7a 100644
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
index 89697f204715..a54db342653a 100644
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
 


