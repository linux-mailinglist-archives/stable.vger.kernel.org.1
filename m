Return-Path: <stable+bounces-154758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DFAE0150
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2451819E300D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D68274FC2;
	Thu, 19 Jun 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmBV+soZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB5278767
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323762; cv=none; b=YxvsP52UiLWF+uSpompOavxsEtX2poMH+cvLhBMHKbalyT3RY0KSIxwXeceP+QBPwUKu6RfJA7fsDscNUZRnLtgCAgrpamkyBpJ7+JiEltqp5c3aU1Cb1mkNIXsvEjbEbhDhTpuHww7FX3WHFhHGzFuIwyDNDon9YUoJYXcLkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323762; c=relaxed/simple;
	bh=5ffqTCrKNYgMrnBiaCxiVaB1QVOF6Lz3Vm0K/fMAzg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G++C2Sw7vQdePkEOk32rnK+8ZMUm7H0s1gUT6Q9DzRizJOjbrFmJ2enIDha5QXmc4lrzjL2fY46e9WDCWgiAbYW2C1KkTvZsU7NHvs+Bf4SXGNK2pxe+HEk+k2Ad896MUq0xluFbiyhmHlXM4rDgqxJr/jv19EcKsKsCQCrpmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmBV+soZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFD3C4CEEA;
	Thu, 19 Jun 2025 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323762;
	bh=5ffqTCrKNYgMrnBiaCxiVaB1QVOF6Lz3Vm0K/fMAzg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmBV+soZt4invAVYpVZFcri00PtcNvP7ZYeR1cxu7P8MDJ42pvaQGBA59SPJ5zcrl
	 Al89HEEly504V1RK9RR79m8DOhwpjdyFNa9AuYeK2Yxu55aLcCMHdsnmLxrag4EyPD
	 Hn20fOR0MWbf3fuf/BT0UIrfNA8rShZpk/Y8QQ5PSv4/D7LvVOOxfCSQngEshjvsJt
	 9inOWDBbbTEKqBDPc/ddV9jMro6FzACvmiqPa3jzVSCMuSbGxs5RKtX8F3oDGyn1gD
	 QdGlNVFkRAR6GIJipryzUY5cTmajHhL/Ntn6TZ22gRBnKtp4fltxTncAmkyPRxYClN
	 j0yomPAdRGL0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 09/16] x86/its: Add support for ITS-safe return thunk
Date: Thu, 19 Jun 2025 05:02:40 -0400
Message-Id: <20250618180601-0069a8108a94b4e4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-9-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: a75bf27fe41abe658c53276a0c486c4bf9adecfc

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 51000047235f)
6.6.y | Present (different SHA1: 4754e29f43c6)
6.1.y | Present (different SHA1: dbd8f170af47)
5.15.y | Present (different SHA1: 5d19a0574b75)

