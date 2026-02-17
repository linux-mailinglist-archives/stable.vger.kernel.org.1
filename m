Return-Path: <stable+bounces-216783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKgxGqJLlGnfCAIAu9opvQ
	(envelope-from <stable+bounces-216783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:06:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C408614B274
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E29B30209CF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101E32ED2B;
	Tue, 17 Feb 2026 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMAiHrEy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFC324B3A;
	Tue, 17 Feb 2026 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326364; cv=none; b=C1vWJ10/lwnOtHxu6mZG7uAyi38+1KH78/ST2TGvPWT25ncMqhmTs/Sle6efUo5jLqYx4wAftQlrdzOq2NjJMrDaC4kEOjEhz4TBaErrmD5D0vI5GwkdVMSJRVdzJ+HE4Q/pGU54BQqtyCmvzarJDUy71nA2Uv3icGXvyWiq5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326364; c=relaxed/simple;
	bh=wc8NJ0oxE2FxeIyeicW60XgU9/Gu9bnFS0pijP9y5gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbpyM1G5ZAp26lh/xb5tMZjI6qJuCgwFXvxxWfhA3/9pIxQ6ubQfkKVIAjMlit2PpJYcqCm+CjxirB6SBON3zpLHbriOvN+Fmsr8pXf1Bt1hgUNcGESGIvpAXSa73xIO50II6DKCAJyVN1AwbuC82IgxAynjT4OfXdIWGVMgucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMAiHrEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE31C4CEF7;
	Tue, 17 Feb 2026 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771326364;
	bh=wc8NJ0oxE2FxeIyeicW60XgU9/Gu9bnFS0pijP9y5gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMAiHrEyq5BPuZRUGpbKuIUEU/N+2XkxUx6+DZ/ZE4I6AE7z5YKNCr21jXKIA92u9
	 awoiOHyEpwxaIW9jXnMeIOh89dDM9P1VPt9/GofZFosgmsTG2/HLVBP4XnJnd6ssCq
	 8fBOdqSLNidbsAW81MHxj/zqdJU7WT19GTfPbLeU=
Date: Tue, 17 Feb 2026 12:06:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH V2 for 6.6 & 6.12] LoongArch: Rework KASAN initialization
 for PTW-enabled systems
