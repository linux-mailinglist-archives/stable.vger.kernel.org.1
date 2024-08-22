Return-Path: <stable+bounces-69874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2195B243
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BC21F24715
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795A17C220;
	Thu, 22 Aug 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZnmCjvha"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8B13AF2
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319971; cv=none; b=QdR5LZYkusPqPx5uA7w7HP5eSjYHfreM+6KWmeXfTo8sWK8IkwDpZfoTF0g0VOYiJFW5lmlZAMN6VjVZIkyA/x4S56LED9H395OFNhR8k97zg8Tx3gtiaF4SGD0mYHRdxCnyZs0zqV3JeCrYlHVfXNeqjO52DuIqqa3Sw24RnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319971; c=relaxed/simple;
	bh=nMM5xc87HjLe57Hpiot1MTxh121OV1wiV02Mms8rhng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRR4eP/TpOWFT8p0o5JBuMw6KgN9jEk/0GsmwVNvfrXKKsU7E27l6TtQ/j1Xp8S2LK99vZ38ktrMYC9rIXNZDyPtpktZusLxKjm61vGMmOP1dRu5bDnVKl2e2ShjMTDmBDeRhvnZCz3iKorKH9g9sifhVS53JfMAQp/QDsvWvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZnmCjvha; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2f51535-ca38-ac67-03b4-1aa45b2a7429@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724319965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpLoHGwQLK8WQXV+c9zw5UdCABNMrKwbUQvPoiXDGGI=;
	b=ZnmCjvhaKsFk3ZN13JjRJLCgg0qX5lN0bs07e3X85nnPxEeM++zMfsEIHJu8iXteKEe1jG
	gFmQ+dPpCtMyuWuUA4D7h7Qhu5W+/GFhU2FNenvWhEPx/YkhUtP/FmZuAqX7MKCj0tlrN2
	XoUn5two9gmQVZ/ns2jn5Ee+X7OsyNE=
Date: Thu, 22 Aug 2024 17:45:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
To: Miaohe Lin <linmiaohe@huawei.com>, surenb@google.com,
 kent.overstreet@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>, stable@vger.kernel.org, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, david@redhat.com
References: <20240822025800.13380-1-hao.ge@linux.dev>
 <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Miaohe


Thank you for taking the time to review this patch.


On 8/22/24 16:04, Miaohe Lin wrote:
> On 2024/8/22 10:58, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
> Thanks for your patch.
>
>> The PG_hwpoison page will be caught and isolated on the entrance to
>> the free buddy page pool. so,when we clear this flag and return it
>> to the buddy system,mark codetags for pages as empty.
>>
> Is below scene cause the problem?
>
> 1. Pages are allocated. pgalloc_tag_add() will be called when prep_new_page().
>
> 2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison flag and pgalloc_tag_sub()
> will be called when pages are caught and isolated on the entrance to buddy.
>
> 3. unpoison_memory cleared flags and sent the pages to buddy. pgalloc_tag_sub() will be
> called again in free_pages_prepare().
>
> So there is a imbalance that pgalloc_tag_add() is called once and pgalloc_tag_sub() is called twice?
As you said, that's exactly the case.
>
> If so, let's think about more complicated scene:
>
> 1. Same as above.
>
> 2. Pages are hwpoisoned. But memory_failure() fails to handle it. So PG_hwpoison flag is set
> but pgalloc_tag_sub() is not called (pages are not sent to buddy).
>
> 3. unpoison_memory cleared flags and calls clear_page_tag_ref() without calling pgalloc_tag_sub()
> first. Will this cause problem?
>
> Though this should be really rare...
>
> Thanks.
> .

Great, I didn't anticipate this scenario.

When we call clear_page_tag_ref() without calling pgalloc_tag_sub(),

It will cause exceptions in|tag->counters->bytes|and|tag->counters->calls|.

We can add a layer of protection to handle it

The pseudocode is as follows:

if (mem_alloc_profiling_enabled()) {
         union codetag_ref *ref = get_page_tag_ref(page);

         if (ref) {
             if( ref->ct != NULL && !is_codetag_empty(ref))
             {
                 tag = ct_to_alloc_tag(ref->ct);
                 this_cpu_sub(tag->counters->bytes, bytes);
                 this_cpu_dec(tag->counters->calls);
             }
             set_codetag_empty(ref);
             put_page_tag_ref(ref);
         }
}

Hi Suren and Kent

Do you have any suggestions for this? If it's okay, I'll add comments 
and include this pseudocode in|clear_page_tag_ref|.

