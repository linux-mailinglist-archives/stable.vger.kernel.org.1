Return-Path: <stable+bounces-152330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D1AD4301
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563AE17933E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC926462E;
	Tue, 10 Jun 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EH3D6dpj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E223183E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584516; cv=none; b=eIImVRa2ue9P2hggxIer4MeNxV2o/wEz/R++F3Q+61blse/U0zJC5OsZ+uWm4WJ2uyg+GsrioSeHsYKXBcgr9yYepv35ltbOtuX6Hs/raV9m/yQRgIFGE8trhQluCzeQBAy8ZTUvBpb90aGhEdE4KCtPJH4w2WFG6gEJ7Da4qFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584516; c=relaxed/simple;
	bh=B6//xnOR7d1Is0AP4/Ia3hfokISc8pSCIRxeLE/HAEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjBNhNS1d3x0YVgjqI3B6+r5cUUKV1v6rmtIS0pn2kk/dMBBDT+zkyM1mi5+hwjhQdaAat2AbCzzGwk9v4W2DXKBb9jE0yhlq3dK2iyo5Z07VtlqSPC2SR3i2FmU4JaoWceubIq/dIY+dTfoRY5Ser0w6bnmNLoSJruIntsm9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EH3D6dpj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584515; x=1781120515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B6//xnOR7d1Is0AP4/Ia3hfokISc8pSCIRxeLE/HAEA=;
  b=EH3D6dpjbN0lpP/8nelKYc0M/cDfEoSi7YlI5i3G6QW+qOcyOCJ5DiX1
   PaagKPKtsPOWWr4gBZOg/xeA7ooFdsKzxyX8bgMXXplDXfe/vjaQUIOam
   8m/yB3oQJ2Fw9tivSDLEOH4cVwdg1NLYK9Xt0ARi+FWgs2t/mNgBcCQUt
   iCpdhMg/6BKnP5vUG5gq3v8CvUREY7iMZGbjgoPvIFIOJnxDoOubkdr91
   xIQcDzWA4Dl3MPv1ar9av8qx0IrFDt7NscIUbpMyf/otEWibMqfW9N6kD
   1ANKl/xQYMyvvrBwc5s3hx4HB1gl0idXH1aJeQiVTWzVRHTfXi++ervRi
   A==;
X-CSE-ConnectionGUID: VWi2H3v+SfiaY7wiGajEAg==
X-CSE-MsgGUID: jk3dVY7DSYCGhDSrO/ZPsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63121014"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="63121014"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:41:54 -0700
X-CSE-ConnectionGUID: N/7+a84dTd6wKiq1lLmvHg==
X-CSE-MsgGUID: iqQwa9bwTwSIf5JtjbOMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146917903"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:41:53 -0700
Date: Tue, 10 Jun 2025 12:41:52 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5.10 06/16] x86/its: Add support for ITS-safe indirect
 thunk
Message-ID: <20250610-its-5-10-v1-6-64f0ae98c98d@linux.intel.com>
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
 arch/x86/Kconfig                     | 11 ++++++
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/nospec-branch.h |  5 +++
 arch/x86/kernel/alternative.c        | 77 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |  6 +++
 arch/x86/lib/retpoline.S             | 28 +++++++++++++
 arch/x86/net/bpf_jit_comp.c          |  6 ++-
 7 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 93a1f9937a9bb2d905d82f2d3c2bd2c166d01744..c399dbfcf3ad3d84aafef13156c6d03cb3e85e96 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2521,6 +2521,17 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
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
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b9aefb75eafff39ae0eaf2fca5de07e96e864234..a9ccd2ac2d7ae1dd5b9da90fe7d7bd31abb3df96 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -290,7 +290,7 @@
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
 #define X86_FEATURE_BHI_CTRL		(11*32+ 8) /* "" BHI_DIS_S HW control available */
-/* FREE!				(11*32+ 9) */
+#define X86_FEATURE_INDIRECT_THUNK_ITS	(11*32+ 9) /* "" Use thunk for indirect branches in lower half of cacheline */
 #define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
 #define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
 #define X86_FEATURE_RETPOLINE		(11*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7978d5fe1ce6e491ab0bc485611a45dae6a40bdc..4cc0ee529325e62d5b30f171933b47f31ff14a92 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -243,6 +243,11 @@ extern void (*x86_return_thunk)(void);
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 
+#define ITS_THUNK_SIZE	64
+typedef u8 its_thunk_t[ITS_THUNK_SIZE];
+
+extern its_thunk_t	 __x86_indirect_its_thunk_array[];
+
 #define GEN(reg) \
 	extern retpoline_thunk_t __x86_indirect_thunk_ ## reg;
 #include <asm/GEN-for-each-reg.h>
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 70a6165d4e11899b6e0de8548255fef6b913da08..d8e16c479fd0508fceecedae19e992516aeecc9e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -550,6 +550,74 @@ static int emit_indirect(int op, int reg, u8 *bytes)
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
@@ -621,6 +689,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 740f87d8aa48142845f4d726bf0962171362deff..6cee70927281f30871cb5a9680d11c5bf44b4156 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -538,6 +538,12 @@ INIT_PER_CPU(irq_stack_backing_store);
 		"SRSO function pair won't alias");
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+. = ASSERT(__x86_indirect_its_thunk_rax & 0x20, "__x86_indirect_thunk_rax not in second half of cacheline");
+. = ASSERT(((__x86_indirect_its_thunk_rcx - __x86_indirect_its_thunk_rax) % 64) == 0, "Indirect thunks are not cacheline apart");
+. = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
+#endif
+
 #endif /* CONFIG_X86_32 */
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d1902213a0d6379b369cde97615b8398cb080947..9bde4e9d8c2a36bfa2bc804efefefe10ffd5eae7 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -255,6 +255,34 @@ SYM_FUNC_START(entry_untrain_ret)
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
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d7d592c0929835338302146dad95248016a36808..6225e8a8349f76bb8d62bb5613823bc083ffaf4b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -387,7 +387,11 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 	int cnt = 0;
 
 #ifdef CONFIG_RETPOLINE
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (IS_ENABLED(CONFIG_MITIGATION_ITS) &&
+	    cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
+		OPTIMIZER_HIDE_VAR(reg);
+		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {

-- 
2.34.1