Message-ID: <2026021735-scorebook-cheese-25d3@gregkh>
References: <20260216142550.1479337-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216142550.1479337-1-chenhuacai@loongson.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216783-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,loongson.cn:email]
X-Rspamd-Queue-Id: C408614B274
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:25:50PM +0800, Huacai Chen wrote:
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.
> 
> kasan_init_generic() indicates that kasan is fully initialized, so it
> should be put at end of kasan_init().
> 
> Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
> on PTW-enabled systems, here are the call chains:
> 
>     kernel_entry()
>       start_kernel()
>         setup_arch()
>           kasan_init()
>             kasan_init_generic()
> 
> The reason is PTW-enabled systems have speculative accesses which means
> memory accesses to the shadow memory after kasan_init() may be executed
> by hardware before. However, accessing shadow memory is safe only after
> kasan fully initialized because kasan_init() uses a temporary PGD table
> until we have populated all levels of shadow page tables and writen the
> PGD register. Moving kasan_init_generic() later can defer the occasion
> of kasan_enabled(), so as to avoid speculative accesses on shadow pages.
> 
> After moving kasan_init_generic() to the end, kasan_init() can no longer
> call kasan_mem_to_shadow() for shadow address conversion because it will
> always return kasan_early_shadow_page. On the other hand, we should keep
> the current logic of kasan_mem_to_shadow() for both the early and final
> stage because there may be instrumentation before kasan_init().
> 
> To solve this, we factor out a new mem_to_shadow() function from current
> kasan_mem_to_shadow() for the shadow address conversion in kasan_init().
> 
> [ Huacai: To backport from upstream to 6.6 & 6.12, kasan_enabled() is
>           replaced with kasan_arch_is_ready() and kasan_init_generic()
>           is replaced with "kasan_early_stage = false". ]
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/kasan_init.c | 77 ++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
> index d2681272d8f0..9337380a70eb 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -42,39 +42,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  
>  bool kasan_early_stage = true;
>  
> -void *kasan_mem_to_shadow(const void *addr)
> +static void *mem_to_shadow(const void *addr)
>  {
> -	if (!kasan_arch_is_ready()) {
> +	unsigned long offset = 0;
> +	unsigned long maddr = (unsigned long)addr;
> +	unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
> +
> +	if (maddr >= FIXADDR_START)
>  		return (void *)(kasan_early_shadow_page);
> -	} else {
> -		unsigned long maddr = (unsigned long)addr;
> -		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
> -		unsigned long offset = 0;
> -
> -		if (maddr >= FIXADDR_START)
> -			return (void *)(kasan_early_shadow_page);
> -
> -		maddr &= XRANGE_SHADOW_MASK;
> -		switch (xrange) {
> -		case XKPRANGE_CC_SEG:
> -			offset = XKPRANGE_CC_SHADOW_OFFSET;
> -			break;
> -		case XKPRANGE_UC_SEG:
> -			offset = XKPRANGE_UC_SHADOW_OFFSET;
> -			break;
> -		case XKPRANGE_WC_SEG:
> -			offset = XKPRANGE_WC_SHADOW_OFFSET;
> -			break;
> -		case XKVRANGE_VC_SEG:
> -			offset = XKVRANGE_VC_SHADOW_OFFSET;
> -			break;
> -		default:
> -			WARN_ON(1);
> -			return NULL;
> -		}
>  
> -		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
> +	maddr &= XRANGE_SHADOW_MASK;
> +	switch (xrange) {
> +	case XKPRANGE_CC_SEG:
> +		offset = XKPRANGE_CC_SHADOW_OFFSET;
> +		break;
> +	case XKPRANGE_UC_SEG:
> +		offset = XKPRANGE_UC_SHADOW_OFFSET;
> +		break;
> +	case XKPRANGE_WC_SEG:
> +		offset = XKPRANGE_WC_SHADOW_OFFSET;
> +		break;
> +	case XKVRANGE_VC_SEG:
> +		offset = XKVRANGE_VC_SHADOW_OFFSET;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return NULL;
>  	}
> +
> +	return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
> +}
> +
> +void *kasan_mem_to_shadow(const void *addr)
> +{
> +	if (kasan_arch_is_ready())
> +		return mem_to_shadow(addr);
> +	else
> +		return (void *)(kasan_early_shadow_page);
>  }
>  
>  const void *kasan_shadow_to_mem(const void *shadow_addr)
> @@ -295,10 +299,8 @@ void __init kasan_init(void)
>  	/* Maps everything to a single page of zeroes */
>  	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE, true);
>  
> -	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
> -					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
> -
> -	kasan_early_stage = false;
> +	kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_START),
> +					mem_to_shadow((void *)KFENCE_AREA_END));
>  
>  	/* Populate the linear mapping */
>  	for_each_mem_range(i, &pa_start, &pa_end) {
> @@ -308,13 +310,13 @@ void __init kasan_init(void)
>  		if (start >= end)
>  			break;
>  
> -		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
> -			(unsigned long)kasan_mem_to_shadow(end), NUMA_NO_NODE);
> +		kasan_map_populate((unsigned long)mem_to_shadow(start),
> +			(unsigned long)mem_to_shadow(end), NUMA_NO_NODE);
>  	}
>  
>  	/* Populate modules mapping */
> -	kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
> -		(unsigned long)kasan_mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
> +	kasan_map_populate((unsigned long)mem_to_shadow((void *)MODULES_VADDR),
> +		(unsigned long)mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
>  	/*
>  	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so we
>  	 * should make sure that it maps the zero page read-only.
> @@ -329,5 +331,6 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> +	kasan_early_stage = false;
>  	pr_info("KernelAddressSanitizer initialized.\n");
>  }
> -- 
> 2.52.0
> 
> 

Does not apply to 6.6.y, I get the following error:

checking file arch/loongarch/mm/kasan_init.c
Hunk #1 FAILED at 42.
Hunk #2 succeeded at 290 (offset -5 lines).
Hunk #3 succeeded at 301 (offset -5 lines).
Hunk #4 succeeded at 322 (offset -5 lines).
1 out of 4 hunks FAILED

