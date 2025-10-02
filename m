Return-Path: <stable+bounces-183015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E029CBB2B08
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F819C1EA8
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2F2C11D1;
	Thu,  2 Oct 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I7m7p2Kd"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BC2C08C5
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390064; cv=none; b=dfCzh/Ibr5cnWQOI2brJrsj+2seq5JrjYsdDZ0MLSqgR4N+dHlj7NuTQnYM/Igz3a7zRocQtbfUdVBYruVrTtwxzce76ojFVv4L5iG85g8ir33EECHvIf7F11zJj0EGhzeI0VsdLsVn35CmjpD4RcWW/muRQfgDsqTQWR9trYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390064; c=relaxed/simple;
	bh=E0O3pTQIzDNGpJ6hxldJ9njEUqHefl8QuY2JfvtB1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFGTYWc0C62CqNGmXZiHLjMEPEhouxxNlZEveX7xG5oWrVURiUdcU8lLZDc/IuFVyz1NtUEqpPzkqP2mZuZR0uYelXsYG6evStS7dFtT0Z7vxAfDdAurCp0YnT7XACmwvKs8VcFKAmYnwy/3qUSjHEmNdpIySLYkEKiEYUhJU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I7m7p2Kd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51e0b689-02fa-465c-896b-1178497085c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759390060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tf8z5q3IrTjEa1scLQkDrmTv4dYy/I6ofHkuRkCTr8Q=;
	b=I7m7p2Kd817cIsaAJb9eSW7jpXSdGDewMdzS5u6oj/QuFuKiQWcxfwN2BkkzJyT/MRT46K
	3msA7XJ25s+FZvio5MGaMCyIPPWvaPetXpxc62LH+k0mK8gFPwQiF2YIkEPVsD0grdRgCb
	dDyMSOrJefEuRKSNi09OgUugxGQ6Wqc=
Date: Thu, 2 Oct 2025 15:27:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 wangkefeng.wang@huawei.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <20251002014604.d2ryohvtrdfn7mvf@master>
 <fa3f9e82-c6c8-43f2-803f-b8bb0fe56f37@linux.dev>
 <20251002031743.4anbofbyym5tlwrt@master>
 <a4b5589a-1607-4e67-939d-f86f98a395a6@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a4b5589a-1607-4e67-939d-f86f98a395a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/2 15:16, David Hildenbrand wrote:
> On 02.10.25 05:17, Wei Yang wrote:
>> On Thu, Oct 02, 2025 at 10:31:53AM +0800, Lance Yang wrote:
>>>
>>>
>>> On 2025/10/2 09:46, Wei Yang wrote:
>>>> On Thu, Oct 02, 2025 at 01:38:25AM +0000, Wei Yang wrote:
>>>>> We add pmd folio into ds_queue on the first page fault in
>>>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>>>> memory pressure. This should be the same for a pmd folio during wp
>>>>> page fault.
>>>>>
>>>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>>>>> to add it to ds_queue, which means system may not reclaim enough 
>>>>> memory
>>>>> in case of memory pressure even the pmd folio is under used.
>>>>>
>>>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>>>>> folio installation consistent.
>>>>>
>>>>
>>>> Since we move deferred_split_folio() into map_anon_folio_pmd(), I am 
>>>> thinking
>>>> about whether we can consolidate the process in collapse_huge_page().
>>>>
>>>> Use map_anon_folio_pmd() in collapse_huge_page(), but skip those 
>>>> statistic
>>>> adjustment.
>>>
>>> Yeah, that's a good idea :)
>>>
>>> We could add a simple bool is_fault parameter to map_anon_folio_pmd()
>>> to control the statistics.
>>>
>>> The fault paths would call it with true, and the collapse paths could
>>> then call it with false.
>>>
>>> Something like this:
>>>
>>> ```
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1b81680b4225..9924180a4a56 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1218,7 +1218,7 @@ static struct folio 
>>> *vma_alloc_anon_folio_pmd(struct
>>> vm_area_struct *vma,
>>> }
>>>
>>> static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>>> -        struct vm_area_struct *vma, unsigned long haddr)
>>> +        struct vm_area_struct *vma, unsigned long haddr, bool is_fault)
>>> {
>>>     pmd_t entry;
>>>
>>> @@ -1228,10 +1228,15 @@ static void map_anon_folio_pmd(struct folio 
>>> *folio,
>>> pmd_t *pmd,
>>>     folio_add_lru_vma(folio, vma);
>>>     set_pmd_at(vma->vm_mm, haddr, pmd, entry);
>>>     update_mmu_cache_pmd(vma, haddr, pmd);
>>> -    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> -    count_vm_event(THP_FAULT_ALLOC);
>>> -    count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>> -    count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +
>>> +    if (is_fault) {
>>> +        add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> +        count_vm_event(THP_FAULT_ALLOC);
>>> +        count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>> +        count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +    }
>>> +
>>> +    deferred_split_folio(folio, false);
>>> }
>>>
>>> static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index d0957648db19..2eddd5a60e48 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1227,17 +1227,10 @@ static int collapse_huge_page(struct 
>>> mm_struct *mm,
>>> unsigned long address,
>>>     __folio_mark_uptodate(folio);
>>>     pgtable = pmd_pgtable(_pmd);
>>>
>>> -    _pmd = folio_mk_pmd(folio, vma->vm_page_prot);
>>> -    _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>> -
>>>     spin_lock(pmd_ptl);
>>>     BUG_ON(!pmd_none(*pmd));
>>> -    folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>> -    folio_add_lru_vma(folio, vma);
>>>     pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>> -    set_pmd_at(mm, address, pmd, _pmd);
>>> -    update_mmu_cache_pmd(vma, address, pmd);
>>> -    deferred_split_folio(folio, false);
>>> +    map_anon_folio_pmd(folio, pmd, vma, address, false);
>>>     spin_unlock(pmd_ptl);
>>>
>>>     folio = NULL;
>>> ```
>>>
>>> Untested, though.
>>>
>>
>> This is the same as I thought.
>>
>> Will prepare a patch for it.
> 
> Let's do that as an add-on patch, though.

Yeah, let’s do that separately ;)

