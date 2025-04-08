Return-Path: <stable+bounces-131790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D25BA80FE5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE87BD518
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1E22B5B1;
	Tue,  8 Apr 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV/gJPHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701842253B2
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125784; cv=none; b=XflX5INoSsHCuJwjqtkN2BBha+rbm7jhCLFAWariANGSWoXojEBAcP9Hwt2fmYctXP1KCHQO6xBLxEoVrZ4ptMrpNRbIyunmENFMyyIzEUamuHlc0XPtmCUPfk8QvkCt0p1S75UwXipPt1PRXrdco3Y2c27aoljEl8UguainxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125784; c=relaxed/simple;
	bh=wkTvchI3bib9Pnh+lS+4WUTTsHXvYi0sHRdAAg/S9s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP4bi2Wc3PaCsJtS2cbIMlg0H/yUUeeUqeqsbWqE1DbCd8E28vajpV4qeqEQ5XHdvVp8qYuqBKSvOCqaS1zQrN5pFeNHtO3L9befnyKmYliJT0m06gXQj48fcuJcNILqz+HUSeFfSEjxhqr9eT7GXsAiogmjQXkmOHjH50i5tJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV/gJPHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E03C4CEE9;
	Tue,  8 Apr 2025 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125783;
	bh=wkTvchI3bib9Pnh+lS+4WUTTsHXvYi0sHRdAAg/S9s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV/gJPHwptycSvQ+eTpJJt7XJybZeJH5QG3zTOaVfWEdMe/gEXKzxSFguE6loV9vC
	 HyHT7qY9fv3gYHM93L7VgY7bYOB5+1PYOpLscyHdyukbtMbbJtmnqZBq2U/46f+RL2
	 uJYUR7Xxu4E8mWf05S/+qdEUHYCpHj8xRfaA+8GKYjeFj+tviCzu7Ga04sgW0HHRDJ
	 BCyqCMjSfPTnvui6mqEw3lOgFqCGN3HXWldcpolyOHVGhGngQfLMCn7RIoSgXoCKb4
	 AxmJQ3Plsc+eB3bbaVA/UF+e3cg6Lf1HKSdvC//VCTHkbSGydtUyO2dVO0dwhZX+rC
	 G45lX1c4GxlPg==
Date: Tue, 8 Apr 2025 08:23:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk,
	stable@vger.kernel.org, broonie@kernel.org
Subject: Re: FAILED: patch "[PATCH] ARM: 9443/1: Require linker to support
 KEEP within OVERLAY" failed to apply to 6.13-stable tree
Message-ID: <20250408152300.GA3301081@ax162>
References: <2025040805-boaster-hazing-36c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x8E+sD+dvmdZGvqM"
Content-Disposition: inline
In-Reply-To: <2025040805-boaster-hazing-36c3@gregkh>


--x8E+sD+dvmdZGvqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2025 at 11:15:05AM +0200, gregkh@linuxfoundation.org wrote:
...
> ------------------ original commit in Linus's tree ------------------
> 
> From e7607f7d6d81af71dcc5171278aadccc94d277cd Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <nathan@kernel.org>
> Date: Thu, 20 Mar 2025 22:33:49 +0100
> Subject: [PATCH] ARM: 9443/1: Require linker to support KEEP within OVERLAY
>  for DCE

Attached is a backport for 6.12 and 6.13. This change is necessary for
"ARM: 9444/1: add KEEP() keyword to ARM_VECTORS", as pointed out at
https://lore.kernel.org/71339b92-5292-48b7-8a45-addbac43ee32@sirena.org.uk/.

Cheers,
Nathan

--x8E+sD+dvmdZGvqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ARM-9443-1-Require-linker-to-support-KEEP-within-OVE.patch

From 4800091d0ce47de62d584cda0c4c4eb2eedbe794 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 20 Mar 2025 22:33:49 +0100
Subject: [PATCH 6.12 and 6.13] ARM: 9443/1: Require linker to support KEEP
 within OVERLAY for DCE

commit e7607f7d6d81af71dcc5171278aadccc94d277cd upstream.

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
[nathan: Fix conflict in init/Kconfig due to lack of RUSTC symbols]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig                   | 2 +-
 arch/arm/include/asm/vmlinux.lds.h | 6 ++++++
 init/Kconfig                       | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202397be76d8..d0040fb67c36 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -118,7 +118,7 @@ config ARM
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
index 4c88cb58c261..f3dbdec0a04e 100644
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
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))

base-commit: 1edf71b4b7d9f599843d2c5280537d10be495ebc
-- 
2.49.0


--x8E+sD+dvmdZGvqM--

