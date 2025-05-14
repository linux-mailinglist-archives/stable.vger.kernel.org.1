Return-Path: <stable+bounces-144327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E826AB62C6
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF02860A1B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24B1F428C;
	Wed, 14 May 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsWUTaU7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5831F5E6
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203019; cv=none; b=bm8dOp6qLqpv2e87m4bdk2dSftA/VD6N7H5Z1zDU/DKP0zfWv4WHHmS1BFMk9BMFJAeBmOPoC6mEXjoIukmgZSxdmkZdUQmG6Wa1h/Nf99jcYt0yg5QRTp2lfv0I6Th55nKFxPin+JGAcrIxTMeySerdKwoEOAgP+zXShI4RJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203019; c=relaxed/simple;
	bh=IJOqEn0K5+Hwu+RAQ4qWqkOCtGbhzsRfq1cSi7XcUHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbIytT9DEv7A8Mtmm3wjd9ucVhMqmji/vjUG7hsIegfujHVHRqQTEEItu7JIiI6RX1UJT9fg4h1XZEef4WCrJJkUceHKfqxKLdVn6sGpt7CTZPZHaxDRuIe3IMCY+8m93lGGNHmfs9JyRf8AEDLmqBdSGNPePtseFapU2VNjJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsWUTaU7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747203018; x=1778739018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJOqEn0K5+Hwu+RAQ4qWqkOCtGbhzsRfq1cSi7XcUHI=;
  b=QsWUTaU77NURsJ88tY0eq6EgthMtiLyV+YSSbn9erCe9KQ+LZjXCMubF
   WpGo4w9lTvBVfHDihuzVj7tjr220DfcFL5nDfqe4NocyMHmtk6XcO3mlt
   KVZOb/6dHoN09QVTDurHS9YClqCvs70N3DMsMNa/bAiAkRXiVG6x4nM3i
   BT04ZviVKIdVWgnc1sbvglwjmD+w4FYJCzsxR+P2tFDHgnSVR+5K/TRuQ
   oClStwbBbv9LRW8YzK8YvFbwqUesp8vVwFZCXBPFrFz9+uyhyBJk1KzVT
   s6smebTqUE3mbtTL+KE2LoVLy/0wjX5B1b96O52RlyQlM1vnnnpomZrAX
   A==;
X-CSE-ConnectionGUID: EaF8kscjQGu8Km14qWtpJg==
X-CSE-MsgGUID: 9XKpah1WQp+5oMZFlHgEkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48191066"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="48191066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:10:17 -0700
X-CSE-ConnectionGUID: i7/lyyIRSQ+nCraJndMaog==
X-CSE-MsgGUID: FYD/qwNyR/OPJ1UdINygRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137982326"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:10:17 -0700
Date: Tue, 13 May 2025 23:10:16 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v2 14/14] x86/its: Use dynamic thunks for indirect
 branches
Message-ID: <20250513-its-5-15-v2-14-90690efdc7e0@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>

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
---
 arch/x86/include/asm/alternative.h |  10 +++
 arch/x86/kernel/alternative.c      | 133 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |   7 ++
 include/linux/module.h             |   5 ++
 4 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4038b893449a7d38f4079e213a924493e67f4231..aa7b155b617343b3a508eb0039c81562aba53dfd 100644
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
 #ifdef CONFIG_RETHUNK
 extern bool cpu_wants_rethunk(void);
 extern bool cpu_wants_rethunk_at(void *addr);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c3df557be55e37e256d05a83f55e4ebfdee9d451..7f5bed8753d658393278a7e28fc9217f2036cf3a 100644
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
@@ -30,6 +31,7 @@
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
 #include <asm/asm-prototypes.h>
+#include <asm/set_memory.h>
 
 int __read_mostly alternatives_patched;
 
@@ -397,6 +399,127 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
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
@@ -444,9 +567,13 @@ static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
 
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
index 06b53ea940bf604e94e3f55d6dd6316ceb9ed3f7..183b8d541b5448b50ba91a22ea0db283efda3dc9 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -283,10 +283,16 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *pseg = (void *)para->sh_addr;
 		apply_paravirt(pseg, pseg + para->sh_size);
 	}
+
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
@@ -317,4 +323,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 void module_arch_cleanup(struct module *mod)
 {
 	alternatives_smp_module_del(mod);
+	its_free_mod(mod);
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index fb9762e16f2858e070773893495ffbbefa50e7d4..8e629b03ed1e4181d7a30d3528f21dbc7b112825 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -528,6 +528,11 @@ struct module {
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



