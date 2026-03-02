Return-Path: <stable+bounces-222627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFN3KUuupWleEQAAu9opvQ
	(envelope-from <stable+bounces-222627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:35:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFEC1DBF2D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F23C304D25C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2C41B375;
	Mon,  2 Mar 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9gCK//1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855C41B344;
	Mon,  2 Mar 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465295; cv=none; b=bLS8Coa9Moqp4zztd3la/5TIqyMNXcilFrVxDnDELxYjk8TfZPMItbJly8Be2acyeeJdHSflkm5ooOgZmpyoZkDm4+XGqUPVVRhmHhC/fvHmOSP6qp2Y8DsB2bxZQrAhPGUt9VckbsnKpqTZ6grLYGc1f1HMF3R/apsBwM2HWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465295; c=relaxed/simple;
	bh=bLBAyZ1BexHi7dQN3dUIva97z4hRfah1yjE2p8lfp+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVRilyn0SzEgm5/L0Y5Tgct3tnBPYn+rfGu1sQhLzQthziDPTlWppQ084udInkoV9wlIt2xxFtT4wKh9jcU/g6lfd+ySfj8tTgchfpncascl4F5rMHR2lwf3tRj1hdZZPZgmX2YNFgad7owLKkzPjBcJHZTOqQCp/aH5OgOytvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9gCK//1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B8C19423;
	Mon,  2 Mar 2026 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772465294;
	bh=bLBAyZ1BexHi7dQN3dUIva97z4hRfah1yjE2p8lfp+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9gCK//1M15CcqoJAY0n92aVVUqokthG4UqgAiNM62ZoGveq2ft2l5TFdox26xFxq
	 CZQuG6r5pD2FJWHlojAbgGBDZPti65Jh7rmtO0vgqYK3Kqnk/8+dQxmE1dGbvhRyk5
	 663Ez/MG1esVyeJQePMh3Uz7RF7aX/LLxPETOl2ZhZFYpNWSRKZZdQjECNg8iBEKVF
	 XHMUgNg6H04oyxT4o1hiP/5IQzFQ+MYtsjue1PF50rvTWB87FIcBjtYzw4S3LvHnNM
	 WXJpFkAFTNDm3WvQ6lZDaH6B0HkhqdSlE5HlZQVy2EVUOrdkttjpYBJdJmUFMeLXsw
	 TvDFQjadOYPjA==
Message-ID: <bf956adb-06bc-4b68-b846-7dddb9413867@kernel.org>
Date: Mon, 2 Mar 2026 16:28:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260224062423.972404-1-anshuman.khandual@arm.com>
 <20260224062423.972404-2-anshuman.khandual@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260224062423.972404-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0EFEC1DBF2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222627-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

On 2/24/26 07:24, Anshuman Khandual wrote:
> During a memory hot remove operation, both linear and vmemmap mappings for
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
> 
> Prior to this fix, it was hypothetically possible for a speculative access
> to a higher address in the contiguous block to fill the TLB with shattered
> entries for the entire contiguous range after a lower address had already
> been cleared and invalidated. Due to the table entries being shattered, the
> subsequent TLB invalidation for the higher address would not then clear the
> TLB entries for the lower address, meaning stale TLB entries could persist.
> 
> Besides it also helps in improving the performance via TLBI range operation
> along with reduced synchronization instructions. The time spent executing
> unmap_hotplug_range() improved 97% measured over a 2GB memory hot removal
> in KVM guest.
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
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 81 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a6a00accf4f9..dfb61d218579 100644
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

I'm not sure about repeating these longish comments a couple of times :)

For example, I think you can drop the ones regarding the TLB flush
("TLB flush is batched in unmap_hotplug_range ...") completely.
unmap_hotplug_range(), the only caller, is pretty clear about that. And
anybody reading that code should be able to spot the "!free_mapped" case
easily.

Alternatively, just say

	/* unmap_hotplug_range() flushes TLB for !free_mapped */

"TLB flush is essential for freeing memory." is rather obvious when
freeing memory, so I would drop that as well.

Regarding pte_cont(), can we shorten that to

	/* CONT blocks in the vmemmap are not supported. */

Anybody who wants to figure *why* can lookup your patch where you add
that comment+check.


I did not check whether people suggested to add these comments in
previous versions. But to me they don't add a lot of real value that
couldn't be had from the code already (or common sense: freeing requires
prior TLB flush).

> +			WARN_ON(pte_cont(pte));
> +
> +			/*
> +			 * TLB flush is essential for freeing memory.
> +			 */
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>  			free_hotplug_page_range(pte_page(pte),
>  						PAGE_SIZE, altmap);
> +		}

[...]

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

Also, here, I don't think the comment really adds value.

* !free_mapped -> linear mapping, no freeing of memory
* CONT blocks -> irrelevant, you can batch in either case

> +	if (!free_mapped)
> +		flush_tlb_kernel_range(start, end);
>  }
-- 
Cheers,

David

