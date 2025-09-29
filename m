Return-Path: <stable+bounces-181912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8722BA9518
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154161920C39
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2E3054D6;
	Mon, 29 Sep 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nofgTvVc"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917F26F443
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152172; cv=none; b=fTwwHajYz2ai8NP86O8KiOLzVrh/8iSi+q+XgA9SjbZNYwr6cUS/l7j67ERJFVsLRKYoeJszh2C9O7uRiMZ0aOnIOL16DViGCzJ8dcBu/sbxjwcXpP16HOabH4NxHzjcFcmmC1/G1JYTfqH7g2BrVxkiXj3FtnKPBcJkBPQShdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152172; c=relaxed/simple;
	bh=avDN4Jk0dcmDDAJsxd1Ya6Eyi9qpGIUO1bswDv8fR3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jj4BV/1qnNukhtUbBal6batTDgDVToEPQ92L1oYHKzVmLMwMjsh3bYC/xsVC8F/+sAJomlrZIbXo2QYib+LOV+u3xFQXr1kPojCCLXzCXL1xaTRK/MiT8SFFD8nSwLGcUa+Y/PS6dB6iFmfwGlqB5JnpoYjRsQwdmgMeXwh78zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nofgTvVc; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0701c9d9-b9b3-4313-8783-8e6d1dbec94d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759152165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEY4Wq5zRiJY8ZDmsjRBwwv7BQUDjoacSGQVy+nSiw8=;
	b=nofgTvVcT7NTFQk/LoeYAL1QMMD+NwAgSMS5++Z3v51RGaY0qB/4sNR1XmpkccV1gutI6R
	FN4D8JDH3/YFp7o+/xwfMvq9ZK+7IugxZZGwSgCbVwFWu2CZ0heC7OFSz/U5B7PLrjj3eH
	anK6qqN9M0/hCNWp+lVtGY1zP+HCSHY=
Date: Mon, 29 Sep 2025 21:22:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
References: <20250928044855.76359-1-lance.yang@linux.dev>
 <b19b4880-169f-4946-8c50-e82f699bb93b@redhat.com>
 <900d0314-8e9a-4779-a058-9bb3cc8840b8@linux.dev>
 <1f66374a-a901-49e7-95c8-96b1e5a5f22d@linux.dev>
 <69b463e5-9854-496d-b461-4bf65e82bc0a@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <69b463e5-9854-496d-b461-4bf65e82bc0a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/29 20:08, David Hildenbrand wrote:
> On 29.09.25 13:29, Lance Yang wrote:
>>
>>
>> On 2025/9/29 18:29, Lance Yang wrote:
>>>
>>>
>>> On 2025/9/29 15:25, David Hildenbrand wrote:
>>>> On 28.09.25 06:48, Lance Yang wrote:
>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>
>>>>> When splitting an mTHP and replacing a zero-filled subpage with the
>>>>> shared
>>>>> zeropage, try_to_map_unused_to_zeropage() currently drops the soft- 
>>>>> dirty
>>>>> bit.
>>>>>
>>>>> For userspace tools like CRIU, which rely on the soft-dirty mechanism
>>>>> for
>>>>> incremental snapshots, losing this bit means modified pages are 
>>>>> missed,
>>>>> leading to inconsistent memory state after restore.
>>>>>
>>>>> Preserve the soft-dirty bit from the old PTE when creating the 
>>>>> zeropage
>>>>> mapping to ensure modified pages are correctly tracked.
>>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage
>>>>> when splitting isolated thp")
>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>> ---
>>>>>    mm/migrate.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index ce83c2c3c287..bf364ba07a3f 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct
>>>>> page_vma_mapped_walk *pvmw,
>>>>>        newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>>>>                        pvmw->vma->vm_page_prot));
>>>>> +
>>>>> +    if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
>>>>> +        newpte = pte_mksoft_dirty(newpte);
>>>>> +
>>>>>        set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>>>        dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>>>>
>>>> It's interesting that there isn't a single occurrence of the stof-
>>>> dirty flag in khugepaged code. I guess it all works because we do the
>>>>
>>>>       _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>>>
>>>> and the pmd_mkdirty() will imply marking it soft-dirty.
>>>>
>>>> Now to the problem at hand: I don't think this is particularly
>>>> problematic in the common case: if the page is zero, it likely was
>>>> never written to (that's what the unerused shrinker is targeted at),
>>>> so the soft-dirty setting on the PMD is actually just an over-
>>>> indication for this page.
>>>
>>> Cool. Thanks for the insight! Good to know that ;)
>>>
>>>>
>>>> For example, when we just install the shared zeropage directly in
>>>> do_anonymous_page(), we obviously also don't set it dirty/soft-dirty.
>>>>
>>>> Now, one could argue that if the content was changed from non-zero to
>>>> zero, it ould actually be soft-dirty.
>>>
>>> Exactly. A false negative could be a problem for the userspace tools, 
>>> IMO.
>>>
>>>>
>>>> Long-story short: I don't think this matters much in practice, but
>>>> it's an easy fix.
>>>>
>>>> As said by dev, please avoid double ptep_get() if possible.
>>>
>>> Sure, will do. I'll refactor it in the next version.
>>>
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>> Thanks!
>>>
>>>>
>>>>
>>>> @Lance, can you double-check that the uffd-wp bit is handled
>>>> correctly? I strongly assume we lose that as well here.
>>
>> Yes, the uffd-wp bit was indeed being dropped, but ...
>>
>> The shared zeropage is read-only, which triggers a fault. IIUC,
>> The kernel then falls back to checking the VM_UFFD_WP flag on
>> the VMA and correctly generates a uffd-wp event, masking the
>> fact that the uffd-wp bit on the PTE was lost.
> 
> That's not how VM_UFFD_WP works :)

My bad! Please accept my apologies for the earlier confusion :(

I messed up my test environment (forgot to enable mTHP), which
led me to a completely wrong conclusion...

You're spot on. With mTHP enabled, the WP fault was not caught
on the shared zeropage after it replaced a zero-filled subpage
during an mTHP split.

This is because do_wp_page() requires userfaultfd_pte_wp() to
be true, which in turn needs both userfaultfd_wp(vma) and
pte_uffd_wp(pte).

static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
				      pte_t pte)
{
	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
}

userfaultfd_pte_wp() fails as we lose the uffd-wp bit on the PTE ...

Please correct me if I missed something important!

