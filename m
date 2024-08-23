Return-Path: <stable+bounces-69950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58495C790
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20101C24D20
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F5148311;
	Fri, 23 Aug 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="awlyk1I3"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B0142E9D
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400614; cv=none; b=PnsUIl9Kmp3mdCYgDq9WsBIpOVZ8EThWbwaOWidpvdHREG9bt7ToZCz96Hwq7iGYqsblIZJRfb64XsddZpXsMcrlsMxno2nHq3/TtS3vpdb/qYpjj9qpphi7LKWMRHAxFt2mL4gwTJv4GuBjJSOg6y3i1PsMd8FZ82X22RkpnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400614; c=relaxed/simple;
	bh=64IRvIy8S2kxDWhv9Zwr7Mk1kOegeXmyr3QHRXMD8Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D34v7tBnamiy+jdzqVEnobxEflkS2LXeuz7BY5v5E+9fuqM4mjn3IINC9GMLBeokqT1FYJhKW66gXsviSHBomtAQtGw2RL2SwAL87+7HuMuV089+qvo7ZkguYziR3AflZhxpUxPB65bqbr0CFDZendQinzrGYXTeTRWAUuF90f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=awlyk1I3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50e74f28-5165-a45b-c152-1b18f32e61aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724400610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn5wnRQMXm7eArEe25VtPGx5Zc8qNdSU3gOpFjda3wg=;
	b=awlyk1I3N6cP7oTTHLeOQOg2RO5uKBvPfy/elRoHHXEXrJ3oQMVRYY7xC2hj7/c0N8diPE
	xNVhPx3SgwH0ypvV7gGO8id0bj0C/CoYV9qC3f/EFxbKHqz4w+FnQBNMYOzy8SGavcDh+Q
	YLkUwOhbdr4BpR5GUspF5V5P77H/kAo=
Date: Fri, 23 Aug 2024 16:10:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
To: Miaohe Lin <linmiaohe@huawei.com>, Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 stable@vger.kernel.org, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, david@redhat.com
References: <20240822025800.13380-1-hao.ge@linux.dev>
 <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
 <b2f51535-ca38-ac67-03b4-1aa45b2a7429@linux.dev>
 <CAJuCfpHUZBkGtu8CL=5cxNMtJa4iNyJ8gBVu2Ho_WOXCRzzfTA@mail.gmail.com>
 <eb021308-76f4-216f-77e2-1de8ab72b083@linux.dev>
 <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
 <292d1141-4edf-ee60-a145-4ca06600076a@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <292d1141-4edf-ee60-a145-4ca06600076a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Miaohe


On 8/23/24 15:40, Miaohe Lin wrote:
> On 2024/8/23 11:37, Hao Ge wrote:
>> Hi Suren and Miaohe
>>
>>
>> On 8/23/24 09:47, Hao Ge wrote:
>>> Hi Suren and Miaohe
>>>
>>>
>>> Thank you all for taking the time to discuss this issue.
>>>
>>>
>>> On 8/23/24 06:50, Suren Baghdasaryan wrote:
>>>> On Thu, Aug 22, 2024 at 2:46 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>> Hi Miaohe
>>>>>
>>>>>
>>>>> Thank you for taking the time to review this patch.
>>>>>
>>>>>
>>>>> On 8/22/24 16:04, Miaohe Lin wrote:
>>>>>> On 2024/8/22 10:58, Hao Ge wrote:
>>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>>
>>>>>> Thanks for your patch.
>>>>>>
>>>>>>> The PG_hwpoison page will be caught and isolated on the entrance to
>>>>>>> the free buddy page pool. so,when we clear this flag and return it
>>>>>>> to the buddy system,mark codetags for pages as empty.
>>>>>>>
>>>>>> Is below scene cause the problem?
>>>>>>
>>>>>> 1. Pages are allocated. pgalloc_tag_add() will be called when prep_new_page().
>>>>>>
>>>>>> 2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison flag and pgalloc_tag_sub()
>>>>>> will be called when pages are caught and isolated on the entrance to buddy.
>>>> Hi Folks,
>>>> Thanks for reporting this! Could you please describe in more details
>>>> how memory_failure() ends up calling pgalloc_tag_sub()? It's not
>>>> obvious to me which path leads to pgalloc_tag_sub(), so I must be
>>>> missing something.
>>>
>>> OK,Let me describe the scenario I encountered.
>>>
>>> In the Link [1] I mentioned,here is the logic behind it:
>>>
>>> It performed the following operations:
>>>
>>> madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE)
>>>
>>> and then the kernel's call stack looks like this:
>>>
>>> do_madvise
>>>
>>> soft_offline_page
>>>
>>> page_handle_poison
>>>
>>> __folio_put
>>>
>>> free_unref_page
>>>
>> I just reviewed it and I think I missed a stack.
>>
>> Actually, it's like this
>>
>> do_madvise
>>
>> soft_offline_page
>>
>> soft_offline_in_use_page
>>
>> page_handle_poison
>>
>> __folio_put
>>
>> free_unref_page
>>
>>
>> And I've come up with a minimal solution. If everyone agrees, I'll send the patch.look this
>>
>> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/page_alloc.c#L1056
>>
>> Let's directly call clear_page_tag_ref after pgalloc_tag_sub.
> I tend to agree with you. It should be a good practice to call clear_page_tag_ref()
> whenever page_tag finished its work. Do you think below code is also needed?

Actually, this is not necessary,It follows the normal logic of 
allocation and release.

The actual intention of the clear_page_tag_reffunction is to indicate to 
thealloc_tag  that the page is not being returned to the

buddy system through normal allocation.

Just like when the page first enters the buddy system,

https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/mm_init.c#L2464

So, can you help review this patch?

https://lore.kernel.org/all/20240823062002.21165-1-hao.ge@linux.dev/

>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index de54c3567539..707710f03cf5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1104,6 +1104,7 @@ __always_inline bool free_pages_prepare(struct page *page,
>          reset_page_owner(page, order);
>          page_table_check_free(page, order);
>          pgalloc_tag_sub(page, 1 << order);
> +       clear_page_tag_ref(page);
>
>          if (!PageHighMem(page)) {
>                  debug_check_no_locks_freed(page_address(page),
>
> Thanks.
> .

