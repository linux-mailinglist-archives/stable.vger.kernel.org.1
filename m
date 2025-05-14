Return-Path: <stable+bounces-144429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E653EAB768F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B828C5FAB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD65295502;
	Wed, 14 May 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo/aYNvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD9293753
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253629; cv=none; b=dDNb797Yczv/o0l246oWuJN8Pi/0kxmhguDvrWeHbrQ1qMUBIg4Ug+BvEwp1bSfAvkNXoUKyPZN1LAYxC+5jyaie5cQy51NJ0pSlbJZLZ0vmqDATSm+A2EvuWG6yJqoL/YbWmFVGofUabdZ0jQv/6ixVqwTn20hlDk6mqepJstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253629; c=relaxed/simple;
	bh=b5zY5qvNW/JrVKkeGTfwRsNIz/S0D8fJDzva1CHBJbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZDWikMYXw8EWXOvsoIQih8efI2mPMNmhgMv/UobhcmybiAiQ08kuQN+tTDRtEZmt/wGl/zLb9x/zJ9lXvfZTXC6UwmofqJawlUSusGCFoaOe5aOGzRcVkyVvFWYltX1znWP2qIJfqAWkEb/Rzo8GX9lCA4qrYsUJn7SZ+1cCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo/aYNvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE72C4CEE3;
	Wed, 14 May 2025 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253628;
	bh=b5zY5qvNW/JrVKkeGTfwRsNIz/S0D8fJDzva1CHBJbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qo/aYNvcGjsoms7Se9ZEJ4XnJ9g71NwijN/N9qt+nVWKbWLS2UXkMypiKpC/PnSfH
	 arQYjclHJVCoAPyt7y6RGdLZVXf/sI3YwE9QNmuI7b2AyFGC+tT0BQSMCr4pwOO3a3
	 Ng3my/hL8nP29bduSsx5SwDhy+OFGqmMO9nO1VB9jXYaJdpogOypMUBbvqY/YKCNiT
	 o62RbqM448LgnPiXYuKPZfko8baXpJ4F3Bsp/s85CIURntQoMXfkOLpSjVNEUfGceB
	 i5IPT5BMBXca5AzYsp9ujLkVaM2PIBMw37OfQ00B/DzvDM7YVbJmsZnAO0MRp7tw3P
	 xx8UfGfEtLkkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 10/14] x86/its: Add support for ITS-safe return thunk
Date: Wed, 14 May 2025 16:13:45 -0400
Message-Id: <20250514112807-2257c01777a0878a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-10-90690efdc7e0@linux.intel.com>
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
6.14.y | Present (different SHA1: 308cb38001dc)
6.12.y | Present (different SHA1: 09f29041465a)
6.6.y | Present (different SHA1: 16103770be91)
6.1.y | Present (different SHA1: eb5018752a74)

Note: The patch differs from the upstream commit:
---
1:  a75bf27fe41ab ! 1:  7254fab50b115 x86/its: Add support for ITS-safe return thunk
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

