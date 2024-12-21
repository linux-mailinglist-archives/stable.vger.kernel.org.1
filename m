Return-Path: <stable+bounces-105532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022479FA07E
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 13:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F067165C17
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664071F190D;
	Sat, 21 Dec 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pSI2BljQ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245B25949E;
	Sat, 21 Dec 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734782812; cv=none; b=IaEEDjNUqbv4IpvSNEVmT6oOTI+Ef+iw1nCKzzEBoxcoTBQZVfy0G+uKvDkAiOcDG7LwFwTtrbv5omnTMNX+FpKylQ4qUztaPMp+h++zmP4hCBVEfe0u6gOmmLYdjWuRFKzq075CPIJ0d+hrIlyZls0kARtr1QDyFCH8Ca/1Nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734782812; c=relaxed/simple;
	bh=6cjg3bXh/OsM3E60x8rS36hGGpEICt6jZLZJ04Gjrn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kur6d03S2cotCtmfG0SIzGHk3U6hZGKQXIvt5fuKFXCvz2/A12Gs0t1+g8/O9Sd7fj9Dx3a1ndm0atWZZOlk1/+tpnBdVyvhxy5NQPU6jUCb61w0i6dtKaRsQ8XBoTpyKLQaQ6OQXKYYpRg885meQhu6IWxCW/DWxeYJoYkvDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pSI2BljQ; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZosUyGnmovPEBWzy4oa5AcYcXN9kr0hw/5zK6jZF/oA=;
	b=pSI2BljQQLjBGym0Fj5onDlp1iv/QuBHPub0ar7EGSGggMZ/WqJ1YKhYoDRvdj
	1WC01F2Bf6I6M9Zgjm01M7iToTQMk4dxOSsA3tLuWCrdtYzmzMINhsJLYCAWweO2
	XgUvJWvv26QzWCjrnOVN+vBu4lRpJNujSgjYPHFVBo274=
Received: from [172.20.10.3] (unknown [39.144.39.55])
	by gzsmtp4 (Coremail) with SMTP id qCkvCgD3PIfrrmZnzSstCw--.48830S2;
	Sat, 21 Dec 2024 20:05:00 +0800 (CST)
Message-ID: <333e584c-2688-4a3f-bc1f-2e84d5215005@126.com>
Date: Sat, 21 Dec 2024 20:04:59 +0800
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
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <fe57ef80-bbdb-44dc-97d9-b390778430a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qCkvCgD3PIfrrmZnzSstCw--.48830S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr48ZFyxKry3Gr4xKw4Durg_yoWrZw4UpF
	WrGa1ak3yDJrZxJr12qwn8CF1FyrsrWFW0qF1rtF9YvwsxAryIkr12yw1Y93yfAr1fGa10
	v3yvqws7u3WUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKFAJUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhu7G2dlk9LH2gACsd



在 2024/12/21 0:30, David Hildenbrand 写道:
> On 20.12.24 09:56, Ge Yang wrote:
>>
>>
>> 在 2024/12/20 0:40, David Hildenbrand 写道:
>>> On 18.12.24 07:33, yangge1116@126.com wrote:
>>>> From: yangge <yangge1116@126.com>
>>>
>>> CCing Oscar, who worked on migrating these pages during memory offlining
>>> and alloc_contig_range().
>>>
>>>>
>>>> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
>>>> have configured each NUMA node with 16GB of CMA and 16GB of in-use
>>>> hugetlb pages. The allocation of contiguous memory via the
>>>> cma_alloc() function can fail probabilistically.
>>>>
>>>> The cma_alloc() function may fail if it sees an in-use hugetlb page
>>>> within the allocation range, even if that page has already been
>>>> migrated. When in-use hugetlb pages are migrated, they may simply
>>>> be released back into the free hugepage pool instead of being
>>>> returned to the buddy system. This can cause the
>>>> test_pages_isolated() function check to fail, ultimately leading
>>>> to the failure of the cma_alloc() function:
>>>> cma_alloc()
>>>>       __alloc_contig_migrate_range() // migrate in-use hugepage
>>>>       test_pages_isolated()
>>>>           __test_page_isolated_in_pageblock()
>>>>                PageBuddy(page) // check if the page is in buddy
>>>
>>> I thought this would be working as expected, at least we tested it with
>>> alloc_contig_range / virtio-mem a while ago.
>>>
>>> On the memory_offlining path, we migrate hugetlb folios, but also
>>> dissolve any remaining free folios even if it means that we will going
>>> below the requested number of hugetlb pages in our pool.
>>>
>>> During alloc_contig_range(), we only migrate them, to then free them up
>>> after migration.
>>>
>>> Under which circumstances doe sit apply that "they may simply be
>>> released back into the free hugepage pool instead of being returned to
>>> the buddy system"?
>>>
>>
>> After migration, in-use hugetlb pages are only released back to the
>> hugetlb pool and are not returned to the buddy system.
> 
> We had
> 
> commit ae37c7ff79f1f030e28ec76c46ee032f8fd07607
> Author: Oscar Salvador <osalvador@suse.de>
> Date:   Tue May 4 18:35:29 2021 -0700
> 
>      mm: make alloc_contig_range handle in-use hugetlb pages
>      alloc_contig_range() will fail if it finds a HugeTLB page within the
>      range, without a chance to handle them.  Since HugeTLB pages can be
>      migrated as any LRU or Movable page, it does not make sense to bail 
> out
>      without trying.  Enable the interface to recognize in-use HugeTLB 
> pages so
>      we can migrate them, and have much better chances to succeed the call.
> 
> 
> And I am trying to figure out if it never worked correctly, or if
> something changed that broke it.
> 
> 
> In start_isolate_page_range()->isolate_migratepages_block(), we do the
> 
>      ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
> 
> to add these folios to the cc->migratepages list.
> 
> In __alloc_contig_migrate_range(), we migrate the pages using 
> migrate_pages().
> 
> 
> After that, the src hugetlb folios should still be isolated? 
Yes.

But I'm
> getting
> confused when these pages get un-silated and putback to hugetlb/freed.
> 
If the migration is successful, call folio_putback_active_hugetlb to 
release the src hugetlb folios back to the free hugetlb pool.

trace:
unmap_and_move_huge_page
     folio_putback_active_hugetlb
         folio_put
             free_huge_folio

alloc_contig_range_noprof
     __alloc_contig_migrate_range
     if (test_pages_isolated())  //to determine if hugetlb pages in buddy
         isolate_freepages_range //grab isolated pages from freelists.
     else
         undo_isolate_page_range //undo isolate

> 
>>
>> The specific steps for reproduction are as follows:
>> 1，Reserve hugetlb pages. Some of these hugetlb pages are allocated
>> within the CMA area.
>> echo 10240 > /proc/sys/vm/nr_hugepages
>>
>> 2，To ensure that hugetlb pages are in an in-use state, we can use the
>> following command.
>> qemu-system-x86_64 \
>>     -mem-prealloc \
>>     -mem-path /dev/hugepage/ \
>>     ...
>>
>> 3，At this point, using cma_alloc() to allocate contiguous memory may
>> result in a probable failure.
>>
> 
> Will these free hugetlb folios become surplus pages? I would have assumed
> they get freed immediately to the buddy, or does you config maybe allow for
> surplus pages?
> 
These freed hugetlb folios will not become surplus pages. I have not 
configured the system to allow for the existence of surplus pages.



