Return-Path: <stable+bounces-164715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30059B1173B
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 05:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EDD3BEB5D
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A3233D9C;
	Fri, 25 Jul 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vjiXYVt3"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074C4A3E;
	Fri, 25 Jul 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753415572; cv=none; b=OAUI8vseqxS9ubZpyZvPHV6iUeTSbLzqRiHI4D7gPkoh1LNZ8ABhd9vb3512QzWJQ79EulQvL7eXhIrMikczX0AVMuvIhvAQSXtcYpZyJnQfkb0FCHh2czQflfh6KnND9GfDbrwX7ceA9cS9iusQ6dbWv3HKucX4+PtFqcWlCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753415572; c=relaxed/simple;
	bh=EId7FXSGC20+gdUegarRID1CqmebOZMIMHQlLgQo5Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8NHd/PoT9wt0R4w5Yam59P4AhrYEy9lEDwqsif7TxP7Z1QFVfr68qEFVJlEKcHaBAMUc4wEiC33qSSvd2pym99B5ewCEbANwGIbKSIXUUjFX+OytEJwKNm0F2bXP2nEw1TtmVUs+zsSL42GM0L7iscGy2y+VmoeC8coBUHEkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vjiXYVt3; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753415566; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mfu4uFiMvUI8JUko7ejXG7LLjlYmZWWJPSy5UDDoyF8=;
	b=vjiXYVt32uynU9c1BA1DHKKuyesAxhfq0HdWjvo/PBKIG1muundAKi1fs2i1Pkk2v/zKwQASPk3TTx9Npmb5IdsnzVxE6/nfejJCnYuCDHtMDMVMjCSm/eUduBaU7R3Mp/JM7ApYVMyfX4a4drqpf3hYZcYy6Zaue2lDhHivV9c=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjvFo.E_1753415565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 11:52:46 +0800
Message-ID: <437bdc7a-d570-4602-9715-c716a660e762@linux.alibaba.com>
Date: Fri, 25 Jul 2025 11:52:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-2-ryncsn@gmail.com>
 <CAMgjq7A+DBw=z8RPP-P1hcCH4Mid0txfmKqgqXghoE_v7zGEoA@mail.gmail.com>
 <CAMgjq7DfPXS4PkpGK-zem2L1gZD0dekbAyHa-CPHjf=eonoFXg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7DfPXS4PkpGK-zem2L1gZD0dekbAyHa-CPHjf=eonoFXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/25 02:16, Kairui Song wrote:
