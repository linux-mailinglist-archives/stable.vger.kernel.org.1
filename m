Return-Path: <stable+bounces-94543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B89D50D1
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21573283E8F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB21487A7;
	Thu, 21 Nov 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaC/tpEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51B41C79
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207396; cv=none; b=XYJAw6NZ1yhhzGJGnQcOaQaj8Co0GQjJ0P97w2hwYyvyxC1Yd58chpEyef/dXida/+5rgp677vy9dc3inmEfdIBTCRLXYGHqt2S/g3F8VgRG5VYmu/iQDOXfum7Ef1hsfB/DwgTRwe8v6Ew3082AMmFJBPK00Ue1djir3qqJy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207396; c=relaxed/simple;
	bh=gvf7E04oFlud91ndKYNTnJ28ItpiGUmxeLCAStNR1gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns328h7IGkA6CjS2+NlfI4PmPZEBDkfa2O26Wka3aMt8udCZd+orqu8s3NXBgypfzNM1xfAUwAkqpBuvAAjWSBGMJDgWKU+MrD315IAWdziRW10xlO5AulzvS7tL8fC8V733ZLs9WmCLbaDOSwvcw3M8gscBs90TP791tApkWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaC/tpEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CBAC4CECC;
	Thu, 21 Nov 2024 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207396;
	bh=gvf7E04oFlud91ndKYNTnJ28ItpiGUmxeLCAStNR1gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaC/tpEOG85JrFmc9WwJXXd9SjvTiXZH+lyK57h1K2yi6qVvJPoQju6f/Iv88tde/
	 JmMXy3LD1ET7NBji1jxHWBXdrTFYRMHahjPtJMBFodURImkwjMayoLQ8BD7uh3inK9
	 YtoZhzcrhY2t41BoPt2JDjh5cyTCRWomxjLRbhHqagAS7ZZ6gstYanMLG27nvFH9vJ
	 fIm4TmUziLTwzsWpFlBcxRUa49j0QF6iQsjsUBGPItakJEp5b6mnecosfBnv/Wwc9m
	 QaBiUjNsS768sj7nYwd9sxq908PVrvTmtX8Dkj/lQ4kJnnJrbGQAbDOxrs1inN9Jiv
	 CgVBUrok26sXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] x86/stackprotector: Work around strict Clang TLS symbol requirements
Date: Thu, 21 Nov 2024 11:43:14 -0500
Message-ID: <20241121113759-bfbd60f09616737f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121142954.3564808-1-brgerst@gmail.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 11:36:31.477986014 -0500
+++ /tmp/tmp.Ilo61KBJEG	2024-11-21 11:36:31.470932303 -0500
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
+index 8b9fa777f513..dcd8c6f676ca 100644
 --- a/arch/x86/Makefile
 +++ b/arch/x86/Makefile
-@@ -142,9 +142,10 @@ ifeq ($(CONFIG_X86_32),y)
+@@ -90,7 +90,8 @@ ifeq ($(CONFIG_X86_32),y)
  
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
+index bdcf1e9375ee..f8e5598408bf 100644
 --- a/arch/x86/kernel/cpu/common.c
 +++ b/arch/x86/kernel/cpu/common.c
-@@ -2089,8 +2089,10 @@ void syscall_init(void)
+@@ -1974,8 +1974,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
  
  #ifdef CONFIG_STACKPROTECTOR
  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -114,16 +111,21 @@
  #endif	/* CONFIG_X86_64 */
  
 diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
-index b8c5741d2fb48..feb8102a9ca78 100644
+index 740f87d8aa48..60fb61dffe98 100644
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
+ #ifdef CONFIG_X86_32
  /*
-  * Per-cpu symbols which need to be offset from __per_cpu_load
+  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
+
+base-commit: 711d99f845cdb587b7d7cf5e56c289c3d96d27c5
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    In file included from ./include/linux/mm.h:30,
                     from ./include/linux/pagemap.h:8,
                     from ./include/linux/buffer_head.h:14,
                     from fs/udf/udfdecl.h:12,
                     from fs/udf/super.c:41:
    fs/udf/super.c: In function 'udf_fill_partdesc_info':
    ./include/linux/overflow.h:70:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       70 |         (void) (&__a == &__b);                  \
          |                      ^~
    fs/udf/super.c:1155:21: note: in expansion of macro 'check_add_overflow'
     1155 |                 if (check_add_overflow(map->s_partition_len,
          |                     ^~~~~~~~~~~~~~~~~~

