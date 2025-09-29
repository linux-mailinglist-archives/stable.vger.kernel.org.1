Return-Path: <stable+bounces-181869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D714BA8E36
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAB51C228C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68992580F2;
	Mon, 29 Sep 2025 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wy1pfPgs"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38D2F9D88
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141790; cv=none; b=gO8FyAYLBDvEg8yf48o3LtDI+dSzueZpZS3ApKFVS7/ifh8TyjcJNEYVZKqQmDJR32C2ZQAeWyxg+KYkiF+nZUTbgZZUy91a1Y9iAApRVXkyV8zSCp65HmR/5k0hL6lQscn0yEDurksz0guImu6hzAmD2Ar6kjwy+E5fdtDskVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141790; c=relaxed/simple;
	bh=Dcq5V4tf3jjWEesf+dKHX6423tm/a2VNtwdthDH1etU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iD6ur3KhpBzXakt+ojeiPeNM4fg8ex1/QS/+LLS0VD3bupWsWgev0LncYLqO40HQHZAlxwzR9ixInKYk664aJ8NKWNQtXhGXbBXVk9r44hz7ATUq+znq8QT6DGR+pdnXY9fEDs0LJeHf1L5HJz18qrZGM0k5oiytWCXw+I4wJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wy1pfPgs; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <900d0314-8e9a-4779-a058-9bb3cc8840b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759141785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUhtBwI4+jsvsk1lD+y61YKvfckMQnAYP5yAxgvSD1Y=;
	b=wy1pfPgsXvK57QzoBeqr38f+zuFNCl6FGSxmZUjM9R6wCDpTZ9t0hX+gNSnKfZRrtSEzA2
	vMeMSkorolNri5VHunRvbqe4Jdmtwk0/YyW7YagrfXI2cfA6FZd0GNUORN+sUTg80Ry2xf
	dJmG4C3A07A0TWBt0xR4IUcaf1bOrc8=
Date: Mon, 29 Sep 2025 18:29:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
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
Content-Language: en-US
In-Reply-To: <b19b4880-169f-4946-8c50-e82f699bb93b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/29 15:25, David Hildenbrand wrote:
> On 28.09.25 06:48, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> When splitting an mTHP and replacing a zero-filled subpage with the 
>> shared
>> zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
>> bit.
>>
>> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
>> incremental snapshots, losing this bit means modified pages are missed,
>> leading to inconsistent memory state after restore.
>>
>> Preserve the soft-dirty bit from the old PTE when creating the zeropage
>> mapping to ensure modified pages are correctly tracked.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>> when splitting isolated thp")
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/migrate.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index ce83c2c3c287..bf364ba07a3f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct 
>> page_vma_mapped_walk *pvmw,
>>       newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>                       pvmw->vma->vm_page_prot));
>> +
>> +    if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
>> +        newpte = pte_mksoft_dirty(newpte);
>> +
>>       set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>       dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> 
> It's interesting that there isn't a single occurrence of the stof-dirty 
> flag in khugepaged code. I guess it all works because we do the
> 
>      _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
> 
> and the pmd_mkdirty() will imply marking it soft-dirty.
> 
> Now to the problem at hand: I don't think this is particularly 
> problematic in the common case: if the page is zero, it likely was never 
> written to (that's what the unerused shrinker is targeted at), so the 
> soft-dirty setting on the PMD is actually just an over-indication for 
> this page.

Cool. Thanks for the insight! Good to know that ;)

> 
> For example, when we just install the shared zeropage directly in 
> do_anonymous_page(), we obviously also don't set it dirty/soft-dirty.
> 
> Now, one could argue that if the content was changed from non-zero to 
> zero, it ould actually be soft-dirty.

Exactly. A false negative could be a problem for the userspace tools, IMO.

> 
> Long-story short: I don't think this matters much in practice, but it's 
> an easy fix.
> 
> As said by dev, please avoid double ptep_get() if possible.

Sure, will do. I'll refactor it in the next version.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> 
> 
> @Lance, can you double-check that the uffd-wp bit is handled correctly? 
> I strongly assume we lose that as well here.

Certainly, I'll check the uffd-wp bit as well and get back to you soon.

Cheers,
Lance

