Return-Path: <stable+bounces-105108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECF9F5DA9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 04:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78F416E85D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0014AD19;
	Wed, 18 Dec 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iWVhY2br"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBD35963;
	Wed, 18 Dec 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494290; cv=none; b=KgT86xOmYJKD6A0BWm8AQOMoO+p4NY3lrO6A+kew21NYMFl4QjWGNggbqNqMCH3/obGTCzNmQjEy5p8WglOonEFXRzXygwi09JWyw3pDj3o/u1CL3IMyEr+YERB8XbZm+3BlZ+in+cEvMdO5YN5a3g5yTECpWuvnA4NRWy9r9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494290; c=relaxed/simple;
	bh=r6YWsxT/NFC00nyD2nQaRrogopwLKEBi/LPyO8xZtmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey0AElWY063RdRUYOKF2AoPDbEfQFlVJjAvF0jOOEfVhTHFDLSl+9PQ7mBCqWb+VfD/MoRwKbDTWIucs29qlw8DMmWLM0NOm8+Yfi+LjX0plRdSbRFa38yXckkwiBZOWVk46XR42jHEoAJoBzvxdTxONw+bWAARDPfaLzT8yrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iWVhY2br; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=H0rV7nOqP7RCz5IRGPZCsWDOEEA7MaqTNZrDyQCLXDU=;
	b=iWVhY2br4gav4iLHbubC30fUr7QSorZDno/KyHUR85mzrjmP7LjWoSbSX5CelD
	LbUU/G65lcuAASAGVu9rgsJvfxxKGTN+55vGsvvEFQQ8/2wyEIkvodEeoSnhxU7I
	gXaVuGdsmR4aUZkC6wIUSxjpQQqUEb6LcYFMuSJC77L48=
Received: from [172.21.22.210] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3X1T9R2JnRKLGAQ--.51710S2;
	Wed, 18 Dec 2024 11:56:46 +0800 (CST)
Message-ID: <fbc8a712-8ddd-467f-ab1f-d146f19535a6@126.com>
Date: Wed, 18 Dec 2024 11:56:45 +0800
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
 <93cf1aee-70df-426f-a3c0-1db8068bd59a@126.com>
 <20241218032936.GB37530@cmpxchg.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20241218032936.GB37530@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1T9R2JnRKLGAQ--.51710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW5Xr1Dur43WF1furW5Awb_yoW7WF4Dpr
	W7ZFnFkws8XFy5Krs7tw1v9a4Ygw4rJF4UXw10vr1kurnI9F9FkF4DtFyUCFyUXr15JayY
	qFWUuF9rZF45Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq0PhUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifhi5G2diKSuriQACsj



在 2024/12/18 11:29, Johannes Weiner 写道:
> On Wed, Dec 18, 2024 at 10:15:06AM +0800, Ge Yang wrote:
>>
>>
>> 在 2024/12/17 23:55, Johannes Weiner 写道:
>>> Hello Yangge,
>>>
>>> On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
>>>> in __compaction_suitable()") allow compaction to proceed when free
>>>> pages required for compaction reside in the CMA pageblocks, it's
>>>> possible that __compaction_suitable() always returns true, and in
>>>> some cases, it's not acceptable.
>>>>
>>>> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
>>>> of memory. I have configured 16GB of CMA memory on each NUMA node,
>>>> and starting a 32GB virtual machine with device passthrough is
>>>> extremely slow, taking almost an hour.
>>>>
>>>> During the start-up of the virtual machine, it will call
>>>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
>>>> Long term GUP cannot allocate memory from CMA area, so a maximum
>>>> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
>>>> machine memory. Since there is 16G of free CMA memory on the NUMA
>>>> node, watermark for order-0 always be met for compaction, so
>>>> __compaction_suitable() always returns true, even if the node is
>>>> unable to allocate non-CMA memory for the virtual machine.
>>>>
>>>> For costly allocations, because __compaction_suitable() always
>>>> returns true, __alloc_pages_slowpath() can't exit at the appropriate
>>>> place, resulting in excessively long virtual machine startup times.
>>>> Call trace:
>>>> __alloc_pages_slowpath
>>>>       if (compact_result == COMPACT_SKIPPED ||
>>>>           compact_result == COMPACT_DEFERRED)
>>>>           goto nopage; // should exit __alloc_pages_slowpath() from here
>>>>
>>>> Other unmovable alloctions, like dma_buf, which can be large in a
>>>> Linux system, are also unable to allocate memory from CMA, and these
>>>> allocations suffer from the same problems described above. In order
>>>> to quickly fall back to remote node, we should remove ALLOC_CMA both
>>>> in __compaction_suitable() and __isolate_free_page() for unmovable
>>>> alloctions. After this fix, starting a 32GB virtual machine with
>>>> device passthrough takes only a few seconds.
>>>
>>> The symptom is obviously bad, but I don't understand this fix.
>>>
>>> The reason we do ALLOC_CMA is that, even for unmovable allocations,
>>> you can create space in non-CMA space by moving migratable pages over
>>> to CMA space. This is not a property we want to lose. But I also don't
>>> see how it would interfere with your scenario.
>>
>> The __alloc_pages_slowpath() function was originally intended to exit at
>> place 1, but due to __compaction_suitable() always returning true, it
>> results in __alloc_pages_slowpath() exiting at place 2 instead. This
>> ultimately leads to a significantly longer execution time for
>> __alloc_pages_slowpath().
>>
>> Call trace:
>>    __alloc_pages_slowpath
>>         if (compact_result == COMPACT_SKIPPED ||
>>            compact_result == COMPACT_DEFERRED)
>>             goto nopage; // place 1
>>         __alloc_pages_direct_reclaim() // Reclaim is very expensive
>>         __alloc_pages_direct_compact()
>>         if (gfp_mask & __GFP_NORETRY)
>>             goto nopage; // place 2
>>
>> Every time memory allocation goes through the above slower process, it
>> ultimately leads to significantly longer virtual machine startup times.
> 
> I still don't follow. Why do you want the allocation to fail?
>
pin_user_pages_remote(..., FOLL_LONGTERM, ...) first attemps to allocate 
THP only on local node, and then fall back to remote NUMA nodes if the 
local allocation fail. For detail, see alloc_pages_mpol().

static struct page *alloc_pages_mpol()
{
     page = __alloc_frozen_pages_noprof(__GFP_THISNODE,...); // 1, try 
to allocate THP only on local node

     if (page || !(gpf & __GFP_DIRECT_RECLAIM))
         return page;

     page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);//2, 
fall back to remote NUMA nodes
}
> The changelog says this is in order to fall back quickly to other
> nodes. But there is a full node walk in get_page_from_freelist()
> before the allocator even engages reclaim. There is something missing
> from the story still.
> 
> But regardless - surely you can see that we can't make the allocator
> generally weaker on large requests just because they happen to be
> optional in your specific case? >First, try to allocate THP on the local node as much as possible, and 
then fall back to a remote node if the local allocation fail. This is 
the default memory allocation strategy when starting virtual machines.

>>> There is the compaction_suitable() check in should_compact_retry(),
>>> but that only applies when COMPACT_SKIPPED. IOW, it should only happen
>>> when compaction_suitable() just now returned false. IOW, a race
>>> condition. Which is why it's also not subject to limited retries.
>>>
>>> What's the exact condition that traps the allocator inside the loop?
>> The should_compact_retry() function was not executed, and the slow here
>> was mainly due to the execution of __alloc_pages_direct_reclaim().
> 
> Ok.


