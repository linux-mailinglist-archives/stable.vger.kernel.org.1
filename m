Return-Path: <stable+bounces-272149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uGCKDsVbS2oSQAEAu9opvQ
	(envelope-from <stable+bounces-272149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:39:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A526770DA7D
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:39:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272149-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272149-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFA03303E11F
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185B3FBEA2;
	Mon,  6 Jul 2026 07:31:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17723F5BD6;
	Mon,  6 Jul 2026 07:31:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323078; cv=none; b=j9CJNE5rwvVIXy2Ev2ZbdOeMQovCENtDV4SmR95i8QR1iYPKmIq63WInELr40Qgz7sXb+Oc7uKAxg/jiOGgbJTbG9/OmBGzVoaX/RNsPxCNy9CO8pXyZGkIdz8wbA8i4tCBxru3gcfuiXWOp8MUKpANQOeWWr5KsowZB8ktH9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323078; c=relaxed/simple;
	bh=VTUXD5kKEwznD7W5jqv90+90DnujuyknXSC1WzcX7Q8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VIBmwkqV4fMoR8cQ+Kjuji109YisYx5nHZ15e9pMU7PuETI+3XSTzBH/TMx5EpjBk2oG2Jka0AWgJWwypitpEf6QxD4VxeLliFMbHqsrnn64CthzXA4lPTfXdTpTbLZvEKuIhbr5XC3mGSFOUDGv4iQ91u4qOABqhW3OGqD4wVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx9+q4WUtqBlUAAA--.1571S3;
	Mon, 06 Jul 2026 15:31:04 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuSyWUtq8fIBAA--.11922S3;
	Mon, 06 Jul 2026 15:30:59 +0800 (CST)
Subject: Re: [PATCH bpf v2] LoongArch: BPF: Fix tail call count pointer offset
 for arena programs
To: George Guo <dongtai.guo@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Hengqi Chen <hengqi.chen@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, George Guo <guodongtai@kylinos.cn>,
 bpf@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625083212.277417-1-dongtai.guo@linux.dev>
 <20260629085511.359546-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d1fb11ae-b1a7-f2c0-6eef-58cf6c8c7d7e@loongson.cn>
Date: Mon, 6 Jul 2026 15:30:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260629085511.359546-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuSyWUtq8fIBAA--.11922S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1fWw15Gr43CFW3Xr4DZFc_yoWrXF45pr
	4UAF4xKrWDXr4xAF47K3y0vr15K395ZrW3GF17Cr95CFnIvr1rWFyFg3yUWFy5uw4rJr18
	Xrs09r4a9a98A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
	6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	T7K3UUUUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_FROM(0.00)[bounces-272149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,gmail.com,iogearbox.net];
	FORGED_SENDER(0.00)[yangtiezhu@loongson.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:dongtai.guo@linux.dev,m:chenhuacai@kernel.org,m:hengqi.chen@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kernel@xen0n.name,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:guodongtai@kylinos.cn,m:bpf@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hengqichen@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[xen0n.name,linux.dev,gmail.com,kylinos.cn,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangtiezhu@loongson.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,loongson.cn:from_mime,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A526770DA7D

On 2026/6/29 下午4:55, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> The tail call count (TCC) and its pointer occupy the two deepest slots of
> the callee-saved area set up by build_prologue(). An arena program reserves
> one extra word for REG_ARENA (arena_vm_start) right above them:
> 
>      ra fp s0 s1 s2 s3 s4 s5      <- 8 words
>      [ REG_ARENA ]                <- only if ctx->arena_vm_start
>      tail_call_cnt
>      tail_call_cnt_ptr            <- loaded on tail call / bpf2bpf call
> 
> BPF_TAIL_CALL_CNT_PTR_STACK_OFF() hardcodes the pointer at
> round_up(stack, 16) - 80, which is only correct when REG_ARENA is absent.
> For an arena program the extra word shifts every slot below it down by 8
> bytes, so the macro resolves to the tail_call_cnt slot (the counter value)
> instead of tail_call_cnt_ptr. The JIT then loads the counter value and
> dereferences it as the TCC pointer, corrupting memory or panicking the
> kernel whenever an arena program performs a tail call or a bpf2bpf call.
> 
> Replace the macro with a helper that accounts for the REG_ARENA slot,
> mirroring the reservation logic in build_prologue().
> 
> Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> v2:
>   - Dropped the second patch ("Don't charge an empty prog_array slot to
>     the tail call count"); that off-by-one was fixed independently by
>     commit 0379d10f09bc ("LoongArch: BPF: Fix off-by-one error in tail
>     call"), now in 7.2-rc1. The arena tail call count pointer offset bug
>     addressed here is independent and still unfixed.
>   - No code change; reworded the commit message and rebased on 7.2-rc1.
>   - v1: https://lore.kernel.org/all/20260625083212.277417-1-dongtai.guo@linux.dev
> 
>   arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ad7e28375aa9..5e34e9e3f508 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -25,7 +25,23 @@
>   
>   #define REG_TCC		LOONGARCH_GPR_A6
>   #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
> -#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
> +
> +static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
> +{
> +	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
> +	 * tail call count plus its pointer, which occupy the two deepest
> +	 * slots of the callee-saved area.
> +	 */
> +	int offset = sizeof(long) * 10;
> +
> +	/* An arena program reserves one extra word above them (REG_ARENA),
> +	 * which pushes the tail call count pointer down by one slot.
> +	 */
> +	if (ctx->arena_vm_start)
> +		offset += sizeof(long);
> +
> +	return round_up(ctx->stack_size, 16) - offset;
> +}
>   
>   static const int regmap[] = {
>   	/* return value from in-kernel function, and exit value for eBPF program */
> @@ -291,7 +307,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>   static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>   {
>   	int off, tc_ninsn = 0;
> -	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> +	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
>   	u8 a1 = LOONGARCH_GPR_A1;
>   	u8 a2 = LOONGARCH_GPR_A2;
>   	u8 t1 = LOONGARCH_GPR_T1;
> @@ -1181,7 +1197,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			return ret;
>   
>   		if (insn->src_reg == BPF_PSEUDO_CALL) {
> -			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> +			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
>   			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
>   		}
>   
> 

Please see the discussion in the other thread:

https://lore.kernel.org/loongarch/d7f2c8d3-4a46-e978-5cce-f59b84e632f0@loongson.cn/

Thanks,
Tiezhu


