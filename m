Return-Path: <stable+bounces-208240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4AAD16F5B
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27043011F8F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47236A00D;
	Tue, 13 Jan 2026 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fo+Lsozi"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57136A012;
	Tue, 13 Jan 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288584; cv=none; b=etL3R9K21eF/G7qAGZVOHlBCnc+pPEmKwxzWUfBu5s/3X8qGxy3/BDWmv+MfvdMcmtJeWpETjufe3dpDzMVqH5rQkTPsOFSfBucPy6AwlHXo3nRCUkI0u+Io11F1v/pV/Pe0B5NwxixVS3n/GdzNikI1ma7g0+7Dwq2dVTSEkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288584; c=relaxed/simple;
	bh=8QK1mur0U7bp5Ludyscyw+7IqDlPs+CWV78WTTwBI5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjxiV/VW4hHKRXj/wk7wTCq29ZW3Dx8ugYDM8xLvQjbmy0UK5uPR+YJ8e68NkKIr9ytUGtogfjInbBidMSvyDYNgRwkxGK1NJKQbLqdtmBTgcRvyeI7sEMrs+SmFoQ4KOc7WH+OoRsmDk5S5Fl073YPw3+y3l3W3KUt4WFLS6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fo+Lsozi; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768288578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IZNhFnQEZUXJnPJHL10ktoc1HOWLSt8s0MJQfSG/HMI=;
	b=fo+LsoziczKM9VaW2r/6pAUNzzeZXeCL+FGm1gdyMOZ05/er32sgx3mkC33RB/hy2ZrLk4lLyFrWaPOMcxsmos365ZI3JCriXyAaNpx1LFgaer/q6TnWW4Dv/6upj/l8Fbb3zegb0Nd2jbppxyNXdxojwA6df0qOTkUOuq0ALxA=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WwzyEDF_1768288577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Jan 2026 15:16:17 +0800
Message-ID: <d95f9ea4-aa47-4d85-9b76-11afd0fb3ee7@linux.alibaba.com>
Date: Tue, 13 Jan 2026 15:16:16 +0800
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
 <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com>
 <CAMgjq7Biq9nB_waZeWW+iJUa9Pj+paSSrke-tmnB=-3uY8k2VA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7Biq9nB_waZeWW+iJUa9Pj+paSSrke-tmnB=-3uY8k2VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kairui,

Sorry for late reply.

