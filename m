Return-Path: <stable+bounces-182021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483CBAB76B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 07:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C228419222D0
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 05:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DFA26F462;
	Tue, 30 Sep 2025 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enkuZ78m"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF286323
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759209794; cv=none; b=FcoepU3Fn0BDOvsS5uvNZIuMReiJyNcdridBZeEO8zG3c9jo6uq988eQn2gGJkuMoNNOElxNpIGoUL7RTpn887OyancDeTnrhwbwlA3+raJl/z+PMgrkAiuZlrgEKF9UPTBRZ0Ygs+zUR2qDUehbzfZjVzurcaE6TTxvf4Bx8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759209794; c=relaxed/simple;
	bh=Mp4Bceoc5Z5LQ4JPSrpXPERxMYrOFKiwVKe3COfGeHQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NWwB6UZmNooz3RGO5NcZiXfHy5G9ZrscM3o49JCX25X3HbmcZ8euhRiH1DvCAJ/964Wo7QrSmsGV7Qh8HPEVs0Jf35WmsVXiMDdqXkz1IxGWpPiBdmEYgE4sGLy7frglH68OypLMpO/aOYEgkMksbOd8ua/BjSf0T5pRgQhaOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enkuZ78m; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <668bfb74-014c-4fd5-a636-ff5ec17861c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759209788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtYmqC2JBRU8BJUTWVRUrUQAYfqmfbq1JzJMz9RYCo0=;
	b=enkuZ78mJ1c4AdM332qUKwV2XmuDNEL586pBBYXQ3ZlOuOSiahvDsfnUOECdhsvvjwQRed
	mHR4XacLrQv9pX9BQ4gkg5hz1KJ019CU7YpICInUcauQxj8jr4e2fegy41R9M+xOq0kJ84
	1sYIQYLoBGHkLiY9UyCkWYpafbKWsw4=
Date: Tue, 30 Sep 2025 13:22:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
To: Dev Jain <dev.jain@arm.com>
Cc: peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, ryan.roberts@arm.com, npache@redhat.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 usamaarif642@gmail.com, yuzhao@google.com, lorenzo.stoakes@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com
References: <20250930043351.34927-1-lance.yang@linux.dev>
 <0c498301-7434-4b2b-b7bc-73abe2057b67@arm.com>
Content-Language: en-US
In-Reply-To: <0c498301-7434-4b2b-b7bc-73abe2057b67@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/30 12:50, Dev Jain wrote:
> 
> On 30/09/25 10:03 am, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the 
>> shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops several 
>> important
>> PTE bits.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
>> incremental snapshots, losing the soft-dirty bit means modified pages are
>> missed, leading to inconsistent memory state after restore.
>>
>> As pointed out by David, the more critical uffd-wp bit is also dropped.
>> This breaks the userfaultfd write-protection mechanism, causing writes
>> to be silently missed by monitoring applications, which can lead to data
>> corruption.
>>
>> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
>> creating the new zeropage mapping to ensure they are correctly tracked.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>> when splitting isolated thp")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Dev Jain <dev.jain@arm.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> v1 -> v2:
>>   - Avoid calling ptep_get() multiple times (per Dev)
>>   - Double-check the uffd-wp bit (per David)
>>   - Collect Acked-by from David - thanks!
>>   - https://lore.kernel.org/linux-mm/20250928044855.76359-1- 
>> lance.yang@linux.dev/
>>
>>   mm/migrate.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ce83c2c3c287..50aa91d9ab4e 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -300,13 +300,14 @@ static bool try_to_map_unused_to_zeropage(struct 
>> page_vma_mapped_walk *pvmw,
>>                         unsigned long idx)
>>   {
>>       struct page *page = folio_page(folio, idx);
>> +    pte_t oldpte = ptep_get(pvmw->pte);
> 
> What I meant to say was, you can pass oldpte from remove_migration_pte 
> to this
> function. Basically define old_pte = ptep_get(pvmw.pte) in the 
> declarations of
> the start of the while block in remove_migration_pte and remove the 
> existing
> one. That will ensure ptep_get() gets called only once per iteration.

Ah, got it. Thanks for the clarification!

IIUC, you mean something like this:

```
diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..bafd8cb3bebe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -297,6 +297,7 @@ bool isolate_folio_to_list(struct folio *folio, 
struct list_head *list)

  static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk 
*pvmw,
  					  struct folio *folio,
+					  pte_t old_pte,
  					  unsigned long idx)
  {
  	struct page *page = folio_page(folio, idx);
@@ -306,7 +307,7 @@ static bool try_to_map_unused_to_zeropage(struct 
page_vma_mapped_walk *pvmw,
  		return false;
  	VM_BUG_ON_PAGE(!PageAnon(page), page);
  	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
+	VM_BUG_ON_PAGE(pte_present(old_pte), page);

  	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
  	    mm_forbids_zeropage(pvmw->vma->vm_mm))
@@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct 
page_vma_mapped_walk *pvmw,

  	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
  					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(old_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_swp_uffd_wp(old_pte))
+		newpte = pte_mkuffd_wp(newpte);
+
  	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);

  	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
@@ -344,7 +351,7 @@ static bool remove_migration_pte(struct folio *folio,

  	while (page_vma_mapped_walk(&pvmw)) {
  		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
+		pte_t old_pte = ptep_get(pvmw.pte);
  		pte_t pte;
  		swp_entry_t entry;
  		struct page *new;
@@ -365,12 +372,11 @@ static bool remove_migration_pte(struct folio *folio,
  		}
  #endif
  		if (rmap_walk_arg->map_unused_to_zeropage &&
-		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
  			continue;

  		folio_get(folio);
  		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);

  		entry = pte_to_swp_entry(old_pte);
  		if (!is_migration_entry_young(entry))
```

ptep_get() gets called only once per iteration, right?

> 
>>       pte_t newpte;
>>       if (PageCompound(page))
>>           return false;
>>       VM_BUG_ON_PAGE(!PageAnon(page), page);
>>       VM_BUG_ON_PAGE(!PageLocked(page), page);
>> -    VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>> +    VM_BUG_ON_PAGE(pte_present(oldpte), page);
>>       if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & 
>> VM_LOCKED) ||
>>           mm_forbids_zeropage(pvmw->vma->vm_mm))
>> @@ -322,6 +323,12 @@ static bool try_to_map_unused_to_zeropage(struct 
>> page_vma_mapped_walk *pvmw,
>>       newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>                       pvmw->vma->vm_page_prot));
>> +
>> +    if (pte_swp_soft_dirty(oldpte))
>> +        newpte = pte_mksoft_dirty(newpte);
>> +    if (pte_swp_uffd_wp(oldpte))
>> +        newpte = pte_mkuffd_wp(newpte);
>> +
>>       set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>       dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));

