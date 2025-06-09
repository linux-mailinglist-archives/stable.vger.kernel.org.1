Return-Path: <stable+bounces-151971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1DEAD16DC
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6932216901D
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33583157A67;
	Mon,  9 Jun 2025 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SABb3ooL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCD2459D8
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436473; cv=none; b=df8dOnZWY+Km8KODW9MPv9iNFAjgAMA2iMJlsRkZiGnbkqFjKXFGJWqYfaeLFoCntJTJWL6PI784KeyekSAWMDhoANwFAwsinij6rgzqIFzZdk+qPtu0RV7G37koOR9u30YZ32V+hB4FsCtbgSAGDN7gRP7JUk5ERFalWQS5erE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436473; c=relaxed/simple;
	bh=c+Tv1076ANHe2ix5y8G640s5HkoAnUYA9Z82p2bhCeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFBOOHBvEFHj+kx92oaCCcI5kUjWq+L0b1+r6wERh5TOjSIQJerHefPmiOqrtfYt+tfrtKCxeiIq67GYSvupAJv788dXGAZn+f9Odt1+skIYUqyHj3LLQp38POqKzXtWB3lxlWHpD4wKwpX7CucBRoUKTYJPydD9Ks+Ks5/p0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SABb3ooL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F92C4CEEE;
	Mon,  9 Jun 2025 02:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436472;
	bh=c+Tv1076ANHe2ix5y8G640s5HkoAnUYA9Z82p2bhCeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SABb3ooLe1cJUicO0S9XRczQkCtl+gTHq0rL1YUYinj/lEox6ofe3znXydSfiZ1j2
	 p3Sl2q/g0KBKRGUVCaW6Uyo6uaZH5EihIaBaozJYxs6feengV9A84ny4V/fJyJuNWQ
	 JbCYD0ojWbmm7LO4+AXsiJYL6noRudJFSgn2QBuPAz3zb3AdbJ9WR6tLokF2eD2aZg
	 RnHevgeO0bdg052z//j2RV8QAOClJsKohdeK/AwEzd6aAJUXxG2p6NQgrIHvDxZnjv
	 sIQYNNR6j0fIXfEtwR4PLPwEanmdbiUCUTz6D3XwWYEXZ6PfdfOPwluK4qnKN79by5
	 gXBGpoRUW5/bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 7/9] arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
Date: Sun,  8 Jun 2025 22:34:30 -0400
Message-Id: <20250608165241-269c7c6580730a25@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-8-pulehui@huaweicloud.com>
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

Note: The patch differs from the upstream commit:
---
1:  0dfefc2ea2f29 ! 1:  f697b935a7719 arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
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
     @@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
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
      #include <asm/insn.h>
    - #include <asm/text-patching.h>
    -@@ arch/arm64/net/bpf_jit_comp.c: static void build_plt(struct jit_ctx *ctx)
    - 		plt->target = (u64)&dummy_tramp;
    + #include <asm/set_memory.h>
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
| stable/linux-6.1.y        |  Success    |  Success   |