On 1/12/26 5:55 PM, Kairui Song wrote:
> On Mon, Jan 12, 2026 at 4:22 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>> On 1/12/26 1:56 PM, Kairui Song wrote:
>>> On Mon, Jan 12, 2026 at 12:00 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>> On 1/12/26 1:53 AM, Kairui Song wrote:
>>>>> From: Kairui Song <kasong@tencent.com>
>>>>>
>>>>> The helper for shmem swap freeing is not handling the order of swap
>>>>> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
>>>>> but it gets the entry order before that using xa_get_order
>>>>> without lock protection. As a result the order could be a stalled value
>>>>> if the entry is split after the xa_get_order and before the
>>>>> xa_cmpxchg_irq. In fact that are more way for other races to occur
>>>>> during the time window.
>>>>>
>>>>> To fix that, open code the Xarray cmpxchg and put the order retrivial and
>>>>> value checking in the same critical section. Also ensure the order won't
>>>>> exceed the truncate border.
>>>>>
>>>>> I observed random swapoff hangs and swap entry leaks when stress
>>>>> testing ZSWAP with shmem. After applying this patch, the problem is resolved.
>>>>>
>>>>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>>>> ---
>>>>>     mm/shmem.c | 35 +++++++++++++++++++++++------------
>>>>>     1 file changed, 23 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>> index 0b4c8c70d017..e160da0cd30f 100644
>>>>> --- a/mm/shmem.c
>>>>> +++ b/mm/shmem.c
>>>>> @@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>>>>>      * the number of pages being freed. 0 means entry not found in XArray (0 pages
>>>>>      * being freed).
>>>>>      */
>>>>> -static long shmem_free_swap(struct address_space *mapping,
>>>>> -                         pgoff_t index, void *radswap)
>>>>> +static long shmem_free_swap(struct address_space *mapping, pgoff_t index,
>>>>> +                         unsigned int max_nr, void *radswap)
>>>>>     {
>>>>> -     int order = xa_get_order(&mapping->i_pages, index);
>>>>> -     void *old;
>>>>> +     XA_STATE(xas, &mapping->i_pages, index);
>>>>> +     unsigned int nr_pages = 0;
>>>>> +     void *entry;
>>>>>
>>>>> -     old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
>>>>> -     if (old != radswap)
>>>>> -             return 0;
>>>>> -     swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
>>>>> +     xas_lock_irq(&xas);
>>>>> +     entry = xas_load(&xas);
>>>>> +     if (entry == radswap) {
>>>>> +             nr_pages = 1 << xas_get_order(&xas);
>>>>> +             if (index == round_down(xas.xa_index, nr_pages) && nr_pages < max_nr)
>>>>> +                     xas_store(&xas, NULL);
>>>>> +             else
>>>>> +                     nr_pages = 0;
>>>>> +     }
>>>>> +     xas_unlock_irq(&xas);
>>>>> +
>>>>> +     if (nr_pages)
>>>>> +             swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
>>>>>
>>>>> -     return 1 << order;
>>>>> +     return nr_pages;
>>>>>     }
>>>>
>>>> Thanks for the analysis, and it makes sense to me. Would the following
>>>> implementation be simpler and also address your issue (we will not
>>>> release the lock in __xa_cmpxchg() since gfp = 0)?
>>>
>>> Hi Baolin,
>>>
>>>>
>>>> static long shmem_free_swap(struct address_space *mapping,
>>>>                                pgoff_t index, void *radswap)
>>>> {
>>>>            XA_STATE(xas, &mapping->i_pages, index);
>>>>            int order;
>>>>            void *old;
>>>>
>>>>            xas_lock_irq(&xas);
>>>>            order = xas_get_order(&xas);
>>>
>>> Thanks for the suggestion. I did consider implementing it this way,
>>> but I was worried that the order could grow upwards. For example
>>> shmem_undo_range is trying to free 0-95 and there is an entry at 64
>>> with order 5 (64 - 95). Before shmem_free_swap is called, the entry
>>> was swapped in, then the folio was freed, then an order 6 folio was
>>> allocated there and swapped out again using the same entry.
>>>
>>> Then here it will free the whole order 6 entry (64 - 127), while
>>> shmem_undo_range is only supposed to erase (0-96).
>>
>> Good point. However, this cannot happen during swapoff, because the
>> 'end' is set to -1 in shmem_evict_inode().
> 
> That's not only for swapff, shmem_truncate_range / falloc can also use it right?

Yes, so I just mentioned your swapoff case.

>> Actually, the real question is how to handle the case where a large swap
>> entry happens to cross the 'end' when calling shmem_truncate_range(). If
>> the shmem mapping stores a folio, we would split that large folio by
>> truncate_inode_partial_folio(). If the shmem mapping stores a large swap
>> entry, then as you noted, the truncation range can indeed exceed the 'end'.
>>
>> But with your change, that large swap entry would not be truncated, and
>> I’m not sure whether that might cause other issues. Perhaps the best
>> approach is to first split the large swap entry and only truncate the
>> swap entries within the 'end' boundary like the
>> truncate_inode_partial_folio() does.
> 
> Right... I was thinking that the shmem_undo_range iterates the undo
> range twice IIUC, in the second try it will retry if shmem_free_swap
> returns 0:
> 
> swaps_freed = shmem_free_swap(mapping, indices[i], end - indices[i], folio);
> if (!swaps_freed) {
>      /* Swap was replaced by page: retry */
>      index = indices[i];
>      break;
> }
> 
> So I thought shmem_free_swap returning 0 is good enough. Which is not,
> it may cause the second loop to retry forever.

After further investigation, I think your original fix seems to be the 
right direction, as the second loop’s find_lock_entries() will filter 
out large swap entries crossing the 'end' boundary. Sorry for noise.

See the code in find_lock_entries() (Thanks to Hugh:))

	} else {
		nr = 1 << xas_get_order(&xas);
		base = xas.xa_index & ~(nr - 1);
		/* Omit order>0 value which begins before the start */
		if (base < *start)
			continue;
		/* Omit order>0 value which extends beyond the end */
		if (base + nr - 1 > end)
			break;
	}

Then the shmem_get_partial_folio() will swap-in the large swap entry and 
split the large folio which crosses the 'end' boundary.

So we don't need to split the large swap entry.

As for your original code, can you pass the 'end' to the 
shmem_free_swap() just like the find_lock_entries() does? Something like 
below (untested):

static long shmem_free_swap(struct address_space *mapping,
                             pgoff_t index, pgoff_t end, void *radswap)
{
         XA_STATE(xas, &mapping->i_pages, index);
         unsigned int nr_pages = 0;
         void *entry;

         xas_lock_irq(&xas);
         entry = xas_load(&xas);
         if (entry == radswap) {
                 nr_pages = 1 << xas_get_order(&xas);
                 base = xas.xa_index & ~(nr_pages - 1);
                 if (base < index || base + nr_pages - 1 > end)
                         nr_pages = 0;
                 else
                         xas_store(&xas, NULL);
         }
         xas_unlock_irq(&xas);

         if (nr_pages)
                 swap_put_entries_direct(radix_to_swp_entry(radswap), 
nr_pages);

         return nr_pages;
}

