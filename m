Return-Path: <stable+bounces-94544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0F9D50D2
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559DD1F22E42
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA0197A87;
	Thu, 21 Nov 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKJBA/0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10414387B
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207398; cv=none; b=bIBG8DrxIx2dzwW4xdFMja1gJSo4DeOKOXF56XHYeRsYQp4pKJ8DQpnn8gTIDOpaAMh/kXqMVLPHSLWy4JWIFH+cwOYnZs+a6TEt5sq9OMEA9v1NCfOpkMLpPRwu4bWUSeO2Ik0mXFBnoU7c1dA5HnYhy+0567Mnw/vv1MLREQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207398; c=relaxed/simple;
	bh=T9aTsngz5SdHqkn8i2yIU/CI5seNISfJrIe0Ikg5f1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoFPGj7RzgTMfWJ0h89c1+BUCI5/yomgdfQM5foeBNE/gcNI/aDTMH5f5qA53bN05XUOHW0B9p0ev7aMce6pQlc3m55QLa3SNLqDYPhjIGZeKnJ0La5r0UbpYJc2fCRu2vfNxOPy7+tmQ2+oljhvJ0Y/Ynarwyz4ffMFOrb0TwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKJBA/0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44F2C4CECD;
	Thu, 21 Nov 2024 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207398;
	bh=T9aTsngz5SdHqkn8i2yIU/CI5seNISfJrIe0Ikg5f1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKJBA/0bb+WeXcNZkp3CfXMIHqRlQXOK1cTAvBVOYcKYzTHnT/5bAuPSw08Pbd25p
	 MLaSxDkeMR/k6rKVKj5Klzuv068UnpSasfCQz9Cm4iIR6zdVHjHEIKfRqia2OlEo8I
	 RKhZA3EgSfYwtCSfO0QnTyNavejNBoaUYmG0QvJKU/YGrNdjEuYc4J285vdAsCw0/c
	 XNSJ4uiyKPtrXSYci3+UZTP6qoevkRUSgsnlWSjYpHm9gSETF6GBhobt31+7xOwVUD
	 8uvWt//sS0niLb8MWaHjnBb1+ZS+yIL3ErkbLhwvopTiItaSPeuR2pV031OL+w6ksQ
	 Att0s4hQU4xoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 11:43:16 -0500
Message-ID: <20241121113629-495782fc07c545dd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121151519.3692548-1-brgerst@gmail.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 11:32:21.903231818 -0500
+++ /tmp/tmp.Q0DbBn1V8Q	2024-11-21 11:32:21.894493156 -0500
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
+index 3ff53a2d4ff0..c83582b5a010 100644
 --- a/arch/x86/Makefile
 +++ b/arch/x86/Makefile
-@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
+@@ -113,7 +113,8 @@ ifeq ($(CONFIG_X86_32),y)
  
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
+index 34eca8015b64..2143358d0c4c 100644
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
+index 0e82074517f6..768076e68668 100644
 --- a/arch/x86/include/asm/asm-prototypes.h
 +++ b/arch/x86/include/asm/asm-prototypes.h
-@@ -20,3 +20,6 @@
+@@ -19,3 +19,6 @@
  extern void cmpxchg8b_emu(void);
  #endif
  
@@ -99,10 +96,10 @@
 +extern unsigned long __ref_stack_chk_guard;
 +#endif
 diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
-index a5f221ea56888..f43bb974fc66d 100644
+index 7a1e58fb43a0..852cc2ab4df9 100644
 --- a/arch/x86/kernel/cpu/common.c
 +++ b/arch/x86/kernel/cpu/common.c
-@@ -2089,8 +2089,10 @@ void syscall_init(void)
+@@ -2159,8 +2159,10 @@ void syscall_init(void)
  
  #ifdef CONFIG_STACKPROTECTOR
  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -114,16 +111,21 @@
  #endif	/* CONFIG_X86_64 */
  
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index b8c5741d2fb48..feb8102a9ca78 100644
+index 54a5596adaa6..60eb8baa44d7 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -491,6 +491,9 @@ SECTIONS
- . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
- 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
+@@ -496,6 +496,9 @@ SECTIONS
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
+base-commit: c1036e4f14d03aba549cdd9b186148d331013056
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

