Return-Path: <stable+bounces-124828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7AA677C5
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680BD17912F
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930EE20E718;
	Tue, 18 Mar 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQWzCkNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECB4A23
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311787; cv=none; b=JKefsduCZTeGD+q2VuDIHU+qtCnzgEOCQ3CFhQeR3QyhwMm0WiK25mUVrnK8lH+sIVdz+2aVhC2d2W9yBxNo5Zw/mjkz5b37HubN8uLwoQYKzI5FWYH8DuNlKmY3e3QI1TDQkYlnhF8yeJiyym+w8tpDdI2/I6O4phU7yazWOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311787; c=relaxed/simple;
	bh=MA6xa4oVGjgPeP6Sm7Kz3kVwVcJDtwoz9e+MIcRiFS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WLD3OdSBb0qh7n6mPqGgZJBwwDcSvAGmTCqPD3lrVXW17VJmMfIqIngvp1Tb3S9tFo+Yk+UnS0v6BHGE14+usfikGujQq7m/XwxCLQHd5IpTvfs1aKaFHVewmwCcxR/JSLZvYXtaNctI7wk5S0r6K3yj908/DzdOroVrHMnh0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQWzCkNX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so7223643a91.3
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742311783; x=1742916583; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bdgupffSmbkXir1Vbkd+rvHJ6cbMmWRXpMaVVQuwys=;
        b=cQWzCkNXjj8AyO6P2iRfORLsADl9RRZe7VPOugZNlGoP48+Cz2vaUOpWl/+GytrKJH
         6ljBRw4HsnlpqEkdU2tEde5kp/a4hOir6KoeaNDSjuWDQp/LOsaYMvh8ZYXsWnrSmy2t
         aPoQHf4MmkyNuclrAWyqnljHmJxIvtL6Wq8QKTp19jCVPUvPNeREqwH9Hlf7aMjxFqHQ
         No6fNVZ3+eJQSSvl2S13rIqRICrs1GJuS1/HBdFRMedA1FmEgFYP0VZHraJ1HgJS+eLM
         q7GaKe1vDlstDkRM8VSXv3lR5vn1uH3s35RHBgvqKKUCg2+ffVQ37XGL9VBfOp/8Wxp5
         g4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311783; x=1742916583;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bdgupffSmbkXir1Vbkd+rvHJ6cbMmWRXpMaVVQuwys=;
        b=IQLEeXWOP4tw1Bl/zL1kR81RYtb3b0OK2hAKpLwgOF6dEXtjgxcZlp/8F258gI0Dhg
         Q0DJpTRcYbEqSNVza7Q6hqP+8VpOhyqK5t+tZQqOLw85wSlJ/3Bq0Msls6w9i3HkF1By
         CTmwHmukYz0I4I8IKW7pzx6PxSVolZRCfW8jMDHFOZGbYKAIa/0SnmIEJhYzzB0AbrJ/
         3boASYM3cExPJ3r5KqEtpkrTNH7211P6n3NwNcGL+vc7E6g1T0XQHeVwHAq6N8CDzfu0
         8PgqvpZqMQP7Qp5IWbpE9Fi6Sou424H4lz8aEase4Ifpg3CtLTY3M81LDJ7de1/Vtsd+
         Pv9g==
X-Gm-Message-State: AOJu0YzjlfqXyxmPhZrU1Fw9JrzXpwDYA7lO2Jt1okq/PilLjvTn61TZ
	X91N/140CjlcWAcQc02WLz6CCbiIAyw+1Ykzeu298ZMJn3VPkRB6optLUNrgAeFc+4nZYALcTWq
	r5Q==
X-Gm-Gg: ASbGnctL6XgonEbtowyknIuHRJqeTWTlGQ7UR3og0q+JiV3N58TJdWP+Wu3Z1RCAMxL
	VcOdY+D4bva7BC+jNaEuLrz8Ltv3A2047BwXVAdCc0/HpSzmtjZ3gSmW/lDDNF/62M+xgAPpaNa
	qo8Je9JReijD+OklHFusCfJyIqv1kKQiLpB+7vFTAaRAflDckbv503eBHQWMy3eXHrN84YfBCG9
	+uVA7OyjsWOqvSuBHchHQ/IdiZhaA+QWHQ5uQW47eLFt/owQloqeL3tWi9/zl3b9pJQR8X9PV+O
	x0VhsN9Wxgz5IvpteEU5D9CORiA1yqDx7RVYjn4XBK3EPiKYeUfVTvJxZcTmZBAWDSBTbeFJPwf
	/F0sPO4Wp9J0FofJ0CSrDGPy4DZ0n
X-Google-Smtp-Source: AGHT+IEsSc/bri/JQV4u6cdUS3EZTJdp4w2dl7bE7dGC75Zx5olUrmBnMhr1CkUHUl4ix+k4lhd9yA==
X-Received: by 2002:a05:6a20:c706:b0:1f5:70d8:6a98 with SMTP id adf61e73a8af0-1fa40f19d87mr6771477637.0.1742311783193;
        Tue, 18 Mar 2025 08:29:43 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e17fsm9970333b3a.104.2025.03.18.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:29:42 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:29:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: stable@vger.kernel.org
cc: stable-commits@vger.kernel.org, baolin.wang@linux.alibaba.com, 
    Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: shmem: skip swapcache for swapin of synchronous swap
 device" has been added to the 6.12-stable tree
In-Reply-To: <20250318113012.2054475-1-sashal@kernel.org>
Message-ID: <aaf270f0-be1f-1125-3c07-afa41ae17de4@google.com>
References: <20250318113012.2054475-1-sashal@kernel.org>
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
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-shmem-skip-swapcache-for-swapin-of-synchronous-sw.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit df6cb03ef8e3bf53ebe143c79cf2c073bfa0584b
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
> index 5960e5035f983..738893d7fe083 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1878,6 +1878,65 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
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
> @@ -1981,7 +2040,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>  }
>  
>  static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
> -					 struct folio *folio, swp_entry_t swap)
> +					 struct folio *folio, swp_entry_t swap,
> +					 bool skip_swapcache)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	swp_entry_t swapin_error;
> @@ -1997,7 +2057,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  
>  	nr_pages = folio_nr_pages(folio);
>  	folio_wait_writeback(folio);
> -	delete_from_swap_cache(folio);
> +	if (!skip_swapcache)
> +		delete_from_swap_cache(folio);
>  	/*
>  	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
> @@ -2101,6 +2162,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct swap_info_struct *si;
>  	struct folio *folio = NULL;
> +	bool skip_swapcache = false;
>  	swp_entry_t swap;
>  	int error, nr_pages;
>  
> @@ -2122,6 +2184,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	/* Look it up and read it in.. */
>  	folio = swap_cache_get_folio(swap, NULL, 0);
>  	if (!folio) {
> +		int order = xa_get_order(&mapping->i_pages, index);
> +		bool fallback_order0 = false;
>  		int split_order;
>  
>  		/* Or update major stats only when swapin succeeds?? */
> @@ -2131,6 +2195,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
> @@ -2161,9 +2252,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
> @@ -2199,7 +2291,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
> @@ -2210,8 +2307,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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

