Return-Path: <stable+bounces-229981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHiaMWKCwWnATgQAu9opvQ
	(envelope-from <stable+bounces-229981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:11:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D86592FB019
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 385CE30C0E56
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4063C73C5;
	Mon, 23 Mar 2026 17:20:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2A3BED70;
	Mon, 23 Mar 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286441; cv=none; b=RFWiu4c4+VSSTUv2wmZQhzlufJUSxcfy6+/SYnYqUHdV07tYmB/5sZaRnHZ4g2F1R4OukWR3T8iPBMbHkb+1Lsy4CxjYLxQeBSPEci/T0YGn5lfCtxLhHG63IKapDh1QoPNvQ00H7ztQJLRRn7WaE8kHuRCnjro0UJFAViNuTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286441; c=relaxed/simple;
	bh=cGwdQXbx4HQmSXzfvzrDVIxS8sciA0V0xGoMWgKtZzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INa2cT9uegrBIHG0309p/Xui7mfpnW/WywwaO2KFNRJjmw5LI5YDYWlatbJCyoY9Bb5i/mlNrjrC/409sfgZz/WxPsc+zG92K4XUSM0Zl6lF+RqBoIIB0Uz2LvJavpz0H5OuIa8LEU4cRKMWLUlo34D9FEd1VfjMSnDb6ZBn+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B2014BF;
	Mon, 23 Mar 2026 10:20:33 -0700 (PDT)
Received: from [10.57.83.179] (unknown [10.57.83.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DAD53F694;
	Mon, 23 Mar 2026 10:20:37 -0700 (PDT)
Message-ID: <4b514b8b-c999-44f7-a7b1-12bd301b007f@arm.com>
Date: Mon, 23 Mar 2026 17:20:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-2-ryan.roberts@arm.com>
 <71261065-7895-492f-8457-998901391530@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <71261065-7895-492f-8457-998901391530@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229981-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D86592FB019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 16:52, Kevin Brodsky wrote:
> On 23/03/2026 14:03, Ryan Roberts wrote:
>> [...]
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 96711b8578fd0..b9b248d24fd10 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -350,7 +350,6 @@ void __init arch_mm_preinit(void)
>>  	}
>>  
>>  	swiotlb_init(swiotlb, flags);
>> -	swiotlb_update_mem_attributes();
>>  
>>  	/*
>>  	 * Check boundaries twice: Some fundamental inconsistencies can be
>> @@ -377,6 +376,14 @@ void __init arch_mm_preinit(void)
>>  	}
>>  }
>>  
>> +bool page_alloc_available __ro_after_init;
>> +
>> +void __init mem_init(void)
>> +{
>> +	page_alloc_available = true;
>> +	swiotlb_update_mem_attributes();
> 
> The move seems reasonable, x86 calls this function even later (from
> arch_cpu_finalize_init()).
> 
>> +}
>> +
>>  void free_initmem(void)
>>  {
>>  	void *lm_init_begin = lm_alias(__init_begin);
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index a6a00accf4f93..5b6a8d53e64b7 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -773,14 +773,33 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>  {
>>  	int ret;
>>  
>> -	/*
>> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
>> -	 * anything that is not pte-mapped in the first place. Just return early
>> -	 * and let the permission change code raise a warning if not already
>> -	 * pte-mapped.
>> -	 */
>> -	if (!system_supports_bbml2_noabort())
>> -		return 0;
>> +	if (!system_supports_bbml2_noabort()) {
>> +		/*
>> +		 * !BBML2_NOABORT systems should not be trying to change
>> +		 * permissions on anything that is not pte-mapped in the first
>> +		 * place. Just return early and let the permission change code
>> +		 * raise a warning if not already pte-mapped.
>> +		 */
>> +		if (system_capabilities_finalized() ||
>> +		    !cpu_supports_bbml2_noabort())
>> +			return 0;
>> +
>> +		/*
>> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
>> +		 * page allocator. Can't split until it's available.
>> +		 */
>> +		extern bool page_alloc_available;
> 
> Could we at least have the declaration in say <asm/mmu.h>? x86 defines a
> similar global so we could eventually have a generic global (defined
> before mem_init() is called).

Yeah, fair enough. I was being lazy. I'll move it to the header for v2.

> 
> Looks good otherwise:
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
>> +		if (WARN_ON(!page_alloc_available))
>> +			return -EBUSY;
>> +
>> +		/*
>> +		 * Boot-time: Started secondary cpus but don't know if they
>> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
>> +		 * window in case they don't.
>> +		 */
>> +		if (WARN_ON(num_online_cpus() > 1))
>> +			return -EBUSY;
>> +	}
>>  
>>  	/*
>>  	 * If the region is within a pte-mapped area, there is no need to try to


