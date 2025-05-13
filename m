Return-Path: <stable+bounces-144230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0AAB5CB2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE5F867A51
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70AD1E521A;
	Tue, 13 May 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czt50XQp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB9136349
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162145; cv=none; b=UoG8XZcWHz3DenntVLXKemUqnf0V0Koha1IrWfSlo4hHKd6zva8+vafSE3iml/0B9WO1cTN7MDzW8bTAPcAP2n/w2L0HrMrjL53lJoGpLTY67AGpk9n5buoh3gvvw22Z5lQ41vEWshBmNMlCABoDVN6Z9sv39Zws0TFmd18YtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162145; c=relaxed/simple;
	bh=oBJCv/zVwnHSGzZqvP7fEojB2Ak9QBv7a+xCZFc0myk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPsz89/ORFzNo73d4R0T76VNOU/20QdsqCw4ZbVydwVEWPGFSJTrhdYTCYfsw/OxD0xgAEqx8wI4ffeKiWjPo2tgy+W7+7W3iWq6aEOJ+/e+V7K5UtsHbNDxGSY0H1yB6WkYcwnQc/QvIFn1HjdtLmh6a9A2+2CRUegRWCYkdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czt50XQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D99C4CEE4;
	Tue, 13 May 2025 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162145;
	bh=oBJCv/zVwnHSGzZqvP7fEojB2Ak9QBv7a+xCZFc0myk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Czt50XQpx0wUGMBmxmJ8noIRzRzo+blCL9XyEuO+nxg1BaWEKIjp+wLljwB3BBMIi
	 Ay8hUNoOqsRv1M/omnLzIl/2a8EKQXIW3ofwyPWt4HGEIg2zaDOrWtHigTZiYbGsdF
	 YKZHnLoGSgkevmU1r6sVdrgCEJ84bJJZJWOWSBWH+FgrB8PBncFCP2Oz7Sz9aI4RhC
	 9IkT/AZh/DuKccT79d4se5WsMup84lqpX05uP+hxaUnIhnWdxPiBlxr/eKSxnwTRuA
	 AHteyJCPkyc+5ucS70hGSCHGldrj84NPunE8iaBnBAI4NNsHPm2V5xer1Fl6V1yhcX
	 H231FZDuNyiSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 14/14] x86/its: Use dynamic thunks for indirect branches
Date: Tue, 13 May 2025 14:49:01 -0400
Message-Id: <20250513144525-bfa78097e191ffde@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-14-6a536223434d@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 872df34d7c51a79523820ea6a14860398c639b87

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 0177d630dd90)
6.12.y | Present (different SHA1: e730bef9bebb)
6.6.y | Present (different SHA1: 101d064c5817)
6.1.y | Present (different SHA1: bc7ff7035f36)

