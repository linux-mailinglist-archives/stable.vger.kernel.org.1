Return-Path: <stable+bounces-213054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdGIHWCgGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:54:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9ECCB49B
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 177573042245
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80505358D37;
	Mon,  2 Feb 2026 10:48:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A127AC57;
	Mon,  2 Feb 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029331; cv=none; b=PxgmbaQOOAMNct4y0DWeFWWYGd6IuG0xj4LkkKCMAgNmKWqx0Vw86RxtLIFpd9J2R50GVHYzoytAYhSJTN2dSGhzE04MpJroG8u6cOwePRcPcZN55lFt6fYNPxwYjpp80s1beKG6znvSgdmR653kYnSK4C6R3zk/qO8VsUO9kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029331; c=relaxed/simple;
	bh=OymeOrzz4iNF9a/6uvCn01vya/GB8eGV785femhK8Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKn2U8k0ONxo4QJhfCjmmAFfo1xzS3P4B50j0J1xXv9rA496hD+cZSdFMl1aKWdTQAOvpqUoXhmCc81sPknU6Lw1iHUz1nR9juPyp53Ln+mXhC0D6SbJ2AeVch/qLRAHs3nRvIooT01pYaXP030qti6irmIA5J+lF9Vmycs9k7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7741F339;
	Mon,  2 Feb 2026 02:48:42 -0800 (PST)
