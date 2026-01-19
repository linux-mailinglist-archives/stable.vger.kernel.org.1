Return-Path: <stable+bounces-210251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE95D39CAC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 04:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D143007EDD
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363321E3DDE;
	Mon, 19 Jan 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LQz5WSIz"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EA1FC7;
	Mon, 19 Jan 2026 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791852; cv=none; b=U4bKdq0Q3xdf4G7GDg9c2lyFeIWN+YCO7zHH/CbFqq1bsmScGYMIk1+7+rt8UF8r8T2mmF5qRWTGfWuWERH65ZBUpI+WbPlrTkp0swosioYZIK+EPK1AmTMBAyfNJ4+b+s/Fiq0IjI6HRcITc8Bs+QLDeNo2VqleO06A1CInamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791852; c=relaxed/simple;
	bh=9APQOLRPdTSsLQbmoO5e0agg9Nd/3Ica+fM6BVLbddM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkTzZxZM2CZutGvbc4nQXtOKsA8r8obRgsCGuZtO7lk2G9qszftd3Zxncqles9P4Pd9n+v1Mqc1AXS093SLr9zle3gfsotySEwuhrlwWRSQZvd+hAUMOBxn5HkIm4HPQLYD+a6Dk4+A+tWvZ6c45SSnNE6bYDSUC6VYI9K4iQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LQz5WSIz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768791844; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n0eI/5dwYg2GHXyg1BMxV5hVYdSwwVqxTeMdN4bZK0Q=;
	b=LQz5WSIzRY1EfiFC1oEk+fCoO/GInACCxlZ47lUn147z5nCoPIAcd11suiQt5pp29dC0ILB/s0X061RwpomHkhrqIXu0UvdQlvj15o957xMslbrXlI7m1F41KGkyqZpjCU1MmJYp+uU2KebvJYvCEb6yJuM7ZGjk8iZ+GM+v9jo=
Received: from 30.74.144.151(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WxHY2Rb_1768791843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 11:04:03 +0800
Message-ID: <74fd3fd1-97d0-46a3-b76e-435808efff02@linux.alibaba.com>
Date: Mon, 19 Jan 2026 11:04:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry
 split
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/19/26 12:55 AM, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The helper for shmem swap freeing is not handling the order of swap
> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry, but
> it gets the entry order before that using xa_get_order without lock
> protection, and it may get an outdated order value if the entry is split
> or changed in other ways after the xa_get_order and before the
> xa_cmpxchg_irq.
> 
> And besides, the order could grow and be larger than expected, and cause
> truncation to erase data beyond the end border. For example, if the
> target entry and following entries are swapped in or freed, then a large
> folio was added in place and swapped out, using the same entry, the
> xa_cmpxchg_irq will still succeed, it's very unlikely to happen though.
> 
> To fix that, open code the Xarray cmpxchg and put the order retrieval
> and value checking in the same critical section. Also, ensure the order
> won't exceed the end border, skip it if the entry goes across the
> border.
> 
> Skipping large swap entries crosses the end border is safe here.
> Shmem truncate iterates the range twice, in the first iteration,
> find_lock_entries already filtered such entries, and shmem will
> swapin the entries that cross the end border and partially truncate the
> folio (split the folio or at least zero part of it). So in the second
> loop here, if we see a swap entry that crosses the end order, it must
> at least have its content erased already.
> 
> I observed random swapoff hangs and kernel panics when stress testing
> ZSWAP with shmem. After applying this patch, all problems are gone.
> 
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Changes in v2:
> - Fix a potential retry loop issue and improvement to code style thanks
>    to Baoling Wang. I didn't split the change into two patches because a
>    separate patch doesn't stand well as a fix.
> - Link to v1: https://lore.kernel.org/r/20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com
> ---
>   mm/shmem.c | 45 ++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0b4c8c70d017..fadd5dd33d8b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -962,17 +962,29 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>    * being freed).
>    */
>   static long shmem_free_swap(struct address_space *mapping,
> -			    pgoff_t index, void *radswap)
> +			    pgoff_t index, pgoff_t end, void *radswap)
>   {
> -	int order = xa_get_order(&mapping->i_pages, index);
> -	void *old;
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	unsigned int nr_pages = 0;
> +	pgoff_t base;
> +	void *entry;
>   
> -	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
> -	if (old != radswap)
> -		return 0;
> -	swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
> +	xas_lock_irq(&xas);
> +	entry = xas_load(&xas);
> +	if (entry == radswap) {
> +		nr_pages = 1 << xas_get_order(&xas);
> +		base = round_down(xas.xa_index, nr_pages);
> +		if (base < index || base + nr_pages - 1 > end)
> +			nr_pages = 0;
> +		else
> +			xas_store(&xas, NULL);
> +	}
> +	xas_unlock_irq(&xas);
> +
> +	if (nr_pages)
> +		swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
>   
> -	return 1 << order;
> +	return nr_pages;
>   }
>   
>   /*
> @@ -1124,8 +1136,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>   			if (xa_is_value(folio)) {
>   				if (unfalloc)
>   					continue;
> -				nr_swaps_freed += shmem_free_swap(mapping,
> -							indices[i], folio);
> +				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
> +								  end - 1, folio);
>   				continue;
>   			}
>   
> @@ -1191,12 +1203,23 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>   			folio = fbatch.folios[i];
>   
>   			if (xa_is_value(folio)) {
> +				int order;
>   				long swaps_freed;
>   
>   				if (unfalloc)
>   					continue;
> -				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
> +				swaps_freed = shmem_free_swap(mapping, indices[i],
> +							      end - 1, folio);
>   				if (!swaps_freed) {
> +					/*
> +					 * If found a large swap entry cross the end border,
> +					 * skip it as the truncate_inode_partial_folio above
> +					 * should have at least zerod its content once.
> +					 */
> +					order = shmem_confirm_swap(mapping, indices[i],
> +								   radix_to_swp_entry(folio));
> +					if (order > 0 && indices[i] + order > end)
> +						continue;

The latter check shoud be 'indices[i] + 1 << order > end', right?

