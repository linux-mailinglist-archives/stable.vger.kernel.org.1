Return-Path: <stable+bounces-181423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD642B93E62
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 03:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769617A4749
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575225A334;
	Tue, 23 Sep 2025 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NsZlq29c"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A08635D
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592157; cv=none; b=QhzwSeH6KFqAJnbq1E3hfQTP8s0AkzXkMxgbN4RJxZHKLdxehwYfr+J0d/bDiHqKFAgtGWDcfzUK5H2DyDPsfLsgQWyyue9Tzls4rv8x/EdRHtvbViLtMwBy6iYbx0dORc2HFGHz9hQ5/dy0hshgTDxC260+yHfa0GMISzhwv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592157; c=relaxed/simple;
	bh=TkiTPMRoLkZWncaiZSIK+7gzZui0QKiQe9GqYXV8xvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrV5RVKzRbrQbA/eBEMVS9onboCAa2YIIXnkSRaJR8zLDNcIaqE978wyaLa7thUR2mvONDzXISBWFkAxpJ4PIlH49pSBmO8M7eFNuZwuBnaNNmtZIsmxHOcccRvo1M5Pth9Rn2D2PSUACJnAIXeblVd9gqtu9LQ3no+3+YMfHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NsZlq29c; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9471bd83-911f-433d-8ce2-f83f080ed264@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758592150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KiWATjJlRyNXagDcw5KRHJfeXKRLsAKy/bPmDguzbG0=;
	b=NsZlq29cN7YJE4XCbL77ung8YpUPS/Ew9mPVomMh00fJjOeP0PekGP1EtxZgGpMCHL7cOg
	hn8YGsfqo2M5EI3luUBnZUXQOc4F7+KZLHXZfeHrkKaRVyvNSVVMtRyO46aE7/0e6fCf2M
	ugvJETzfOwEkWEw7g7wKHzc6mVClt/E=
Date: Tue, 23 Sep 2025 09:48:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
 Liam.Howlett@oracle.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com> <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/23 01:59, David Hildenbrand wrote:
> On 22.09.25 19:24, Catalin Marinas wrote:
>> On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> When both THP and MTE are enabled, splitting a THP and replacing its
>>> zero-filled subpages with the shared zeropage can cause MTE tag mismatch
>>> faults in userspace.
>>>
>>> Remapping zero-filled subpages to the shared zeropage is unsafe, as the
>>> zeropage has a fixed tag of zero, which may not match the tag 
>>> expected by
>>> the userspace pointer.
>>>
>>> KSM already avoids this problem by using memcmp_pages(), which on arm64
>>> intentionally reports MTE-tagged pages as non-identical to prevent 
>>> unsafe
>>> merging.
>>>
>>> As suggested by David[1], this patch adopts the same pattern, 
>>> replacing the
>>> memchr_inv() byte-level check with a call to pages_identical(). This
>>> leverages existing architecture-specific logic to determine if a page is
>>> truly identical to the shared zeropage.
>>>
>>> Having both the THP shrinker and KSM rely on pages_identical() makes the
>>> design more future-proof, IMO. Instead of handling quirks in generic 
>>> code,
>>> we just let the architecture decide what makes two pages identical.
>>>
>>> [1] https://lore.kernel.org/all/ 
>>> ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
>>> Closes: https://lore.kernel.org/all/ 
>>> a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
>>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage 
>>> when splitting isolated thp")
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>
>> Functionally, the patch looks fine, both with and without MTE.
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for taking time to review!

>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 32e0ec2dde36..28d4b02a1aa5 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4104,29 +4104,20 @@ static unsigned long 
>>> deferred_split_count(struct shrinker *shrink,
>>>   static bool thp_underused(struct folio *folio)
>>>   {
>>>       int num_zero_pages = 0, num_filled_pages = 0;
>>> -    void *kaddr;
>>>       int i;
>>>       for (i = 0; i < folio_nr_pages(folio); i++) {
>>> -        kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>>> -        if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>>> -            num_zero_pages++;
>>> -            if (num_zero_pages > khugepaged_max_ptes_none) {
>>> -                kunmap_local(kaddr);
>>> +        if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
>>> +            if (++num_zero_pages > khugepaged_max_ptes_none)
>>>                   return true;
>>
>> I wonder what the overhead of doing a memcmp() vs memchr_inv() is. The
>> former will need to read from two places. If it's noticeable, it would
>> affect architectures that don't have an MTE equivalent.
>>
>> Alternatively we could introduce something like folio_has_metadata()
>> which on arm64 simply checks PG_mte_tagged.
> 
> We discussed something similar in the other thread (I suggested 
> page_is_mergable()). I'd prefer to use pages_identical() for now, so we 
> have the same logic here and in ksm code.
> 
> (this patch here almost looks like a cleanup :) )

Yeah, let's keep it as-is for now.

Using the same pages_identical() pattern as KSM makes the logic
consistent.

And it's simple enough to be easily backported to stable trees ;)

> 
> If this becomes a problem, what we could do is in pages_identical() 
> would be simply doing the memchr_inv() in case is_zero_pfn(). KSM might 
> benefit from that as well when merging with the shared zeropage through 
> try_to_merge_with_zero_page().

Right, there is room for that optimization. I will look into it as a
follow-up patch after this one is settled and backported, especially if
the performance overhead turns out to be a real concern :)

Cheers,
Lance

