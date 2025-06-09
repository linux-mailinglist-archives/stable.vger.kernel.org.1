Return-Path: <stable+bounces-151984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F887AD16EC
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389A7188ABC4
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81442459D7;
	Mon,  9 Jun 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD63paHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE42459D5
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436499; cv=none; b=B05iRe5/YNJkbUcXXbwVasyDXKACi6NGLVVuUXiD4Z/7vzjZfWQGjjdurG3rYi0W65hweb8qA2SPhteBUZYeZ2AaLYFQywbFT15rGf10qwFGWAPZRR8dWkIMjrIzaS5E57Ih9aqMazYK0rSZ5QIAcee7AJqbGHAdBBTgL/xIDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436499; c=relaxed/simple;
	bh=Krm1/Eyc1FroGZOLrQyBIFLbDdy5xJUDsyhTk7BO0lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkajQ2AAbiGzoK0wMBZ554fnn+POQRnxgWWFABFoQ4Pbn8LxuIrJk2rbG+NqlAKs6QIj6SU6v0OUslc73O8qzsxAtdxmhXR2VPxxlAm2FU+teYcH23hl3Mvg4zUDD/ydufVWao2l2eVoJ9YEnTvtLTBoVWz1KZAKCfqGq3er8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD63paHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBB0C4CEEE;
	Mon,  9 Jun 2025 02:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436499;
	bh=Krm1/Eyc1FroGZOLrQyBIFLbDdy5xJUDsyhTk7BO0lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hD63paHKR3YaFIzXleaPFFHJ7hvinvtYXvN0bViCT4dSLdcy27tjvYIR8LC40eiHs
	 QgKEI+Vbaz39qgppGD4kbw2ZJoUlFBssPmrHqYwLuNyu/l1Az03wKeXQbEP2h1Xwx5
	 +e7hRXamO87eMR3IZ08HPFJGryrnyNXhIRs9/0AHdOpfrn1D+owH7ILduusbjF3LpN
	 I8WLLJgTBH21aJm7iYfqca+9KfxSmwhnRxyhz4wmQfQFc5D6u3xfUX5gQQ91ILGKNV
	 ixRloJBqhu3Ip8frLxvqvN4NLrLY337ISxVS5RBjJizh3GSpOX/AKG2kVmNj/4siF1
	 QY6LLUfKVjnsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 12/14] arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
Date: Sun,  8 Jun 2025 22:34:57 -0400
Message-Id: <20250608202626-b032632786bcf82b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-13-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 0dfefc2ea2f29ced2416017d7e5b1253a54c2735

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 852b8ae934b5)
6.12.y | Present (different SHA1: 38c345fd54af)
6.6.y | Present (different SHA1: 42a20cf51011)
6.1.y | Present (different SHA1: 8fe5c37b0e08)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0dfefc2ea2f29 ! 1:  450e9a287d5b4 arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
    @@ Metadata
      ## Commit message ##
         arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
     
    +    [ Upstream commit 0dfefc2ea2f29ced2416017d7e5b1253a54c2735 ]
    +
         A malicious BPF program may manipulate the branch history to influence
         what the hardware speculates will happen next.
     
    @@ Commit message
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
         Acked-by: Daniel Borkmann <daniel@iogearbox.net>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/spectre.h ##
    -@@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
    +@@ arch/arm64/include/asm/spectre.h: void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
      
      enum mitigation_state arm64_get_spectre_bhb_state(void);
      bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
    @@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state
      void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
     
      ## arch/arm64/kernel/proton-pack.c ##
    -@@ arch/arm64/kernel/proton-pack.c: static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
    - 	isb();
    - }
    +@@ arch/arm64/kernel/proton-pack.c: static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { }
    + #endif /* CONFIG_KVM */
      
    + static bool spectre_bhb_fw_mitigated;
     -static bool __read_mostly __nospectre_bhb;
     +bool __read_mostly __nospectre_bhb;
      static int __init parse_spectre_bhb_param(char *str)
    @@ arch/arm64/net/bpf_jit_comp.c
     +#include <linux/arm-smccc.h>
      #include <linux/bitfield.h>
      #include <linux/bpf.h>
    ++#include <linux/cpu.h>
      #include <linux/filter.h>
    -@@
    - #include <asm/asm-extable.h>
    + #include <linux/printk.h>
    + #include <linux/slab.h>
    + 
      #include <asm/byteorder.h>
      #include <asm/cacheflush.h>
     +#include <asm/cpufeature.h>
      #include <asm/debug-monitors.h>
    - #include <asm/insn.h>
    - #include <asm/text-patching.h>
    -@@ arch/arm64/net/bpf_jit_comp.c: static void build_plt(struct jit_ctx *ctx)
    - 		plt->target = (u64)&dummy_tramp;
    + #include <asm/set_memory.h>
    + 
    +@@ arch/arm64/net/bpf_jit_comp.c: static int emit_bpf_tail_call(struct jit_ctx *ctx)
    + #undef jmp_offset
      }
      
     -static void build_epilogue(struct jit_ctx *ctx)
    @@ arch/arm64/net/bpf_jit_comp.c: static void build_plt(struct jit_ctx *ctx)
     +static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
      {
      	const u8 r0 = bpf2a64[BPF_REG_0];
    - 	const u8 ptr = bpf2a64[TCCNT_PTR];
    + 	const u8 r6 = bpf2a64[BPF_REG_6];
     @@ arch/arm64/net/bpf_jit_comp.c: static void build_epilogue(struct jit_ctx *ctx)
    - 
    - 	emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
    + 	emit(A64_POP(r8, r9, A64_SP), ctx);
    + 	emit(A64_POP(r6, r7, A64_SP), ctx);
      
     +	if (was_classic)
     +		build_bhb_mitigation(ctx);
    @@ arch/arm64/net/bpf_jit_comp.c: static void build_epilogue(struct jit_ctx *ctx)
     +	/* Move the return value from bpf:r0 (aka x7) to x0 */
      	emit(A64_MOV(1, A64_R(0), r0), ctx);
      
    - 	/* Authenticate lr */
    + 	emit(A64_RET(A64_LR), ctx);
     @@ arch/arm64/net/bpf_jit_comp.c: struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
      	}
      
      	ctx.epilogue_offset = ctx.idx;
     -	build_epilogue(&ctx);
     +	build_epilogue(&ctx, was_classic);
    - 	build_plt(&ctx);
      
    - 	extable_align = __alignof__(struct exception_table_entry);
    + 	extable_size = prog->aux->num_exentries *
    + 		sizeof(struct exception_table_entry);
     @@ arch/arm64/net/bpf_jit_comp.c: struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
    - 		goto out_free_hdr;
    + 		goto out_off;
      	}
      
     -	build_epilogue(&ctx);
     +	build_epilogue(&ctx, was_classic);
    - 	build_plt(&ctx);
      
    - 	/* Extra pass to validate JITed code. */
    + 	/* 3. Extra pass to validate JITed code. */
    + 	if (validate_code(&ctx)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

