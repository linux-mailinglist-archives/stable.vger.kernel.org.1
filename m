Return-Path: <stable+bounces-144653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B4ABA6DE
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D929F1BC7D00
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FED1FC8;
	Sat, 17 May 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZekOwBlO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E0136E
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440128; cv=none; b=NO5VM1a0GfDhoSusllkKr9jjJHciYPNS/M39/ZtpIYEEZ0E0d8JRZ8sJxjZo3/R2OpBpDqgsx07eub2/S/TyY22qF0kJL8/0p7ei31BdI4/Bdqgce60UuSyRsMpeKEAtvs0rz5CeOP0TMH+emrlZwMcuQ5XDR7Eg7TKn9dYC+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440128; c=relaxed/simple;
	bh=NWtjNSEVdX3m9mcVRFKPE2uEbYkQm5g/ZLHvzkmAgdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I41i9j/FfcUxEtzV+cIooDcJV4cw2EwWyM9V78HGAO/2K/oVLWMnhXhiAahHCTcjoIP5JBSHrl2xAl7liUo4Pw/zgKXtZvt0G0RbQtoEwh1+KpTGfwc0jbDDGtZKfv+POXgsvEK4QxmyV7Iv+nb2/LJ9Eon41hVWi5kq+qlRNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZekOwBlO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440127; x=1778976127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWtjNSEVdX3m9mcVRFKPE2uEbYkQm5g/ZLHvzkmAgdk=;
  b=ZekOwBlOzj4mfrBK2nCxr7ZK2TBMhpkvx8iPufbzlEipol/8UfF0lI1N
   blMFWjIU5P0P1/TVS012jv8js41VNQ1n+699r6eButRD51FTd4D/ApQgk
   6j957+I5DQlgvPsR/UzPIkIchCndgfDU0hXXLAyVdnxj3x5f3myFF5d1o
   gJlgz0i6DsyW9vOknRLBLaAFJEkADCerQ5lpQBLtUVvlJ9k9aStsMKBfM
   xE9+OZfnvANzSz5TObHFCpayOcg3ISxBxdU/SCpdSuZDgh5k64uWbn9Z5
   hC4xziY8p38iB0knCY9QjijzJfa5QUX/wNPD07wwPu7br/rB9en/utAmD
   w==;
X-CSE-ConnectionGUID: oBHrpiGGQKiza47Q8iup2Q==
X-CSE-MsgGUID: EVnBcBFmSqOa8vMbb9R89Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60062218"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="60062218"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:02:06 -0700
X-CSE-ConnectionGUID: Rvi2APGZR1Gdd3LWq7h7BQ==
X-CSE-MsgGUID: 2Te+georR3+4Jhpxn094xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138576165"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:02:05 -0700
Date: Fri, 16 May 2025 17:02:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v3 10/16] x86/its: Add support for ITS-safe return thunk
Message-ID: <20250516-its-5-15-v3-10-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

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
---
 arch/x86/include/asm/alternative.h   | 14 ++++++++++++++
 arch/x86/include/asm/nospec-branch.h |  6 ++++++
 arch/x86/kernel/alternative.c        | 17 ++++++++++++++++-
 arch/x86/kernel/ftrace.c             |  2 +-
 arch/x86/kernel/static_call.c        |  2 +-
 arch/x86/kernel/vmlinux.lds.S        |  4 ++++
 arch/x86/lib/retpoline.S             | 13 ++++++++++++-
 arch/x86/net/bpf_jit_comp.c          |  2 +-
 8 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index a364971967c40e2673624917f0ddea2a8ed6f95e..4038b893449a7d38f4079e213a924493e67f4231 100644
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
index 37b66b45337102e44826d76e20798958d6cbe5ff..17156b61fcc32d503bb52ad4703c4c121d5ab3cc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -250,6 +250,12 @@ extern void __x86_return_thunk(void);
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
index 5951c77723787401f8ddb470fdcda76a488ca524..c3df557be55e37e256d05a83f55e4ebfdee9d451 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -605,6 +605,21 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 
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
@@ -621,7 +636,7 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	int i = 0;
 
 	/* Patch the custom return thunks... */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk_at(addr)) {
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 85c09843df1b9e373039572a9e1441e5d20e33da..c15e3bdc61e300a8cecef46db842afb44da7c011 100644
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
index a5dd11c92d055c1db17664f63bf012a83895d3c4..74eb1d6c7bb0d0aad778a89b98da5a3d28c0e57c 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -81,7 +81,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		break;
 
 	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		if (cpu_wants_rethunk_at(insn))
 			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f85810b435b9bf4faca58e0293af877d31d98662..c570da8be0307744de7c986fa7f1bae9462f6f37 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -538,6 +538,10 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
 #endif
 
+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
+. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
+#endif
+
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 4a037315e9e9f942809be7fb8fd9f0b91430e50e..ae0151c6caba57b885e191f8ce93a4c47e535948 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -280,7 +280,18 @@ SYM_CODE_START(__x86_indirect_its_thunk_array)
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
index a3e974a956f141863bb2295fa9917b6d486a342a..8be74c2aa7b895604855b1d8e340eddc004694e3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -466,7 +466,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk()) {
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */

-- 
2.34.1



