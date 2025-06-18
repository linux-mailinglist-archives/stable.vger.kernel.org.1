Return-Path: <stable+bounces-154619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DBADE0F8
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 04:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0323178404
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1418DB1E;
	Wed, 18 Jun 2025 02:08:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78D2904;
	Wed, 18 Jun 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212522; cv=none; b=ZMYbNv5+JjmlotLBRkOphkEBOjMAux63+KwdfYlIszWhCLADrrADdJM2bJIg3VeszMJcDCIbDiczNklhsC/95oX2AjOnez8dT4IWFh6Cw0BFhjJ7GwYpC24NDnFZiXzBf6gEYXsQ+liXXXjfacloQ5gADFAk7IA8JhwmWw370jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212522; c=relaxed/simple;
	bh=6Nuq4CUXy1YX1/fRM1lVHGrJ7enBv9J1w86HvLuohCo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AKcIvMxUqInyh9B/epCX95tOetfnasvVl001AE9+v+EjompFPk6OdtrXa4Iwh+AjBnalGl7q/CP/ahKIUgTXVrp9SO9+NL1/3q9K0o8GIExg08axpUuqPSnbxzPdYE3EfxOiCOrY9HAx5K+TrP/l4kq9gHDy6YmrwVEqrSv441I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bMRx13k78zKHN99;
	Wed, 18 Jun 2025 10:08:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D93581A12C5;
	Wed, 18 Jun 2025 10:08:35 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP3 (Coremail) with SMTP id _Ch0CgD3ScSUH1JoZwV2Pg--.4725S2;
	Wed, 18 Jun 2025 10:08:35 +0800 (CST)
Subject: Re: [PATCH 1/4] mm/shmem, swap: improve cached mTHP handling and fix
 potential hung
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250617183503.10527-1-ryncsn@gmail.com>
 <20250617183503.10527-2-ryncsn@gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b7ab2c46-793a-7cea-8941-6d77e9f44a8d@huaweicloud.com>
Date: Wed, 18 Jun 2025 10:08:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250617183503.10527-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgD3ScSUH1JoZwV2Pg--.4725S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyDuw43Kw13XFW8CFy7trb_yoW7Xr1fpF
	ZFgwn3JFW8Wr9Fkr17tF40vryru3yIgFW8KF93Gw43A3Z8Xw1jkF18tw12vFyUCr97Ga92
	qF18ZF1q9F1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/18/2025 2:35 AM, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The current swap-in code assumes that, when a swap entry in shmem
> mapping is order 0, its cached folios (if present) must be order 0
> too, which turns out not always correct.
> 
> The problem is shmem_split_large_entry is called before verifying the
> folio will eventually be swapped in, one possible race is:
> 
>     CPU1                          CPU2
> shmem_swapin_folio
> /* swap in of order > 0 swap entry S1 */
>   folio = swap_cache_get_folio
>   /* folio = NULL */
>   order = xa_get_order
>   /* order > 0 */
>   folio = shmem_swap_alloc_folio
>   /* mTHP alloc failure, folio = NULL */
>   <... Interrupted ...>
>                                  shmem_swapin_folio
>                                  /* S1 is swapped in */
>                                  shmem_writeout
>                                  /* S1 is swapped out, folio cached */
>   shmem_split_large_entry(..., S1)
>   /* S1 is split, but the folio covering it has order > 0 now */
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
> 
> Cc: stable@vger.kernel.org
> Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index eda35be2a8d9..4e7ef343a29b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  				   pgoff_t index, void *expected, gfp_t gfp)
>  {
>  	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
> -	long nr = folio_nr_pages(folio);
> +	unsigned long nr = folio_nr_pages(folio);
> +	swp_entry_t iter, swap;
> +	void *entry;
>  
>  	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  
>  	gfp &= GFP_RECLAIM_MASK;
>  	folio_throttle_swaprate(folio, gfp);
> +	swap = iter = radix_to_swp_entry(expected);
>  
>  	do {
>  		xas_lock_irq(&xas);
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
>  		}
> -		if (expected && xas_find_conflict(&xas)) {
> +		if (expected && iter.val - nr != swap.val) {
>  			xas_set_err(&xas, -EEXIST);
>  			goto unlock;
>  		}
> @@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  			error = -ENOMEM;
>  			goto failed;
>  		}
> -	} else if (order != folio_order(folio)) {
> +	} else if (order > folio_order(folio)) {
>  		/*
>  		 * Swap readahead may swap in order 0 folios into swapcache
>  		 * asynchronously, while the shmem mapping can still stores
> @@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  
>  			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>  		}
> +	} else if (order < folio_order(folio)) {
> +		swap.val = round_down(swp_type(swap), folio_order(folio));
>  	}
>  
>  alloced:
>  	/* We have to do this with folio locked to prevent races */
>  	folio_lock(folio);
>  	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
> -	    folio->swap.val != swap.val ||
> -	    !shmem_confirm_swap(mapping, index, swap) ||
> -	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
> +	    folio->swap.val != swap.val) {
>  		error = -EEXIST;
>  		goto unlock;
>  	}
> 
Nice catch!
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>


