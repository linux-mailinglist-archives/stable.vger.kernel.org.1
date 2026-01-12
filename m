Return-Path: <stable+bounces-208053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E964D112FA
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D424A301F008
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3B31A556;
	Mon, 12 Jan 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lxUnsoz8"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9D31A576;
	Mon, 12 Jan 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206152; cv=none; b=K3MFBMZaprQSAq98nNBcxGnPgDrNRI6R4VOaVvn9cnysg4NWHQ2XbTrmsK7trjF52sEs9hXL1icRX2AE87enjQYo12H7vk7Tw9UBT7NaYL/jdRZbMOvMtb0Ak5amL+Dq6/0sG6OhXq/7zMEj/BhMfPXkzQ2Z+r2lp5uI989p5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206152; c=relaxed/simple;
	bh=KUqF/1fFS2rFaJlGWXLeNlav0oxVLDqNH89BpnAW724=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArY76LZJkE3yZZFlelop9knYNsAmmWjtzxQSbLfKuOlZ6oRQjMcEH0lzgR1TDmBlfjzrTsXDGSprKh4+AmWx4RCf/7YiJp8sCM3Y+VFN2/mim9ipGdd6o6FWbd34oWKRUl5kZFoGAkG/jCI8M2fQ6FB7P/v5JsYtn+bv9OWmHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lxUnsoz8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768206147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ad7R/+eI3g9Xu6IbHx4VEjDEO9JdlcbHLzN6J0fDGaI=;
	b=lxUnsoz857wQ/W1AiHtdaafeK7+wlghNrhHnqm0Qhql5+QoVXtihy0zzre/vlV9myeOoESLp1Q1y2ZFwMzJxXwXhyLirUcdfH9dTnMQEchcD9Sl8WIR5i5Txsrv0xK68oWlZOkp4SyNihgV2fyfjBGrER37s3ooVt+NZABrXQ+Q=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wwr3iRU_1768206145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 16:22:26 +0800
Message-ID: <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com>
Date: Mon, 12 Jan 2026 16:22:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
 <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com>
 <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/12/26 1:56 PM, Kairui Song wrote:
> On Mon, Jan 12, 2026 at 12:00 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>> On 1/12/26 1:53 AM, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> The helper for shmem swap freeing is not handling the order of swap
>>> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
>>> but it gets the entry order before that using xa_get_order
>>> without lock protection. As a result the order could be a stalled value
>>> if the entry is split after the xa_get_order and before the
>>> xa_cmpxchg_irq. In fact that are more way for other races to occur
>>> during the time window.
>>>
>>> To fix that, open code the Xarray cmpxchg and put the order retrivial and
>>> value checking in the same critical section. Also ensure the order won't
>>> exceed the truncate border.
>>>
>>> I observed random swapoff hangs and swap entry leaks when stress
>>> testing ZSWAP with shmem. After applying this patch, the problem is resolved.
>>>
>>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>>    mm/shmem.c | 35 +++++++++++++++++++++++------------
>>>    1 file changed, 23 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 0b4c8c70d017..e160da0cd30f 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>>>     * the number of pages being freed. 0 means entry not found in XArray (0 pages
>>>     * being freed).
>>>     */
>>> -static long shmem_free_swap(struct address_space *mapping,
>>> -                         pgoff_t index, void *radswap)
>>> +static long shmem_free_swap(struct address_space *mapping, pgoff_t index,
>>> +                         unsigned int max_nr, void *radswap)
>>>    {
>>> -     int order = xa_get_order(&mapping->i_pages, index);
>>> -     void *old;
>>> +     XA_STATE(xas, &mapping->i_pages, index);
>>> +     unsigned int nr_pages = 0;
>>> +     void *entry;
>>>
>>> -     old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
>>> -     if (old != radswap)
>>> -             return 0;
>>> -     swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
>>> +     xas_lock_irq(&xas);
>>> +     entry = xas_load(&xas);
>>> +     if (entry == radswap) {
>>> +             nr_pages = 1 << xas_get_order(&xas);
>>> +             if (index == round_down(xas.xa_index, nr_pages) && nr_pages < max_nr)
>>> +                     xas_store(&xas, NULL);
>>> +             else
>>> +                     nr_pages = 0;
>>> +     }
>>> +     xas_unlock_irq(&xas);
>>> +
>>> +     if (nr_pages)
>>> +             swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
>>>
>>> -     return 1 << order;
>>> +     return nr_pages;
>>>    }
>>
>> Thanks for the analysis, and it makes sense to me. Would the following
>> implementation be simpler and also address your issue (we will not
>> release the lock in __xa_cmpxchg() since gfp = 0)?
> 
> Hi Baolin,
> 
>>
>> static long shmem_free_swap(struct address_space *mapping,
>>                               pgoff_t index, void *radswap)
>> {
>>           XA_STATE(xas, &mapping->i_pages, index);
>>           int order;
>>           void *old;
>>
>>           xas_lock_irq(&xas);
>>           order = xas_get_order(&xas);
> 
> Thanks for the suggestion. I did consider implementing it this way,
> but I was worried that the order could grow upwards. For example
> shmem_undo_range is trying to free 0-95 and there is an entry at 64
> with order 5 (64 - 95). Before shmem_free_swap is called, the entry
> was swapped in, then the folio was freed, then an order 6 folio was
> allocated there and swapped out again using the same entry.
> 
> Then here it will free the whole order 6 entry (64 - 127), while
> shmem_undo_range is only supposed to erase (0-96).

Good point. However, this cannot happen during swapoff, because the 
'end' is set to -1 in shmem_evict_inode().

Actually, the real question is how to handle the case where a large swap 
entry happens to cross the 'end' when calling shmem_truncate_range(). If 
the shmem mapping stores a folio, we would split that large folio by 
truncate_inode_partial_folio(). If the shmem mapping stores a large swap 
entry, then as you noted, the truncation range can indeed exceed the 'end'.

But with your change, that large swap entry would not be truncated, and 
I’m not sure whether that might cause other issues. Perhaps the best 
approach is to first split the large swap entry and only truncate the 
swap entries within the 'end' boundary like the 
truncate_inode_partial_folio() does.

Alternatively, this patch could only focus on the race on the order, 
which seems uncontested. As for handling large swap entries that go 
beyond the 'end', should we address that in a follow-up, for example by 
splitting? What do you think?

> That's why I added a max_nr argument to the helper. The GFP == 0 below
> looks not very clean either, that's trivial though.
> 
>>           old = __xa_cmpxchg(xas.xa, index, radswap, NULL, 0);
> 
> Am I overthinking it?