> On Fri, Jul 25, 2025 at 1:02 AM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> On Thu, Jul 10, 2025 at 11:37 AM Kairui Song <ryncsn@gmail.com> wrote:
>>>
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> The current swap-in code assumes that, when a swap entry in shmem mapping
>>> is order 0, its cached folios (if present) must be order 0 too, which
>>> turns out not always correct.
>>>
>>> The problem is shmem_split_large_entry is called before verifying the
>>> folio will eventually be swapped in, one possible race is:
>>>
>>>      CPU1                          CPU2
>>> shmem_swapin_folio
>>> /* swap in of order > 0 swap entry S1 */
>>>    folio = swap_cache_get_folio
>>>    /* folio = NULL */
>>>    order = xa_get_order
>>>    /* order > 0 */
>>>    folio = shmem_swap_alloc_folio
>>>    /* mTHP alloc failure, folio = NULL */
>>>    <... Interrupted ...>
>>>                                   shmem_swapin_folio
>>>                                   /* S1 is swapped in */
>>>                                   shmem_writeout
>>>                                   /* S1 is swapped out, folio cached */
>>>    shmem_split_large_entry(..., S1)
>>>    /* S1 is split, but the folio covering it has order > 0 now */
>>>
>>> Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
>>> folio lookup will return a folio with order > 0.  The
>>> `xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will always
>>> return false causing swap-in to return -EEXIST.
>>>
>>> And this looks fragile.  So fix this up by allowing seeing a larger folio
>>> in swap cache, and check the whole shmem mapping range covered by the
>>> swapin have the right swap value upon inserting the folio.  And drop the
>>> redundant tree walks before the insertion.
>>>
>>> This will actually improve performance, as it avoids two redundant Xarray
>>> tree walks in the hot path, and the only side effect is that in the
>>> failure path, shmem may redundantly reallocate a few folios causing
>>> temporary slight memory pressure.
>>>
>>> And worth noting, it may seems the order and value check before inserting
>>> might help reducing the lock contention, which is not true.  The swap
>>> cache layer ensures raced swapin will either see a swap cache folio or
>>> failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
>>> bypassed), so holding the folio lock and checking the folio flag is
>>> already good enough for avoiding the lock contention.  The chance that a
>>> folio passes the swap entry value check but the shmem mapping slot has
>>> changed should be very low.
>>>
>>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>   mm/shmem.c | 30 +++++++++++++++++++++---------
>>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> Hi All,
>>
>> Just found some issue here with this patch...
>>
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 334b7b4a61a0..e3c9a1365ff4 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
>>>                                     pgoff_t index, void *expected, gfp_t gfp)
>>>   {
>>>          XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
>>> -       long nr = folio_nr_pages(folio);
>>> +       unsigned long nr = folio_nr_pages(folio);
>>> +       swp_entry_t iter, swap;
>>> +       void *entry;
>>>
>>>          VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
>>>          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *folio,
>>>
>>>          gfp &= GFP_RECLAIM_MASK;
>>>          folio_throttle_swaprate(folio, gfp);
>>> +       swap = iter = radix_to_swp_entry(expected);
>>>
>>>          do {
>>>                  xas_lock_irq(&xas);
>>
>> I missed a xas_reset here, also better reset iter value too.
>>
>>> -               if (expected != xas_find_conflict(&xas)) {
>>> -                       xas_set_err(&xas, -EEXIST);
>>> -                       goto unlock;
>>> +               xas_for_each_conflict(&xas, entry) {
>>> +                       /*
>>> +                        * The range must either be empty, or filled with
>>> +                        * expected swap entries. Shmem swap entries are never
>>> +                        * partially freed without split of both entry and
>>> +                        * folio, so there shouldn't be any holes.
>>> +                        */
>>> +                       if (!expected || entry != swp_to_radix_entry(iter)) {
>>> +                               xas_set_err(&xas, -EEXIST);
>>> +                               goto unlock;
>>> +                       }
>>> +                       iter.val += 1 << xas_get_order(&xas);
>>>                  }
>>> -               if (expected && xas_find_conflict(&xas)) {
>>> +               if (expected && iter.val - nr != swap.val) {
>>>                          xas_set_err(&xas, -EEXIST);
>>>                          goto unlock;
>>>                  }
>>> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>                          error = -ENOMEM;
>>>                          goto failed;
>>>                  }
>>> -       } else if (order != folio_order(folio)) {
>>> +       } else if (order > folio_order(folio)) {
>>>                  /*
>>>                   * Swap readahead may swap in order 0 folios into swapcache
>>>                   * asynchronously, while the shmem mapping can still stores
>>> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>
>>>                          swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>                  }
>>> +       } else if (order < folio_order(folio)) {
>>> +               swap.val = round_down(swap.val, 1 << folio_order(folio));
>>>          }
>>>
>>>   alloced:
>>>          /* We have to do this with folio locked to prevent races */
>>>          folio_lock(folio);
>>>          if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>>> -           folio->swap.val != swap.val ||
>>> -           !shmem_confirm_swap(mapping, index, swap) ||
>>> -           xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
>>
>> And this part is incorrect. This `shmem_confirm_swap(mapping, index,
>> swap) ` can't be simply omitted. Some functions below before the
>> shmem_add_to_page_cache shouldn't be called on folios might have
>> already been mapped by others. This shmem_confirm_swap ensures that
>> won't happen.

OK, thanks for the reminding. But could you elaborate a bit? Which 
function should not be called, and what problem might be caused?

>> It may seem like a small change, but it leads to some minor conflicts
>> in one or two following commits, the benchmark result will change too.
>> So I'll have to send a V6 I think.
>>
>> We can remove this `shmem_confirm_swap`, but not in this series I
>> think, maybe after this. Need to re-arrange some functions, with some
>> clean ups for shmem_add_to_page_cache and others.
>>
>>> +           folio->swap.val != swap.val) {
>>>                  error = -EEXIST;
>>>                  goto unlock;
>>>          }
>>> --
>>> 2.50.0
>>>
>>
>> In summary, I'll squash this patch into it and do a rebase of later commits:
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index e3c9a1365ff4..4ca0b665b79e 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -898,9 +898,11 @@ static int shmem_add_to_page_cache(struct folio *folio,
>>
>>          gfp &= GFP_RECLAIM_MASK;
>>          folio_throttle_swaprate(folio, gfp);
>> -       swap = iter = radix_to_swp_entry(expected);
>> +       swap = radix_to_swp_entry(expected);
>>
>>          do {
>> +               iter = swap;
>> +               xas_reset(&xas);
> 
> Correction: this xas_reset is not needed, the iter = swap is needed.

Indeed, my tests do not cover the scenario where xas_nomem() returns true.

>>                  xas_lock_irq(&xas);
>>                  xas_for_each_conflict(&xas, entry) {
>>                          /*
>> @@ -2365,9 +2367,16 @@ static int shmem_swapin_folio(struct inode
>> *inode, pgoff_t index,
>>          }
>>
>>   alloced:
> 
> And it needs `nr_pages = folio_nr_pages(folio); index =
> round_down(index, nr_pages);` here...

IIUC, the index alignment should move into the 'order < 
folio_order(folio)' branch?

>> -       /* We have to do this with folio locked to prevent races */
>> +       /*
>> +        * We have to do this with folio locked to prevent races.
>> +        * The shmem_confirm_swap below only checks if the first swap
>> +        * entry matches the folio, that's enough to ensure the folio
>> +        * is not used outside of shmem, as shmem swap entrie
>> +        * and swap cache folios are never partially freed.
>> +        */
>>          folio_lock(folio);
>>          if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>> +           !shmem_confirm_swap(mapping, index, swap) ||
>>              folio->swap.val != swap.val) {
>>                  error = -EEXIST;
>>                  goto unlock;
>>
>> And I'll do some clean up afterward to get rid of this
>> shmem_confirm_swap. How do you think?


