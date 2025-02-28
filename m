Return-Path: <stable+bounces-119939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AFA49A01
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4B3170DED
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2526B2B5;
	Fri, 28 Feb 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1tyJile"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016C26A1CB
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747318; cv=none; b=bucdsac80vSk9NKhVd1kzW3r1bDDQMWc93JI82W9BoujZFRrInLzgLIO8dVH5iMP6clc88xYFV0wCtQAi5qBjxthI3IAX3Zeboek6gHI9q8iZ1Qbj1xVzlIWZOT3JwWtlhCcmZbJli/Bgxr6x7KqtSNLI1yzBi9htFcT2HQmFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747318; c=relaxed/simple;
	bh=fqWmReMCOrVPGcaLkJPLrOetIWfyFvttKdJ7/MnAQpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEunRcJa8LdivfI35+4W1yGCvorLqz7c6UyZvyIWSAaF5pr3CWPUpAdvSjwkUGhLySF4ZV9L8yii4z3JFJbPMy0Aj4Iz1KGGP9G8OXo1kX8+acKLCEDcq8Au6KIvX+Jj4vYuSpWScrdMTlW2XzrpLvzEvpsj4oEdyR6s3rG3w6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1tyJile; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740747317; x=1772283317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fqWmReMCOrVPGcaLkJPLrOetIWfyFvttKdJ7/MnAQpg=;
  b=c1tyJilenp6J/Gkz0HLp/2lfF0DCrTIZpmKJNwdGe/i8HrcloSsGbB9P
   g/CLi/byEPcyPBA0xmcTqu/4znw9bV+HRREC0VFroMmGUnP8Al8KyAW+p
   mJM7DKPNo64W2DAD9YxKaOyyjkyG9IPZKo8eUn0wFaNV8uPGqR/eJVZk9
   xm2XRBPVY5/YEQiIYOS8rp/1qnxaOxiaft2uAiNQ6tiSokLYVqGYRwTpv
   grwu+KJCN68pZEevFf23uhFA4wHEBYSZfrXFtM3OFx4QeQEcHb96+zhh2
   0tns6+OfB7U3FNtJTvenAi6DSDbEdK0QWCK/nZKmozMNqnHpTqepWqPds
   w==;
X-CSE-ConnectionGUID: ashtMFOISYyh5Yxa3kyYsA==
X-CSE-MsgGUID: excKkkTjR9mip5DlopVFDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="29268029"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="29268029"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:55:14 -0800
X-CSE-ConnectionGUID: obr1jXmLR1q/uzxHv6tcJQ==
X-CSE-MsgGUID: coQoM36iQu+53OYueW2q/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148133336"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.73]) ([10.245.244.73])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:55:13 -0800
Message-ID: <b62352fd-f16a-423c-8a20-5d7697a6c4a7@intel.com>
Date: Fri, 28 Feb 2025 12:55:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/xe/hmm: Don't dereference struct page pointers
 without notifier lock
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
References: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
 <20250228104418.44313-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250228104418.44313-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 10:44, Thomas Hellström wrote:
