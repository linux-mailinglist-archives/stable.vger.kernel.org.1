Return-Path: <stable+bounces-105101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02E9F5CBA
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFABA7A199B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5A1EA90;
	Wed, 18 Dec 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AImudZie"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F32F3B;
	Wed, 18 Dec 2024 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488146; cv=none; b=N9uby+wgKxGq3to33t2D/vwOvaSka9v8832H1vZPtyK+nXtiZ2nDibDeJTP30LUnDQ3dJ3dDlu1UtldGZg0On9bTdfyl18YFWRhVknt5MCPz5P1a3ZV8B17qIQf2+e+y+42XZKY8Wt8dZGd+aMxV8gfAMXiFq5aKW8PXA1H03Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488146; c=relaxed/simple;
	bh=PGcVUbTDxYfjAwzNSqwhREh3pDsx5gmJswCYMRavpjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMsWDoitIy8CDw7sgPbmbnSqvfzVKevFMYE8qpepkCKkH2jY9sd6GXnsUd9+XwkweWIKiaPvvwJSkQGVCAVIiOwZRQ4A3SMzuUkWNqAFSL1qFSy8wEDm6T9RwKn6t4rnOPB6KZ/1qk9WNSHXVGnw6LIQjFT+9whRdYynsJYW7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AImudZie; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=53Hsg8krc/9Eb72fAtYb1b6FfRkOMXJEiWWXPojXaYI=;
	b=AImudZie8AJIhZ1ru//aQrHQtuopGbEdVrjvBBH+rsob0m0p9EaHck8PwKz5gc
	L929EGqvAgeR04MpKCTQqwro5JtX5/3xZRyuJoT8xmDhI96HAEom3/Gz7yghvkOf
	kS3SofgDfXmSnqppdhnL8tCq+qfFZ0pkEiNCmT1bBN+Hk=
Received: from [172.21.22.210] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3l5IqMGJneqnIAQ--.29653S2;
	Wed, 18 Dec 2024 10:15:07 +0800 (CST)
Message-ID: <93cf1aee-70df-426f-a3c0-1db8068bd59a@126.com>
Date: Wed, 18 Dec 2024 10:15:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] mm, compaction: don't use ALLOC_CMA for unmovable
 allocations
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, vbabka@suse.cz,
 liuzixing@hygon.cn
References: <1734436004-1212-1-git-send-email-yangge1116@126.com>
 <20241217155551.GA37530@cmpxchg.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20241217155551.GA37530@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l5IqMGJneqnIAQ--.29653S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4xCw17CF4fGrWxCr48JFb_yoWrGry8pF
	W8ZrnFkws8ZFWDKrn2yw1v9a4jga18tF4UJw1qvrykursIkF9IkF1DtFyUCFyUXr15tayS
	qFW8u3sxAa15Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqYLPUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhq4G2dhmi52-wACs6



在 2024/12/17 23:55, Johannes Weiner 写道:
> Hello Yangge,
> 
> On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>> in __compaction_suitable()") allow compaction to proceed when free
>> pages required for compaction reside in the CMA pageblocks, it's
>> possible that __compaction_suitable() always returns true, and in
>> some cases, it's not acceptable.
>>
>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>> and starting a 32GB virtual machine with device passthrough is
>> extremely slow, taking almost an hour.
>>
>> During the start-up of the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>> Long term GUP cannot allocate memory from CMA area, so a maximum
>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>> machine memory. Since there is 16G of free CMA memory on the NUMA
>> node, watermark for order-0 always be met for compaction, so
>> __compaction_suitable() always returns true, even if the node is
>> unable to allocate non-CMA memory for the virtual machine.
>>
>> For costly allocations, because __compaction_suitable() always
>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>> place, resulting in excessively long virtual machine startup times.
>> Call trace:
>> __alloc_pages_slowpath
>>      if (compact_result == COMPACT_SKIPPED ||
>>          compact_result == COMPACT_DEFERRED)
>>          goto nopage; // should exit __alloc_pages_slowpath() from here
>>
>> Other unmovable alloctions, like dma_buf, which can be large in a
>> Linux system, are also unable to allocate memory from CMA, and these
>> allocations suffer from the same problems described above. In order
>> to quickly fall back to remote node, we should remove ALLOC_CMA both
>> in __compaction_suitable() and __isolate_free_page() for unmovable
>> alloctions. After this fix, starting a 32GB virtual machine with
>> device passthrough takes only a few seconds.
> 
> The symptom is obviously bad, but I don't understand this fix.
> 
> The reason we do ALLOC_CMA is that, even for unmovable allocations,
> you can create space in non-CMA space by moving migratable pages over
> to CMA space. This is not a property we want to lose. But I also don't
> see how it would interfere with your scenario.

The __alloc_pages_slowpath() function was originally intended to exit at 
place 1, but due to __compaction_suitable() always returning true, it 
results in __alloc_pages_slowpath() exiting at place 2 instead. This 
ultimately leads to a significantly longer execution time for 
__alloc_pages_slowpath().

Call trace:
  __alloc_pages_slowpath
       if (compact_result == COMPACT_SKIPPED ||
          compact_result == COMPACT_DEFERRED)
           goto nopage; // place 1
       __alloc_pages_direct_reclaim() // Reclaim is very expensive
       __alloc_pages_direct_compact()
       if (gfp_mask & __GFP_NORETRY)
           goto nopage; // place 2

Every time memory allocation goes through the above slower process, it 
ultimately leads to significantly longer virtual machine startup times.

> 
> There is the compaction_suitable() check in should_compact_retry(),
> but that only applies when COMPACT_SKIPPED. IOW, it should only happen
> when compaction_suitable() just now returned false. IOW, a race
> condition. Which is why it's also not subject to limited retries.
> 
> What's the exact condition that traps the allocator inside the loop?
The should_compact_retry() function was not executed, and the slow here 
was mainly due to the execution of __alloc_pages_direct_reclaim().


