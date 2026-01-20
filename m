Return-Path: <stable+bounces-210419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C77D3BCC9
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 02:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185483024E67
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB71A23AC;
	Tue, 20 Jan 2026 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="td2NTkX9"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB34149C6F;
	Tue, 20 Jan 2026 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871803; cv=none; b=Z4KRFoEf9pZVpQjqy9sXRlJH9gSKwYgCEPp3k3tBMquSd8NzLpfGWxR45WPgaHnZzLARoBJ2CCCkdj57UOnI2inxHS29aqnI2foYVz20JYBpYxt5wkMRpPzZ0v/SdRpca7jinVzCrvo6Ce6ZXYgkzMv7uN0V12XyW+hzWYWv5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871803; c=relaxed/simple;
	bh=G6h8YKg7ZR0FFVrxS7k1IXOcLEX+Wq2nIhK8Vo4b4gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ch0zUIh3YW6rKE/IeNwz2eWYcqKLXseDW/FtvtOhLt2UWubA6k6HQFJPhydclB3iCN2/7yqt94RdPh95uB4aWUKwT+tAbNHzuWT07ymJWYkA/mSaSxddet59Pi3agEP95YmOHJCGIeEcpFPSurmZLWWH+LumpDJWZYU7cdKmDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=td2NTkX9; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768871792; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tOHQsrEmVvikkCnWyd025/g3MvKnBrG2ukxJxETFEIM=;
	b=td2NTkX9ZgTpk9wbWlIwbeC9Cs+bJxKytE7YTnA4EZi8ouRBmCWcId3RVNdxNKF5K0WoSvh0/fwFH+cU2LZr2CVi4FqwzgnWxbhyrgzTpzeYBkuFLGMarh2K2/sKLLAEbKUbXVlfjBxorGxuP+9L+QEZFirGXQPczbXJikTgFaE=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WxSDocC_1768871791 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 09:16:32 +0800
Message-ID: <9961743c-6d5f-4a62-9220-50869ac9a2d5@linux.alibaba.com>
Date: Tue, 20 Jan 2026 09:16:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry
 split
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/20/26 12:11 AM, Kairui Song wrote:
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

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes in v3:
> - Rebased on top of mainline.
> - Fix nr_pages calculation [ Baolin Wang ]
> - Link to v2: https://lore.kernel.org/r/20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com
> 
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
> index ec6c01378e9d..6c3485d24d66 100644
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
> -	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
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
> +		free_swap_and_cache_nr(radix_to_swp_entry(radswap), nr_pages);
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
> +					if (order > 0 && indices[i] + (1 << order) > end)
> +						continue;
>   					/* Swap was replaced by page: retry */
>   					index = indices[i];
>   					break;
> 
> ---
> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> change-id: 20260111-shmem-swap-fix-8d0e20a14b5d
> 
> Best regards,


