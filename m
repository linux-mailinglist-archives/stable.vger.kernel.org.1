Return-Path: <stable+bounces-105559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294D9FA57C
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD04C7A2177
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BD189903;
	Sun, 22 Dec 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mA4TqJkT"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D2824A3;
	Sun, 22 Dec 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734868420; cv=none; b=LmjzfwFO8upFu8syhBxhYPxt9IfWFYt+dm0FEVj4uI+Dam8Cl2Z5AP7IdImLqdqkQ0lVdqVuubpqiVcsKq3jHrJwScjg7k3zt8IWhbfaU7inZxuylNEU2uT32fD/4iM6h1oNc+BfJFfi1IAjp9AnpDlDIyFsDiOSy40hEOeTZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734868420; c=relaxed/simple;
	bh=SdkwkhqyYTqSjhm9orRJt15ybsCzOjAQgNkgrSZqxGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI3nWKKCqO5BY+H4s3wHu/qrXwU6b0GbIVV0yFMEwiIvOQPAUG7VZKeYMIbL8OH2MDv9Hq1fYvR6c7PW5b1elLtNpNpBx47koTtvncfVw1apVruV/hZ+tPJGbSm4dV+BQqbGZkWgDYvJbIG2LacfSVABFJr6ohPDgymOk4bfC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mA4TqJkT; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=8iBGyhnfqgjCTgk/XlJi8b/O6yi4Lyu+Du98lMusV1Q=;
	b=mA4TqJkTQ1jDNlM4x2V8vxnYPgBIu7fijV3qnE4rwkNWcbehuMzDJDFYuxyQYc
	cXv9oywXb9kTcBhSekqX3IR/OU7waPc/ALvnr/r5vL+dX2/wd+SrObgbwM+4BejB
	f/Tlj/cX0sdjLxOReTaQEOQfFRtU3fAm1wvF+fGzRM/sM=
Received: from [172.20.10.3] (unknown [39.144.107.68])
	by gzsmtp4 (Coremail) with SMTP id qCkvCgDHf1gb_WdnUD9jCw--.18188S2;
	Sun, 22 Dec 2024 19:50:52 +0800 (CST)
Message-ID: <f877d493-8d06-43da-a4cb-f056d60dd921@126.com>
Date: Sun, 22 Dec 2024 19:50:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0b41cc6b-5c93-408f-801f-edd9793cb979@redhat.com>
 <1241b567-88b6-462c-9088-8f72a45788b7@126.com>
 <fe57ef80-bbdb-44dc-97d9-b390778430a4@redhat.com>
 <333e584c-2688-4a3f-bc1f-2e84d5215005@126.com>
 <433fb64d-80e1-4d96-904e-10b51e40898d@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <433fb64d-80e1-4d96-904e-10b51e40898d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qCkvCgDHf1gb_WdnUD9jCw--.18188S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1xWw4rGFyUZw1DGw4fGrg_yoWxJryrpF
	W8Ga17trWDJr9xJrn2qw1DCr10yrsrWrWjgF1rtFWFvrsIvry7Kr12y3WY93yrAr1fGF40
	vrWvqws7uF1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKFAJUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRO9G2dnuXaZzgABs1



