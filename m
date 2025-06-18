Return-Path: <stable+bounces-154610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF7ADE032
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258647A2447
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66323208A7;
	Wed, 18 Jun 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDSYaNwM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2C29A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207586; cv=none; b=nl2I5Z70tQKoDAv9r2pO5JJrBk7tPeom1VTqav2bfgtRPXgKXUaxSMVxYNhwn4K9kZ0H4gB3fj7hRqIflheLNHSoCZ9FTcBHyO4yP5jdB9Wkx8MDOF0ucS7RSVmKiFDGJWkgp1lxuIbfUoeALNIlyvEybHESAcgDeorjCdEui7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207586; c=relaxed/simple;
	bh=A7TKZ56k+rfQaE7CIbCTIGkKPx15jJnwaFRf1iBSX+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvDBIWPQqn7wsjQtRWkxJPbv2pB6LScxhJUqz2m+XmvW0xuzy8T/YDVcnlXL8d7gfXKVsvo39dx2TxWDfvs9iU+2FfoG2YO+5eOXh6t25qIYr2Y3GTJKtFIKM2GJ8zEgz9nnkWCCtH5WpZ4ZyseIe6+jx7At6jn3ExWPpQwzFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDSYaNwM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207585; x=1781743585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7TKZ56k+rfQaE7CIbCTIGkKPx15jJnwaFRf1iBSX+E=;
  b=iDSYaNwM87J5Kc6ZSNJH3VGcYCA3Ul6ZR+lpy/ynq42aU2l26Jnh6RiT
   JvK9yIsb6ftD6/pvW3fq4Lepej4JhiHpJNuLFXs9AUq78bJgBrr+NUNZV
   HiiR1v66I0PGFOu9JuTKi4qHbgvUMuDMX3KgE9ACpDxsbuHxICBaY6fCf
   zmyErI4kP8hD8GxOb9ThOzmCU0ZPVkwLm9EavpXBfF2j2mbGTrL/QlXBK
   jCTvG0/8/wlrzZjichOpgoDGYYrQ7KS2G/Uw+UgBH0fAaEf98DQLWMzM2
   xL1L7hP+uL6H9lTwBV6mWy3PTuiWPEokPYVFP9yCo0HZq8nqKzhoQhYxZ
   w==;
X-CSE-ConnectionGUID: LLitRAKdQbuU7jkHEh5GUQ==
X-CSE-MsgGUID: 55VaqiHfStKEtyWfxiFS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="69856637"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="69856637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:25 -0700
X-CSE-ConnectionGUID: u4xHdV+tSfyFuHvhOOik8w==
X-CSE-MsgGUID: CzTecG7LSceYYyVNwbWEug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="179984881"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:24 -0700
Date: Tue, 17 Jun 2025 17:46:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.10 v2 09/16] x86/its: Add support for ITS-safe return thunk
Message-ID: <20250617-its-5-10-v2-9-3e925a1512a1@linux.intel.com>
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

commit a75bf27fe41abe658c53276a0c486c4bf9adecfc upstream.

RETs in the lower half of cacheline may be affected by ITS bug,
specifically when the RSB-underflows. Use ITS-safe return thunk for such
RETs.

RETs that are not patched:

- RET in retpoline sequence does not need to be patched, because the
  sequence itself fills an RSB before RET.
- RETs in .init section are not reachable after init.
- RETs that are explicitly marked safe with ANNOTATE_UNRET_SAFE.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
index 0e777b27972b..d7f33c1e052b 100644
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
index 4cc0ee529325..7ccaefaa16a6 100644
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
index 3102e7cf6a48..ae4a6bc25b29 100644
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
index 46447877b594..fba03ad16cce 100644
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
index 4544f124bbd4..42564d29eb1b 100644
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
index 6cee70927281..1f77896515c5 100644
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
index 9bde4e9d8c2a..01fcf0cd679b 100644
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
index 6225e8a8349f..c32270212640 100644
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
2.43.0



