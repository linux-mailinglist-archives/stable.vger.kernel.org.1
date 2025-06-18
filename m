Return-Path: <stable+bounces-154615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16674ADE037
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592BF189B10A
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41B208A7;
	Wed, 18 Jun 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crXuo0LA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF129A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207663; cv=none; b=OD/3eGWQi9h7VKl1rLVAwbnhLYDNg5EE+jmL1qLfgy5pqUvgzupFquby0JP6lwCZSDhqxH6hPNgMO1AU8R12ALD5ZetUjkLHosF2fJVt7VvnAFWut4/mlYLtll8n66tg7D/VGzUDS3XY0gr1ljG8QFwlMA5DCzNsL79kO3SeW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207663; c=relaxed/simple;
	bh=heStEwD6aJeJgUcyVS0RIXNto/RmXZlgLzVCXooufew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXr6MPxc+lF8tPr4o+I+zYSPuDhM4f4IKtghn8pYYJUgr3rLjrFPY0BRfLWgyANhpZGJ/i3NPabypCoUAi5OO5AsgmBDeG7rUuBdcNOQnAes5w8M/hw38YjfWQ9BGCD9xT9RUgZ9zG0VIc9o3MPWJ11gdU1m/FEUETuDyCaAqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crXuo0LA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207661; x=1781743661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=heStEwD6aJeJgUcyVS0RIXNto/RmXZlgLzVCXooufew=;
  b=crXuo0LAgzvwwNNisj09M2tHmEPjxbwrtbxivZqxoUuogJd0rHStI3TG
   69MFq2cmF0Gmt17gr5pxLcd2Fz7U3H+xwDPkHY68+RMqhxqHgCc6Jy+At
   7dwbMPKi/k+mWSJO75PIBZYEKF/B7csVmtQELrhZD+W9xd8H1ebN09OTv
   OpdbQv7bQ131x+Fh5kpaEpeN9QmGG0h/hMVLYpUqGRilUbTQWYaTbOvA1
   bJvuDpOhG/zf0+NYSLWDiiYWzqhlRbWN2URLc9eK8hcfWrhVfWUv8Tync
   7SUUEmrhCkRtEbD+mG39+lkEN3y2/qeUnKJlw0oUSEKk+mWX+qf82K03C
   Q==;
X-CSE-ConnectionGUID: zJNmVxBBRR2WgGL13kgOBQ==
X-CSE-MsgGUID: QtZ3ILWvT1yCqZ0uK5Q4xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52491213"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52491213"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:41 -0700
X-CSE-ConnectionGUID: SQc/eqvqQi6c2hzMlUFWqQ==
X-CSE-MsgGUID: 9q/Fr9TwSPWPm/4uzo8Wcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="154482460"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:41 -0700
Date: Tue, 17 Jun 2025 17:47:41 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.10 v2 14/16] x86/its: Use dynamic thunks for indirect
 branches
Message-ID: <20250617-its-5-10-v2-14-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

From: Peter Zijlstra <peterz@infradead.org>

commit 872df34d7c51a79523820ea6a14860398c639b87 upstream.

ITS mitigation moves the unsafe indirect branches to a safe thunk. This
could degrade the prediction accuracy as the source address of indirect
branches becomes same for different execution paths.

To improve the predictions, and hence the performance, assign a separate
thunk for each indirect callsite. This is also a defense-in-depth measure
to avoid indirect branches aliasing with each other.

As an example, 5000 dynamic thunks would utilize around 16 bits of the
address space, thereby gaining entropy. For a BTB that uses
32 bits for indexing, dynamic thunks could provide better prediction
accuracy over fixed thunks.

