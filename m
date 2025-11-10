Return-Path: <stable+bounces-192880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2328C44B13
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A65B34E26C3
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC321369B4;
	Mon, 10 Nov 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LM5epqrP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED9184E;
	Mon, 10 Nov 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736463; cv=none; b=Wmpiu6/e7Y8VWvm5COBroKa1tboCohJS8z1DpsrVgtTlruUpVXlLwfZJm8533Pns1PTDqmXW9FSmDJ3dl7d1ssYqZCROMwtg6rcAQBRA293kA90xODiRcAutWc0LugKO7hXGX8HRdsT0U6SL0c5WqDwqh8U5YI6ki7Zi0QsxhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736463; c=relaxed/simple;
	bh=VwoauO8e1RWqPBsp4AaLMfdMlCNd5t3asmKpP++k99s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjJRYRnsh+V4a6GctAzl18DBQ1Wt6HzFMbGoQHih6x6FEH38/pUz03yj904qz7wxsdZ5MnPBdvdYQWnjR7wyWpblrrbtMiHCPhxG6aqC3Xh8PZNObm+yw8bm17gNK12kfsDbJslD2Hs+WV6tn7x6mp1ETy09B62WkIIDqzdhOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LM5epqrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC4AC4CEFB;
	Mon, 10 Nov 2025 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762736463;
	bh=VwoauO8e1RWqPBsp4AaLMfdMlCNd5t3asmKpP++k99s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LM5epqrPKqSFwJ9QHgHMn7I+tCQ+5SVLoilapiShmI9grGgqRph2Xcc3SOwNfA4V3
	 8tgMv7nIrkSxZIKcBtxYXGAFqFN8YAF//oXZce0N1vd78UuqX/MvzhC8WuNiBa/C0Z
	 oXrC3ngim/1C8weOCpqfB0hpG/HQQPFwcBrGFlf4=
Date: Mon, 10 Nov 2025 10:00:59 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Kairui Song <ryncsn@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
Message-ID: <2025111053-saddlebag-maybe-0edc@gregkh>
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>

On Mon, Nov 10, 2025 at 02:06:03AM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
> 
> While reviewing recent leaf entry changes, I noticed that commit
> 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
> correct. It's true that most all callers of __read_swap_cache_async are
> already holding a swap entry reference, so the repeated swap device
> pinning isn't needed on the same swap device, but it is possible that
> VMA readahead (swap_vma_readahead()) may encounter swap entries from a
> different swap device when there are multiple swap devices, and call
> __read_swap_cache_async without holding a reference to that swap device.
> 
> So it is possible to cause a UAF if swapoff of device A raced with
> swapin on device B, and VMA readahead tries to read swap entries from
> device A. It's not easy to trigger but in theory possible to cause real
> issues. And besides, that commit made swap more vulnerable to issues
> like corrupted page tables.
> 
> Just revert it. __read_swap_cache_async isn't that sensitive to
> performance after all, as it's mostly used for SSD/HDD swap devices with
> readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
> 1 entries, but very soon we will have a new helper and routine for
> such devices, so they will never touch this helper or have redundant
> swap device reference overhead.
> 
> Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 14 ++++++--------
>  mm/zswap.c      |  8 +-------
>  2 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3f85a1c4cfd9..0c25675de977 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -406,13 +406,17 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
>  		bool skip_if_exists)
>  {
> -	struct swap_info_struct *si = __swap_entry_to_info(entry);
> +	struct swap_info_struct *si;
>  	struct folio *folio;
>  	struct folio *new_folio = NULL;
>  	struct folio *result = NULL;
>  	void *shadow = NULL;
>  
>  	*new_page_allocated = false;
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return NULL;
> +
>  	for (;;) {
>  		int err;
>  
> @@ -499,6 +503,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	put_swap_folio(new_folio, entry);
>  	folio_unlock(new_folio);
>  put_and_return:
> +	put_swap_device(si);
>  	if (!(*new_page_allocated) && new_folio)
>  		folio_put(new_folio);
>  	return result;
> @@ -518,16 +523,11 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		struct swap_iocb **plug)
>  {
> -	struct swap_info_struct *si;
>  	bool page_allocated;
>  	struct mempolicy *mpol;
>  	pgoff_t ilx;
>  	struct folio *folio;
>  
> -	si = get_swap_device(entry);
> -	if (!si)
> -		return NULL;
> -
>  	mpol = get_vma_policy(vma, addr, 0, &ilx);
>  	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
> @@ -535,8 +535,6 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  
>  	if (page_allocated)
>  		swap_read_folio(folio, plug);
> -
> -	put_swap_device(si);
>  	return folio;
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5d0f8b13a958..aefe71fd160c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1005,18 +1005,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct folio *folio;
>  	struct mempolicy *mpol;
>  	bool folio_was_allocated;
> -	struct swap_info_struct *si;
>  	int ret = 0;
>  
>  	/* try to allocate swap cache folio */
> -	si = get_swap_device(swpentry);
> -	if (!si)
> -		return -EEXIST;
> -
>  	mpol = get_task_policy(current);
>  	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> -			NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
> -	put_swap_device(si);
> +				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
>  	if (!folio)
>  		return -ENOMEM;
>  
> 
> ---
> base-commit: 02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
> change-id: 20251109-revert-78524b05f1a3-04a1295bef8a
> 
> Best regards,
> -- 
> Kairui Song <kasong@tencent.com>
> 
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

