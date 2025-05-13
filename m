Return-Path: <stable+bounces-144086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97273AB49CD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A419E81B5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74521DDC04;
	Tue, 13 May 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jsuxh6Eo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AC2A1CA
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105170; cv=none; b=U6VOgvA2MFCTmWXx6Uo3osjOoQpD54zP0yw7keZLBHw97v9dJCcP5ijR/Ox6fqmjLd071RwivYbD5eIVyXpTT2/ZJtCOhTwRKxewuSVOZ3Xig2zCgsketYgNZAgPz6mhso6QcnYjU2pymDslyiy9SlFZ4jdckfkOd+jvcEbr0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105170; c=relaxed/simple;
	bh=+598gN1YY98YQa7A5YIdxA+cvCEQwgcYcN64obN+xB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgHal5+j2YcWDNwTdf8tNeoi6T2UeONIaZdRVJ/gkZnF1x3cPZAsShlDFR7FQvXY+R40X51WWwAtIM9F7e4vRRYSvD3iX7PJI+4SFtxEvuwPKgG5sBGfB/At1bQq0pSXKjyALqV9QfGaULqcyj6bt5g2CTiyh9aOd2ImaH6/oNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jsuxh6Eo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105169; x=1778641169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+598gN1YY98YQa7A5YIdxA+cvCEQwgcYcN64obN+xB4=;
  b=Jsuxh6EoOYW3KCyVOS+zLyK5FjN1HSqODxhO/eRo8pJpZiDl8n8vLgxE
   oxKkqSf4/aXYERpweUR3Y1vYPJONfcyhZHVUQC+4/4ZtDmo+Tbnrp54rs
   sBFlEYI4gQPsYNdkgPBkPlyFCojoeFZkqTR8fdvR/3muonEBU6QFkUssm
   fLX5nFzYkXC0K6Ro6oTtSsuwcR2i589ShBW6+ZZXT8v0ctjr3x0bZhB9W
   FMPMe9FCO9/tZYMdVFno5471ydwby7Q6+ZC3Y84URcDYecxELtdzKscZ5
   50PQFDJ6DvpK6ivnYXYmvuv4xly06l9Er81myPYtWWH9OQ3LoNkMlx+8d
   Q==;
X-CSE-ConnectionGUID: dxaZHKWCTZWYrpHo0g13lQ==
X-CSE-MsgGUID: 5eot13gvSFaP5MmVZ7BlSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48804046"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="48804046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:59:28 -0700
X-CSE-ConnectionGUID: VMAxqGHaSIOv72cGxRZbCQ==
X-CSE-MsgGUID: n/ytfpk2SNG1x1/d2fotPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="168469409"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:59:28 -0700
Date: Mon, 12 May 2025 19:59:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 07/14] x86/its: Add support for ITS-safe indirect thunk
Message-ID: <20250512-its-5-15-v1-7-6a536223434d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>

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
---
 arch/x86/Kconfig                     | 11 ++++++
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  5 +++
 arch/x86/kernel/alternative.c        | 77 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |  6 +++
 arch/x86/lib/retpoline.S             | 28 +++++++++++++
 arch/x86/net/bpf_jit_comp.c          |  6 ++-
 7 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index de6a66ad3fa624b16d1101023f84f7f2d5bd6b5b..026a5714f78f394d0856e81aa3433d7f90686573 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2517,6 +2517,17 @@ config MITIGATION_SPECTRE_BHI
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
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a74ea1281d3f1e35d53327e7a9212939d0c760a8..a268028a6ac7b71e6968356f622663c561d65153 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -433,6 +433,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 5) /* "" Use thunk for indirect branches in lower half of cacheline */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 79f51824fad3938032bd994709e46f1171c1b70c..37b66b45337102e44826d76e20798958d6cbe5ff 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -271,6 +271,11 @@ extern void (*x86_return_thunk)(void);
 
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
index 5614e6d219b756379e488952dbcd2d79fbfa2345..ddf696742c97263af9cc59c68daf1fd19efee0c6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,74 @@ static int emit_indirect(int op, int reg, u8 *bytes)
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
@@ -466,6 +534,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
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
index 351c604de263ac5f77ded665196f1f1841ead66c..f85810b435b9bf4faca58e0293af877d31d98662 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -532,6 +532,12 @@ INIT_PER_CPU(irq_stack_backing_store);
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
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 019096b66eff353892a75c50491d56fdae3afebb..4a037315e9e9f942809be7fb8fd9f0b91430e50e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -254,6 +254,34 @@ SYM_FUNC_START(entry_untrain_ret)
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
index ac06f53391ec19db122cc0b1d0c93e43411bf4ec..c0d96e6f60f589730b3876b9248fce1ef6952b95 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -444,7 +444,11 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 	u8 *prog = *pprog;
 
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



