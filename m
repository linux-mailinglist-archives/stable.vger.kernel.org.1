Return-Path: <stable+bounces-69935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B93095C3C6
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 05:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06CC1C222DA
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05272940F;
	Fri, 23 Aug 2024 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZoC87Hz"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097341EF1D
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384235; cv=none; b=AHhOJ93k9zD9e524T7Ru/S/Z4qUcpSMyhoMsYNA2A9dtQxhXbr+vPhf9LgtQkdA2UbkSw5got/0p4Z672424DDDRYofmJE5Cz88BcW6xPypufrp3TG+3TFeZcKHpU+zYFRfDX050YocGwIOeatdfWGb6KYBQ7pgD9IONc7uA5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384235; c=relaxed/simple;
	bh=Z8QEmwIvhhBAtgzzjvQ1Vyn70bF/wzXSmXShbJdc3JE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=apc1GmVkbxoP+WDM8Zh6lCh8oA108c3GbcS2l1F0MugfZfOKAe8USEzGhVL95Iw5XkOFbPB5N7vRggzSWzDX1qyJvTg4E6lcU3OalwBAUPPka5yQJHI7OtN82kTVQbOecvvmbMekqW2WgMoGuqyDzo7gDkX+Y0J3Q6ZEj2D53MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZoC87Hz; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724384230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cY24nOUEo2m206GlJwgB19ZAs8hLikNfAgK8dR8ZU44=;
	b=NZoC87Hz1pLFaHnHL4SbGQcF+e9d+YA3JSgICauOGv4UM+ANdhV6hrDti2FSSQWlFQHHI6
	c5oYcYwk8maD7LYJA5HR5HIDwJvhINjWA+Jd6WOSKCK5UYkz1po8/AKORUJOl7mKDDurI0
	ypYUPtj+ZIRRLA9eRWb5JTkvEgBI0MA=
Date: Fri, 23 Aug 2024 11:37:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: kent.overstreet@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 stable@vger.kernel.org, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, david@redhat.com
References: <20240822025800.13380-1-hao.ge@linux.dev>
 <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
 <b2f51535-ca38-ac67-03b4-1aa45b2a7429@linux.dev>
 <CAJuCfpHUZBkGtu8CL=5cxNMtJa4iNyJ8gBVu2Ho_WOXCRzzfTA@mail.gmail.com>
 <eb021308-76f4-216f-77e2-1de8ab72b083@linux.dev>
In-Reply-To: <eb021308-76f4-216f-77e2-1de8ab72b083@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Suren and Miaohe


On 8/23/24 09:47, Hao Ge wrote:
> Hi Suren and Miaohe
>
>
> Thank you all for taking the time to discuss this issue.
>
>
> On 8/23/24 06:50, Suren Baghdasaryan wrote:
>> On Thu, Aug 22, 2024 at 2:46 AM Hao Ge <hao.ge@linux.dev> wrote:
>>> Hi Miaohe
>>>
>>>
>>> Thank you for taking the time to review this patch.
>>>
>>>
>>> On 8/22/24 16:04, Miaohe Lin wrote:
>>>> On 2024/8/22 10:58, Hao Ge wrote:
>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>
>>>> Thanks for your patch.
>>>>
>>>>> The PG_hwpoison page will be caught and isolated on the entrance to
>>>>> the free buddy page pool. so,when we clear this flag and return it
>>>>> to the buddy system,mark codetags for pages as empty.
>>>>>
>>>> Is below scene cause the problem?
>>>>
>>>> 1. Pages are allocated. pgalloc_tag_add() will be called when 
>>>> prep_new_page().
>>>>
>>>> 2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison flag 
>>>> and pgalloc_tag_sub()
>>>> will be called when pages are caught and isolated on the entrance 
>>>> to buddy.
>> Hi Folks,
>> Thanks for reporting this! Could you please describe in more details
>> how memory_failure() ends up calling pgalloc_tag_sub()? It's not
>> obvious to me which path leads to pgalloc_tag_sub(), so I must be
>> missing something.
>
>
> OK,Let me describe the scenario I encountered.
>
> In the Link [1] I mentioned,here is the logic behind it:
>
> It performed the following operations:
>
> madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE)
>
> and then the kernel's call stack looks like this:
>
> do_madvise
>
> soft_offline_page
>
> page_handle_poison
>
> __folio_put
>
> free_unref_page
>

