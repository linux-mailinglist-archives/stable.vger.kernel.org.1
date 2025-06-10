Return-Path: <stable+bounces-152338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C744EAD4314
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FABF3A4473
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7E264634;
	Tue, 10 Jun 2025 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JG7BxJl2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C48264A6D
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584642; cv=none; b=kQ0Nx1R+4A2vTslZ4u4WebXn3GLDx+gsZPGYQmkL3/+fERuTPTZ6Xq3aNUu5tXxas5JuX1a8sZzy994fvgsnegGXufa51n5MdQE32lWoz8UmDFrVNSHc/oEtaIa5oDHtGzeS5ODSmSY+bj5i2eUVKTMJgekYEYCpXfinxR/GAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584642; c=relaxed/simple;
	bh=wk6/CEZ7mcS1GQE6DzYLMb8MFCnBv3vqQFF0Ufl/edI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBLEP+y2XTQiiiN82SbFUjrROijjcag1KcuguczbU+AYZWGWC1O3UuQ6u+Y3ysr0TNx6w91L2ERFoDFhHIrQa3rOcye6M0zcVp6aUYMHBODiV2xbHumjZ+x+9CNMAfKv++2N3OpPepJeeAmHL2FegPVOeJpnQGFxGAV7/4tPC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JG7BxJl2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584641; x=1781120641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wk6/CEZ7mcS1GQE6DzYLMb8MFCnBv3vqQFF0Ufl/edI=;
  b=JG7BxJl2hmVOBj6QfBeXw0ZcI5wcS2NsrZQeKThdl5Ax8BeWyMKLvPrv
   53zs1dOGmcw0yhvFurDNCBx2GGoC/ARd3j8KQNhO5eyGjAAt8PLxym1e9
   /9b4juttrPfU1TV5AugK1IEl9adoXZ+79SjQ+4Kgk0GtUeIOHvO2RhzFo
   j6THhJVDwQE+QuH9rkFLf/H4ABGwC1vr9+6uiE6fhVtOhrmBXKPP4VMLR
   3TjYWvUuvvnTSw7NWjY6fm7zfFvzqrmro2rsJE79VPC96mydZv9Gw/Y6o
   1+PvOeotwf2odQm0PqKvX0rljsY4pbEHgEjz4jogYXyNwtyhP3RubVKUA
   A==;
X-CSE-ConnectionGUID: kRBr0I6vTGK8zj3NF/sI7Q==
X-CSE-MsgGUID: 78nskAIjTKOPW59KgGydNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51703476"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51703476"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:44:00 -0700
X-CSE-ConnectionGUID: /GcgxdddRdWvBe9Thms2rw==
X-CSE-MsgGUID: criqBXU2TXW2othQl3eiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146859225"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:44:00 -0700
Date: Tue, 10 Jun 2025 12:43:58 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5.10 14/16] x86/its: Use dynamic thunks for indirect
 branches
Message-ID: <20250610-its-5-10-v1-14-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/alternative.h |  10 +++
 arch/x86/kernel/alternative.c      | 133 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |   6 ++
 include/linux/module.h             |   5 ++
 4 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4b9a2842f90e972a5569a363479c5885bd919287..4ab021fd3887211723e0bf0f68683e713f260f07 100644
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
index ae4a6bc25b29c19842dd281d041fb23cb5ba5a75..33d17fe841828738ee248e3c2dbd2693ffd33672 100644
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
index e28c701e8f8b0f09324dc7af7f27e66e2c5482e0..1ab8e583c795d16d00535d4e5f56e494ea8e32a1 100644
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
index 63fe94e6ae6f19a0d340aefdb31e3791c9df325c..f5a150c42918c63ff563038b521c9506d8b415a2 100644
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
2.34.1



