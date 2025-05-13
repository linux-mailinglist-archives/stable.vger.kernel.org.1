Return-Path: <stable+bounces-144235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2BBAB5CB9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6BE4A278D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F22BEC3F;
	Tue, 13 May 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jscH5CCm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445E1B3950
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162166; cv=none; b=ulAR9ORTkxV35ooO66T97qr5zPbfqOwzdwX5ITE+aW45tZKbXsO32HoQA/nnIEoePK7jaXn+h0ouVmaWZMSSqEPjEIXOTwfUu4M7hMqDE7+6VtwsWAnA+duvJfnCwFThrVxVEkCow3ZgNuN79R3CWKqMPm1W/ExX/8g5K0NX4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162166; c=relaxed/simple;
	bh=5hxtuwU6WUqhe0pgzVeDNjW8r6ligZAOmo2QsIvo+r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUuvykkA/rqHCbChJUX4sIax8VS4E0Xm5AkEJ/xwXDw0Z2q5ga8gC5366clQ4rSzIHaSW/GsBXCfYqBpNDNJHflnKClvhiNzHysYYqXjNpOo6sEobKSaz5OY58uqr5yq5kVwy+I1P1XrTrJ0bD3gcOdmB6OWatEYmD+zBjYJ8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jscH5CCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41EC4CEEB;
	Tue, 13 May 2025 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162166;
	bh=5hxtuwU6WUqhe0pgzVeDNjW8r6ligZAOmo2QsIvo+r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jscH5CCm9DTxOFEGMd3I44Ugd7uCCWPc/BM2YIqbqykwOEQhEz2T87MmqHUosyS/z
	 K8CLgtGr2vJL1EXh5NrYrdgpCHEl7YAqTaYOiujsQofngN/sKR0eSOJRxni+D/PHdA
	 wWqPUOpc3sB4hX9Zn1PK5BDS02It6Cr9ZIDIGSAo13SXAXOXxnjuWwzixrIJaGCfgG
	 t1J1edjODY2crmVfdPMO/CxkhPFKbd0a/kE2LSZZyAcSJiEdDMQLZSqWl47hNnuiBi
	 jHXTa9H9nlQiHsygRGPxJENe1y/j0Y/8cW+PNrFfbC8flWB7fWr7dL8xJfoAuRMN9C
	 6C9wNjeieAcJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 10/14] x86/its: Add support for ITS-safe return thunk
Date: Tue, 13 May 2025 14:49:22 -0400
Message-Id: <20250513135428-205a063810242422@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-10-6a536223434d@linux.intel.com>
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
1:  a75bf27fe41ab ! 1:  8baf62c74291b x86/its: Add support for ITS-safe return thunk
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

