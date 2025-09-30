Return-Path: <stable+bounces-182033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA7BABAB2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F293C27FE
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBD236453;
	Tue, 30 Sep 2025 06:33:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C32128395;
	Tue, 30 Sep 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214032; cv=none; b=DeajIM0Q17Z95jj0cfw+udl10Q13lSQCdvCNQGYnH+C086npONETIPEHBZyzNw1lJ5//yJ+H4iGR+b5J/0IA/eipezqxT0OttAjsrfjJb3pZn5F5KDMoO1ZzwSe8PITSW8q9rDlKIADcpjJWBI73dtnxz3YYwnXBrjqzjIqAfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214032; c=relaxed/simple;
	bh=JxmpbEZWtAozvqAduF/ljajHhnVtEkMPMUpyFBV0KHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOkZlvztsTKCJp4QRJ0dBd+wMFcJFmh1YOpRJY3a0s9xGpK04hlhgExeghaIImMbaaeyzmozHeaQC6+N1V43AlHUUriR7hKvLq2e7mU4qYE3fQGENESdB9KCfOQO9ibVYDximrh8MKm4UVdf92uPdx63/QjEZKNh/n1ID0VVq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3074E1424;
	Mon, 29 Sep 2025 23:33:40 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE13A3F66E;
	Mon, 29 Sep 2025 23:33:39 -0700 (PDT)
Message-ID: <838505c8-053e-49af-b37b-0475520daf68@arm.com>
Date: Tue, 30 Sep 2025 12:03:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, ryan.roberts@arm.com, npache@redhat.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 usamaarif642@gmail.com, yuzhao@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250930060557.85133-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250930060557.85133-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/09/25 11:35 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> When splitting an mTHP and replacing a zero-filled subpage with the shared
> zeropage, try_to_map_unused_to_zeropage() currently drops several important
> PTE bits.
>
> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
> incremental snapshots, losing the soft-dirty bit means modified pages are
> missed, leading to inconsistent memory state after restore.
>
> As pointed out by David, the more critical uffd-wp bit is also dropped.
> This breaks the userfaultfd write-protection mechanism, causing writes
> to be silently missed by monitoring applications, which can lead to data
> corruption.
>
> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
> creating the new zeropage mapping to ensure they are correctly tracked.
>
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v2 -> v3:
>   - ptep_get() gets called only once per iteration (per Dev)
>   - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/
>
> v1 -> v2:
>   - Avoid calling ptep_get() multiple times (per Dev)
>   - Double-check the uffd-wp bit (per David)
>   - Collect Acked-by from David - thanks!
>   - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/
>
>   mm/migrate.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..bafd8cb3bebe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -297,6 +297,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>   
>   static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   					  struct folio *folio,
> +					  pte_t old_pte,
>   					  unsigned long idx)

Could have just added this in the same line as folio?

>   {
>   	struct page *page = folio_page(folio, idx);
> @@ -306,7 +307,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   		return false;
>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> +	VM_BUG_ON_PAGE(pte_present(old_pte), page);
>   
>   	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>   	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> @@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   
>   	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>   					pvmw->vma->vm_page_prot));
> +
> +	if (pte_swp_soft_dirty(old_pte))
> +		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_swp_uffd_wp(old_pte))
> +		newpte = pte_mkuffd_wp(newpte);
> +
>   	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>   
>   	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> @@ -344,7 +351,7 @@ static bool remove_migration_pte(struct folio *folio,
>   
>   	while (page_vma_mapped_walk(&pvmw)) {
>   		rmap_t rmap_flags = RMAP_NONE;
> -		pte_t old_pte;
> +		pte_t old_pte = ptep_get(pvmw.pte);
>   		pte_t pte;
>   		swp_entry_t entry;
>   		struct page *new;
> @@ -365,12 +372,11 @@ static bool remove_migration_pte(struct folio *folio,
>   		}
>   #endif
>   		if (rmap_walk_arg->map_unused_to_zeropage &&
> -		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
> +		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
>   			continue;
>   
>   		folio_get(folio);
>   		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
> -		old_pte = ptep_get(pvmw.pte);
>   
>   		entry = pte_to_swp_entry(old_pte);
>   		if (!is_migration_entry_young(entry))

Looks good, the special bit does not overlay on any arch with the soft-dirty bit.
It shouldn't overlay with uffd-wp as well since split_huge_zero_page_pmd does the
same bit preservation.

Reviewed-by: Dev Jain <dev.jain@arm.com>