I just reviewed it and I think I missed a stack.

Actually, it's like this

do_madvise

soft_offline_page

soft_offline_in_use_page

page_handle_poison

__folio_put

free_unref_page


And I've come up with a minimal solution. If everyone agrees, I'll send 
the patch.look this

https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/page_alloc.c#L1056

Let's directly call clear_page_tag_ref after pgalloc_tag_sub.

Thanks

BR

Hao


> It will set a flag within the following function and then release the 
> page.
>
> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/memory-failure.c#L206 
>
>
> and and then,because you set the PG_hwpoison flag, so the page will be 
> caught and isolated on the
>
> entrance to the free buddy page pool. look here:
>
> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/page_alloc.c#L1052
>
> At this very moment, we call pgalloc_tag_sub.
>
> So,when we callunpoison_memoryclear this flag and return the page to 
> the buddy system, the problem arises.
>
>
>> On a conceptual level I want to understand if the page isolated in
>> this manner should be considered freed or not. If it shouldn't be
>> considered free then I think the right fix would be to avoid
>> pgalloc_tag_sub() when this isolation happens.
>> Thanks,
>> Suren.
>
> In my understanding, the purpose of unpoison_memory is to reclaim 
> poisoned pages.
>
> I dug up the patch that introduced this function back then
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/mm/memory-failure.c?id=847ce401df392b0704369fd3f75df614ac1414b4 
>
>
> Therefore, this is reasonable.
>
> Thanks
>
> Best regards
>
> Hao
>
>>
>>>> 3. unpoison_memory cleared flags and sent the pages to buddy. 
>>>> pgalloc_tag_sub() will be
>>>> called again in free_pages_prepare().
>>>>
>>>> So there is a imbalance that pgalloc_tag_add() is called once and 
>>>> pgalloc_tag_sub() is called twice?
>>> As you said, that's exactly the case.
>>>> If so, let's think about more complicated scene:
>>>>
>>>> 1. Same as above.
>>>>
>>>> 2. Pages are hwpoisoned. But memory_failure() fails to handle it. 
>>>> So PG_hwpoison flag is set
>>>> but pgalloc_tag_sub() is not called (pages are not sent to buddy).
>>>>
>>>> 3. unpoison_memory cleared flags and calls clear_page_tag_ref() 
>>>> without calling pgalloc_tag_sub()
>>>> first. Will this cause problem?
>>>>
>>>> Though this should be really rare...
>>>>
>>>> Thanks.
>>>> .
>>> Great, I didn't anticipate this scenario.
>>>
>>> When we call clear_page_tag_ref() without calling pgalloc_tag_sub(),
>>>
>>> It will cause exceptions 
>>> in|tag->counters->bytes|and|tag->counters->calls|.
>>>
>>> We can add a layer of protection to handle it
>>>
>>> The pseudocode is as follows:
>>>
>>> if (mem_alloc_profiling_enabled()) {
>>>           union codetag_ref *ref = get_page_tag_ref(page);
>>>
>>>           if (ref) {
>>>               if( ref->ct != NULL && !is_codetag_empty(ref))
>>>               {
>>>                   tag = ct_to_alloc_tag(ref->ct);
>>>                   this_cpu_sub(tag->counters->bytes, bytes);
>>>                   this_cpu_dec(tag->counters->calls);
>>>               }
>>>               set_codetag_empty(ref);
>>>               put_page_tag_ref(ref);
>>>           }
>>> }
>>>
>>> Hi Suren and Kent
>>>
>>> Do you have any suggestions for this? If it's okay, I'll add comments
>>> and include this pseudocode in|clear_page_tag_ref|.
>>>
>>>>> It was detected by [1] and the following WARN occurred:
>>>>>
>>>>> [  113.930443][ T3282] ------------[ cut here ]------------
>>>>> [  113.931105][ T3282] alloc_tag was not set
>>>>> [  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at 
>>>>> ./include/linux/alloc_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
>>>>> [  113.932866][ T3282] Modules linked in: hwpoison_inject fuse 
>>>>> ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 
>>>>> xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_man4
>>>>> [  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 
>>>>> Kdump: loaded Tainted: G        W 6.11.0-rc4-dirty #18
>>>>> [  113.943003][ T3282] Tainted: [W]=WARN
>>>>> [  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, 
>>>>> BIOS unknown 2/2/2022
>>>>> [  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO 
>>>>> -DIT -SSBS BTYPE=--)
>>>>> [  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
>>>>> [  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
>>>>> [  113.946706][ T3282] sp : ffff800087093a10
>>>>> [  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 
>>>>> x27: ffff80008249f0a0
>>>>> [  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 
>>>>> x24: 0000000000000000
>>>>> [  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 
>>>>> x21: 0000000000000000
>>>>> [  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 
>>>>> x18: ffffffffffffffff
>>>>> [  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 
>>>>> x15: ffff800081746210
>>>>> [  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 
>>>>> x12: 5b5d353031313339
>>>>> [  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d 
>>>>> x9 : 00000000ffffffd0
>>>>> [  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 
>>>>> x6 : c0000000ffff7fff
>>>>> [  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 
>>>>> x3 : 0000000000000001
>>>>> [  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 
>>>>> x0 : 0000000000000000
>>>>> [  113.957962][ T3282] Call trace:
>>>>> [  113.958350][ T3282] pgalloc_tag_sub.part.66+0x154/0x164
>>>>> [  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
>>>>> [  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
>>>>> [  113.960096][ T3282]  __folio_put+0xd4/0x120
>>>>> [  113.960614][ T3282]  folio_put+0x24/0x50
>>>>> [  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
>>>>> [  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
>>>>> [  113.962436][ T3282] simple_attr_write_xsigned.isra.34+0xec/0x1cc
>>>>> [  113.963183][ T3282]  simple_attr_write+0x38/0x48
>>>>> [  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
>>>>> [  113.964330][ T3282]  full_proxy_write+0x68/0x98
>>>>> [  113.964880][ T3282]  vfs_write+0xdc/0x4d0
>>>>> [  113.965372][ T3282]  ksys_write+0x78/0x100
>>>>> [  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
>>>>> [  113.966440][ T3282]  invoke_syscall+0x7c/0x104
>>>>> [  113.966984][ T3282] el0_svc_common.constprop.1+0x88/0x104
>>>>> [  113.967652][ T3282]  do_el0_svc+0x2c/0x38
>>>>> [  113.968893][ T3282]  el0_svc+0x3c/0x1b8
>>>>> [  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
>>>>> [  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
>>>>> [  113.970511][ T3282] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Link [1]: 
>>>>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise11.c
>>>>>
>>>>> Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() 
>>>>> helper function")
>>>>> Cc: stable@vger.kernel.org # v6.10
>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>> ---
>>>>>    mm/memory-failure.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index 7066fc84f351..570388c41532 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -2623,6 +2623,12 @@ int unpoison_memory(unsigned long pfn)
>>>>>
>>>>>               folio_put(folio);
>>>>>               if (TestClearPageHWPoison(p)) {
>>>>> +                    /* the PG_hwpoison page will be caught and 
>>>>> isolated
>>>>> +                     * on the entrance to the free buddy page pool.
>>>>> +                     * so,when we clear this flag and return it 
>>>>> to the buddy system,
>>>>> +                     * clear it's codetag
>>>>> +                     */
>>>>> +                    clear_page_tag_ref(p);
>>>>>                       folio_put(folio);
>>>>>                       ret = 0;
>>>>>               }
>>>>>
>>>>>
>>> Thanks
>>>
>>> BR
>>>
>>> Hao
>>>

