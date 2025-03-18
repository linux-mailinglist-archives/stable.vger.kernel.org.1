Return-Path: <stable+bounces-124827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E851A677C1
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B826B178973
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB420F095;
	Tue, 18 Mar 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHbgQucu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06720E013
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311743; cv=none; b=VVtgGFKPc5fwHtkd/K7F+/nOGoBIs9ZmXqCD8K2nY+uIZ3RmyfyX8ZtmR8fatN9Auccb97yUGS5m7iRhBwcfxKAWt+jdHa4QaVQJZYR0JhWdlSM5ZW1LvOzm8b2cJtsdMffkCi33IWk9EFPakkRDO5okOq/ONXFMgI49p9echFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311743; c=relaxed/simple;
	bh=CI68ark1PHNJ759BZFH4hapfgyvdAbCx9XZ3NN1Et0o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gNtF4qvwOTJlfkRZrSQI/Y/ux4Y80r2kBwxTU/7o2lX8UJYYvE+cuXQYLZg932as7YfYQYUlbMZ1xE9UOwkp4Qz7DKle1A/t7N+R7BNPNwvG923eWMGm3Sc6X/abtdF18C6A8zdcPKk+9yLNGRriveu6TBBtlzcqcsPqG4Nl8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHbgQucu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225a28a511eso99287925ad.1
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742311736; x=1742916536; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck7vxHLxi5/ysl7+5fP8R3Y1ywz2YCzxDOSeWR2KFfs=;
        b=PHbgQucuQuRyjenhEYIktCQZnYfOQZGakCmqpqIuuE4sfDdNX4TG2XbTzNqT3JNbvT
         M6Vvyr6d/+yxRGHmvjuhFWq43iscEWqVgarNgiX9yOgnIDHfoSzwPGl2ZPJzKQN4ZTd/
         fFqh+ESrO3T0cg8Pgc7snJkeRvIQEmGIU8oWQiF4QgCoylQXUu2RXkYD2bODOLq47Bzi
         Hd8RvsDj2oiCOwaCeVg4pPiAH/cujzOPJh8NZiOj7zzcQ24fPK1yE9qGJTM2N8XQNRjg
         ZnTbb05zo9kIOUxhJI9I6HH5N+e7XNbAC8fXiv9ukEQOtzyIGzt11P6n6/jc5J6XAshD
         V2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311736; x=1742916536;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck7vxHLxi5/ysl7+5fP8R3Y1ywz2YCzxDOSeWR2KFfs=;
        b=D6EIDogj4xjX4UoPNIBs+hokAIq1IJiEDYxK/so9iv4ak/uFEuEKCsOsrh/CUqvH1w
         vxnRdmGwo9DJ1etN1ZlhhuJa/kObQal1wj1KWqIwtMrGcKgINcv9fAjPh5wgOWi/lm+f
         QDcTIGYFNi1NiIGZwYBEwk4GKk+uxNs9LAkExDMsgmZti5NBkRnA1U8ghsANzHyNoATg
         BqmSepUODfg+zD6mPDDT4EJtSwdpsZ1SlPX+nAnh4KhS3siRRgKW86nUWrOVa2AAeoYY
         Bq826IK4GI9RBEnLytlXYnIj4fQnucKssXKyJzMZ9in2xIplQlaKc3W+z9xItaEwY63O
         k8TQ==
X-Gm-Message-State: AOJu0YwzaBmh+w0o8G1dCT8Kfc66Qk85ycpJAW/wuUcPCTV2QFFI9Czb
	ySxx381pVeU81fDQhkOOstNleMe8RF/uPLhO7g/9c25CP/S9hLJH1FZ8xlYV5ppqjt/Jvd7lvsx
	a0A==
X-Gm-Gg: ASbGncsB3CALMMUDR27c3kOwwieU2vEHzYEfwlJXveZjmYrzueguughprkZ8XR6JmPH
	8hyGL8gA7gxi0USvbd1Iyqge3a8gdJ9ZaN+bQHk1uT7EN4SASWaJ4R89hxiSi8PWxzjcDvd0q9k
	tz4agtxj+kJMXT9adXVlq7TCoXYtEDNgfz60MnPgG4QpCC3b9DG8T1XOqXeIvFsyuZ9sH7FMZgq
	j0IPPY4aLmmuKluF+6KvMNyUs9X2dcg99BV+k4llipkOFXcoB7phIteKa6IrCeKDexEXUL7YQ3b
	mZHavi9WDyvNZM+hAj62YgcH+68DKNTYwFsZM+XywG0SdvFcKc87buyEKfeDdB8srmdOtruwupY
	abTUa8bJzYsClqtL8B5voSBL3gaQ1famOuwEZ2OQ=
