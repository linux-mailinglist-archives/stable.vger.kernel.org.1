Return-Path: <stable+bounces-144676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A66ABAA34
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD8E9E13BE
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A7155393;
	Sat, 17 May 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhvmJeW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9761E1A3B
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487295; cv=none; b=WjewaplBd92Y3I9JA5QbRIR9vvnufSoDbWhFUzVNKE1EFUUVKdwrbPaD8sOr0y+K6/+WVkx/Aw71BHHIcgerxVje5xj8DHSnbmPMDFB+378KQWawr543H8HDfo+a+V8fu8/WFSlX9T3WlPKQO+iK64it3d/ZqeNgojUq8v+OFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487295; c=relaxed/simple;
	bh=/Mca+ICJZM2CjvU/FA9WaVQNkewKANey5CJLN4X9A9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCflUWnUPZbCyYUoRvjteGe1c1yVhFqiloE8cakE6kp5vqguAt/HuCczcnGxaNd/qHbSnkeZMRLw3pU97hPTY93iX2I+BCN0wON6fW2BcTZXazFh3fYE4oySwJNlaj43qGKx0dJjeW6UNtWbS69uduocxsBVO7Xzf+VHO7po+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhvmJeW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8321EC4CEE3;
	Sat, 17 May 2025 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487295;
	bh=/Mca+ICJZM2CjvU/FA9WaVQNkewKANey5CJLN4X9A9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhvmJeW1L/TccTD0cBa1dq2KEBCVQOaaFyikoeAQxXIfEeeaZYK3ZcCbz54HLcuxH
	 rCBsZokNtTSo85g9aIFEnem99fFsWPv6cvl8qtvn+xaOAjbHnb1ri4Bp9H++gAkezA
	 hIaRNIWsDEQjm7E7iy1Tvn871AA9WTuPA8JFpbTESuC+zd3SP5kf7BExDbb259LmI9
	 UkRIsh9yERamWkLbc8NqyYg1riYy7a2RtnydqMMUBjowvpd2PNQzB0j4JwfzX1R0LP
	 55Iv5U0QGQoPUtho/EoF69CPc6qYV2w2gEO0Hy7/FymLAygwllrF3ogEJT+5P2vU20
	 3HrONwmQppd7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 07/16] x86/its: Add support for ITS-safe indirect thunk
Date: Sat, 17 May 2025 09:08:13 -0400
Message-Id: <20250516214446-83f41109c9822f4c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-7-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 8754e67ad4ac692c67ff1f99c0d07156f04ae40c

Status in newer kernel trees:
6.14.y | Present (different SHA1: c6dd7a78b9ae)
6.12.y | Present (different SHA1: 1565863153af)
6.6.y | Present (different SHA1: 6b1c379b8824)
6.1.y | Present (different SHA1: 5f4dfa416aee)