Note: The patch differs from the upstream commit:
---
1:  872df34d7c51a ! 1:  1160b93e28fe4 x86/its: Use dynamic thunks for indirect branches
    @@ Metadata
      ## Commit message ##
         x86/its: Use dynamic thunks for indirect branches
     
    +    commit 872df34d7c51a79523820ea6a14860398c639b87 upstream.
    +
         ITS mitigation moves the unsafe indirect branches to a safe thunk. This
         could degrade the prediction accuracy as the source address of indirect
         branches becomes same for different execution paths.
    @@ Commit message
         they are both more flexible (got to extend them later) and live in 2M TLBs,
         just like kernel code, avoiding undue TLB pressure.
     
    +      [ pawan: CONFIG_EXECMEM and CONFIG_EXECMEM_ROX are not supported on
    +               backport kernel, made changes to use module_alloc() and
    +               set_memory_*() for dynamic thunks. ]
    +
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
     
    - ## arch/x86/Kconfig ##
    -@@ arch/x86/Kconfig: config MITIGATION_ITS
    - 	bool "Enable Indirect Target Selection mitigation"
    - 	depends on CPU_SUP_INTEL && X86_64
    - 	depends on MITIGATION_RETPOLINE && MITIGATION_RETHUNK
    -+	select EXECMEM
    - 	default y
    - 	help
    - 	  Enable Indirect Target Selection (ITS) mitigation. ITS is a bug in
    -
      ## arch/x86/include/asm/alternative.h ##
    -@@ arch/x86/include/asm/alternative.h: static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
    - }
    - #endif
    +@@ arch/x86/include/asm/alternative.h: extern void apply_returns(s32 *start, s32 *end);
    + 
    + struct module;
      
     +#ifdef CONFIG_MITIGATION_ITS
     +extern void its_init_mod(struct module *mod);
    @@ arch/x86/include/asm/alternative.h: static __always_inline int x86_call_depth_em
     +static inline void its_free_mod(struct module *mod) { }
     +#endif
     +
    - #if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
    + #ifdef CONFIG_RETHUNK
      extern bool cpu_wants_rethunk(void);
      extern bool cpu_wants_rethunk_at(void *addr);
     
    @@ arch/x86/kernel/alternative.c
      #include <linux/mmu_context.h>
      #include <linux/bsearch.h>
      #include <linux/sync_core.h>
    -+#include <linux/execmem.h>
    ++#include <linux/moduleloader.h>
      #include <asm/text-patching.h>
      #include <asm/alternative.h>
      #include <asm/sections.h>
     @@
    + #include <asm/fixmap.h>
    + #include <asm/paravirt.h>
      #include <asm/asm-prototypes.h>
    - #include <asm/cfi.h>
    - #include <asm/ibt.h>
     +#include <asm/set_memory.h>
      
      int __read_mostly alternatives_patched;
      
    -@@ arch/x86/kernel/alternative.c: const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
    - #endif
    - };
    +@@ arch/x86/kernel/alternative.c: static int emit_indirect(int op, int reg, u8 *bytes)
    + 
    + #ifdef CONFIG_MITIGATION_ITS
      
    -+#ifdef CONFIG_MITIGATION_ITS
    -+
     +static struct module *its_mod;
     +static void *its_page;
     +static unsigned int its_offset;
    @@ arch/x86/kernel/alternative.c: const unsigned char * const x86_nops[ASM_NOP_MAX+
     +
     +void its_fini_mod(struct module *mod)
     +{
    ++	int i;
    ++
     +	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
     +		return;
     +
    @@ arch/x86/kernel/alternative.c: const unsigned char * const x86_nops[ASM_NOP_MAX+
     +	its_page = NULL;
     +	mutex_unlock(&text_mutex);
     +
    -+	for (int i = 0; i < mod->its_num_pages; i++) {
    ++	for (i = 0; i < mod->its_num_pages; i++) {
     +		void *page = mod->its_page_array[i];
    -+		execmem_restore_rox(page, PAGE_SIZE);
    ++		set_memory_ro((unsigned long)page, 1);
    ++		set_memory_x((unsigned long)page, 1);
     +	}
     +}
     +
     +void its_free_mod(struct module *mod)
     +{
    ++	int i;
    ++
     +	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
     +		return;
     +
    -+	for (int i = 0; i < mod->its_num_pages; i++) {
    ++	for (i = 0; i < mod->its_num_pages; i++) {
     +		void *page = mod->its_page_array[i];
    -+		execmem_free(page);
    ++		module_memfree(page);
     +	}
     +	kfree(mod->its_page_array);
     +}
     +
     +static void *its_alloc(void)
     +{
    -+	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
    ++	void *page = module_alloc(PAGE_SIZE);
     +
     +	if (!page)
     +		return NULL;
    @@ arch/x86/kernel/alternative.c: const unsigned char * const x86_nops[ASM_NOP_MAX+
     +		void *tmp = krealloc(its_mod->its_page_array,
     +				     (its_mod->its_num_pages+1) * sizeof(void *),
     +				     GFP_KERNEL);
    -+		if (!tmp)
    ++		if (!tmp) {
    ++			module_memfree(page);
     +			return NULL;
    ++		}
     +
     +		its_mod->its_page_array = tmp;
     +		its_mod->its_page_array[its_mod->its_num_pages++] = page;
    -+
    -+		execmem_make_temp_rw(page, PAGE_SIZE);
     +	}
     +
    -+	return no_free_ptr(page);
    ++	return page;
     +}
     +
     +static void *its_allocate_thunk(int reg)
    @@ arch/x86/kernel/alternative.c: const unsigned char * const x86_nops[ASM_NOP_MAX+
     +	thunk = its_page + its_offset;
     +	its_offset += size;
     +
    -+	return its_init_thunk(thunk, reg);
    -+}
    ++	set_memory_rw((unsigned long)its_page, 1);
    ++	thunk = its_init_thunk(thunk, reg);
    ++	set_memory_ro((unsigned long)its_page, 1);
    ++	set_memory_x((unsigned long)its_page, 1);
     +
    -+#endif
    ++	return thunk;
    ++}
     +
    - /*
    -  * Nomenclature for variable names to simplify and clarify this code and ease
    -  * any potential staring at it:
    -@@ arch/x86/kernel/alternative.c: static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
    - #ifdef CONFIG_MITIGATION_ITS
    + static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
    + 			     void *call_dest, void *jmp_dest)
    + {
    +@@ arch/x86/kernel/alternative.c: static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
    + 
      static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
      {
     -	return __emit_trampoline(addr, insn, bytes,
    @@ arch/x86/kernel/alternative.c: static int emit_call_track_retpoline(void *addr,
     
      ## arch/x86/kernel/module.c ##
     @@ arch/x86/kernel/module.c: int module_finalize(const Elf_Ehdr *hdr,
    - 			ibt_endbr = s;
    + 		void *pseg = (void *)para->sh_addr;
    + 		apply_paravirt(pseg, pseg + para->sh_size);
      	}
    - 
    ++
     +	its_init_mod(me);
     +
    - 	if (retpolines || cfi) {
    - 		void *rseg = NULL, *cseg = NULL;
    - 		unsigned int rsize = 0, csize = 0;
    -@@ arch/x86/kernel/module.c: int module_finalize(const Elf_Ehdr *hdr,
    + 	if (retpolines) {
      		void *rseg = (void *)retpolines->sh_addr;
      		apply_retpolines(rseg, rseg + retpolines->sh_size);
      	}
    @@ arch/x86/kernel/module.c: int module_finalize(const Elf_Ehdr *hdr,
     +	its_free_mod(mod);
      }
     
    - ## include/linux/execmem.h ##
    -@@
    - 
    - #include <linux/types.h>
    - #include <linux/moduleloader.h>
    -+#include <linux/cleanup.h>
    - 
    - #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
    - 		!defined(CONFIG_KASAN_VMALLOC)
    -@@ include/linux/execmem.h: void *execmem_alloc(enum execmem_type type, size_t size);
    -  */
    - void execmem_free(void *ptr);
    - 
    -+DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
    -+
    - #ifdef CONFIG_MMU
    - /**
    -  * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
    -
      ## include/linux/module.h ##
     @@ include/linux/module.h: struct module {
      	atomic_t refcnt;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

