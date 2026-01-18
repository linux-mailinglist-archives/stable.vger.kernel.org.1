Return-Path: <stable+bounces-210240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C2D3996E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471F13009412
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3656267729;
	Sun, 18 Jan 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ROsNx4kS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ECBB67E;
	Sun, 18 Jan 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768764796; cv=none; b=rkFQyh5puvpC9nH9ijfDWJvX3vsnMW0Sbzk9dIs1HfRwHanNeP5TdkWqJ6sGIaTBNieg+vPlOEHjiGRt+EpInSXbM5fswiloJDpGxc1ap9uTynvhmLJKXdNiDC6B+JTjjgO0QjIDAgS7ACYoEfJIhij+7S/BFEKbD6DrVKOXu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768764796; c=relaxed/simple;
	bh=Z+Jk8atOFmoKOV1bvDP8AmN9aAvWYcDPiNtVQJD27Ww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tTBZ2FbAyCTE2hnYkh1Ctwncv7u5mnMVCp1hH6IpiHfraCNIyM9VK3YqiFD6zxy7sZxdvyapSmJw96s1kkIxmavXVxPr3n3MwlC46YVld0dx7PMiKSZvhd0ltFjmr6G4RH5nCZcZUakcJ9qBChhyHuNPlXeCSmWDL6Jwg+WqS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ROsNx4kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE8C116D0;
	Sun, 18 Jan 2026 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768764796;
	bh=Z+Jk8atOFmoKOV1bvDP8AmN9aAvWYcDPiNtVQJD27Ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROsNx4kSsxCqNztbQEdn66FEa0kaCUSn1IxPqSel8tUGvT8Z+lxvVkNBXaoz8bQta
	 jINJX8BF2Aenca5/8AusZ4SI2CHxG2oKXtsXvrKElCd2ufNCIpy8zwAfpcN4ADMCP4
	 8t3x0GoBbUeix3TT0Jk8pHeBSPf7LBpRg7JAGW1I=
Date: Sun, 18 Jan 2026 11:33:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry
 split
Message-Id: <20260118113315.b102a7728769f05c5aeec57c@linux-foundation.org>
In-Reply-To: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
References: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 00:55:59 +0800 Kairui Song <ryncsn@gmail.com> wrote:

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

September 2024.

Seems about right.  A researcher recently found that kernel bugs take two years
to fix.  https://pebblebed.com/blog/kernel-bugs?ref=itsfoss.com

>
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -962,17 +962,29 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
>   * being freed).
>   */
>  static long shmem_free_swap(struct address_space *mapping,
> -			    pgoff_t index, void *radswap)
> +			    pgoff_t index, pgoff_t end, void *radswap)
>  {
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
>  }
>  

What tree was this prepared against?

Both Linus mainline and mm.git have

: static long shmem_free_swap(struct address_space *mapping,
: 			    pgoff_t index, void *radswap)
: {
: 	int order = xa_get_order(&mapping->i_pages, index);
: 	void *old;
: 
: 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
: 	if (old != radswap)
: 		return 0;
: 	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
: 
: 	return 1 << order;
: }

but that free_swap_and_cache_nr() call is absent from your tree.