Have ITS thunks be variable sized and use EXECMEM_MODULE_TEXT such that
they are both more flexible (got to extend them later) and live in 2M TLBs,
just like kernel code, avoiding undue TLB pressure.

  [ pawan: CONFIG_EXECMEM and CONFIG_EXECMEM_ROX are not supported on
	   backport kernel, made changes to use module_alloc() and
	   set_memory_*() for dynamic thunks. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/alternative.h |  10 +++
 arch/x86/kernel/alternative.c      | 133 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |   6 ++
 include/linux/module.h             |   5 ++
 4 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4b9a2842f90e..4ab021fd3887 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -80,6 +80,16 @@ extern void apply_returns(s32 *start, s32 *end);
 
 struct module;
 
+#ifdef CONFIG_MITIGATION_ITS
+extern void its_init_mod(struct module *mod);
+extern void its_fini_mod(struct module *mod);
+extern void its_free_mod(struct module *mod);
+#else /* CONFIG_MITIGATION_ITS */
+static inline void its_init_mod(struct module *mod) { }
+static inline void its_fini_mod(struct module *mod) { }
+static inline void its_free_mod(struct module *mod) { }
+#endif
+
 #if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
 extern bool cpu_wants_rethunk(void);
 extern bool cpu_wants_rethunk_at(void *addr);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ae4a6bc25b29..33d17fe84182 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,6 +18,7 @@
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
 #include <linux/sync_core.h>
+#include <linux/moduleloader.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -29,6 +30,7 @@
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/asm-prototypes.h>
+#include <asm/set_memory.h>
 
 int __read_mostly alternatives_patched;
 
@@ -552,6 +554,127 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
 #ifdef CONFIG_MITIGATION_ITS
 
+static struct module *its_mod;
+static void *its_page;
+static unsigned int its_offset;
+
+/* Initialize a thunk with the "jmp *reg; int3" instructions. */
+static void *its_init_thunk(void *thunk, int reg)
+{
+	u8 *bytes = thunk;
+	int i = 0;
+
+	if (reg >= 8) {
+		bytes[i++] = 0x41; /* REX.B prefix */
+		reg -= 8;
+	}
+	bytes[i++] = 0xff;
+	bytes[i++] = 0xe0 + reg; /* jmp *reg */
+	bytes[i++] = 0xcc;
+
+	return thunk;
+}
+
+void its_init_mod(struct module *mod)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	mutex_lock(&text_mutex);
+	its_mod = mod;
+	its_page = NULL;
+}
+
+void its_fini_mod(struct module *mod)
+{
+	int i;
+
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	WARN_ON_ONCE(its_mod != mod);
+
+	its_mod = NULL;
+	its_page = NULL;
+	mutex_unlock(&text_mutex);
+
+	for (i = 0; i < mod->its_num_pages; i++) {
+		void *page = mod->its_page_array[i];
+		set_memory_ro((unsigned long)page, 1);
+		set_memory_x((unsigned long)page, 1);
+	}
+}
+
+void its_free_mod(struct module *mod)
+{
+	int i;
+
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	for (i = 0; i < mod->its_num_pages; i++) {
+		void *page = mod->its_page_array[i];
+		module_memfree(page);
+	}
+	kfree(mod->its_page_array);
+}
+
+static void *its_alloc(void)
+{
+	void *page = module_alloc(PAGE_SIZE);
+
+	if (!page)
+		return NULL;
+
+	if (its_mod) {
+		void *tmp = krealloc(its_mod->its_page_array,
+				     (its_mod->its_num_pages+1) * sizeof(void *),
+				     GFP_KERNEL);
+		if (!tmp) {
+			module_memfree(page);
+			return NULL;
+		}
+
+		its_mod->its_page_array = tmp;
+		its_mod->its_page_array[its_mod->its_num_pages++] = page;
+	}
+
+	return page;
+}
+
+static void *its_allocate_thunk(int reg)
+{
+	int size = 3 + (reg / 8);
+	void *thunk;
+
+	if (!its_page || (its_offset + size - 1) >= PAGE_SIZE) {
+		its_page = its_alloc();
+		if (!its_page) {
+			pr_err("ITS page allocation failed\n");
+			return NULL;
+		}
+		memset(its_page, INT3_INSN_OPCODE, PAGE_SIZE);
+		its_offset = 32;
+	}
+
+	/*
+	 * If the indirect branch instruction will be in the lower half
+	 * of a cacheline, then update the offset to reach the upper half.
+	 */
+	if ((its_offset + size - 1) % 64 < 32)
+		its_offset = ((its_offset - 1) | 0x3F) + 33;
+
+	thunk = its_page + its_offset;
+	its_offset += size;
+
+	set_memory_rw((unsigned long)its_page, 1);
+	thunk = its_init_thunk(thunk, reg);
+	set_memory_ro((unsigned long)its_page, 1);
+	set_memory_x((unsigned long)its_page, 1);
+
+	return thunk;
+}
+
 static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
 			     void *call_dest, void *jmp_dest)
 {
@@ -599,9 +722,13 @@ static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
 
 static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
 {
-	return __emit_trampoline(addr, insn, bytes,
-				 __x86_indirect_its_thunk_array[reg],
-				 __x86_indirect_its_thunk_array[reg]);
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+	u8 *tmp = its_allocate_thunk(reg);
+
+	if (tmp)
+		thunk = tmp;
+
+	return __emit_trampoline(addr, insn, bytes, thunk, thunk);
 }
 
 /* Check if an indirect branch is at ITS-unsafe address */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index e28c701e8f8b..1ab8e583c795 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -274,10 +274,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 			returns = s;
 	}
 
+	its_init_mod(me);
+
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
 		apply_retpolines(rseg, rseg + retpolines->sh_size);
 	}
+
+	its_fini_mod(me);
+
 	if (returns) {
 		void *rseg = (void *)returns->sh_addr;
 		apply_returns(rseg, rseg + returns->sh_size);
@@ -313,4 +318,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 void module_arch_cleanup(struct module *mod)
 {
 	alternatives_smp_module_del(mod);
+	its_free_mod(mod);
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index 63fe94e6ae6f..f5a150c42918 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -524,6 +524,11 @@ struct module {
 	atomic_t refcnt;
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+	int its_num_pages;
+	void **its_page_array;
+#endif
+
 #ifdef CONFIG_CONSTRUCTORS
 	/* Constructor functions. */
 	ctor_fn_t *ctors;

-- 
2.43.0