Note: The patch differs from the upstream commit:
---
1:  a75bf27fe41ab ! 1:  594e35adc4df3 x86/its: Add support for ITS-safe return thunk
    @@ Metadata
      ## Commit message ##
         x86/its: Add support for ITS-safe return thunk
     
    +    commit a75bf27fe41abe658c53276a0c486c4bf9adecfc upstream.
    +
         RETs in the lower half of cacheline may be affected by ITS bug,
         specifically when the RSB-underflows. Use ITS-safe return thunk for such
         RETs.
    @@ Commit message
     
         - RET in retpoline sequence does not need to be patched, because the
           sequence itself fills an RSB before RET.
    -    - RET in Call Depth Tracking (CDT) thunks __x86_indirect_{call|jump}_thunk
    -      and call_depth_return_thunk are not patched because CDT by design
    -      prevents RSB-underflow.
         - RETs in .init section are not reachable after init.
         - RETs that are explicitly marked safe with ANNOTATE_UNRET_SAFE.
     
    -    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/alternative.h ##
    -@@ arch/x86/include/asm/alternative.h: static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
    - }
    - #endif
    +@@ arch/x86/include/asm/alternative.h: extern void apply_returns(s32 *start, s32 *end);
    + 
    + struct module;
      
    -+#if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
    ++#ifdef CONFIG_RETHUNK
     +extern bool cpu_wants_rethunk(void);
     +extern bool cpu_wants_rethunk_at(void *addr);
     +#else
    @@ arch/x86/include/asm/alternative.h: static __always_inline int x86_call_depth_em
      					void *locks, void *locks_end,
     
      ## arch/x86/include/asm/nospec-branch.h ##
    -@@ arch/x86/include/asm/nospec-branch.h: static inline void srso_return_thunk(void) {}
    - static inline void srso_alias_return_thunk(void) {}
    +@@ arch/x86/include/asm/nospec-branch.h: extern void __x86_return_thunk(void);
    + static inline void __x86_return_thunk(void) {}
      #endif
      
     +#ifdef CONFIG_MITIGATION_ITS
    @@ arch/x86/include/asm/nospec-branch.h: static inline void srso_return_thunk(void)
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
      
    - #ifdef CONFIG_MITIGATION_RETHUNK
    + #ifdef CONFIG_RETHUNK
      
     +bool cpu_wants_rethunk(void)
     +{
    @@ arch/x86/kernel/alternative.c: static int patch_return(void *addr, struct insn *
      		i = JMP32_INSN_SIZE;
      		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
      	} else {
    -@@ arch/x86/kernel/alternative.c: void __init_or_module noinline apply_returns(s32 *start, s32 *end)
    - {
    - 	s32 *s;
    - 
    --	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
    -+	if (cpu_wants_rethunk())
    - 		static_call_force_reinit();
    - 
    - 	for (s = start; s < end; s++) {
     
      ## arch/x86/kernel/ftrace.c ##
     @@ arch/x86/kernel/ftrace.c: create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
    @@ arch/x86/kernel/static_call.c: static void __ref __static_call_transform(void *i
      			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
      		else
      			code = &retinsn;
    -@@ arch/x86/kernel/static_call.c: static void __ref __static_call_transform(void *insn, enum insn_type type,
    - 	case JCC:
    - 		if (!func) {
    - 			func = __static_call_return;
    --			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
    -+			if (cpu_wants_rethunk())
    - 				func = x86_return_thunk;
    - 		}
    - 
     
      ## arch/x86/kernel/vmlinux.lds.S ##
    -@@ arch/x86/kernel/vmlinux.lds.S: PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
    +@@ arch/x86/kernel/vmlinux.lds.S: INIT_PER_CPU(irq_stack_backing_store);
    + . = ASSERT(__x86_indirect_its_thunk_rax & 0x20, "__x86_indirect_thunk_rax not in second half of cacheline");
    + . = ASSERT(((__x86_indirect_its_thunk_rcx - __x86_indirect_its_thunk_rax) % 64) == 0, "Indirect thunks are not cacheline apart");
      . = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
    - #endif
    - 
    -+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
    -+. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
    -+#endif
     +
    - #endif /* CONFIG_X86_64 */
    ++. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
    + #endif
      
    - /*
    + #endif /* CONFIG_X86_32 */
     
      ## arch/x86/lib/retpoline.S ##
     @@ arch/x86/lib/retpoline.S: SYM_CODE_START(__x86_indirect_its_thunk_array)
    @@ arch/x86/lib/retpoline.S: SYM_CODE_START(__x86_indirect_its_thunk_array)
     +
     +#endif /* CONFIG_MITIGATION_ITS */
      
    - /*
    -  * This function name is magical and is used by -mfunction-return=thunk-extern
    + SYM_CODE_START(__x86_return_thunk)
    + 	UNWIND_HINT_FUNC
     
      ## arch/x86/net/bpf_jit_comp.c ##
     @@ arch/x86/net/bpf_jit_comp.c: static void emit_return(u8 **pprog, u8 *ip)
    - {
      	u8 *prog = *pprog;
    + 	int cnt = 0;
      
     -	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
     +	if (cpu_wants_rethunk()) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