X-Google-Smtp-Source: AGHT+IGGq/ih6eqBj6/lD1dZWmJHTeszKNF1T6bL3kNUJNmt+PzWBaRVB3vMc0wQEF/xZ/kuMQZcyw==
X-Received: by 2002:a17:903:183:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-225e0a9b025mr167675335ad.30.1742311735946;
        Tue, 18 Mar 2025 08:28:55 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm95801805ad.149.2025.03.18.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:28:54 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:28:44 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: stable@vger.kernel.org
cc: stable-commits@vger.kernel.org, baolin.wang@linux.alibaba.com, 
    Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: shmem: skip swapcache for swapin of synchronous swap
 device" has been added to the 6.13-stable tree
In-Reply-To: <20250318112951.2053931-1-sashal@kernel.org>
Message-ID: <850f7c3f-26f6-9d60-ac46-ccaf20661cf6@google.com>
References: <20250318112951.2053931-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Mar 2025, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     mm: shmem: skip swapcache for swapin of synchronous swap device
> 
> to the 6.13-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-shmem-skip-swapcache-for-swapin-of-synchronous-sw.patch
> and it can be found in the queue-6.13 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 91c40c9fb0e939508d814e1ac302011d8e8213eb
> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> Date:   Wed Jan 8 10:16:49 2025 +0800
> 
>     mm: shmem: skip swapcache for swapin of synchronous swap device
>     
>     [ Upstream commit 1dd44c0af4fa1e80a4e82faa10cbf5d22da40362 ]
>     
>     With fast swap devices (such as zram), swapin latency is crucial to
>     applications.  For shmem swapin, similar to anonymous memory swapin, we
>     can skip the swapcache operation to improve swapin latency.  Testing 1G
>     shmem sequential swapin without THP enabled, I observed approximately a 6%
>     performance improvement: (Note: I repeated 5 times and took the mean data
>     for each test)
>     
>     w/o patch       w/ patch        changes
>     534.8ms         501ms           +6.3%
>     
>     In addition, currently, we always split the large swap entry stored in the
>     shmem mapping during shmem large folio swapin, which is not perfect,
>     especially with a fast swap device.  We should swap in the whole large
>     folio instead of splitting the precious large folios to take advantage of
>     the large folios and improve the swapin latency if the swap device is
>     synchronous device, which is similar to anonymous memory mTHP swapin.
>     Testing 1G shmem sequential swapin with 64K mTHP and 2M mTHP, I observed
>     obvious performance improvement:
>     
>     mTHP=64K
>     w/o patch       w/ patch        changes
>     550.4ms         169.6ms         +69%
>     
>     mTHP=2M
>     w/o patch       w/ patch        changes
>     542.8ms         126.8ms         +77%
>     
>     Note that skipping swapcache requires attention to concurrent swapin
>     scenarios.  Fortunately the swapcache_prepare() and
>     shmem_add_to_page_cache() can help identify concurrent swapin and large
>     swap entry split scenarios, and return -EEXIST for retry.
>     
>     [akpm@linux-foundation.org: use IS_ENABLED(), tweak comment grammar]
>     Link: https://lkml.kernel.org/r/3d9f3bd3bc6ec953054baff5134f66feeaae7c1e.1736301701.git.baolin.wang@linux.alibaba.com
>     Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>     Cc: David Hildenbrand <david@redhat.com>
>     Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
>     Cc: Hugh Dickins <hughd@google.com>
>     Cc: Kairui Song <kasong@tencent.com>
>     Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>     Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>     Cc: Ryan Roberts <ryan.roberts@arm.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Stable-dep-of: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

No, NAK to this one going to stable.

