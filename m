Return-Path: <stable+bounces-155282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BFAE33F8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F9416E4D2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162513D531;
	Mon, 23 Jun 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PC72J30s"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7123774;
	Mon, 23 Jun 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649525; cv=none; b=CfANIKEzfnLTpAtqaic+44bdhOoArK+Aq9fAVn5lzSizYTcOH0dNy4RQhzRa7iNyQRIboU3e/LSDp/chFkXAn4GJHCcZCUGWJjaH0aibrA6hr1j/EZmW+Tie8feivOQEmTR871ET64KR3CFFQyR4xFUA3L3lFy3woVUTHX7jO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649525; c=relaxed/simple;
	bh=ptmrSPw4u/sC94iu8etg+3UM6WuNpNyczzEblTaE4dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APzoNKSjAYNrJGWs74wAU8+xdmCzAX8n1dKggBerUTwbmZS8qulL27cCAZlNRuvVJd+YJHjcJHYV/CjXU1/jLrrho5IJwCzXlcNXRFTx6iRVN7kZ47c3j6ub8ViWqCuW04owve6cL0ZH7k0WwyHHvJUxbx/nkp1k9TfB1FbQ0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PC72J30s; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750649514; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wYHutWc8bo/cobGKcb79yoay4X6hZe8yZdDY2OXxASI=;
	b=PC72J30s/Chi9U2r21tRhw0CJyKfvnQYy3laKGGYLWBnagJ0qymnlQqx/u9TJHCtAt64Q5ENacqtoYlDMyqkjft5opdps0JwPH329R8h+c0Q2NNjdTpauBMk2eYGkG6FQLI7AfyXLVz8yzOkBmGbc+9cW8f5yX3ZUwhjYDk2aZE=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WeSN70M_1750649193 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 11:26:33 +0800
Message-ID: <f90a6072-b75a-40df-a58c-9a98e9ca10ad@linux.alibaba.com>
Date: Mon, 23 Jun 2025 11:26:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250619175538.15799-1-ryncsn@gmail.com>
 <20250619175538.15799-2-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250619175538.15799-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kairui,

On 2025/6/20 01:55, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The current swap-in code assumes that, when a swap entry in shmem
> mapping is order 0, its cached folios (if present) must be order 0
> too, which turns out not always correct.
> 
> The problem is shmem_split_large_entry is called before verifying the
> folio will eventually be swapped in, one possible race is:
> 
>      CPU1                          CPU2
> shmem_swapin_folio
> /* swap in of order > 0 swap entry S1 */
>    folio = swap_cache_get_folio
>    /* folio = NULL */
>    order = xa_get_order
>    /* order > 0 */
>    folio = shmem_swap_alloc_folio
>    /* mTHP alloc failure, folio = NULL */
>    <... Interrupted ...>
>                                   shmem_swapin_folio
>                                   /* S1 is swapped in */
>                                   shmem_writeout
>                                   /* S1 is swapped out, folio cached */
>    shmem_split_large_entry(..., S1)
>    /* S1 is split, but the folio covering it has order > 0 now */
> 
> Now any following swapin of S1 will hang: `xa_get_order` returns 0,
> and folio lookup will return a folio with order > 0. The
> `xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will
> always return false causing swap-in to return -EEXIST.
> 
> And this looks fragile. So fix this up by allowing seeing a larger folio
> in swap cache, and check the whole shmem mapping range covered by the
> swapin have the right swap value upon inserting the folio. And drop
> the redundant tree walks before the insertion.
> 
> This will actually improve the performance, as it avoided two redundant
> Xarray tree walks in the hot path, and the only side effect is that in
> the failure path, shmem may redundantly reallocate a few folios
> causing temporary slight memory pressure.
> 
> And worth noting, it may seems the order and value check before
> inserting might help reducing the lock contention, which is not true.
> The swap cache layer ensures raced swapin will either see a swap cache
> folio or failed to do a swapin (we have SWAP_HAS_CACHE bit even if
> swap cache is bypassed), so holding the folio lock and checking the
> folio flag is already good enough for avoiding the lock contention.
> The chance that a folio passes the swap entry value check but the
> shmem mapping slot has changed should be very low.

Thanks for fixing the issue. Sadly, I haven't reproduced this issue from 
my previous test cases :(

And I have a question below.

> Cc: stable@vger.kernel.org
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/shmem.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index eda35be2a8d9..4e7ef343a29b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
>   				   pgoff_t index, void *expected, gfp_t gfp)
>   {
>   	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
> -	long nr = folio_nr_pages(folio);
> +	unsigned long nr = folio_nr_pages(folio);
> +	swp_entry_t iter, swap;
> +	void *entry;
>   
>   	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *folio,
>   
>   	gfp &= GFP_RECLAIM_MASK;
>   	folio_throttle_swaprate(folio, gfp);
> +	swap = iter = radix_to_swp_entry(expected);
>   
>   	do {
>   		xas_lock_irq(&xas);
> -		if (expected != xas_find_conflict(&xas)) {
> -			xas_set_err(&xas, -EEXIST);
> -			goto unlock;
> +		xas_for_each_conflict(&xas, entry) {
> +			/*
> +			 * The range must either be empty, or filled with
> +			 * expected swap entries. Shmem swap entries are never
> +			 * partially freed without split of both entry and
> +			 * folio, so there shouldn't be any holes.
> +			 */
> +			if (!expected || entry != swp_to_radix_entry(iter)) {
> +				xas_set_err(&xas, -EEXIST);
> +				goto unlock;
> +			}
> +			iter.val += 1 << xas_get_order(&xas);
>   		}
> -		if (expected && xas_find_conflict(&xas)) {
> +		if (expected && iter.val - nr != swap.val) {
>   			xas_set_err(&xas, -EEXIST);
>   			goto unlock;
>   		}
> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   			error = -ENOMEM;
>   			goto failed;
>   		}
> -	} else if (order != folio_order(folio)) {
> +	} else if (order > folio_order(folio)) {
>   		/*
>   		 * Swap readahead may swap in order 0 folios into swapcache
>   		 * asynchronously, while the shmem mapping can still stores
> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   
>   			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>   		}
> +	} else if (order < folio_order(folio)) {
> +		swap.val = round_down(swp_type(swap), folio_order(folio));

Why rounding down the swap type? do you mean rounding down the swap offset?

>   	}
>   
>   alloced:
>   	/* We have to do this with folio locked to prevent races */
>   	folio_lock(folio);
>   	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> -	    folio->swap.val != swap.val ||
> -	    !shmem_confirm_swap(mapping, index, swap) ||
> -	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
> +	    folio->swap.val != swap.val) {
>   		error = -EEXIST;
>   		goto unlock;
>   	}


