Return-Path: <stable+bounces-176538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F5B38F49
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11721C20548
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA430DED4;
	Wed, 27 Aug 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG59mOeT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F730CDA5;
	Wed, 27 Aug 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337511; cv=none; b=SWnQusBQoyRCNJZ+iLkRudrPrk3JluxkTU1nuBB0BBsH9INeY/pP1Xfh5Q0LJeUtlS7ojweRx4nHXCBIdjbFhxst360wjDwM0ebzoC81BwuM29TS6a/cbqtVPJNBp25Jo9XOHZ684iKo/kb7SBS/nEE+6+nfguyDxpJ8sZtNvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337511; c=relaxed/simple;
	bh=Pr43rHlgjc0vSumPG28l+hqGsoMuQh0VkZmhV6Con9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3OkKhzjR91pDHvXRVTApQawYHNfTC8NfNkQFK4EkiQaZNXt84IaUMmkMfMt7MtfQLN541+sphZd0A91fipL8pzekSallknE9QOcAkUEJMv3dQ1W7girLVvx5sh3Atk2/4Fw8ZsJ9+RuNwf2NWjRHJSrKdcmesPgKJgXWVBYaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG59mOeT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756337509; x=1787873509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pr43rHlgjc0vSumPG28l+hqGsoMuQh0VkZmhV6Con9Q=;
  b=XG59mOeTMQoaR1AKRgM+mBg6/u0UiBLaVpx/T6CFF6j20bm/2Mfjo4eR
   rRS5JwRrKzKgRndP91r7Kizgl7NFVoPLqnmFxSBDAUJr6pe341czqOAW0
   QpmUi2/7SmfOHwP1koX9itg8ENVZ7Cr8msGLPApC0FdPRB/IttBo4J5Vd
   PtBZ3TQt+o9RbNQO/CbQn/bD8EnCHndp6YWPM+QpKWzWu95j+AtxvfxHi
   d5vx55ERboQG/wT1W/nX2QN+9WUkDxj0bxDDdwzsuuLzZpKhtfiIDmDI0
   uIYMA7oux1VdXHtGCRwfcgFZ5inXN87a7vhYZU5mSX1I8FYhvKPq/74qA
   w==;
X-CSE-ConnectionGUID: jsR7ccOSQ/C/kPiqd7JAgQ==
X-CSE-MsgGUID: uTMRhxC0QhuAePUJVKNMlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62435912"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62435912"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 16:31:48 -0700
X-CSE-ConnectionGUID: zaImdtF3S8OAJ9Z6jJHR+A==
X-CSE-MsgGUID: I6MVNWUsRsaN0YvnkC6GBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169214043"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.109.56]) ([10.125.109.56])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 16:31:48 -0700
Message-ID: <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
Date: Wed, 27 Aug 2025 16:31:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, vishal.moola@gmail.com,
 Matthew Wilcox <willy@infradead.org>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/25 03:58, Baolu Lu wrote:
> Following the insights above, I wrote the code as follows. Does it look
> good?

I'd really prefer an actual diff that compiles. Because:

> #ifdef CONFIG_ASYNC_PGTABLE_FREE
> /* a 'struct ptdesc' that needs its destructor run */
> #define ASYNC_PGTABLE_FREE_DTOR    BIT(NR_PAGEFLAGS)

This doesn't work, does it? Don't you need to _allocate_ a new bit?
Wouldn't this die a hilariously horrible death if NR_PAGEFLAGS==64? ;)

Also, I'm pretty sure you can't just go setting random bits in this
because it aliases with page flags.

...
> static void kernel_pgtable_work_func(struct work_struct *work)
> {
>     struct ptdesc *ptdesc, *next;
>     LIST_HEAD(page_list);
> 
>     spin_lock(&kernel_pgtable_work.lock);
>     list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
>     spin_unlock(&kernel_pgtable_work.lock);
> 
>     iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> 
>     list_for_each_entry_safe(ptdesc, next, &page_list, pt_list) {
>         list_del(&ptdesc->pt_list);
>         if (ptdesc->__page_flags & ASYNC_PGTABLE_FREE_DTOR)
>             pagetable_dtor_free(ptdesc);
>         else
>             __free_page(ptdesc_page(ptdesc));
>     }
> }
What I had in mind was that kernel_pgtable_work_func() only does:

	__free_pages(page, compound_order(page));

All of the things that queue gunk to the list do the legwork of making
the work_func() simple. This also guides them toward proving a single,
compound page because _they_ have to do the work if they don't want
something simple.

> void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc)
> {
>     spin_lock(&kernel_pgtable_work.lock);
>     ptdesc->__page_flags |= ASYNC_PGTABLE_FREE_DTOR;
>     list_add(&ptdesc->pt_list, &kernel_pgtable_work.list);
>     spin_unlock(&kernel_pgtable_work.lock);
> 
>     schedule_work(&kernel_pgtable_work.work);
> }
> 
> void kernel_pgtable_async_free_page_list(struct list_head *list)
> {
>     spin_lock(&kernel_pgtable_work.lock);
>     list_splice_tail(list, &kernel_pgtable_work.list);
>     spin_unlock(&kernel_pgtable_work.lock);
> 
>     schedule_work(&kernel_pgtable_work.work);
> }
> 
> void kernel_pgtable_async_free_page(struct page *page)
> {
>     spin_lock(&kernel_pgtable_work.lock);
>     list_add(&page_ptdesc(page)->pt_list, &kernel_pgtable_work.list);
>     spin_unlock(&kernel_pgtable_work.lock);
> 
>     schedule_work(&kernel_pgtable_work.work);
> }

I wouldn't have three of these, I'd have _one_. If you want to free a
bunch of pages, then just call it a bunch of times. This is not
performance critical.

Oh, and the ptdesc flag shouldn't be for "I need to be asynchronously
freed". All kernel PTE pages should ideally set it at allocation so you
can do this:

static inline void pagetable_free(struct ptdesc *pt)
{
        struct page *page = ptdesc_page(pt);

	if (ptdesc->some_field | PTDESC_KERNEL)
		kernel_pgtable_async_free_page(page);
	else
	        __free_pages(page, compound_order(page));
}

The folks that, today, call pagetable_dtor_free() don't have to do
_anything_ at free time. They just set the PTDESC_KERNEL bit at
allocation time.

See how that code reads? "If you have a kernel page table page, you must
asynchronously free it." That's actually meaningful.

I'm pretty sure the lower 24 bits of ptdesc->__page_type are free. So
I'd just do this:

#define PTDESC_TYPE_KERNEL BIT(0)

Then, something needs to set:

	ptdesc->__page_type |= PTDESC_TYPE_KERNEL;

That could happen as late as here:

static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
{
	struct ptdesc *ptdesc = virt_to_ptdesc(pte);

	// here 	

        pagetable_dtor_free(ptdesc);
}

Or as early as ptdesc allocation/constructor time. Then you check for
PTDESC_TYPE_KERNEL in pagetable_free().

