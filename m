Return-Path: <stable+bounces-158862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F949AED2FE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 05:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C327188C67F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE91885A5;
	Mon, 30 Jun 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SiabUvLc"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77779D2;
	Mon, 30 Jun 2025 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255095; cv=none; b=ncXsBF/ltw1KWq8TypgWPz6Jp1VFFxM8cvFKKZy6GsXHYdfDMRNEM41PdoC1d6Lf4B7Ljrm4ddDabxPidbaQnZBlthxcifdlEebK5poN7HMuu6u7ScP9I1H6MBG98I+p7qQraqKdRdtvN7Y6roMGq/L6nPXe8up3TwHNPGNxbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255095; c=relaxed/simple;
	bh=88ulF0REYyPDR0/UxS+GxEO4n2Ih2fT7fzGanLXy7Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqJGe+OOxUhh7MQZNlK7dkMdSeMuVhK36wrvGPIeSedpFNpprbF/wknlCwRbnC+G1buC9eThMk79VSAERbucPspOUnDhT68FAan2NFfG2fMvlcc7gAtT4cJd6pQ5SCIMPoImSGcmZ8o67zz2rNdI1A981WXv2xHg6XO0hLIA23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SiabUvLc; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751255089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QsTpXV2V1rV0+Oa1zr7kOXHhIJsc5m47BLpH4PEFQbM=;
	b=SiabUvLc6+71VW+iMWKxuHC942qBYUdFLfoOkTLBtCpHgE5HgkEhoGVF5n3j+np2uV2jfvefis2RgCymkIhGfu+BqGms2tDa29VyaUmrYQtylVoeOO0CLvt8HxjIVZ68F+jCySROM2/GaHg5ziQh607U3STpBzpgo5TJSGA9HCA=
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wg3VK0b_1751255087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 11:44:47 +0800
Message-ID: <4cbd6804-deff-4541-8c37-1ee4ba1a3845@linux.alibaba.com>
Date: Mon, 30 Jun 2025 11:44:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mm/shmem, swap: improve cached mTHP handling and
 fix potential hung
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250627062020.534-1-ryncsn@gmail.com>
 <20250627062020.534-2-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250627062020.534-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/27 14:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The current swap-in code assumes that, when a swap entry in shmem mapping
> is order 0, its cached folios (if present) must be order 0 too, which
> turns out not always correct.
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
> Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
> folio lookup will return a folio with order > 0.  The
> `xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will always
> return false causing swap-in to return -EEXIST.
> 
> And this looks fragile.  So fix this up by allowing seeing a larger folio
> in swap cache, and check the whole shmem mapping range covered by the
> swapin have the right swap value upon inserting the folio.  And drop the
> redundant tree walks before the insertion.
> 
> This will actually improve performance, as it avoids two redundant Xarray
> tree walks in the hot path, and the only side effect is that in the
> failure path, shmem may redundantly reallocate a few folios causing
> temporary slight memory pressure.
> 
> And worth noting, it may seems the order and value check before inserting
> might help reducing the lock contention, which is not true.  The swap
> cache layer ensures raced swapin will either see a swap cache folio or
> failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
> bypassed), so holding the folio lock and checking the folio flag is
> already good enough for avoiding the lock contention.  The chance that a
> folio passes the swap entry value check but the shmem mapping slot has
> changed should be very low.
> 
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: <stable@vger.kernel.org>

Thanks for fixing the issue.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 334b7b4a61a0..e3c9a1365ff4 100644
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
> +		swap.val = round_down(swap.val, 1 << folio_order(folio));
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