Hugh

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e10d6e0924620..6d30139d3967d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1903,6 +1903,65 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  	return ERR_PTR(error);
>  }
>  
> +static struct folio *shmem_swap_alloc_folio(struct inode *inode,
> +		struct vm_area_struct *vma, pgoff_t index,
> +		swp_entry_t entry, int order, gfp_t gfp)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct folio *new;
> +	void *shadow;
> +	int nr_pages;
> +
> +	/*
> +	 * We have arrived here because our zones are constrained, so don't
> +	 * limit chance of success with further cpuset and node constraints.
> +	 */
> +	gfp &= ~GFP_CONSTRAINT_MASK;
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && order > 0) {
> +		gfp_t huge_gfp = vma_thp_gfp_mask(vma);
> +
> +		gfp = limit_gfp_mask(huge_gfp, gfp);
> +	}
> +
> +	new = shmem_alloc_folio(gfp, order, info, index);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nr_pages = folio_nr_pages(new);
> +	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> +					   gfp, entry)) {
> +		folio_put(new);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/*
> +	 * Prevent parallel swapin from proceeding with the swap cache flag.
> +	 *
> +	 * Of course there is another possible concurrent scenario as well,
> +	 * that is to say, the swap cache flag of a large folio has already
> +	 * been set by swapcache_prepare(), while another thread may have
> +	 * already split the large swap entry stored in the shmem mapping.
> +	 * In this case, shmem_add_to_page_cache() will help identify the
> +	 * concurrent swapin and return -EEXIST.
> +	 */
> +	if (swapcache_prepare(entry, nr_pages)) {
> +		folio_put(new);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	__folio_set_locked(new);
> +	__folio_set_swapbacked(new);
> +	new->swap = entry;
> +
> +	mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> +	shadow = get_shadow_from_swap_cache(entry);
> +	if (shadow)
> +		workingset_refault(new, shadow);
> +	folio_add_lru(new);
> +	swap_read_folio(new, NULL);
> +	return new;
> +}
> +
>  /*
>   * When a page is moved from swapcache to shmem filecache (either by the
>   * usual swapin of shmem_get_folio_gfp(), or by the less common swapoff of
> @@ -2006,7 +2065,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>  }
>  
>  static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
> -					 struct folio *folio, swp_entry_t swap)
> +					 struct folio *folio, swp_entry_t swap,
> +					 bool skip_swapcache)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	swp_entry_t swapin_error;
> @@ -2022,7 +2082,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  
>  	nr_pages = folio_nr_pages(folio);
>  	folio_wait_writeback(folio);
> -	delete_from_swap_cache(folio);
> +	if (!skip_swapcache)
> +		delete_from_swap_cache(folio);
>  	/*
>  	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
> @@ -2126,6 +2187,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct swap_info_struct *si;
>  	struct folio *folio = NULL;
> +	bool skip_swapcache = false;
>  	swp_entry_t swap;
>  	int error, nr_pages;
>  
> @@ -2147,6 +2209,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	/* Look it up and read it in.. */
>  	folio = swap_cache_get_folio(swap, NULL, 0);
>  	if (!folio) {
> +		int order = xa_get_order(&mapping->i_pages, index);
> +		bool fallback_order0 = false;
>  		int split_order;
>  
>  		/* Or update major stats only when swapin succeeds?? */
> @@ -2156,6 +2220,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>  		}
>  
> +		/*
> +		 * If uffd is active for the vma, we need per-page fault
> +		 * fidelity to maintain the uffd semantics, then fallback
> +		 * to swapin order-0 folio, as well as for zswap case.
> +		 */
> +		if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma))) ||
> +				  !zswap_never_enabled()))
> +			fallback_order0 = true;
> +
> +		/* Skip swapcache for synchronous device. */
> +		if (!fallback_order0 && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> +			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
> +			if (!IS_ERR(folio)) {
> +				skip_swapcache = true;
> +				goto alloced;
> +			}
> +
> +			/*
> +			 * Fallback to swapin order-0 folio unless the swap entry
> +			 * already exists.
> +			 */
> +			error = PTR_ERR(folio);
> +			folio = NULL;
> +			if (error == -EEXIST)
> +				goto failed;
> +		}
> +
>  		/*
>  		 * Now swap device can only swap in order 0 folio, then we
>  		 * should split the large swap entry stored in the pagecache
> @@ -2186,9 +2277,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  		}
>  	}
>  
> +alloced:
>  	/* We have to do this with folio locked to prevent races */
>  	folio_lock(folio);
> -	if (!folio_test_swapcache(folio) ||
> +	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>  	    folio->swap.val != swap.val ||
>  	    !shmem_confirm_swap(mapping, index, swap)) {
>  		error = -EEXIST;
> @@ -2224,7 +2316,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	if (sgp == SGP_WRITE)
>  		folio_mark_accessed(folio);
>  
> -	delete_from_swap_cache(folio);
> +	if (skip_swapcache) {
> +		folio->swap.val = 0;
> +		swapcache_clear(si, swap, nr_pages);
> +	} else {
> +		delete_from_swap_cache(folio);
> +	}
>  	folio_mark_dirty(folio);
>  	swap_free_nr(swap, nr_pages);
>  	put_swap_device(si);
> @@ -2235,8 +2332,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	if (!shmem_confirm_swap(mapping, index, swap))
>  		error = -EEXIST;
>  	if (error == -EIO)
> -		shmem_set_folio_swapin_error(inode, index, folio, swap);
> +		shmem_set_folio_swapin_error(inode, index, folio, swap,
> +					     skip_swapcache);
>  unlock:
> +	if (skip_swapcache)
> +		swapcache_clear(si, swap, folio_nr_pages(folio));
>  	if (folio) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> 

