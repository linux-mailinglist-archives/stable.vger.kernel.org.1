Return-Path: <stable+bounces-155285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D31AE3403
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9197E188BBB4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8219C554;
	Mon, 23 Jun 2025 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pGLf6Fwm"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0417736;
	Mon, 23 Jun 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649939; cv=none; b=WLLGGXBunsa+1Vz0Zl6XS4FpVuHBLpgxZUPC7tk3ywA2TbeXXwzbLzZ4LB98+qhH0rBVLusWVwLZbQVqFXjGNAV+nz/55QCVlATtBDvZ3DF22Tb5LD9RHMBGrUlflE3BZ4qXrMYgaDkoUJVtF4TWBT0DBeR/uHmfTJ441BQOx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649939; c=relaxed/simple;
	bh=9p2WIEDgefKFHAnwThfoRIGGduHXCkoQj/Lq9rwVK3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgSkY3cHfKiWTXbVAFoExslUz2lNF9keDrDiOBDZhd87h3k+ZXsvnqgU5bZWOzwhq66xTC0jBmVnnO6+oUb8W7OvF+YekTdgafR9LDDJelSzs7JpJrQqgVkt17+OX2gYLt0x06B6urtu6goGgWTrSMtqsGUgT4FJVLTUJloCiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pGLf6Fwm; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750649934; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5FYQj48wsEqvtrDOtYtJF6xNw63teRydsL/cwkD20bY=;
	b=pGLf6Fwmb/D1shpYjq9kU23lTCHzziROr2ctOtqzE982miCXUzdtC3/hUO4xcd4C/1bckteeIsYDE0ijYkE11exrNIf44f/CvJQ8nIlIksbcEg0g21T4ghes7LYdt9rk3gEsQ7gWMpJbzPvTi3BJvs+KICE04bHHT5rPkxnhOQY=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WeSNDHE_1750649933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 11:38:54 +0800
Message-ID: <9e31bbb8-73e7-4e67-973d-491f93ba938f@linux.alibaba.com>
Date: Mon, 23 Jun 2025 11:38:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250619175538.15799-1-ryncsn@gmail.com>
 <20250619175538.15799-2-ryncsn@gmail.com>
 <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com>
 <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7B4RSDYAJ5aGijqq9cAzC8Jd8TF6gu-gpKjO5=E9a-RbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/23 11:35, Kairui Song wrote:
> On Mon, Jun 23, 2025 at 11:26 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Hi Kairui,
>>
>> On 2025/6/20 01:55, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> The current swap-in code assumes that, when a swap entry in shmem
>>> mapping is order 0, its cached folios (if present) must be order 0
>>> too, which turns out not always correct.
>>>
>>> The problem is shmem_split_large_entry is called before verifying the
>>> folio will eventually be swapped in, one possible race is:
>>>
>>>       CPU1                          CPU2
>>> shmem_swapin_folio
>>> /* swap in of order > 0 swap entry S1 */
>>>     folio = swap_cache_get_folio
>>>     /* folio = NULL */
>>>     order = xa_get_order
>>>     /* order > 0 */
>>>     folio = shmem_swap_alloc_folio
>>>     /* mTHP alloc failure, folio = NULL */
>>>     <... Interrupted ...>
>>>                                    shmem_swapin_folio
>>>                                    /* S1 is swapped in */
>>>                                    shmem_writeout
>>>                                    /* S1 is swapped out, folio cached */
>>>     shmem_split_large_entry(..., S1)
>>>     /* S1 is split, but the folio covering it has order > 0 now */
>>>
>>> Now any following swapin of S1 will hang: `xa_get_order` returns 0,
>>> and folio lookup will return a folio with order > 0. The
>>> `xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will
>>> always return false causing swap-in to return -EEXIST.
>>>
>>> And this looks fragile. So fix this up by allowing seeing a larger folio
>>> in swap cache, and check the whole shmem mapping range covered by the
>>> swapin have the right swap value upon inserting the folio. And drop
>>> the redundant tree walks before the insertion.
>>>
>>> This will actually improve the performance, as it avoided two redundant
>>> Xarray tree walks in the hot path, and the only side effect is that in
>>> the failure path, shmem may redundantly reallocate a few folios
>>> causing temporary slight memory pressure.
>>>
>>> And worth noting, it may seems the order and value check before
>>> inserting might help reducing the lock contention, which is not true.
>>> The swap cache layer ensures raced swapin will either see a swap cache
>>> folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
>>> swap cache is bypassed), so holding the folio lock and checking the
>>> folio flag is already good enough for avoiding the lock contention.
>>> The chance that a folio passes the swap entry value check but the
>>> shmem mapping slot has changed should be very low.
>>
>> Thanks for fixing the issue. Sadly, I haven't reproduced this issue from
>> my previous test cases :(
>>
>> And I have a question below.
>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>    mm/shmem.c | 30 +++++++++++++++++++++---------
>>>    1 file changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index eda35be2a8d9..4e7ef343a29b 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
>>>                                   pgoff_t index, void *expected, gfp_t gfp)
>>>    {
>>>        XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
>>> -     long nr = folio_nr_pages(folio);
>>> +     unsigned long nr = folio_nr_pages(folio);
>>> +     swp_entry_t iter, swap;
>>> +     void *entry;
>>>
>>>        VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
>>>        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *folio,
>>>
>>>        gfp &= GFP_RECLAIM_MASK;
>>>        folio_throttle_swaprate(folio, gfp);
>>> +     swap = iter = radix_to_swp_entry(expected);
>>>
>>>        do {
>>>                xas_lock_irq(&xas);
>>> -             if (expected != xas_find_conflict(&xas)) {
>>> -                     xas_set_err(&xas, -EEXIST);
>>> -                     goto unlock;
>>> +             xas_for_each_conflict(&xas, entry) {
>>> +                     /*
>>> +                      * The range must either be empty, or filled with
>>> +                      * expected swap entries. Shmem swap entries are never
>>> +                      * partially freed without split of both entry and
>>> +                      * folio, so there shouldn't be any holes.
>>> +                      */
>>> +                     if (!expected || entry != swp_to_radix_entry(iter)) {
>>> +                             xas_set_err(&xas, -EEXIST);
>>> +                             goto unlock;
>>> +                     }
>>> +                     iter.val += 1 << xas_get_order(&xas);
>>>                }
>>> -             if (expected && xas_find_conflict(&xas)) {
>>> +             if (expected && iter.val - nr != swap.val) {
>>>                        xas_set_err(&xas, -EEXIST);
>>>                        goto unlock;
>>>                }
>>> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>                        error = -ENOMEM;
>>>                        goto failed;
>>>                }
>>> -     } else if (order != folio_order(folio)) {
>>> +     } else if (order > folio_order(folio)) {
>>>                /*
>>>                 * Swap readahead may swap in order 0 folios into swapcache
>>>                 * asynchronously, while the shmem mapping can still stores
>>> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>
>>>                        swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>>                }
>>> +     } else if (order < folio_order(folio)) {
>>> +             swap.val = round_down(swp_type(swap), folio_order(folio));
>>
>> Why rounding down the swap type? do you mean rounding down the swap offset?
> 
> Ouch, right, it should be the value:
> 
> swap.val = round_down(swap.val, folio_order(folio));
> 
> I messed up the code here during a rebase, let me send a V3 then.

Should be

swap.val = round_down(swap.val, 1 << folio_order(folio));

?

