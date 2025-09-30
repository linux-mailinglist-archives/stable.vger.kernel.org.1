Return-Path: <stable+bounces-182042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1215BABD35
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D14B1C29B9
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85CBA3F;
	Tue, 30 Sep 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RkvVAe6F"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D422128B
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217422; cv=none; b=m3uM7ucO/kgFkN7OprCFXNpSv7zdIMUsgoIqfJ9BjPgnvq12FdHZD3BAa4QfVsDTvzFA9a3MCcurflVpxGCCIDW9+9iF9biTkSpyoCPwwc58mcoUd15x0byaZBoahUIPX5IOtjl5BIdQ+kqXycwTQSv7ieIDvFuMvS0u2WZYzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217422; c=relaxed/simple;
	bh=JHaM5to+xC5kopNxos1iMOFNZnH5CeJpPTtCRsoqll8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6k7XqaJudRUsPE17IRjaw0fewoIXwVD5Y2oj6LPcUGOLTTZHr7PmYGGDlm0gbD9T/FZf1qfv93wtu9rJT0pbzcCiPBpfsBkK8MfxsupotSRFimBxen7y3HRoU4EV9Jp/MZx5fMk3bN1Vjly8Iop3LCODE0S4TB/aBJdcU5FhSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RkvVAe6F; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d21c9bc-e299-4ca6-85ba-b01a1f346d9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759217406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRSruWvb4rbc+Pa1Ie+z5dnZdtYXYh6A7V3IBXQrpoA=;
	b=RkvVAe6Fg24cbCSqPBQFHG71Zj73toGRbXfs5rz4SjtNxcJzhYsYly6d9QQbJfmc/J/b+k
	mcM2H8mA80qITCJlV1SDsAczLyAMwm0rLZsumKTVuZRwknHbnD/ITho/VI2ndFsJGoawOO
	k9nrqCuoPY9e4SNr8gdZX+r3sOHrccY=
Date: Tue, 30 Sep 2025 15:29:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: david@redhat.com, dev.jain@arm.com
Cc: peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, ryan.roberts@arm.com, npache@redhat.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 usamaarif642@gmail.com, yuzhao@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org
References: <20250930071053.36158-1-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250930071053.36158-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/30 15:10, Lance Yang wrote:
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
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v3 -> v4:
>   - Minor formatting tweak in try_to_map_unused_to_zeropage() function
>     signature (per David and Dev)
>   - Collect Reviewed-by from Dev - thanks!
>   - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@linux.dev/
> 
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
>   mm/migrate.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..21a2a1bf89f7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>   }
>   
>   static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
> -					  struct folio *folio,
> -					  unsigned long idx)
> +		struct folio *folio, pte_t old_pte, unsigned long idx)
>   {
>   	struct page *page = folio_page(folio, idx);
>   	pte_t newpte;
> @@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   		return false;
>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> +	VM_BUG_ON_PAGE(pte_present(old_pte), page);
>   
>   	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>   	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> @@ -322,6 +321,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
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
> @@ -344,7 +349,7 @@ static bool remove_migration_pte(struct folio *folio,
>   
>   	while (page_vma_mapped_walk(&pvmw)) {
>   		rmap_t rmap_flags = RMAP_NONE;
> -		pte_t old_pte;
> +		pte_t old_pte = ptep_get(pvmw.pte);

Oops, I just found a NULL pointer dereference bug in my changes to
remove_migration_pte() when we encounter a PMD-mapped THP migration
entry.

#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
		/* PMD-mapped THP migration entry */
		if (!pvmw.pte) {
			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
					!folio_test_pmd_mappable(folio), folio);
			remove_migration_pmd(&pvmw, new);
			continue;
		}
#endif

ptep_get() is called too early... before the !pvmw.pte check for
PMD-mapped entries.

The initialization of old_pte must be moved to after that if block.

Sorry for the churn :(
Lance

>   		pte_t pte;
>   		swp_entry_t entry;
>   		struct page *new;
> @@ -365,12 +370,11 @@ static bool remove_migration_pte(struct folio *folio,
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


