Return-Path: <stable+bounces-143635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34EAB40CF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887833AB8C8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719B296D1D;
	Mon, 12 May 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OkWTVDny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7B255222;
	Mon, 12 May 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072588; cv=none; b=DYhq+oFkXEb+eesQUZFvqMmPfSzaH2tWxLe4ujiRUwwQFlMC/B6KsWPxK+FzxIVNd9Y5NjJpNrhi29LXyi3EmsfD6qT+p9/Xgdh4e47g3yENZyBWyeSqdSA0Ye1DcGg/H5NYLrCP8V8bgByBpV2ub25byWyrXyl4IGn/6ZxBY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072588; c=relaxed/simple;
	bh=KCLRXINkg2nQKBuD4XyeU5kOTN/G9hW9uFTeeY/86sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5eXle9oLlZ86AaVoEFUl5HdRieox6VtCmJskoFvdl6BWw2ug/rU7BXbnRBvjJTn5XXsT6mezW7WPuKnTjjA/hSGVAUZUonX5BT+R8ID6ga7b/6xqxxBdyLYfkvBzEUXyfENFBJNHi56AWrdJWyUcr5yWddOrkTKQj3PZkVVLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OkWTVDny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59759C4CEE7;
	Mon, 12 May 2025 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072588;
	bh=KCLRXINkg2nQKBuD4XyeU5kOTN/G9hW9uFTeeY/86sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkWTVDnyQpo06eZx+fgy4Wo2WLT1cjN2HwytJWusSwwSTbWn9HkrkVak64uR56KdW
	 qQN6aLoD7k8A/e7cUtrwMK7J83RAuj6INl7ZxjUASGZi963aHOjZ9L8sXusjkXzQDv
	 Fbxc2txWr/uBMr47J+m74M/gAhZcPRMFRXUTWXWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.1 86/92] x86/its: Add support for ITS-safe indirect thunk
Date: Mon, 12 May 2025 19:46:01 +0200
Message-ID: <20250512172026.629082438@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 8754e67ad4ac692c67ff1f99c0d07156f04ae40c upstream.

Due to ITS, indirect branches in the lower half of a cacheline may be
vulnerable to branch target injection attack.

Introduce ITS-safe thunks to patch indirect branches in the lower half of
cacheline with the thunk. Also thunk any eBPF generated indirect branches
in emit_indirect_jump().

Below category of indirect branches are not mitigated:

- Indirect branches in the .init section are not mitigated because they are
  discarded after boot.
- Indirect branches that are explicitly marked retpoline-safe.

Note that retpoline also mitigates the indirect branches against ITS. This
is because the retpoline sequence fills an RSB entry before RET, and it
does not suffer from RSB-underflow part of the ITS.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig                     |   11 +++++
 arch/x86/include/asm/cpufeatures.h   |    1 
 arch/x86/include/asm/nospec-branch.h |    4 +
 arch/x86/kernel/alternative.c        |   77 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |    6 ++
 arch/x86/lib/retpoline.S             |   28 ++++++++++++
 arch/x86/net/bpf_jit_comp.c          |    6 ++
 7 files changed, 132 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2575,6 +2575,17 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_ITS
