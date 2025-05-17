Return-Path: <stable+bounces-144683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F9ABAA3B
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2AE1B63C64
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825A1F4717;
	Sat, 17 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIfEYZkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3A35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487324; cv=none; b=aLG/QuF4caBP9yyIH0myM+8Z4I7y2d78Sm1Ga0cwmxixO+7dsCaW7v25VW4k6yAFmKfzrw7Y47QviSkk1HLIwniNCYCaE+51L59y3SoNSM96DVjLYlHzShldvwxlY76Y6dPaPPWBmet97I/8z8nhIfuT+nxZGwRspN9ASC3LtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487324; c=relaxed/simple;
	bh=UXu/LOyRWe9Y9sO4FKQQi0BLc/Aiyo1FWHBAvYlb4y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jII6RCzKJEA+jXI+k/dHs6FkiztoQ0ok+Ms34e0Ad1pft7seQVdQDihaRmBOMaemPnmdZRfDgFFtC1yFSUX4v7QIRcyALy2c0/FmH66YzfA9HXsqwoPuTxjespwpmurz+ki7xV/loGPY1b1EqEEEKZI2AGVMsmoIxSofPDB5ovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIfEYZkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415C3C4CEE3;
	Sat, 17 May 2025 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487324;
	bh=UXu/LOyRWe9Y9sO4FKQQi0BLc/Aiyo1FWHBAvYlb4y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIfEYZkNwnF8M3SOtIlzeL+XAsmkh++7kCRJODdFjfEwXbgaA1amR6Bjb9IHFZnEW
	 /jeVBxQzMSzAyBcsGSW2uf16vhDwhE3Ezy4+oQjbXUf5zJ5DcFqpU2AW7uCRVF6enW
	 i/oFjgvP0+bR1MNukuoz4u75bpW2beznLIJoEDEmbmb3la32GO4+SBzSPLYF3A4USW
	 0ZHlecIS8seBrYKr6MwHpEZOImxkJdDJUW5M57HBLumbk0BkJQMeoSCAxQBrxSpo6Z
	 gfgOomPNpUf08JExW00V5UR+yF7pPX5wLhtXTv+uE1qyMfwpZAM8KVD1K8ddvzAXVe
	 KL6nx2o+/hcoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 10/16] x86/its: Add support for ITS-safe return thunk
Date: Sat, 17 May 2025 09:08:43 -0400
Message-Id: <20250516215643-6e77207da7b569a8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-10-16fcdaaea544@linux.intel.com>
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
6.14.y | Present (different SHA1: f9a449a04ad6)
6.12.y | Present (different SHA1: 22d1efbb1e99)
6.6.y | Present (different SHA1: 2bacac79dd22)
6.1.y | Present (different SHA1: e1d254d4a267)

Note: The patch differs from the upstream commit:
---
1:  a75bf27fe41ab ! 1:  335c313faf43f x86/its: Add support for ITS-safe return thunk
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
     
    @@ Commit message
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
     
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
      . = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
      #endif
      
    @@ arch/x86/kernel/vmlinux.lds.S: PROVIDE(__ref_stack_chk_guard = __stack_chk_guard
     +
      #endif /* CONFIG_X86_64 */
      
    - /*
    + #ifdef CONFIG_KEXEC_CORE
     
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

