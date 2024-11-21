Return-Path: <stable+bounces-94542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BD59D50D0
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841E51F22D34
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC8719E7D1;
	Thu, 21 Nov 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+IFGHk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408941C79
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207393; cv=none; b=PRybEjxUCmOvu5raYsSFloHwzmRkBZGNotp7rweHf5zZXyygIwoJ8OXvHAzwGQPGL9G+KBkgTs17dEDWWyG0Lr4ocdODOUX0EFj33Rvwd16Gq3g6j0PUzyyxmmb0CXfuOPXN1TTok2KkUVJGJWoJutap/xoE7XttvIphfuQjSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207393; c=relaxed/simple;
	bh=XC5VLIsfdmnu2hWB4GsrRt1MjGSNUIQGNauc6J9Xf/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlJn0oyVdJSm0RHMS90A6y4YyslxmBBtND5R2kwEPRUYRweEyDN2iwzlajGBMP38iAAHVFsO2viPC4g7n4JKnORSHOUiebAXlYicBkIzRGP8ec66LRNv5jwXshjCXAihrM8/cSVgdjRjmHukriQgRvDT54sx8kv+5fkYRWYqnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+IFGHk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27012C4CECC;
	Thu, 21 Nov 2024 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207393;
	bh=XC5VLIsfdmnu2hWB4GsrRt1MjGSNUIQGNauc6J9Xf/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+IFGHk7rFihJdPJ+xo1jhi+AoXWXKqNfuxMTshKFpodr/I+euYFd+wMiief5RbZk
	 +XenrCbpB+sm1UVrfyPzFQ8kSCEmi1823AjJxd2JrWy4Bz7KbWmB2Iw0Qouz5FARHQ
	 RCRqb+6H9sOaneZc0xOdfV4F5073qC8nRXg/3guw7cCBk0Ss6tIWJn7NzCLycwuHCY
	 LnzxjUk2BtmPNp+lI/QJBmZlhMfRZFd1S+pRZjp0LQpoNUj8/w7Q/Y8kxev4GJp6V/
	 xQ0eCmW4+rj+rKhTnsNINn3Dfr4yV8jnB6KX/WnUGTiIz6cSd912GPwfRfGvjp5AkU
	 ZprKx7fAV6bFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 11:43:11 -0500
Message-ID: <20241121113219-34a471134e9afcb2@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121150337.3667598-1-brgerst@gmail.com>
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

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 11:28:15.623532559 -0500
+++ /tmp/tmp.nNyuaQrZAT	2024-11-21 11:28:15.614010384 -0500
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
+index 3419ffa2a350..a88eede6e7db 100644
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
+index 7f922a359ccc..b4e999048e9a 100644
 --- a/arch/x86/kernel/cpu/common.c
 +++ b/arch/x86/kernel/cpu/common.c
-@@ -2089,8 +2089,10 @@ void syscall_init(void)
+@@ -2158,8 +2158,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
  
  #ifdef CONFIG_STACKPROTECTOR
  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -114,16 +111,21 @@
  #endif	/* CONFIG_X86_64 */
  
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index b8c5741d2fb48..feb8102a9ca78 100644
+index 78ccb5ec3c0e..c1e776ed71b0 100644
 --- a/arch/x86/kernel/vmlinux.lds.S
 +++ b/arch/x86/kernel/vmlinux.lds.S
-@@ -491,6 +491,9 @@ SECTIONS
- . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
- 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
+@@ -486,6 +486,9 @@ SECTIONS
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
+base-commit: b67dc5c9ade9dc354b790eb64aa6a665d0a54ecd
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

