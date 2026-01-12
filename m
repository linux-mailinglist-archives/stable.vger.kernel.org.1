Return-Path: <stable+bounces-208033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C0DD10842
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 05:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44938302F80D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73546220F2A;
	Mon, 12 Jan 2026 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FG1lJlsL"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16ED2F851;
	Mon, 12 Jan 2026 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768190451; cv=none; b=J8Z8QKyzN+BU9qJEaf1n6jN748yw4nhFu5kQBeSEcY7bBBO0TGc4z6gLC73TM/2BTTIeBu4VmXYjr6KGSVZws9N09B2oKKsGAU/anSeohDkGMeMqmBRpWIJc85tB+TaumU12TiVDrWnuIvADqqNsdoyef9seALvgjwYpjiuit7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768190451; c=relaxed/simple;
	bh=5FFhQfOXzki3w2cuqv6KPukjJVXjbuDo9pR1apssd/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUHKEjYKpLaY6q0xZdBd1CoFCbvw3mcEqRNlYg+sqPKaP2KTL12+5RIpDtfSLfhUw2zht0OLGqFHlC/oIO+1yCebxusU9EDN5+C5huCzMScu1mzDhGum3KFedwXxP5waQWWpPk/JfBXIFi3fnwsRlk3c6qO8B9hy00znErj+wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FG1lJlsL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768190446; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PSR7XYx/rEma8e/4ZvAG4dQm3PShN52sV984ltlUVPQ=;
	b=FG1lJlsLREj8rGByupgYa8sohwGk2yDoQwkFACBBVNvVWg+pr5hwQdD0yE5X20l5CQ2ToxnNgYq8RgBjkzyZ5zUPUffO6+gqC5kkKuljJBqnf/ECsmrY7Cgi+ik3qiS6Sw5lkORqvRbSDpyZ3gMfih9ctludg1wJPO5n4kWu93A=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WwnsRvH_1768190445 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 12:00:45 +0800
Message-ID: <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com>
Date: Mon, 12 Jan 2026 12:00:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/26 1:53 AM, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The helper for shmem swap freeing is not handling the order of swap
> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
> but it gets the entry order before that using xa_get_order
> without lock protection. As a result the order could be a stalled value
> if the entry is split after the xa_get_order and before the
> xa_cmpxchg_irq. In fact that are more way for other races to occur
> during the time window.
> 
> To fix that, open code the Xarray cmpxchg and put the order retrivial and
> value checking in the same critical section. Also ensure the order won't
> exceed the truncate border.
> 
> I observed random swapoff hangs and swap entry leaks when stress
> testing ZSWAP with shmem. After applying this patch, the problem is resolved.
> 
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/shmem.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0b4c8c70d017..e160da0cd30f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>    * the number of pages being freed. 0 means entry not found in XArray (0 pages
>    * being freed).
>    */
> -static long shmem_free_swap(struct address_space *mapping,
> -			    pgoff_t index, void *radswap)
> +static long shmem_free_swap(struct address_space *mapping, pgoff_t index,
> +			    unsigned int max_nr, void *radswap)
>   {
> -	int order = xa_get_order(&mapping->i_pages, index);
> -	void *old;
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	unsigned int nr_pages = 0;
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
> +		if (index == round_down(xas.xa_index, nr_pages) && nr_pages < max_nr)
> +			xas_store(&xas, NULL);
> +		else
> +			nr_pages = 0;
> +	}
> +	xas_unlock_irq(&xas);
> +
> +	if (nr_pages)
> +		swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
>   
> -	return 1 << order;
> +	return nr_pages;
>   }

Thanks for the analysis, and it makes sense to me. Would the following 
implementation be simpler and also address your issue (we will not 
release the lock in __xa_cmpxchg() since gfp = 0)?

static long shmem_free_swap(struct address_space *mapping,
                             pgoff_t index, void *radswap)
{
         XA_STATE(xas, &mapping->i_pages, index);
         int order;
         void *old;

         xas_lock_irq(&xas);
         order = xas_get_order(&xas);
         old = __xa_cmpxchg(xas.xa, index, radswap, NULL, 0);
         if (old != radswap) {
                 xas_unlock_irq(&xas);
                 return 0;
         }
         xas_lock_irq(&xas);

         swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);

         return 1 << order;
}

