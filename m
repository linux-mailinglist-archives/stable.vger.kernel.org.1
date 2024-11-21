Return-Path: <stable+bounces-94541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710079D50CF
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239B51F22769
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5F197A87;
	Thu, 21 Nov 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp+1nvA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A741C79
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207392; cv=none; b=O6ZW7THsUw2T2X+MH4NAilhuIu7v6sK9qmw3IC09+gVJ1zOPNPjjySBH7sHkXwxZx2YgTUXFK7z0tPKJPdzLLhjGEyffhqk5GWllLEbQyYaKC9/NVafKtGrbMrvhTnMcB/Pvh58YbqtUSDiZvYjfIXRoh6BJACkIG6PtvYDY+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207392; c=relaxed/simple;
	bh=pMGYrXbB2zEJ+LsGMfci6caqXOTSuZlr0+xOJyn60fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc8EN7epZN1KlIAk7iuUmF/Xw8v83ZewnkZuBMNHkYkkDbjwilmqGVJQ6Wrqan8hVyiOmf847zUQkXL4cVPnIfcGwnOcnUNzj3jY5UkTT73M7YbLGauezzitebfQFimeIbyxeuchO3NGSKMTt7wvUB9n3hPl1EkLXt+sBA+GaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp+1nvA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C81C4CECC;
	Thu, 21 Nov 2024 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207391;
	bh=pMGYrXbB2zEJ+LsGMfci6caqXOTSuZlr0+xOJyn60fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xp+1nvA68rNW9KgaXdSO/UA0zWECBM7wvh1X3TnPV0UyH+DnIJXt/mSATssthPqro
	 OU4vwPVPTYGTbKChqhUJ5PGrQrmPuYDh1HuPJC4zaROhFDdExPrqTmqE5Up4f2q3ET
	 XP4h9MvY9EW7QCHn212fLlgvQRsIPY7HI78sTywaxH0PYSuXJplMDCF5pRNrYXxFLm
	 GoZA8v03286xLBQkY5EuQoO6wt1QTwbykGE2g3Hw3LRq9+bV6WT+OanPLiuFjwckc0
	 8TgSvkgGPwfVmoQQCl4RwHCJ8coIQNcZiCA6j4GOd+jR5oXWXvCq7pWSqHhMN4iour
	 9Q0XRcNl7kcbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 11:43:09 -0500
Message-ID: <20241121112813-16abb8aa4cbf6ae8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121144414.3607863-1-brgerst@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 577c134d311b9b94598d7a0c86be1f431f823003

WARNING: Author mismatch between patch and found commit:
Backport author: Brian Gerst <brgerst@gmail.com>
Commit author: Ard Biesheuvel <ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 43d5fb3ac23e)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 11:24:09.939218101 -0500
+++ /tmp/tmp.Xbl1nnd3OX	2024-11-21 11:24:09.929523096 -0500
@@ -38,40 +38,37 @@
 Cc: stable@vger.kernel.org
 Link: https://github.com/ClangBuiltLinux/linux/issues/1854
 Link: https://lore.kernel.org/r/20241105155801.1779119-2-brgerst@gmail.com
+(cherry picked from commit 577c134d311b9b94598d7a0c86be1f431f823003)
 ---
- arch/x86/Makefile                     |  5 +++--
- arch/x86/entry/entry.S                | 16 ++++++++++++++++
+ arch/x86/Makefile                     |  3 ++-
+ arch/x86/entry/entry.S                | 15 +++++++++++++++
  arch/x86/include/asm/asm-prototypes.h |  3 +++
  arch/x86/kernel/cpu/common.c          |  2 ++
  arch/x86/kernel/vmlinux.lds.S         |  3 +++
- 5 files changed, 27 insertions(+), 2 deletions(-)
+ 5 files changed, 25 insertions(+), 1 deletion(-)
 
 diff --git a/arch/x86/Makefile b/arch/x86/Makefile
-index cd75e78a06c10..5b773b34768d1 100644
+index 9c09bbd390ce..f8a7d2a65434 100644
 --- a/arch/x86/Makefile
 +++ b/arch/x86/Makefile
-@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
+@@ -81,7 +81,8 @@ ifeq ($(CONFIG_X86_32),y)
  
-     ifeq ($(CONFIG_STACKPROTECTOR),y)
-         ifeq ($(CONFIG_SMP),y)
+ 	ifeq ($(CONFIG_STACKPROTECTOR),y)
+ 		ifeq ($(CONFIG_SMP),y)
 -			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
-+            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
-+                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
-         else
--			KBUILD_CFLAGS += -mstack-protector-guard=global
-+            KBUILD_CFLAGS += -mstack-protector-guard=global
-         endif
-     endif
- else
++			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
++					 -mstack-protector-guard-symbol=__ref_stack_chk_guard
+ 		else
+ 			KBUILD_CFLAGS += -mstack-protector-guard=global
+ 		endif
 diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
-index 324686bca3681..b7ea3e8e9eccd 100644
+index f4419afc7147..23f9efbe9d70 100644
 --- a/arch/x86/entry/entry.S
 +++ b/arch/x86/entry/entry.S
-@@ -51,3 +51,19 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
+@@ -48,3 +48,18 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
+ 
  .popsection
  
- THUNK warn_thunk_thunk, __warn_thunk
-+
 +#ifndef CONFIG_X86_64
 +/*
 + * Clang's implementation of TLS stack cookies requires the variable in
@@ -88,10 +85,10 @@
 +#endif
 +#endif
 diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
-index 25466c4d21348..3674006e39744 100644
+index 5cdccea45554..390b13db24b8 100644
 --- a/arch/x86/include/asm/asm-prototypes.h
 +++ b/arch/x86/include/asm/asm-prototypes.h
-@@ -20,3 +20,6 @@
+@@ -18,3 +18,6 @@
  extern void cmpxchg8b_emu(void);
  #endif
  
@@ -99,10 +96,10 @@
 +extern unsigned long __ref_stack_chk_guard;
 +#endif
 diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
-index a5f221ea56888..f43bb974fc66d 100644
+index f0cc4c616ceb..5db433cfaaa7 100644
 --- a/arch/x86/kernel/cpu/common.c
 +++ b/arch/x86/kernel/cpu/common.c
-@@ -2089,8 +2089,10 @@ void syscall_init(void)
+@@ -2000,8 +2000,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
  
  #ifdef CONFIG_STACKPROTECTOR
  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -114,16 +111,21 @@
  #endif	/* CONFIG_X86_64 */
  
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index b8c5741d2fb48..feb8102a9ca78 100644
+index 351c604de263..ab36dacb4cc5 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -491,6 +491,9 @@ SECTIONS
- . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
- 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
+@@ -490,6 +490,9 @@ SECTIONS
+ 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+ }
  
 +/* needed for Clang - see arch/x86/entry/entry.S */
 +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
 +
- #ifdef CONFIG_X86_64
  /*
-  * Per-cpu symbols which need to be offset from __per_cpu_load
+  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
+  */
+
+base-commit: 0a51d2d4527b43c5e467ffa6897deefeaf499358
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

