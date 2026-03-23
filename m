Return-Path: <stable+bounces-229975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wACzBEqDwWnATgQAu9opvQ
	(envelope-from <stable+bounces-229975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E462FB162
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E05A332B122
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B533BED75;
	Mon, 23 Mar 2026 16:52:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE293B2FC6;
	Mon, 23 Mar 2026 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284776; cv=none; b=sAjdeV+lC+HT/IOgi7Q/Cp2DuTNEZQCUBaoScrK56CEvqvfrR8ADu0La4zPsQA/Fg9Xbq+Ql1gPojiZL43ZYQKzWwWhN4lOFw92gE8RjL97BphcFxDi8/TWpJJNnjaOeCMKc+shjne1lBr3hFME7jjqyG1kb3+bf7PTNx2h271g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284776; c=relaxed/simple;
	bh=/G2Xfa4BBLTfPc6udUHxh6tIMJj57mjoBsV95yr/xco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTZlBjD8IYguHTn67r9jkHOGMPPo2veO88IbcbULvdIJYEEr3nfimlFf0gCr21xiU3g4Uqq/31ybtXLnzZ1LjH4rzq1wcI80PyAcqgkV1Q4WYnkZ2mQ9W9fg7YPrZV22x9Drj8xP9vwrbqpVqUFO6cgytY85bnwuDX6HNY5yp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 201FD14BF;
	Mon, 23 Mar 2026 09:52:48 -0700 (PDT)
Received: from [10.57.58.207] (unknown [10.57.58.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68A33F73B;
	Mon, 23 Mar 2026 09:52:51 -0700 (PDT)
Message-ID: <71261065-7895-492f-8457-998901391530@arm.com>
Date: Mon, 23 Mar 2026 17:52:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-2-ryan.roberts@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323130317.1737522-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229975-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69E462FB162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 14:03, Ryan Roberts wrote:
> [...]
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 96711b8578fd0..b9b248d24fd10 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -350,7 +350,6 @@ void __init arch_mm_preinit(void)
>  	}
>  
>  	swiotlb_init(swiotlb, flags);
> -	swiotlb_update_mem_attributes();
>  
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can be
> @@ -377,6 +376,14 @@ void __init arch_mm_preinit(void)
>  	}
>  }
>  
> +bool page_alloc_available __ro_after_init;
> +
> +void __init mem_init(void)
> +{
> +	page_alloc_available = true;
> +	swiotlb_update_mem_attributes();

The move seems reasonable, x86 calls this function even later (from
arch_cpu_finalize_init()).

> +}
> +
>  void free_initmem(void)
>  {
>  	void *lm_init_begin = lm_alias(__init_begin);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a6a00accf4f93..5b6a8d53e64b7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -773,14 +773,33 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>  {
>  	int ret;
>  
> -	/*
> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> -	 * anything that is not pte-mapped in the first place. Just return early
> -	 * and let the permission change code raise a warning if not already
> -	 * pte-mapped.
> -	 */
> -	if (!system_supports_bbml2_noabort())
> -		return 0;
> +	if (!system_supports_bbml2_noabort()) {
> +		/*
> +		 * !BBML2_NOABORT systems should not be trying to change
> +		 * permissions on anything that is not pte-mapped in the first
> +		 * place. Just return early and let the permission change code
> +		 * raise a warning if not already pte-mapped.
> +		 */
> +		if (system_capabilities_finalized() ||
> +		    !cpu_supports_bbml2_noabort())
> +			return 0;
> +
> +		/*
> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
> +		 * page allocator. Can't split until it's available.
> +		 */
> +		extern bool page_alloc_available;

Could we at least have the declaration in say <asm/mmu.h>? x86 defines a
similar global so we could eventually have a generic global (defined
before mem_init() is called).

Looks good otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> +		if (WARN_ON(!page_alloc_available))
> +			return -EBUSY;
> +
> +		/*
> +		 * Boot-time: Started secondary cpus but don't know if they
> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
> +		 * window in case they don't.
> +		 */
> +		if (WARN_ON(num_online_cpus() > 1))
> +			return -EBUSY;
> +	}
>  
>  	/*
>  	 * If the region is within a pte-mapped area, there is no need to try to