>> It was detected by [1] and the following WARN occurred:
>>
>> [  113.930443][ T3282] ------------[ cut here ]------------
>> [  113.931105][ T3282] alloc_tag was not set
>> [  113.931576][ T3282] WARNING: CPU: 2 PID: 3282 at ./include/linux/alloc_tag.h:130 pgalloc_tag_sub.part.66+0x154/0x164
>> [  113.932866][ T3282] Modules linked in: hwpoison_inject fuse ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_man4
>> [  113.941638][ T3282] CPU: 2 UID: 0 PID: 3282 Comm: madvise11 Kdump: loaded Tainted: G        W          6.11.0-rc4-dirty #18
>> [  113.943003][ T3282] Tainted: [W]=WARN
>> [  113.943453][ T3282] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>> [  113.944378][ T3282] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  113.945319][ T3282] pc : pgalloc_tag_sub.part.66+0x154/0x164
>> [  113.946016][ T3282] lr : pgalloc_tag_sub.part.66+0x154/0x164
>> [  113.946706][ T3282] sp : ffff800087093a10
>> [  113.947197][ T3282] x29: ffff800087093a10 x28: ffff0000d7a9d400 x27: ffff80008249f0a0
>> [  113.948165][ T3282] x26: 0000000000000000 x25: ffff80008249f2b0 x24: 0000000000000000
>> [  113.949134][ T3282] x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000000
>> [  113.950597][ T3282] x20: ffff0000c08fcad8 x19: ffff80008251e000 x18: ffffffffffffffff
>> [  113.952207][ T3282] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081746210
>> [  113.953161][ T3282] x14: 0000000000000000 x13: 205d323832335420 x12: 5b5d353031313339
>> [  113.954120][ T3282] x11: ffff800087093500 x10: 000000000000005d x9 : 00000000ffffffd0
>> [  113.955078][ T3282] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008236ba90 x6 : c0000000ffff7fff
>> [  113.956036][ T3282] x5 : ffff000b34bf4dc8 x4 : ffff8000820aba90 x3 : 0000000000000001
>> [  113.956994][ T3282] x2 : ffff800ab320f000 x1 : 841d1e35ac932e00 x0 : 0000000000000000
>> [  113.957962][ T3282] Call trace:
>> [  113.958350][ T3282]  pgalloc_tag_sub.part.66+0x154/0x164
>> [  113.959000][ T3282]  pgalloc_tag_sub+0x14/0x1c
>> [  113.959539][ T3282]  free_unref_page+0xf4/0x4b8
>> [  113.960096][ T3282]  __folio_put+0xd4/0x120
>> [  113.960614][ T3282]  folio_put+0x24/0x50
>> [  113.961103][ T3282]  unpoison_memory+0x4f0/0x5b0
>> [  113.961678][ T3282]  hwpoison_unpoison+0x30/0x48 [hwpoison_inject]
>> [  113.962436][ T3282]  simple_attr_write_xsigned.isra.34+0xec/0x1cc
>> [  113.963183][ T3282]  simple_attr_write+0x38/0x48
>> [  113.963750][ T3282]  debugfs_attr_write+0x54/0x80
>> [  113.964330][ T3282]  full_proxy_write+0x68/0x98
>> [  113.964880][ T3282]  vfs_write+0xdc/0x4d0
>> [  113.965372][ T3282]  ksys_write+0x78/0x100
>> [  113.965875][ T3282]  __arm64_sys_write+0x24/0x30
>> [  113.966440][ T3282]  invoke_syscall+0x7c/0x104
>> [  113.966984][ T3282]  el0_svc_common.constprop.1+0x88/0x104
>> [  113.967652][ T3282]  do_el0_svc+0x2c/0x38
>> [  113.968893][ T3282]  el0_svc+0x3c/0x1b8
>> [  113.969379][ T3282]  el0t_64_sync_handler+0x98/0xbc
>> [  113.969980][ T3282]  el0t_64_sync+0x19c/0x1a0
>> [  113.970511][ T3282] ---[ end trace 0000000000000000 ]---
>>
>> Link [1]: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise11.c
>>
>> Fixes: a8fc28dad6d5 ("alloc_tag: introduce clear_page_tag_ref() helper function")
>> Cc: stable@vger.kernel.org # v6.10
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   mm/memory-failure.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7066fc84f351..570388c41532 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2623,6 +2623,12 @@ int unpoison_memory(unsigned long pfn)
>>   
>>   		folio_put(folio);
>>   		if (TestClearPageHWPoison(p)) {
>> +			/* the PG_hwpoison page will be caught and isolated
>> +			 * on the entrance to the free buddy page pool.
>> +			 * so,when we clear this flag and return it to the buddy system,
>> +			 * clear it's codetag
>> +			 */
>> +			clear_page_tag_ref(p);
>>   			folio_put(folio);
>>   			ret = 0;
>>   		}
>>
>>
Thanks

BR

Hao


