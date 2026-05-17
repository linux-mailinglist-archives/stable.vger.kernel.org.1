Return-Path: <stable+bounces-249141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMVvLlcJCmrqwAQAu9opvQ
	(envelope-from <stable+bounces-249141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:30:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496956321E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A40D300616C
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB03CD8A3;
	Sun, 17 May 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAMNtqdg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE13CA4B6;
	Sun, 17 May 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042622; cv=none; b=SmH3yEQnFzKoJopawrvh2ZKQjsOKRjnpQp3HdwaIRvHBqEt34a1RjZcmqVtymjnyN5S+9yeZjjutuzwMdFNdq7nMViuyRTSVr//zqR+D0DR85PZfG6ANQBJs0Q2VjeA0QlRn97jTwenRNlzS+uYGt18eOSV8tdzlLOBW0thg4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042622; c=relaxed/simple;
	bh=b7Znx/OybzjCtmUpCRxcsMjsUdouW3CnILoEXF2in9s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n9Kw0IgRAMsTzFm+fGQpF8t6n0ReKmUg13HsRLyVMbXUvTpXKz4pnibwORYJ92bbVbIyLbU4NwPCv4oDZtrYTLlR1l28NTz/vyJCVNg9HRCWrCi+e6VTIBw20xfdvConPAzKkVEgOblAIpJ/D7zp+4hE0/hXgEWMmB9SjmmhCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAMNtqdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908C0C2BCB0;
	Sun, 17 May 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042621;
	bh=b7Znx/OybzjCtmUpCRxcsMjsUdouW3CnILoEXF2in9s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SAMNtqdgMeS4Wh8Bt3ZBuE0QwzGyyvlWQeNwAQlsaCy6ypsCqBhoTUASnLP28/9sh
	 an6cwqBYpwF/gTUBRtEzRvAQjFbUwHmhg3cLyUGw/pFRoyGzM250yzWLjoZTVifB+y
	 guuPFuEPGYNxxTeFWpi+o/RTqnyD7Wv4/h6iud8BAyXMWN3NkPcZKxXu2+adJdEMhI
	 KLZoAC+hArrNpKq4TPuvhbbzJ5XAO2hUjfdeJ7bhmkWjdUALHEk6OJqxyQ0rDlDr6P
	 d6MGOH9bm8YVtO85kCbIN85hCKSu7sCtY4U8ksJtlXkRGdIDsBFnp/0idUjkwbEey6
	 KI60zjokL+IJQ==
Content-Type: multipart/mixed; boundary="===============4880274847310997673=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd8a7c45cebfb013732ee23ab22dc9e06a5e27d5e0d130f2bbe061eead6a3556@mail.kernel.org>
In-Reply-To: <20260517214043.12975-2-adubey@linux.ibm.com>
References: <20260517214043.12975-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:30:21 +0000 (UTC)
X-Rspamd-Queue-Id: 4496956321E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-249141-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============4880274847310997673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index f32de8704d4d..71e6e7d01057 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -214,8 +214,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>  int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>  		       u32 *addrs, int pass, bool extra_pass);
>  void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
>  int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
>  void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,

The header file arch/powerpc/net/bpf_jit.h is shared by both the 64-bit
(bpf_jit_comp64.c) and 32-bit (bpf_jit_comp32.c) BPF JIT compilers (per
arch/powerpc/net/Makefile). The patch updates these prototypes to add a
new 'u32 *fimage' parameter, and modifies the PPC64 implementation
(bpf_jit_comp64.c) and the shared file (bpf_jit_comp.c) accordingly.

However, arch/powerpc/net/bpf_jit_comp32.c is not updated. In that file,
bpf_jit_build_epilogue() still has the 2-argument signature:

  void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)

and its call to bpf_jit_build_fentry_stubs() passes only 2 arguments:

  bpf_jit_build_fentry_stubs(image, ctx);

Will this cause a function signature conflict under CONFIG_PPC32 builds
(CONFIG_PPC_BOOK3S_32, CONFIG_PPC_8xx, etc.) since the header now
declares the 3-argument prototype while the .c file defines the
2-argument version?

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 53ab97ad6074..ef7614177cb1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,34 @@ asm (
>  "	.popsection				;"
>  );
>
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
>
>  	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 */
> +#ifdef CONFIG_PPC64
> +	if (fimage && image) {

During pass 0 (where fimage and image are NULL), this condition evaluates
to false. The alignment NOP is not counted in proglen during size
calculation. During the final passes (1 and 2), if the NOP is emitted,
could this increase the instruction count beyond proglen and overflow into
the subsequent exception table or fixups?

> +		/*
> +		 * pc points to first instruction of OOL stub,
> +		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
> +		 *
> +		 * The decision to emit alignment NOP must depend on the alignment
> +		 * of dummy_tramp_addr field.
> +		 */
> +		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
> +		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
> +
> +		if (!IS_ALIGNED(pc, 8))
> +			EMIT(PPC_RAW_NOP());
> +	}

The alignment calculation appears to be incorrect. The code adds 4 or 3 to
the pc value, which is a byte address. Since PowerPC instructions are 4
bytes each, adding 4 or 3 bytes gives the wrong offset.

Looking at the OOL stub instructions that follow this block, with
CONFIG_PPC_FTRACE_OUT_OF_LINE there are 4 instructions (mflr r0; nop;
mtlr r0; b bpf_func+4). This produces a 16-byte offset (4 instructions * 4
bytes). Without the config, there are 3 instructions producing a 12-byte
offset.

The dummy_tramp_addr field would therefore be at pc+16 or pc+12, not pc+4
or pc+3.

For example, with CONFIG_PPC_FTRACE_OUT_OF_LINE enabled and pc 8-byte
aligned (pc%8 == 0):

- True dummy_tramp_addr position: pc+16, which is (pc+16)%8 == 0, already
  aligned.
- But the code calculates: pc += 4 -> pc+4, then !IS_ALIGNED(pc+4, 8) is
  true -> emits NOP.
- With the NOP, dummy_tramp_addr ends up at pc+4+16 = pc+20, and (pc+20)%8
  == 4, which is misaligned.

Similarly, when pc%8 == 4:

- True dummy_tramp_addr position: pc+16, which is (pc+16)%8 == 4, not
  aligned.
- But the code calculates: pc += 4 -> pc+4, then IS_ALIGNED(pc+4, 8) is
  true -> skips NOP.
- dummy_tramp_addr remains at pc+16, which is misaligned.

Does this flawed arithmetic force the code to emit a NOP when the target
address is already aligned, thereby misaligning it instead of aligning it?

> @@ -107,7 +131,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr = ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);
>  	}

Because fimage is strictly passed as NULL here, the if (fimage && image)
check in bpf_jit_build_fentry_stubs() will always evaluate to false. Will
this cause the alignment NOP to be unconditionally skipped for all inline
epilogues, leaving their dummy_tramp_addr fields unaligned?

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index db364d9083e7..885dc8cf55a2 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -398,7 +398,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>  	}
>  }
>
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>  {
>  	bpf_jit_emit_common_epilogue(image, ctx);
>
> @@ -407,7 +407,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>
>  	EMIT(PPC_RAW_BLR());
>
> -	bpf_jit_build_fentry_stubs(image, ctx);
> +	bpf_jit_build_fentry_stubs(image, fimage, ctx);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============4880274847310997673==--