> The pnfs that we obtain from hmm_range_fault() point to pages that
> we don't have a reference on, and the guarantee that they are still
> in the cpu page-tables is that the notifier lock must be held and the
> notifier seqno is still valid.
> 
> So while building the sg table and marking the pages accesses / dirty
> we need to hold this lock with a validated seqno.
> 
> However, the lock is reclaim tainted which makes
> sg_alloc_table_from_pages_segment() unusable, since it internally
> allocates memory.
> 
> Instead build the sg-table manually. For the non-iommu case
> this might lead to fewer coalesces, but if that's a problem it can
> be fixed up later in the resource cursor code. For the iommu case,
> the whole sg-table may still be coalesced to a single contigous
> device va region.
> 
> This avoids marking pages that we don't own dirty and accessed, and
> it also avoid dereferencing struct pages that we don't own.
> 
> Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
> Cc: Oak Zeng <oak.zeng@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_hmm.c | 115 ++++++++++++++++++++++++++----------
>   1 file changed, 85 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
> index c56738fa713b..d3b5551496d0 100644
> --- a/drivers/gpu/drm/xe/xe_hmm.c
> +++ b/drivers/gpu/drm/xe/xe_hmm.c
> @@ -42,6 +42,36 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>   	}
>   }
>   
> +static int xe_alloc_sg(struct sg_table *st, struct hmm_range *range,
> +		       struct rw_semaphore *notifier_sem)
> +{
> +	unsigned long i, npages, hmm_pfn;
> +	unsigned long num_chunks = 0;
> +	int ret;
> +
> +	/* HMM docs says this is needed. */
> +	ret = down_read_interruptible(notifier_sem);
> +	if (ret)
> +		return ret;
> +
> +	if (mmu_interval_read_retry(range->notifier, range->notifier_seq))
> +		return -EAGAIN;
> +
> +	npages = xe_npages_in_range(range->start, range->end);
> +	for (i = 0; i < npages;) {
> +		hmm_pfn = range->hmm_pfns[i];
> +		if (!(hmm_pfn & HMM_PFN_VALID)) {

Is this possible? The default_flags are always REQ_FAULT, so that should 
ensure PFN_VALID, or the hmm_fault would have returned an error?

 From the docs:

"HMM_PFN_REQ_FAULT - The output must have HMM_PFN_VALID or 
hmm_range_fault() will fail"

Should this be an assert?

Also probably dumb question, but why do we need to hold the notifier 
lock over this loop? What is it protecting?

> +			up_read(notifier_sem);
> +			return -EFAULT;
> +		}
> +		num_chunks++;
> +		i += 1UL << hmm_pfn_to_map_order(hmm_pfn);
> +	}
> +	up_read(notifier_sem);
> +
> +	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
> +}
> +
>   /**
>    * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
>    * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
> @@ -50,6 +80,7 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>    * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
>    * has the pfn numbers of pages that back up this hmm address range.
>    * @st: pointer to the sg table.
> + * @notifier_sem: The xe notifier lock.
>    * @write: whether we write to this range. This decides dma map direction
>    * for system pages. If write we map it bi-diretional; otherwise
>    * DMA_TO_DEVICE
> @@ -76,38 +107,33 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>    * Returns 0 if successful; -ENOMEM if fails to allocate memory
>    */
>   static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
> -		       struct sg_table *st, bool write)
> +		       struct sg_table *st,
> +		       struct rw_semaphore *notifier_sem,
> +		       bool write)
>   {
>   	struct device *dev = xe->drm.dev;
> -	struct page **pages;
> -	u64 i, npages;
> -	int ret;
> -
> -	npages = xe_npages_in_range(range->start, range->end);
> -	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
> -	if (!pages)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < npages; i++) {
> -		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
> -		xe_assert(xe, !is_device_private_page(pages[i]));
> -	}
> -
> -	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
> -						xe_sg_segment_size(dev), GFP_KERNEL);
> -	if (ret)
> -		goto free_pages;
> -
> -	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
> -			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
> -	if (ret) {
> -		sg_free_table(st);
> -		st = NULL;
> +	unsigned long hmm_pfn, size;
> +	struct scatterlist *sgl;
> +	struct page *page;
> +	unsigned long i, j;
> +
> +	lockdep_assert_held(notifier_sem);
> +
> +	i = 0;
> +	for_each_sg(st->sgl, sgl, st->nents, j) {
> +		hmm_pfn = range->hmm_pfns[i];
> +		page = hmm_pfn_to_page(hmm_pfn);
> +		xe_assert(xe, !is_device_private_page(page));
> +		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
> +		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
> +		if (unlikely(j == st->nents - 1))
> +			sg_mark_end(sgl);
> +		i += size;
>   	}
> +	xe_assert(xe, i == xe_npages_in_range(range->start, range->end));
>   
> -free_pages:
> -	kvfree(pages);
> -	return ret;
> +	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
> +			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
>   }
>   
>   /**
> @@ -235,16 +261,45 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
>   	if (ret)
>   		goto free_pfns;
>   
> -	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt, write);
> +	if (unlikely(userptr->sg)) {
> +		ret = down_write_killable(&vm->userptr.notifier_lock);
> +		if (ret)
> +			goto free_pfns;
> +
> +		xe_hmm_userptr_free_sg(uvma);
> +		up_write(&vm->userptr.notifier_lock);
> +	}
> +
> +	ret = xe_alloc_sg(&userptr->sgt, &hmm_range, &vm->userptr.notifier_lock);
>   	if (ret)
>   		goto free_pfns;
>   
> +	ret = down_read_interruptible(&vm->userptr.notifier_lock);
> +	if (ret)
> +		goto free_st;
> +
> +	if (mmu_interval_read_retry(hmm_range.notifier, hmm_range.notifier_seq)) {
> +		ret = -EAGAIN;
> +		goto out_unlock;
> +	}
> +
> +	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
> +			  &vm->userptr.notifier_lock, write);
> +	if (ret)
> +		goto out_unlock;
> +
>   	xe_mark_range_accessed(&hmm_range, write);
>   	userptr->sg = &userptr->sgt;
>   	userptr->notifier_seq = hmm_range.notifier_seq;
> +	up_read(&vm->userptr.notifier_lock);
> +	kvfree(pfns);
> +	return 0;
>   
> +out_unlock:
> +	up_read(&vm->userptr.notifier_lock);
> +free_st:
> +	sg_free_table(&userptr->sgt);
>   free_pfns:
>   	kvfree(pfns);
>   	return ret;
>   }
> -