+	bool "Enable Indirect Target Selection mitigation"
+	depends on CPU_SUP_INTEL && X86_64
+	depends on RETPOLINE && RETHUNK
+	default y
+	help
+	  Enable Indirect Target Selection (ITS) mitigation. ITS is a bug in
+	  BPU on some Intel CPUs that may allow Spectre V2 style attacks. If
+	  disabled, mitigation cannot be enabled via cmdline.
+	  See <file:Documentation/admin-guide/hw-vuln/indirect-target-selection.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -445,6 +445,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 5) /* "" Use thunk for indirect branches in lower half of cacheline */
 
 /*
  * BUG word(s)
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -244,8 +244,12 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
+#define ITS_THUNK_SIZE	64
+
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
+typedef u8 its_thunk_t[ITS_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
+extern its_thunk_t	 __x86_indirect_its_thunk_array[];
 
 #ifdef CONFIG_RETHUNK
 extern void __x86_return_thunk(void);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -396,6 +396,74 @@ static int emit_indirect(int op, int reg
 	return i;
 }
 
+#ifdef CONFIG_MITIGATION_ITS
+
+static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
+			     void *call_dest, void *jmp_dest)
+{
+	u8 op = insn->opcode.bytes[0];
+	int i = 0;
+
+	/*
+	 * Clang does 'weird' Jcc __x86_indirect_thunk_r11 conditional
+	 * tail-calls. Deal with them.
+	 */
+	if (is_jcc32(insn)) {
+		bytes[i++] = op;
+		op = insn->opcode.bytes[1];
+		goto clang_jcc;
+	}
+
+	if (insn->length == 6)
+		bytes[i++] = 0x2e; /* CS-prefix */
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		__text_gen_insn(bytes+i, op, addr+i,
+				call_dest,
+				CALL_INSN_SIZE);
+		i += CALL_INSN_SIZE;
+		break;
+
+	case JMP32_INSN_OPCODE:
+clang_jcc:
+		__text_gen_insn(bytes+i, op, addr+i,
+				jmp_dest,
+				JMP32_INSN_SIZE);
+		i += JMP32_INSN_SIZE;
+		break;
+
+	default:
+		WARN(1, "%pS %px %*ph\n", addr, addr, 6, addr);
+		return -1;
+	}
+
+	WARN_ON_ONCE(i != insn->length);
+
+	return i;
+}
+
+static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	return __emit_trampoline(addr, insn, bytes,
+				 __x86_indirect_its_thunk_array[reg],
+				 __x86_indirect_its_thunk_array[reg]);
+}
+
+/* Check if an indirect branch is at ITS-unsafe address */
+static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return false;
+
+	/* Indirect branch opcode is 2 or 3 bytes depending on reg */
+	addr += 1 + reg / 8;
+
+	/* Lower-half of the cacheline? */
+	return !(addr & 0x20);
+}
+#endif
+
 /*
  * Rewrite the compiler generated retpoline thunk calls.
  *
@@ -466,6 +534,15 @@ static int patch_retpoline(void *addr, s
 		bytes[i++] = 0xe8; /* LFENCE */
 	}
 
+#ifdef CONFIG_MITIGATION_ITS
+	/*
+	 * Check if the address of last byte of emitted-indirect is in
+	 * lower-half of the cacheline. Such branches need ITS mitigation.
+	 */
+	if (cpu_wants_indirect_its_thunk_at((unsigned long)addr + i, reg))
+		return emit_its_trampoline(addr, insn, reg, bytes);
+#endif
+
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -528,6 +528,12 @@ INIT_PER_CPU(irq_stack_backing_store);
 		"SRSO function pair won't alias");
 #endif
 
+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
+. = ASSERT(__x86_indirect_its_thunk_rax & 0x20, "__x86_indirect_thunk_rax not in second half of cacheline");
+. = ASSERT(((__x86_indirect_its_thunk_rcx - __x86_indirect_its_thunk_rax) % 64) == 0, "Indirect thunks are not cacheline apart");
+. = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
+#endif
+
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -258,6 +258,34 @@ SYM_FUNC_START(entry_untrain_ret)
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
+#ifdef CONFIG_MITIGATION_ITS
+
+.macro ITS_THUNK reg
+
+SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%\reg
+	int3
+	.align 32, 0xcc		/* fill to the end of the line */
+	.skip  32, 0xcc		/* skip to the next upper half */
+.endm
+
+/* ITS mitigation requires thunks be aligned to upper half of cacheline */
+.align 64, 0xcc
+.skip 32, 0xcc
+SYM_CODE_START(__x86_indirect_its_thunk_array)
+
+#define GEN(reg) ITS_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align 64, 0xcc
+SYM_CODE_END(__x86_indirect_its_thunk_array)
+
+#endif
+
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -464,7 +464,11 @@ static void emit_indirect_jump(u8 **ppro
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (IS_ENABLED(CONFIG_MITIGATION_ITS) &&
+	    cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
+		OPTIMIZER_HIDE_VAR(reg);
+		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {



