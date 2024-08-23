Return-Path: <stable+bounces-69945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1195C6B9
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42241285017
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C4B13A41F;
	Fri, 23 Aug 2024 07:40:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5613BBE9;
	Fri, 23 Aug 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398838; cv=none; b=j1igHn+cDikkOaVr8C3IGklHXDypl5qR1pw17chJ4QFFgbq58UiaXToY7nkx40Krt7jZCQ9c4jzLwpPitCJzTZtJO1tEVaHSaZx8UEDs5t/fJHN25aSDazp0oi87SrRLK5kBs4WQP4xxT5+jdW7muo2NPZBYgFDh99vs1ZJNNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398838; c=relaxed/simple;
	bh=UdwupIWDvBzCFihB9mufJiXZ2wkegy+QV/GKQai76Xc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cFoAfT9C5hPsF1y45y+WKb5pmo5wnFm9MqXSg/xVXDXtjxO+0Hzu0B023Ucdnqsw5FjBjFSxo23eYkeMLhT+UFc654evJ7BlrCruJMkssEYqha2ExXlP6mvso1BXH/i9RJVfLuS4AaSYeJNdhqMlNOJjkeQNOpZD+iu5CaDCIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqsQ91B6kzpSwG;
	Fri, 23 Aug 2024 15:38:57 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D7801800D2;
	Fri, 23 Aug 2024 15:40:31 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 15:40:30 +0800
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>
CC: <kent.overstreet@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Hao Ge <gehao@kylinos.cn>,
	<stable@vger.kernel.org>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>, <david@redhat.com>
References: <20240822025800.13380-1-hao.ge@linux.dev>
 <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
 <b2f51535-ca38-ac67-03b4-1aa45b2a7429@linux.dev>
 <CAJuCfpHUZBkGtu8CL=5cxNMtJa4iNyJ8gBVu2Ho_WOXCRzzfTA@mail.gmail.com>
 <eb021308-76f4-216f-77e2-1de8ab72b083@linux.dev>
 <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <292d1141-4edf-ee60-a145-4ca06600076a@huawei.com>
Date: Fri, 23 Aug 2024 15:40:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/8/23 11:37, Hao Ge wrote:
> Hi Suren and Miaohe
> 
> 
> On 8/23/24 09:47, Hao Ge wrote:
>> Hi Suren and Miaohe
>>
>>
>> Thank you all for taking the time to discuss this issue.
>>
>>
>> On 8/23/24 06:50, Suren Baghdasaryan wrote:
>>> On Thu, Aug 22, 2024 at 2:46 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>> Hi Miaohe
>>>>
>>>>
>>>> Thank you for taking the time to review this patch.
>>>>
>>>>
>>>> On 8/22/24 16:04, Miaohe Lin wrote:
>>>>> On 2024/8/22 10:58, Hao Ge wrote:
>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>
>>>>> Thanks for your patch.
>>>>>
>>>>>> The PG_hwpoison page will be caught and isolated on the entrance to
>>>>>> the free buddy page pool. so,when we clear this flag and return it
>>>>>> to the buddy system,mark codetags for pages as empty.
>>>>>>
>>>>> Is below scene cause the problem?
>>>>>
>>>>> 1. Pages are allocated. pgalloc_tag_add() will be called when prep_new_page().
>>>>>
>>>>> 2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison flag and pgalloc_tag_sub()
>>>>> will be called when pages are caught and isolated on the entrance to buddy.
>>> Hi Folks,
>>> Thanks for reporting this! Could you please describe in more details
>>> how memory_failure() ends up calling pgalloc_tag_sub()? It's not
>>> obvious to me which path leads to pgalloc_tag_sub(), so I must be
>>> missing something.
>>
>>
>> OK,Let me describe the scenario I encountered.
>>
>> In the Link [1] I mentioned,here is the logic behind it:
>>
>> It performed the following operations:
>>
>> madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE)
>>
>> and then the kernel's call stack looks like this:
>>
>> do_madvise
>>
>> soft_offline_page
>>
>> page_handle_poison
>>
>> __folio_put
>>
>> free_unref_page
>>
> 
> I just reviewed it and I think I missed a stack.
> 
> Actually, it's like this
> 
> do_madvise
> 
> soft_offline_page
> 
> soft_offline_in_use_page
> 
> page_handle_poison
> 
> __folio_put
> 
> free_unref_page
> 
> 
> And I've come up with a minimal solution. If everyone agrees, I'll send the patch.look this
> 
> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/page_alloc.c#L1056
> 
> Let's directly call clear_page_tag_ref after pgalloc_tag_sub.

I tend to agree with you. It should be a good practice to call clear_page_tag_ref()
whenever page_tag finished its work. Do you think below code is also needed?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index de54c3567539..707710f03cf5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1104,6 +1104,7 @@ __always_inline bool free_pages_prepare(struct page *page,
        reset_page_owner(page, order);
        page_table_check_free(page, order);
        pgalloc_tag_sub(page, 1 << order);
+       clear_page_tag_ref(page);

        if (!PageHighMem(page)) {
                debug_check_no_locks_freed(page_address(page),

Thanks.
.