在 2024/12/21 22:32, David Hildenbrand 写道:
> On 21.12.24 13:04, Ge Yang wrote:
>>
>>
>> 在 2024/12/21 0:30, David Hildenbrand 写道:
>>> On 20.12.24 09:56, Ge Yang wrote:
>>>>
>>>>
>>>> 在 2024/12/20 0:40, David Hildenbrand 写道:
>>>>> On 18.12.24 07:33, yangge1116@126.com wrote:
>>>>>> From: yangge <yangge1116@126.com>
>>>>>
>>>>> CCing Oscar, who worked on migrating these pages during memory 
>>>>> offlining
>>>>> and alloc_contig_range().
>>>>>
>>>>>>
>>>>>> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
>>>>>> have configured each NUMA node with 16GB of CMA and 16GB of in-use
>>>>>> hugetlb pages. The allocation of contiguous memory via the
>>>>>> cma_alloc() function can fail probabilistically.
>>>>>>
>>>>>> The cma_alloc() function may fail if it sees an in-use hugetlb page
>>>>>> within the allocation range, even if that page has already been
>>>>>> migrated. When in-use hugetlb pages are migrated, they may simply
>>>>>> be released back into the free hugepage pool instead of being
>>>>>> returned to the buddy system. This can cause the
>>>>>> test_pages_isolated() function check to fail, ultimately leading
>>>>>> to the failure of the cma_alloc() function:
>>>>>> cma_alloc()
>>>>>>        __alloc_contig_migrate_range() // migrate in-use hugepage
>>>>>>        test_pages_isolated()
>>>>>>            __test_page_isolated_in_pageblock()
>>>>>>                 PageBuddy(page) // check if the page is in buddy
>>>>>
>>>>> I thought this would be working as expected, at least we tested it 
>>>>> with
>>>>> alloc_contig_range / virtio-mem a while ago.
>>>>>
>>>>> On the memory_offlining path, we migrate hugetlb folios, but also
>>>>> dissolve any remaining free folios even if it means that we will going
>>>>> below the requested number of hugetlb pages in our pool.
>>>>>
>>>>> During alloc_contig_range(), we only migrate them, to then free 
>>>>> them up
>>>>> after migration.
>>>>>
>>>>> Under which circumstances doe sit apply that "they may simply be
>>>>> released back into the free hugepage pool instead of being returned to
>>>>> the buddy system"?
>>>>>
>>>>
>>>> After migration, in-use hugetlb pages are only released back to the
>>>> hugetlb pool and are not returned to the buddy system.
>>>
>>> We had
>>>
>>> commit ae37c7ff79f1f030e28ec76c46ee032f8fd07607
>>> Author: Oscar Salvador <osalvador@suse.de>
>>> Date:   Tue May 4 18:35:29 2021 -0700
>>>
>>>       mm: make alloc_contig_range handle in-use hugetlb pages
>>>       alloc_contig_range() will fail if it finds a HugeTLB page 
>>> within the
>>>       range, without a chance to handle them.  Since HugeTLB pages 
>>> can be
>>>       migrated as any LRU or Movable page, it does not make sense to 
>>> bail
>>> out
>>>       without trying.  Enable the interface to recognize in-use HugeTLB
>>> pages so
>>>       we can migrate them, and have much better chances to succeed 
>>> the call.
>>>
>>>
>>> And I am trying to figure out if it never worked correctly, or if
>>> something changed that broke it.
>>>
>>>
>>> In start_isolate_page_range()->isolate_migratepages_block(), we do the
>>>
>>>       ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
>>>
>>> to add these folios to the cc->migratepages list.
>>>
>>> In __alloc_contig_migrate_range(), we migrate the pages using
>>> migrate_pages().
>>>
>>>
>>> After that, the src hugetlb folios should still be isolated?
>> Yes.
>>
>> But I'm
>>> getting
>>> confused when these pages get un-silated and putback to hugetlb/freed.
>>>
>> If the migration is successful, call folio_putback_active_hugetlb to
>> release the src hugetlb folios back to the free hugetlb pool.
>>
>> trace:
>> unmap_and_move_huge_page
>>       folio_putback_active_hugetlb
>>           folio_put
>>               free_huge_folio
>>
>> alloc_contig_range_noprof
>>       __alloc_contig_migrate_range
>>       if (test_pages_isolated())  //to determine if hugetlb pages in 
>> buddy
>>           isolate_freepages_range //grab isolated pages from freelists.
>>       else
>>           undo_isolate_page_range //undo isolate
> 
> Ah, now I remember, thanks.
> 
> So when we free an ordinary page, we put it onto the buddy isolate list, 
> from where we can grab it later and nobody can allocate it in the meantime.
> 
> In case of hugetlb, we simply free it back to hugetlb, from where it can 
> likely even get allocated immediately again.
> 
> I think that can actually happen in your proposal: the now-free page 
> will get reallocated, for example for migrating the next folio. Or some 
> concurrent system activity can simply allocate the now-free folio. Or am 
> I missing something that prevents these now-free hugetlb folios from 
> getting re-allocated after migration succeeded?
> 
> 
> Conceptually, I think we would want migration code in the case of 
> alloc_contig_range() to allocate a new folio from the buddy, and to free 
> the old one back to the buddy immediately, without ever allowing re- 
> allocation of it.
> 
> What needs to be handled is detecting that
> 
> (a) we want to allocate a fresh hugetlb folio as migration target
> (b) if migration succeeds, we have to free the hugetlb folio back to the 
> buddy
> (c) if migation fails, we have to free the allocated hugetlb foliio back 
> to the buddy
> 
> 
> We could provide a custom alloc_migration_target that we pass to 
> migrate_page to allocate a fresh hugetlb folio to handle (a). Using the 
> put_new_folio callback we could handle (c). (b) would need some thought.
It seems that if we allocate a fresh hugetlb folio as the migration 
target, the source hugetlb folio will be automatically released back to 
the buddy system.

> 
> Maybe we can also just mark the source folio as we isolate it, and 
> enlighten migration+freeing code to handle it automatically?
Can we determine whether a hugetlb page is isolated when allocating it 
from the free hugetlb pool?

dequeue_hugetlb_folio_node_exact() {
     list_for_each_entry(folio, &h->hugepage_freelists[nid], lru) {
         if (is_migrate_isolate_page(folio)) {  //determine whether a 
hugetlb page is isolated
              continue;
         }
     }
}

> 
> Hoping to get some feedback from hugetlb maintainers.
> 