Note: The patch differs from the upstream commit:
---
1:  8754e67ad4ac6 ! 1:  cf5c88c17b7cb x86/its: Add support for ITS-safe indirect thunk
    @@ Metadata
      ## Commit message ##
         x86/its: Add support for ITS-safe indirect thunk
     
    +    commit 8754e67ad4ac692c67ff1f99c0d07156f04ae40c upstream.
    +
         Due to ITS, indirect branches in the lower half of a cacheline may be
         vulnerable to branch target injection attack.
     
    @@ Commit message
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
     
      ## arch/x86/Kconfig ##
    -@@ arch/x86/Kconfig: config MITIGATION_SSB
    - 	  of speculative execution in a similar way to the Meltdown and Spectre
    - 	  security vulnerabilities.
    +@@ arch/x86/Kconfig: config MITIGATION_SPECTRE_BHI
    + 	  indirect branches.
    + 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
      
     +config MITIGATION_ITS
     +	bool "Enable Indirect Target Selection mitigation"
     +	depends on CPU_SUP_INTEL && X86_64
    -+	depends on MITIGATION_RETPOLINE && MITIGATION_RETHUNK
    ++	depends on RETPOLINE && RETHUNK
     +	default y
     +	help
     +	  Enable Indirect Target Selection (ITS) mitigation. ITS is a bug in
    @@ arch/x86/Kconfig: config MITIGATION_SSB
     
      ## arch/x86/include/asm/cpufeatures.h ##
     @@
    - #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
    - #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
    - #define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
    -+#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 9) /* Use thunk for indirect branches in lower half of cacheline */
    + #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
    + #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
    + #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
    ++#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 5) /* "" Use thunk for indirect branches in lower half of cacheline */
      
      /*
       * BUG word(s)
     
      ## arch/x86/include/asm/nospec-branch.h ##
    -@@
    +@@ arch/x86/include/asm/nospec-branch.h: extern void (*x86_return_thunk)(void);
      
    - #else /* __ASSEMBLER__ */
    + typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
      
     +#define ITS_THUNK_SIZE	64
    -+
    - typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
     +typedef u8 its_thunk_t[ITS_THUNK_SIZE];
    - extern retpoline_thunk_t __x86_indirect_thunk_array[];
    - extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
    - extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
    ++
     +extern its_thunk_t	 __x86_indirect_its_thunk_array[];
    - 
    - #ifdef CONFIG_MITIGATION_RETHUNK
    - extern void __x86_return_thunk(void);
    ++
    + #define GEN(reg) \
    + 	extern retpoline_thunk_t __x86_indirect_thunk_ ## reg;
    + #include <asm/GEN-for-each-reg.h>
     
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: static int emit_indirect(int op, int reg, u8 *bytes)
      	return i;
      }
      
    --static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
    ++#ifdef CONFIG_MITIGATION_ITS
    ++
     +static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
     +			     void *call_dest, void *jmp_dest)
    - {
    - 	u8 op = insn->opcode.bytes[0];
    - 	int i = 0;
    -@@ arch/x86/kernel/alternative.c: static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
    - 	switch (op) {
    - 	case CALL_INSN_OPCODE:
    - 		__text_gen_insn(bytes+i, op, addr+i,
    --				__x86_indirect_call_thunk_array[reg],
    ++{
    ++	u8 op = insn->opcode.bytes[0];
    ++	int i = 0;
    ++
    ++	/*
    ++	 * Clang does 'weird' Jcc __x86_indirect_thunk_r11 conditional
    ++	 * tail-calls. Deal with them.
    ++	 */
    ++	if (is_jcc32(insn)) {
    ++		bytes[i++] = op;
    ++		op = insn->opcode.bytes[1];
    ++		goto clang_jcc;
    ++	}
    ++
    ++	if (insn->length == 6)
    ++		bytes[i++] = 0x2e; /* CS-prefix */
    ++
    ++	switch (op) {
    ++	case CALL_INSN_OPCODE:
    ++		__text_gen_insn(bytes+i, op, addr+i,
     +				call_dest,
    - 				CALL_INSN_SIZE);
    - 		i += CALL_INSN_SIZE;
    - 		break;
    -@@ arch/x86/kernel/alternative.c: static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
    - 	case JMP32_INSN_OPCODE:
    - clang_jcc:
    - 		__text_gen_insn(bytes+i, op, addr+i,
    --				__x86_indirect_jump_thunk_array[reg],
    ++				CALL_INSN_SIZE);
    ++		i += CALL_INSN_SIZE;
    ++		break;
    ++
    ++	case JMP32_INSN_OPCODE:
    ++clang_jcc:
    ++		__text_gen_insn(bytes+i, op, addr+i,
     +				jmp_dest,
    - 				JMP32_INSN_SIZE);
    - 		i += JMP32_INSN_SIZE;
    - 		break;
    -@@ arch/x86/kernel/alternative.c: static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
    - 	return i;
    - }
    - 
    -+static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
    -+{
    -+	return __emit_trampoline(addr, insn, bytes,
    -+				 __x86_indirect_call_thunk_array[reg],
    -+				 __x86_indirect_jump_thunk_array[reg]);
    ++				JMP32_INSN_SIZE);
    ++		i += JMP32_INSN_SIZE;
    ++		break;
    ++
    ++	default:
    ++		WARN(1, "%pS %px %*ph\n", addr, addr, 6, addr);
    ++		return -1;
    ++	}
    ++
    ++	WARN_ON_ONCE(i != insn->length);
    ++
    ++	return i;
     +}
     +
    -+#ifdef CONFIG_MITIGATION_ITS
     +static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
     +{
     +	return __emit_trampoline(addr, insn, bytes,
    @@ arch/x86/kernel/alternative.c: static int patch_retpoline(void *addr, struct ins
      		return ret;
     
      ## arch/x86/kernel/vmlinux.lds.S ##
    -@@ arch/x86/kernel/vmlinux.lds.S: PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
    +@@ arch/x86/kernel/vmlinux.lds.S: INIT_PER_CPU(irq_stack_backing_store);
      		"SRSO function pair won't alias");
      #endif
      
    @@ arch/x86/kernel/vmlinux.lds.S: PROVIDE(__ref_stack_chk_guard = __stack_chk_guard
     +
      #endif /* CONFIG_X86_64 */
      
    - /*
    + #ifdef CONFIG_KEXEC_CORE
     
      ## arch/x86/lib/retpoline.S ##
    -@@ arch/x86/lib/retpoline.S: SYM_FUNC_END(call_depth_return_thunk)
    - 
    - #endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
    +@@ arch/x86/lib/retpoline.S: SYM_FUNC_START(entry_untrain_ret)
    + SYM_FUNC_END(entry_untrain_ret)
    + __EXPORT_THUNK(entry_untrain_ret)
      
     +#ifdef CONFIG_MITIGATION_ITS
     +
     +.macro ITS_THUNK reg
     +
     +SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
    -+	UNWIND_HINT_UNDEFINED
    ++	UNWIND_HINT_EMPTY
     +	ANNOTATE_NOENDBR
     +	ANNOTATE_RETPOLINE_SAFE
     +	jmp *%\reg
    @@ arch/x86/lib/retpoline.S: SYM_FUNC_END(call_depth_return_thunk)
     +
     +#endif
     +
    - /*
    -  * This function name is magical and is used by -mfunction-return=thunk-extern
    -  * for the compiler to generate JMPs to it.
    + SYM_CODE_START(__x86_return_thunk)
    + 	UNWIND_HINT_FUNC
    + 	ANNOTATE_NOENDBR
     
      ## arch/x86/net/bpf_jit_comp.c ##
     @@ arch/x86/net/bpf_jit_comp.c: static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
    - {
      	u8 *prog = *pprog;
      
    + #ifdef CONFIG_RETPOLINE
     -	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
    -+	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
    ++	if (IS_ENABLED(CONFIG_MITIGATION_ITS) &&
    ++	    cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
     +		OPTIMIZER_HIDE_VAR(reg);
     +		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
     +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

