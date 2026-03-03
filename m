Return-Path: <stable+bounces-222793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA6JLsZ3pmnxQAAAu9opvQ
	(envelope-from <stable+bounces-222793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:55:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2A1E9583
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9284D301223B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E12EE611;
	Tue,  3 Mar 2026 05:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7F261B92;
	Tue,  3 Mar 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772517310; cv=none; b=njVTsx3KeAD7NPj9yOeekI69aInnnWVuoJUFsWqA23J5OewWkENgJ0/kF1OlPuoOl36iRv49AaCNVR1KzTKCHM1pK+RnRNOC9ZZNqQg7z/mG8uLY+kEp6pvE+K5sufnTn92HyVJFAUHVSPT9BJ12zYtX42sPrUB5ScA2fjQDTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772517310; c=relaxed/simple;
	bh=b1n8N2wHkLpkHjTY9r0XREihtysaq3iiZxzWM951cCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLg8SGBu8Ms6eMCI8t0R3huhRO93aGZ299+Y6e8lgPfOk6hktB5bPAijctQvewB+19f4XVYgKsIYDoqJsBC1nkxENj2hiFR1SKGWgP5WnB5IwutEA31lb0kGxfLERdm4MstnVpQKPKdLPfuNy++MZLvSTzglohLqZP7TNxSHu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B54497;
	Mon,  2 Mar 2026 21:55:01 -0800 (PST)
Received: from [10.164.18.51] (unknown [10.164.18.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C53633F73B;
	Mon,  2 Mar 2026 21:55:04 -0800 (PST)
Message-ID: <f417f7fd-1fc9-4bd8-92a0-4b7c09d5296e@arm.com>
Date: Tue, 3 Mar 2026 11:25:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260224062423.972404-1-anshuman.khandual@arm.com>
 <20260224062423.972404-2-anshuman.khandual@arm.com>
 <bf956adb-06bc-4b68-b846-7dddb9413867@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <bf956adb-06bc-4b68-b846-7dddb9413867@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B4B2A1E9583
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222793-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anshuman.khandual@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.859];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action



On 02/03/26 8:58 PM, David Hildenbrand (Arm) wrote:
> On 2/24/26 07:24, Anshuman Khandual wrote:
>> During a memory hot remove operation, both linear and vmemmap mappings for
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
>>
>> Prior to this fix, it was hypothetically possible for a speculative access
>> to a higher address in the contiguous block to fill the TLB with shattered
>> entries for the entire contiguous range after a lower address had already
>> been cleared and invalidated. Due to the table entries being shattered, the
>> subsequent TLB invalidation for the higher address would not then clear the
>> TLB entries for the lower address, meaning stale TLB entries could persist.
>>
>> Besides it also helps in improving the performance via TLBI range operation
>> along with reduced synchronization instructions. The time spent executing
>> unmap_hotplug_range() improved 97% measured over a 2GB memory hot removal
>> in KVM guest.
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
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 81 +++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 67 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index a6a00accf4f9..dfb61d218579 100644
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
> 
> I'm not sure about repeating these longish comments a couple of times :)
> 
> For example, I think you can drop the ones regarding the TLB flush
> ("TLB flush is batched in unmap_hotplug_range ...") completely.
> unmap_hotplug_range(), the only caller, is pretty clear about that. And
> anybody reading that code should be able to spot the "!free_mapped" case
> easily.
> 
> Alternatively, just say
> 
> 	/* unmap_hotplug_range() flushes TLB for !free_mapped */

Will replace as suggested.

> 
> "TLB flush is essential for freeing memory." is rather obvious when
> freeing memory, so I would drop that as well.
> 
> Regarding pte_cont(), can we shorten that to
> 
> 	/* CONT blocks in the vmemmap are not supported. */
> 
> Anybody who wants to figure *why* can lookup your patch where you add
> that comment+check.

Sure will drop the comment about CONT mapping TLB flush and mention that
such mappings are not supported for vmemmap.

> 
> 
> I did not check whether people suggested to add these comments in
> previous versions. But to me they don't add a lot of real value that
> couldn't be had from the code already (or common sense: freeing requires
> prior TLB flush).

Dropped all these comments - "TLB flush is essential for freeing memory".

> 
>> +			WARN_ON(pte_cont(pte));
>> +
>> +			/*
>> +			 * TLB flush is essential for freeing memory.
>> +			 */
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>  			free_hotplug_page_range(pte_page(pte),
>>  						PAGE_SIZE, altmap);
>> +		}
> 
> [...]
> 
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
> 
> Also, here, I don't think the comment really adds value.
> 
> * !free_mapped -> linear mapping, no freeing of memory
> * CONT blocks -> irrelevant, you can batch in either case

Dropped the comment.

> 
>> +	if (!free_mapped)
>> +		flush_tlb_kernel_range(start, end);
>>  }


