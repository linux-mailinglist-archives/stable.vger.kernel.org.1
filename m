Return-Path: <stable+bounces-146168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386ACAC1D3C
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 08:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5892B16EFD7
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7391A0BF3;
	Fri, 23 May 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jB1Cz9ji"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAC2DCBE6
	for <stable@vger.kernel.org>; Fri, 23 May 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747982623; cv=none; b=YFHjRWv9Hx3mqvXMI5Cc/pFo+SGIzNVV+0W0zmZ1CpeQqr0AzSuiPyVnCaPeXgZ6sJViaRG7OC84Hc76nIdWwQuBMwvsP/HS2sgCqpgYe57P5kc/GmAD1rENCXnZVsUtN8gkfAfwX99f7BJ03Y5a1Jmbn+kWFLMhp5dreYOe0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747982623; c=relaxed/simple;
	bh=K3LHh5smnTrZnCr6oGKjBk9SCGo95PI4g5B2KlxG7jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoNXk8KUmMrC43mpq4AzWIQzvmUTEP07Oh4r2ymssa9RsXJdw24WpdJjk6b7foFz3n2m5dYTPTN+SDXnr9Y4EBU1vAmUtd3p4zGl2xYc7svvCxYzv+K1xgk3whmiez8VZh99+EFM1Aw2W+uXmEEE+RfafyHF77mesp7bPSTpAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jB1Cz9ji; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c491ab26-dc44-4bc9-b481-29b4ba62f658@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747982610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJJ+pU32sx4Yy5ZF3W5MNBuswj8wCkrqLbPd3tq++B0=;
	b=jB1Cz9jiqVkv9BvLbBNgmCOtxZSMQbwz1d6pHZXR4QNG13vaLZqWjpkRAbfxLBxUtm8wUd
	+TyLBdLJR2sYg8L2DegSjzC+QdJHHeGjPwlziVju7AIvFtI1WeE0TYFjLKRqFjCdI7K0+b
	0adK55YH+Y+7lijAyVxRS5dlFPZ45Z8=
Date: Fri, 23 May 2025 14:43:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
 Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, WANG Rui <wangrui@loongson.cn>
References: <20250522125050.2215157-1-chenhuacai@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250522125050.2215157-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 5/22/25 8:50 PM, Huacai Chen 写道:
> When building kernel with LLVM there are occasionally such errors:
> 
> In file included from ./include/linux/spinlock.h:59:
> In file included from ./include/linux/irqflags.h:17:
> arch/loongarch/include/asm/irqflags.h:38:3: error: must not be $r0 or $r1
>     38 |                 "csrxchg %[val], %[mask], %[reg]\n\t"
>        |                 ^
> <inline asm>:1:16: note: instantiated into assembly here
>      1 |         csrxchg $a1, $ra, 0
>        |                       ^
> 
> The "mask" of the csrxchg instruction should not be $r0 or $r1, but the
> compiler cannot avoid generating such code currently. So force to use t0
> in the inline asm, in order to avoid using $r0/$r1.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   arch/loongarch/include/asm/irqflags.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
> index 319a8c616f1f..003172b8406b 100644
> --- a/arch/loongarch/include/asm/irqflags.h
> +++ b/arch/loongarch/include/asm/irqflags.h
> @@ -14,40 +14,48 @@
>   static inline void arch_local_irq_enable(void)
>   {
>   	u32 flags = CSR_CRMD_IE;
> +	register u32 mask asm("t0") = CSR_CRMD_IE;
> +
>   	__asm__ __volatile__(
>   		"csrxchg %[val], %[mask], %[reg]\n\t"
>   		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
>   		: "memory");
>   }
>   
>   static inline void arch_local_irq_disable(void)
>   {
>   	u32 flags = 0;
> +	register u32 mask asm("t0") = CSR_CRMD_IE;
> +
>   	__asm__ __volatile__(
>   		"csrxchg %[val], %[mask], %[reg]\n\t"
>   		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
>   		: "memory");
>   }
>   
>   static inline unsigned long arch_local_irq_save(void)
>   {
>   	u32 flags = 0;
> +	register u32 mask asm("t0") = CSR_CRMD_IE;
> +
>   	__asm__ __volatile__(
>   		"csrxchg %[val], %[mask], %[reg]\n\t"
>   		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
>   		: "memory");
>   	return flags;
>   }
>   
>   static inline void arch_local_irq_restore(unsigned long flags)
>   {
> +	register u32 mask asm("t0") = CSR_CRMD_IE;
> +
>   	__asm__ __volatile__(
>   		"csrxchg %[val], %[mask], %[reg]\n\t"
>   		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
>   		: "memory");
>   }
>   


