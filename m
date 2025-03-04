Return-Path: <stable+bounces-120252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF6A4E358
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E701179BF3
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2C281344;
	Tue,  4 Mar 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvzAwJKx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696927EC99
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101374; cv=none; b=lZ99qBaqKEar3NeVHZ2J/lkNgU6ZUZ90FqfrkC5FVkX1Zm3nZz5JZ2C5afzBPRCWw+1/BUf386J8ikNn5hkLwfvNW3sM93BIkuGQ54IMJZAhUttyxp4cMQwQFyblZH2V2+mlAEZyAepb9nkjwI6+cSzjTeHH1xOF1xkBpuFMCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101374; c=relaxed/simple;
	bh=D7lc0HgY9pEhLV/641cxKfdD1hosvT9DLR1yBFWqnuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQzUMNjJwFtK3BUVYbLSB02l7vPf+xin4jFDPbUDV51Uh59HvQezJYJN1MCMmLGB+bPTK0WliJKIgF43pihB9Ze1ni5nf1+jaf2Yayg/OdAf0YvZLn6PbFfF88SGI7SIYK2/1Pi3vn89ptGgbG6kgwBlrcUpIY5pHzedZYJm4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvzAwJKx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101372; x=1772637372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D7lc0HgY9pEhLV/641cxKfdD1hosvT9DLR1yBFWqnuQ=;
  b=cvzAwJKxPBuet5lGyrDZ9oqJ0RU2MTY/0K3yakr4PmOebUxvttAMqt5u
   VO2DVOcTeTKKCtYFHVxpCzbsWysnJbCqcOLAnqZEPnOzBwVaAJ+ghxhiQ
   +KeXntFw563QLhrzPY4PlmsbUOY4Mt4ium4lRuOdG8PZWzBvXNiWDw6D1
   r4nuYXmJXnPAHZGeV1hEISnxvUKC9NRAjpEN1Sm32L8vVD1VJamEEEM2T
   cCoYz6iLOnsmWbM2wk+hH6OKYjfAPApv/2ADYGDnJEMMdiyohKfZQnnOi
   Aknq9vrn1BvxgxhZ+JM0DmuBYb/hBAMEsCZN8Z62Z+Fru1pKubbIDyqQw
   g==;
X-CSE-ConnectionGUID: D317R36OSPOidiRpyopcWw==
X-CSE-MsgGUID: UCcfdsrQRZSduf9rCNbbCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41272314"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41272314"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:16:12 -0800
X-CSE-ConnectionGUID: L3XX+/J/Q0KHq8Oje4aDzw==
X-CSE-MsgGUID: pFWfIBWLSRi7G1BBQ/F4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123523543"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.188]) ([10.245.245.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:16:11 -0800
Message-ID: <1e5ef4c8-9545-4102-88d9-865cf6a4bec9@intel.com>
Date: Tue, 4 Mar 2025 15:16:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/xe/hmm: Don't dereference struct page pointers
 without notifier lock
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
References: <20250304113758.67889-1-thomas.hellstrom@linux.intel.com>
 <20250304113758.67889-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250304113758.67889-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2025 11:37, Thomas Hellström wrote:
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
> v2:
> - Use assert to check whether hmm pfns are valid (Matthew Auld)
> - Take into account that large pages may cross range boundaries
>    (Matthew Auld)
> 
> Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
> Cc: Oak Zeng <oak.zeng@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/xe/xe_hmm.c | 119 ++++++++++++++++++++++++++++--------
>   1 file changed, 93 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
> index c56738fa713b..93cce9e819a1 100644
> --- a/drivers/gpu/drm/xe/xe_hmm.c
> +++ b/drivers/gpu/drm/xe/xe_hmm.c
> @@ -42,6 +42,40 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>   	}
>   }
>   
> +static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
> +		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
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

up_read() ?

> +		return -EAGAIN;
> +
> +	npages = xe_npages_in_range(range->start, range->end);
> +	for (i = 0; i < npages;) {
> +		unsigned long len;
> +
> +		hmm_pfn = range->hmm_pfns[i];
> +		xe_assert(xe, hmm_pfn & HMM_PFN_VALID);
> +
> +		len = 1UL << hmm_pfn_to_map_order(hmm_pfn);
> +
> +		/* If order > 0 the page may extend beyond range->start */
> +		len -= (hmm_pfn & ~HMM_PFN_FLAGS) & (len - 1);
> +		i += len;
> +		num_chunks++;
> +	}
> +	up_read(notifier_sem);
> +
> +	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
> +}
> +
>   /**
>    * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
>    * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
> @@ -50,6 +84,7 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>    * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
>    * has the pfn numbers of pages that back up this hmm address range.
>    * @st: pointer to the sg table.
> + * @notifier_sem: The xe notifier lock.
>    * @write: whether we write to this range. This decides dma map direction
>    * for system pages. If write we map it bi-diretional; otherwise
>    * DMA_TO_DEVICE
> @@ -76,38 +111,41 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
>    * Returns 0 if successful; -ENOMEM if fails to allocate memory
>    */
>   static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
> -		       struct sg_table *st, bool write)
> +		       struct sg_table *st,
> +		       struct rw_semaphore *notifier_sem,
> +		       bool write)
>   {
> +	unsigned long npages = xe_npages_in_range(range->start, range->end);
>   	struct device *dev = xe->drm.dev;
> -	struct page **pages;
> -	u64 i, npages;
> -	int ret;
> +	struct scatterlist *sgl;
> +	struct page *page;
> +	unsigned long i, j;
>   
> -	npages = xe_npages_in_range(range->start, range->end);
> -	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
> -	if (!pages)
> -		return -ENOMEM;
> +	lockdep_assert_held(notifier_sem);
>   
> -	for (i = 0; i < npages; i++) {
> -		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
> -		xe_assert(xe, !is_device_private_page(pages[i]));
> -	}
> +	i = 0;
> +	for_each_sg(st->sgl, sgl, st->nents, j) {
> +		unsigned long hmm_pfn, size;
>   
> -	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
> -						xe_sg_segment_size(dev), GFP_KERNEL);
> -	if (ret)
> -		goto free_pages;
> +		hmm_pfn = range->hmm_pfns[i];
> +		page = hmm_pfn_to_page(hmm_pfn);
> +		xe_assert(xe, !is_device_private_page(page));
>   
> -	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
> -			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
> -	if (ret) {
> -		sg_free_table(st);
> -		st = NULL;
> +		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
> +		size -= page_to_pfn(page) & (size - 1);
> +		i += size;
> +
> +		if (unlikely(j == st->nents - 1)) {
> +			if (i > npages)
> +				size -= (i - npages);
> +			sg_mark_end(sgl);
> +		}
> +		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
>   	}
> +	xe_assert(xe, i == npages);
>   
> -free_pages:
> -	kvfree(pages);
> -	return ret;
> +	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
> +			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
>   }
>   
>   /**
> @@ -235,16 +273,45 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
>   	if (ret)
>   		goto free_pfns;
>   
> -	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt, write);
> +	if (unlikely(userptr->sg)) {

Is it really possible to hit this? We did the unmap above also, although 
that was outside of the notifier lock?

Otherwise,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> +		ret = down_write_killable(&vm->userptr.notifier_lock);
> +		if (ret)
> +			goto free_pfns;
> +
> +		xe_hmm_userptr_free_sg(uvma);
> +		up_write(&vm->userptr.notifier_lock);
> +	}
> +
> +	ret = xe_alloc_sg(vm->xe, &userptr->sgt, &hmm_range, &vm->userptr.notifier_lock);
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


