Return-Path: <stable+bounces-143882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD97AB4269
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F29D16C5F1
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F1296FA5;
	Mon, 12 May 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IHjZMmV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3422AE45;
	Mon, 12 May 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073173; cv=none; b=oKSQyItGEupRSAkHFb7rItBJl0FIY4EqJutqqzLiqZtK2QseobaCHtdkYM3Do+GAaVP5FIcr4ozOm9LND26B/1axEc3m+e+UFlH7WphR44CnoVv4I6M2Aul9jIB4evlLi24id1LWaB2ICgamrdDiN/Ox5pmT2KbDaMhDv3IjMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073173; c=relaxed/simple;
	bh=qMprXEbnMX6zCe2DmRqFAA5Fc5PaOXsV/akb5j4KRs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIujDnT68Iq6tG4z5Hxa7udopgxiR4F8Or3qHYnq3BR04wkjcW0xcAruvIumSK067XVfnqR909KuhR7XI72/dlm0H47LI2Q+tlmhk13m6X6GWmOzsqw4s8Y/XrhihG2zxuPK137nLwzl/4vv/PScOcpx3Z/qWOEVyOEG37v3/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHjZMmV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2615C4CEE7;
	Mon, 12 May 2025 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073173;
	bh=qMprXEbnMX6zCe2DmRqFAA5Fc5PaOXsV/akb5j4KRs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHjZMmV2cCm+E471IbsPujRVvqSsMULh93j8mNx1EUx2ZhsQC6LuOuOjWl/1oYQV4
	 C1f7yAQ65epeTLzSNOQEolcp32ypAMw1wFqrJRPVp9msPX93KtazSYeO9PC+7TvpXe
	 XCAx5841VYesOPI4zp/HWur82S/A+tEcVfUtW7Hs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.12 177/184] x86/its: Add support for ITS-safe return thunk
Date: Mon, 12 May 2025 19:46:18 +0200
Message-ID: <20250512172049.013982066@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit a75bf27fe41abe658c53276a0c486c4bf9adecfc upstream.

RETs in the lower half of cacheline may be affected by ITS bug,
specifically when the RSB-underflows. Use ITS-safe return thunk for such
RETs.

RETs that are not patched:

- RET in retpoline sequence does not need to be patched, because the
  sequence itself fills an RSB before RET.
- RET in Call Depth Tracking (CDT) thunks __x86_indirect_{call|jump}_thunk
  and call_depth_return_thunk are not patched because CDT by design
  prevents RSB-underflow.
- RETs in .init section are not reachable after init.
- RETs that are explicitly marked safe with ANNOTATE_UNRET_SAFE.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/alternative.h   |   14 ++++++++++++++
 arch/x86/include/asm/nospec-branch.h |    6 ++++++
 arch/x86/kernel/alternative.c        |   19 +++++++++++++++++--
 arch/x86/kernel/ftrace.c             |    2 +-
 arch/x86/kernel/static_call.c        |    4 ++--
 arch/x86/kernel/vmlinux.lds.S        |    4 ++++
 arch/x86/lib/retpoline.S             |   13 ++++++++++++-
 arch/x86/net/bpf_jit_comp.c          |    2 +-
 8 files changed, 57 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -134,6 +134,20 @@ static __always_inline int x86_call_dept
 }
 #endif
 
+#if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
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
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -386,6 +386,12 @@ static inline void srso_return_thunk(voi
 static inline void srso_alias_return_thunk(void) {}
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
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -809,6 +809,21 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_MITIGATION_RETHUNK
 
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
@@ -825,7 +840,7 @@ static int patch_return(void *addr, stru
 	int i = 0;
 
 	/* Patch the custom return thunks... */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk_at(addr)) {
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
@@ -842,7 +857,7 @@ void __init_or_module noinline apply_ret
 {
 	s32 *s;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+	if (cpu_wants_rethunk())
 		static_call_force_reinit();
 
 	for (s = start; s < end; s++) {
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -354,7 +354,7 @@ create_trampoline(struct ftrace_ops *ops
 		goto fail;
 
 	ip = trampoline + size;
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+	if (cpu_wants_rethunk_at(ip))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -81,7 +81,7 @@ static void __ref __static_call_transfor
 		break;
 
 	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		if (cpu_wants_rethunk_at(insn))
 			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
@@ -90,7 +90,7 @@ static void __ref __static_call_transfor
 	case JCC:
 		if (!func) {
 			func = __static_call_return;
-			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+			if (cpu_wants_rethunk())
 				func = x86_return_thunk;
 		}
 
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -536,4 +536,8 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
 #endif
 
+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
+. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
+#endif
+
 #endif /* CONFIG_X86_64 */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -392,7 +392,18 @@ SYM_CODE_START(__x86_indirect_its_thunk_
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
 
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -664,7 +664,7 @@ static void emit_return(u8 **pprog, u8 *
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk()) {
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */



