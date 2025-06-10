Return-Path: <stable+bounces-152333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41380AD4306
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EB11897950
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B84264A83;
	Tue, 10 Jun 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJN/Z3Cp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88426462E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584562; cv=none; b=CrrxHGc/+9D9oONGy0akDJjx54tW0lnib3rTZrj0OOdOopD1tn2aNsE6e07Oa6+zkEDj+SbAWgcMoHzbfpk2wh2jTwLlsS1vp1PPJAb1MhrGS0PXUQuIMSk9lXk1A5YMrHGgOEYo4lNbZfwoBussTQL4+QERfDCpolKFS5EiOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584562; c=relaxed/simple;
	bh=KTnH67b606RjrMxD+cc/9fJJkHlf3TV+iT6W5NZ+SEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALRVDdvb1uX8SeS5SOqnWNVcfk7Bij1ngjOvWXS2SD8CaAJ70T6+RHkngT71IlvB6I+UJfzgx5ao2gnvY0W7hDc14aSrquDfMklTw3pucsPKnsKO+JJzRfw0CdDcHgCQOzVUajWI990sy58PomD1DgHQMzQoqVAKtFHX62EMrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJN/Z3Cp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584561; x=1781120561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTnH67b606RjrMxD+cc/9fJJkHlf3TV+iT6W5NZ+SEc=;
  b=nJN/Z3Cp/+h+Lii5Y6asJG/8IdD+vONQ9ptxz6HqBBtPo1O87ev2a4hH
   iw/XZPrAkETJ8vBO+CwiNpqQTiNVdRZPaVzG08EefZAaFB69nfESZyfO+
   n0kesKZLWYLLGMU7GfTVWkUgxfBk7zwgALr75VhV271flOlI/9lQSVfkJ
   XnRi6LdbeG6i8FtSInyVdPigxTbyA/Y4vxrr4QSXKtK4vcmWUFiD4IYzh
   +Yx4s5tyZPbzPXq+87wvgCUFnP7W7HB96iVtPoDLF35CBcVE22IvET+um
   9wzJ7bq8WCrjLImZgbRHyuPnQNt9By0rtb7Q446viF9f24W1BMr2FQp3M
   w==;
X-CSE-ConnectionGUID: bvFkFL0dT6uLhD7KEZteRA==
X-CSE-MsgGUID: HlrCuGfQSlWFitWcnfMnnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55375217"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="55375217"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:40 -0700
X-CSE-ConnectionGUID: OK/mZSTdSXSgIYM7RUxbXg==
X-CSE-MsgGUID: keHaJlMXRUuk6HCEpAn5mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="152181388"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:41 -0700
Date: Tue, 10 Jun 2025 12:42:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5.10 09/16] x86/its: Add support for ITS-safe return thunk
Message-ID: <20250610-its-5-10-v1-9-64f0ae98c98d@linux.intel.com>
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

commit a75bf27fe41abe658c53276a0c486c4bf9adecfc upstream.

RETs in the lower half of cacheline may be affected by ITS bug,
specifically when the RSB-underflows. Use ITS-safe return thunk for such
RETs.

RETs that are not patched:

- RET in retpoline sequence does not need to be patched, because the
  sequence itself fills an RSB before RET.
- RETs in .init section are not reachable after init.
- RETs that are explicitly marked safe with ANNOTATE_UNRET_SAFE.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/alternative.h   | 14 ++++++++++++++
 arch/x86/include/asm/nospec-branch.h |  6 ++++++
 arch/x86/kernel/alternative.c        | 17 ++++++++++++++++-
 arch/x86/kernel/ftrace.c             |  2 +-
 arch/x86/kernel/static_call.c        |  2 +-
 arch/x86/kernel/vmlinux.lds.S        |  2 ++
 arch/x86/lib/retpoline.S             | 13 ++++++++++++-
 arch/x86/net/bpf_jit_comp.c          |  2 +-
 8 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0e777b27972be34ceecafb5437302e649d36aaee..d7f33c1e052b7724db10fe23c1dfc63ab09dd2c9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -80,6 +80,20 @@ extern void apply_returns(s32 *start, s32 *end);
 
 struct module;
 
+#ifdef CONFIG_RETHUNK
+extern bool cpu_wants_rethunk(void);
+extern bool cpu_wants_rethunk_at(void *addr);
+#else
+static __always_inline bool cpu_wants_rethunk(void)
+{
+	return false;
+}
+static __always_inline bool cpu_wants_rethunk_at(void *addr)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
 					void *locks, void *locks_end,
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4cc0ee529325e62d5b30f171933b47f31ff14a92..7ccaefaa16a683110e58c58c7a22926e2191965f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -226,6 +226,12 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+extern void its_return_thunk(void);
+#else
+static inline void its_return_thunk(void) {}
+#endif
+
 extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3102e7cf6a48375a2216303b0e1769532ed37270..ae4a6bc25b29c19842dd281d041fb23cb5ba5a75 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -760,6 +760,21 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 
 #ifdef CONFIG_RETHUNK
 
+bool cpu_wants_rethunk(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_RETHUNK);
+}
+
+bool cpu_wants_rethunk_at(void *addr)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		return false;
+	if (x86_return_thunk != its_return_thunk)
+		return true;
+
+	return !((unsigned long)addr & 0x20);
+}
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -776,7 +791,7 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	int i = 0;
 
 	/* Patch the custom return thunks... */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk_at(addr)) {
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 46447877b59419984581a294b637fb99c8c781c4..fba03ad16cceb1e17a64559989660327ce09a866 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -367,7 +367,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		goto fail;
 
 	ip = trampoline + size;
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+	if (cpu_wants_rethunk_at(ip))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 4544f124bbd4d6b1bc7ada65e0122b891640fa9d..42564d29eb1bacdd1e11ccca1c0cb14b8c4e10b2 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,7 +41,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		break;
 
 	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		if (cpu_wants_rethunk_at(insn))
 			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6cee70927281f30871cb5a9680d11c5bf44b4156..1f77896515c5230f738b9637ea5c5920bd58a623 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -542,6 +542,8 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT(__x86_indirect_its_thunk_rax & 0x20, "__x86_indirect_thunk_rax not in second half of cacheline");
 . = ASSERT(((__x86_indirect_its_thunk_rcx - __x86_indirect_its_thunk_rax) % 64) == 0, "Indirect thunks are not cacheline apart");
 . = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
+
+. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
 #endif
 
 #endif /* CONFIG_X86_32 */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 9bde4e9d8c2a36bfa2bc804efefefe10ffd5eae7..01fcf0cd679bd65f509c2ae8e334572c42f7e77b 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -281,7 +281,18 @@ SYM_CODE_START(__x86_indirect_its_thunk_array)
 	.align 64, 0xcc
 SYM_CODE_END(__x86_indirect_its_thunk_array)
 
-#endif
+.align 64, 0xcc
+.skip 32, 0xcc
+SYM_CODE_START(its_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_CODE_END(its_return_thunk)
+EXPORT_SYMBOL(its_return_thunk)
+
+#endif /* CONFIG_MITIGATION_ITS */
 
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6225e8a8349f76bb8d62bb5613823bc083ffaf4b..c322702126407e4102cbd0a874264dd69b17b9fd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -408,7 +408,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 	u8 *prog = *pprog;
 	int cnt = 0;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk()) {
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */

-- 
2.34.1



