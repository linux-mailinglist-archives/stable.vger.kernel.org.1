Return-Path: <stable+bounces-249201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI5BLcq+CmpX7QQAu9opvQ
	(envelope-from <stable+bounces-249201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:24:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988E567756
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC5DB304BF3C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E63CF682;
	Mon, 18 May 2026 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGTwO8zm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5676262A6;
	Mon, 18 May 2026 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088734; cv=none; b=i8d2JDqySKjUSFyqK4DRPJZlEEiBIcSDSV35pqQkvaelJGf3rLXaEfR7HemC1dmnTnIyw+u1ptd4OE0prsTepvAdrqXYjlani7o9/EvJEnq7JgwzUtFoDYAUEgYzlT0414WyZsnhivNPdmCaj9KE5SnkIwIzC7NX/XXKMbN8rXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088734; c=relaxed/simple;
	bh=XoJ/i+/eqolz953eatJosJCdVVaNezu4KjMcKKloSm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbqGKfYcD1dMdpgT+UNgDWLWMjuzj2KGTQyQKncOH4+3nqEYkoXPrwny1b7qBqkjMwfaJnQCPr+UQCj5AOjO5+B/99pJm06ldiyhhqKizEa9Xzosapc3VfLUtDD331CSYfdRajPeyITABAWQ3b1AGY7vIf4TQZAXal7NZHiDXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGTwO8zm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HL8WHg2191659;
	Mon, 18 May 2026 07:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tdonT6
	B55BW84bdqXxf557pmW2x2pBu7kQd5eLz1Dd0=; b=SGTwO8zmNuGLDi5ALg84PC
	ce0s+YkCZkwIwrFo1cEJlp+4X9lsphRry0rqVHPRtC3dYmiT+sg/nJEULnFekTQq
	7I6MAVkgbjERAkURYaH2oEDedoEL9fSXHbLIvrTU6+VfD5WBt8djRZn7iL8hsImX
	UJ3Dt8zc2W9Yzyv3p2zGkxGxJvCSOhZmWrRruRN2q5EZ/sEWcWbWHf6FpagYijnc
	0/LZwOLeuTOy+HICo+UUetrdqRaQllDMAJBTBkCUcLrSQjIENmXZ7vyA2+K5Gz7p
	0K5w6hkSkPj8Z3SpO1siqE19AkKYwvisLq9VyTgN0u+3dLjY+Xx7LXfOQN971Isw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havxas8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:18:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I79Ea4026970;
	Mon, 18 May 2026 07:18:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhcmyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:18:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I7IU8m49938864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 07:18:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEA132004B;
	Mon, 18 May 2026 07:18:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B24920043;
	Mon, 18 May 2026 07:18:28 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 07:18:27 +0000 (GMT)
Message-ID: <59f32b35-f7ee-4a63-860c-4a718c454235@linux.ibm.com>
Date: Mon, 18 May 2026 12:48:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] powerpc/bpf: fix alignment of long branch
 trampoline address
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
 <20260517214043.12975-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260517214043.12975-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2NyBTYWx0ZWRfX0ooaaDijMoHk
 7BTneO9KK5jDpNdNFYSNgW+uNWW3nGADLFPb0iIHbbrnCfQCtAZsUsPcoPBUBlalcgTdq28uyTK
 SiDXnd3NDIWpn58+8Ub92dOdAA30zhBlzz1KyksCxldK/8SyqBP6MN6di/gHx2fZkR0G1kmu/38
 qBLI1u1YLF1gpjJNdSXKW33Dfxy6oQJtQiq8DNMZuuXO2/oVkNkDcNhYeP+/wyOZhtPVQYblz9e
 0xNh5ABI62ZAJCeWjw0b+s6wQxIL84FfxA+hK4BAVbqfu6JZDPnPGxKgMEUjbkyZ40Svwh5wGci
 +AQKjJG/dU77KmDNc4wYndAPCwywmGyHaTyfs2zeXvKp82tN5wSNPh4o1Jy4tumUENvdKXlC6AZ
 9IHIeCglWsh0P9L36FbGyQPq2NeCUk44AILzzdc6bpc69SY+yodz7++TDto31oOCg+Vg6qLmB3g
 NF1xTtNScf8DUaA+E4w==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0abd4b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=fwpwmEBc9gXJVyXe0-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d9ydQTc_I8HJtTAlvDp-OpcI-EHUiEgX
X-Proofpoint-GUID: d9ydQTc_I8HJtTAlvDp-OpcI-EHUiEgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180067
X-Rspamd-Queue-Id: 7988E567756
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-249201-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 18/05/26 3:10 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 8-byte aligned, for memory compatibility
> when content loaded to a register.
> 
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  4 ++--
>   arch/powerpc/net/bpf_jit_comp.c   | 34 ++++++++++++++++++++++++++-----
>   arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
>   3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index f32de8704d4d..71e6e7d01057 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -214,8 +214,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>   		       u32 *addrs, int pass, bool extra_pass);
>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
>   void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 53ab97ad6074..ef7614177cb1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,34 @@ asm (
>   "	.popsection				;"
>   );
>   
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
>   
>   	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 */
> +#ifdef CONFIG_PPC64
> +	if (fimage && image) {
> +		/*
> +		 * pc points to first instruction of OOL stub,
> +		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
> +		 *
> +		 * The decision to emit alignment NOP must depend on the alignment
> +		 * of dummy_tramp_addr field.

This makes it easier to read instead of the XOR matrix..

> +		 */
> +		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);

> +		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;

The above line should be:

pc += (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3) * 4;


> +
> +		if (!IS_ALIGNED(pc, 8))
> +			EMIT(PPC_RAW_NOP());
> +	}
> +#endif
> +
> +	/*      nop     // optional, for alignment of dummy_tramp_addr
>   	 * Out-of-line stub:
>   	 *	mflr	r0
>   	 *	[b|bl]	tramp
> @@ -70,7 +93,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>
> +	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
>   	 *	mflr	r12
> @@ -81,6 +104,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   	 */
>   	if (image)
>   		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> +
>   	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
> @@ -107,7 +131,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);
>   	}
>   
>   	return 0;
> @@ -286,7 +310,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	bpf_jit_build_prologue(NULL, &cgctx);
>   	addrs[fp->len] = cgctx.idx * 4;
> -	bpf_jit_build_epilogue(NULL, &cgctx);
> +	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
>   
>   	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
>   	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
> @@ -318,7 +342,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			bpf_jit_binary_pack_free(fhdr, hdr);
>   			goto out_err;
>   		}
> -		bpf_jit_build_epilogue(code_base, &cgctx);
> +		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
>   
>   		if (bpf_jit_enable > 1)
>   			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index db364d9083e7..885dc8cf55a2 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -398,7 +398,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>   	}
>   }
>   
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	bpf_jit_emit_common_epilogue(image, ctx);
>   
> @@ -407,7 +407,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>   
>   	EMIT(PPC_RAW_BLR());
>   
> -	bpf_jit_build_fentry_stubs(image, ctx);
> +	bpf_jit_build_fentry_stubs(image, fimage, ctx);
>   }
>   
>   /*