Received: from [10.163.168.36] (unknown [10.163.168.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5433F740;
	Mon,  2 Feb 2026 02:48:45 -0800 (PST)
Message-ID: <86888c49-4596-48ba-b480-bd317d386c72@arm.com>
Date: Mon, 2 Feb 2026 16:18:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202042617.504183-1-anshuman.khandual@arm.com>
 <20260202042617.504183-2-anshuman.khandual@arm.com>
 <57bc3f07-c227-4117-8fb4-a2b198629215@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <57bc3f07-c227-4117-8fb4-a2b198629215@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-213054-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DB9ECCB49B
X-Rspamd-Action: no action



On 02/02/26 2:48 PM, Ryan Roberts wrote:
> On 02/02/2026 04:26, Anshuman Khandual wrote:
>> During a memory hot remove operartion both linear and vmemmap mappings for
>> the memory range being removed, get unmapped via unmap_hotplug_range() but
>> mapped pages get freed only for vmemmap mapping. This is just a sequential
>> operation where each table entry gets cleared, followed by a leaf specific
>> TLB flush, and then followed by memory free operation when applicable.
>>
>> This approach was simple and uniform both for vmemmap and linear mappings.
>> But linear mapping might contain CONT marked block memory where it becomes
>> necessary to first clear out all entire in the range before a TLB flush.
>> This is as per the architecture requirement. Hence batch all TLB flushes
>> during the table tear down walk and finally do it in unmap_hotplug_range().
> 
> I might be worth mentioning the impact of not bein architecture compliant here?
> 
> Something like:
> 
>   Prior to this fix, it was hypothetically possible for a speculative access to
>   a higher address in the contiguous block to fill the TLB with shattered
>   entries for the entire contiguous range after a lower address had already been
>   cleared and invalidated. Due to the entries being shattered, the subsequent
>   tlbi for the higher address would not then clear the TLB entries for the lower
>   address, meaning stale TLB entries could persist.

Sounds good - will add in the commit message.

> 
>>
>> Besides it is helps in improving the performance via TLBI range operation
> 
> nit:         ^^ (remove)

Will fix that.

> 
>> along with reduced synchronization instructions. The time spent executing
>> unmap_hotplug_range() improved 97% measured over a 2GB memory hot removal
>> in KVM guest.
> 
> That's a great improvement :)
> 
>>
>> This scheme is not applicable during vmemmap mapping tear down where memory
>> needs to be freed and hence a TLB flush is required after clearing out page
>> table entry.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Closes: https://lore.kernel.org/all/aWZYXhrT6D2M-7-N@willie-the-truck/
>> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> I suggested the original shape of this and I see you have added my SOB. Final
> patch looks good to me - I'm not sure if it's correct for me to add Rb, but here
> it is regardless:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks !

> 
> 
>> ---
>>  arch/arm64/mm/mmu.c | 81 +++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 67 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 8e1d80a7033e..8ec8a287aaa1 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1458,10 +1458,32 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>>  
>>  		WARN_ON(!pte_present(pte));
>>  		__pte_clear(&init_mm, addr, ptep);
>> -		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> -		if (free_mapped)
>> +		if (free_mapped) {
>> +			/*
>> +			 * If page is part of an existing contiguous
>> +			 * memory block, individual TLB invalidation
>> +			 * here would not be appropriate. Instead it
>> +			 * will require clearing all entries for the
>> +			 * memory block and subsequently a TLB flush
>> +			 * for the entire range.
>> +			 */
>> +			WARN_ON(pte_cont(pte));
>> +
>> +			/*
>> +			 * TLB flush is essential for freeing memory.
>> +			 */
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>  			free_hotplug_page_range(pte_page(pte),
>>  						PAGE_SIZE, altmap);
>> +		}
>> +
>> +		/*
>> +		 * TLB flush is batched in unmap_hotplug_range()
>> +		 * for the entire range, when memory need not be
>> +		 * freed. Besides linear mapping might have CONT
>> +		 * blocks where TLB flush needs to be done after
>> +		 * clearing all relevant entries.
>> +		 */
>>  	} while (addr += PAGE_SIZE, addr < end);
>>  }
>>  
>> @@ -1482,15 +1504,32 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
>>  		WARN_ON(!pmd_present(pmd));
>>  		if (pmd_sect(pmd)) {
>>  			pmd_clear(pmdp);
>> +			if (free_mapped) {
>> +				/*
>> +				 * If page is part of an existing contiguous
>> +				 * memory block, individual TLB invalidation
>> +				 * here would not be appropriate. Instead it
>> +				 * will require clearing all entries for the
>> +				 * memory block and subsequently a TLB flush
>> +				 * for the entire range.
>> +				 */
>> +				WARN_ON(pmd_cont(pmd));
>> +
>> +				/*
>> +				 * TLB flush is essential for freeing memory.
>> +				 */
>> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
>> +				free_hotplug_page_range(pmd_page(pmd),
>> +							PMD_SIZE, altmap);
>> +			}
>>  
>>  			/*
>> -			 * One TLBI should be sufficient here as the PMD_SIZE
>> -			 * range is mapped with a single block entry.
>> +			 * TLB flush is batched in unmap_hotplug_range()
>> +			 * for the entire range, when memory need not be
>> +			 * freed. Besides linear mapping might have CONT
>> +			 * blocks where TLB flush needs to be done after
>> +			 * clearing all relevant entries.
>>  			 */
>> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> -			if (free_mapped)
>> -				free_hotplug_page_range(pmd_page(pmd),
>> -							PMD_SIZE, altmap);
>>  			continue;
>>  		}
>>  		WARN_ON(!pmd_table(pmd));
>> @@ -1515,15 +1554,20 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
>>  		WARN_ON(!pud_present(pud));
>>  		if (pud_sect(pud)) {
>>  			pud_clear(pudp);
>> +			if (free_mapped) {
>> +				/*
>> +				 * TLB flush is essential for freeing memory.
>> +				 */
>> +				flush_tlb_kernel_range(addr, addr + PUD_SIZE);
>> +				free_hotplug_page_range(pud_page(pud),
>> +							PUD_SIZE, altmap);
>> +			}
>>  
>>  			/*
>> -			 * One TLBI should be sufficient here as the PUD_SIZE
>> -			 * range is mapped with a single block entry.
>> +			 * TLB flush is batched in unmap_hotplug_range()
>> +			 * for the entire range, when memory need not be
>> +			 * freed.
>>  			 */
>> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> -			if (free_mapped)
>> -				free_hotplug_page_range(pud_page(pud),
>> -							PUD_SIZE, altmap);
>>  			continue;
>>  		}
>>  		WARN_ON(!pud_table(pud));
>> @@ -1553,6 +1597,7 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>>  static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>>  				bool free_mapped, struct vmem_altmap *altmap)
>>  {
>> +	unsigned long start = addr;
>>  	unsigned long next;
>>  	pgd_t *pgdp, pgd;
>>  
>> @@ -1574,6 +1619,14 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>>  		WARN_ON(!pgd_present(pgd));
>>  		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
>>  	} while (addr = next, addr < end);
>> +
>> +	/*
>> +	 * Batched TLB flush only for linear mapping which
>> +	 * might contain CONT blocks, and does not require
>> +	 * freeing up memory as well.
>> +	 */
>> +	if (!free_mapped)
>> +		flush_tlb_kernel_range(start, end);
>>  }
>>  
>>  static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
> 


