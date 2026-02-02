Return-Path: <stable+bounces-213039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JexmIXdsgGl38AIAu9opvQ
	(envelope-from <stable+bounces-213039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 10:20:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9321CA0AA
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 10:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2833014677
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1E21FF48;
	Mon,  2 Feb 2026 09:18:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5FA2853EE;
	Mon,  2 Feb 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023906; cv=none; b=LjS8vapHlTkguzEKGPl3mOuRFngQDqMudYavA4bLS9v+ow3ys8QrboClB6mb9fvZZnA9LBA+60IUoHAi6NsGrXr3cToVK/sChlvW7yJPLC+rf/ltDnHt96b+/vtiSKdj63sFo5etvGK4LGiSvdIUvNpCFHXTz54A1ciDvFyRz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023906; c=relaxed/simple;
	bh=4v3D21B6hTaqn2MwwckEw8K3ezBfFg+HctZkT4afc84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT/Dw5gxREbw9xntJBjw58qoaNSffaW6CohMnrF1Pq//6G8f3TfIi7OkgmdFcPRupG7ABqqiH6daQehtuX/k47H5wTqwHCu7vyZSPKieJsIRmC6SMhsRUmpmcrv8DQVwAC6UQEGPU2Y0UCCA7Q76ei+qtbtw1IvHqwzg12IOgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FDB3339;
	Mon,  2 Feb 2026 01:18:17 -0800 (PST)
Received: from [10.57.95.78] (unknown [10.57.95.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0263F740;
	Mon,  2 Feb 2026 01:18:22 -0800 (PST)
Message-ID: <57bc3f07-c227-4117-8fb4-a2b198629215@arm.com>
Date: Mon, 2 Feb 2026 09:18:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202042617.504183-1-anshuman.khandual@arm.com>
 <20260202042617.504183-2-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260202042617.504183-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213039-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: D9321CA0AA
X-Rspamd-Action: no action

On 02/02/2026 04:26, Anshuman Khandual wrote:
> During a memory hot remove operartion both linear and vmemmap mappings for
> the memory range being removed, get unmapped via unmap_hotplug_range() but
> mapped pages get freed only for vmemmap mapping. This is just a sequential
> operation where each table entry gets cleared, followed by a leaf specific
> TLB flush, and then followed by memory free operation when applicable.
> 
> This approach was simple and uniform both for vmemmap and linear mappings.
> But linear mapping might contain CONT marked block memory where it becomes
> necessary to first clear out all entire in the range before a TLB flush.
> This is as per the architecture requirement. Hence batch all TLB flushes
> during the table tear down walk and finally do it in unmap_hotplug_range().

I might be worth mentioning the impact of not bein architecture compliant here?

Something like:

  Prior to this fix, it was hypothetically possible for a speculative access to
  a higher address in the contiguous block to fill the TLB with shattered
  entries for the entire contiguous range after a lower address had already been
  cleared and invalidated. Due to the entries being shattered, the subsequent
  tlbi for the higher address would not then clear the TLB entries for the lower
  address, meaning stale TLB entries could persist.

> 
> Besides it is helps in improving the performance via TLBI range operation

nit:         ^^ (remove)

> along with reduced synchronization instructions. The time spent executing
> unmap_hotplug_range() improved 97% measured over a 2GB memory hot removal
> in KVM guest.

That's a great improvement :)

> 
> This scheme is not applicable during vmemmap mapping tear down where memory
> needs to be freed and hence a TLB flush is required after clearing out page
> table entry.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Closes: https://lore.kernel.org/all/aWZYXhrT6D2M-7-N@willie-the-truck/
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I suggested the original shape of this and I see you have added my SOB. Final
patch looks good to me - I'm not sure if it's correct for me to add Rb, but here
it is regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  arch/arm64/mm/mmu.c | 81 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8e1d80a7033e..8ec8a287aaa1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1458,10 +1458,32 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>  
>  		WARN_ON(!pte_present(pte));
>  		__pte_clear(&init_mm, addr, ptep);
> -		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -		if (free_mapped)
> +		if (free_mapped) {
> +			/*
> +			 * If page is part of an existing contiguous
> +			 * memory block, individual TLB invalidation
> +			 * here would not be appropriate. Instead it
> +			 * will require clearing all entries for the
> +			 * memory block and subsequently a TLB flush
> +			 * for the entire range.
> +			 */
> +			WARN_ON(pte_cont(pte));
> +
> +			/*
> +			 * TLB flush is essential for freeing memory.
> +			 */
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>  			free_hotplug_page_range(pte_page(pte),
>  						PAGE_SIZE, altmap);
> +		}
> +
> +		/*
> +		 * TLB flush is batched in unmap_hotplug_range()
> +		 * for the entire range, when memory need not be
> +		 * freed. Besides linear mapping might have CONT
> +		 * blocks where TLB flush needs to be done after
> +		 * clearing all relevant entries.
> +		 */
>  	} while (addr += PAGE_SIZE, addr < end);
>  }
>  
> @@ -1482,15 +1504,32 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
>  		WARN_ON(!pmd_present(pmd));
>  		if (pmd_sect(pmd)) {
>  			pmd_clear(pmdp);
> +			if (free_mapped) {
> +				/*
> +				 * If page is part of an existing contiguous
> +				 * memory block, individual TLB invalidation
> +				 * here would not be appropriate. Instead it
> +				 * will require clearing all entries for the
> +				 * memory block and subsequently a TLB flush
> +				 * for the entire range.
> +				 */
> +				WARN_ON(pmd_cont(pmd));
> +
> +				/*
> +				 * TLB flush is essential for freeing memory.
> +				 */
> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +				free_hotplug_page_range(pmd_page(pmd),
> +							PMD_SIZE, altmap);
> +			}
>  
>  			/*
> -			 * One TLBI should be sufficient here as the PMD_SIZE
> -			 * range is mapped with a single block entry.
> +			 * TLB flush is batched in unmap_hotplug_range()
> +			 * for the entire range, when memory need not be
> +			 * freed. Besides linear mapping might have CONT
> +			 * blocks where TLB flush needs to be done after
> +			 * clearing all relevant entries.
>  			 */
> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -			if (free_mapped)
> -				free_hotplug_page_range(pmd_page(pmd),
> -							PMD_SIZE, altmap);
>  			continue;
>  		}
>  		WARN_ON(!pmd_table(pmd));
> @@ -1515,15 +1554,20 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
>  		WARN_ON(!pud_present(pud));
>  		if (pud_sect(pud)) {
>  			pud_clear(pudp);
> +			if (free_mapped) {
> +				/*
> +				 * TLB flush is essential for freeing memory.
> +				 */
> +				flush_tlb_kernel_range(addr, addr + PUD_SIZE);
> +				free_hotplug_page_range(pud_page(pud),
> +							PUD_SIZE, altmap);
> +			}
>  
>  			/*
> -			 * One TLBI should be sufficient here as the PUD_SIZE
> -			 * range is mapped with a single block entry.
> +			 * TLB flush is batched in unmap_hotplug_range()
> +			 * for the entire range, when memory need not be
> +			 * freed.
>  			 */
> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -			if (free_mapped)
> -				free_hotplug_page_range(pud_page(pud),
> -							PUD_SIZE, altmap);
>  			continue;
>  		}
>  		WARN_ON(!pud_table(pud));
> @@ -1553,6 +1597,7 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>  static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>  				bool free_mapped, struct vmem_altmap *altmap)
>  {
> +	unsigned long start = addr;
>  	unsigned long next;
>  	pgd_t *pgdp, pgd;
>  
> @@ -1574,6 +1619,14 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>  		WARN_ON(!pgd_present(pgd));
>  		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
>  	} while (addr = next, addr < end);
> +
> +	/*
> +	 * Batched TLB flush only for linear mapping which
> +	 * might contain CONT blocks, and does not require
> +	 * freeing up memory as well.
> +	 */
> +	if (!free_mapped)
> +		flush_tlb_kernel_range(start, end);
>  }
>  
>  static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,


