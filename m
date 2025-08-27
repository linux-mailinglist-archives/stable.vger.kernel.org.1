Return-Path: <stable+bounces-176494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB24B3806D
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79251B67B38
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBF34DCCA;
	Wed, 27 Aug 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjp7TGjY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4530CD9F;
	Wed, 27 Aug 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292291; cv=none; b=ta1XZSbpfB+8zDVZ/74zedW+Xc2aJoS6IT3u/sUbA6QQhWq+mDc3mg2Eej+QMnRob4vNqLo2X16EerDSZ5Rwd4Y2bFP14QYz5/OnO/rfNCOX0SvLZ1ysfDDEL5wf1TausFQYV9KvRETA+FLDrz03/nnqVmqSwpI30mqsZFa9mVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292291; c=relaxed/simple;
	bh=pYvi/sEdWDfStM+WfuWaVdKOo1EwYnq9HgrErqhuzmY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O6wf1190t4ow/D09X/IOIdY+QlxYEbPSqM6v/gw40CJXnwqC8Rfaua0A8T49yX5qKC9YetUQ7CD57UPWnb8hjDwb8FN6lGaD21efXwnDWv8zEx83q9o3a4nned+Gn4hz5T3sVybfCz7JoOKgv5eNn+Tm/be2TOGTXOCHmfxufnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjp7TGjY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756292290; x=1787828290;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYvi/sEdWDfStM+WfuWaVdKOo1EwYnq9HgrErqhuzmY=;
  b=cjp7TGjYwKjGQ4eWqPo2s/zyWpOvt8119Y4tibvkjwdV1lGbtqe2Byy7
   kj3+3bcZ7kvRVdd1bN1kUxpmaIYwy2hk2SVz2HEdEMUvolhKpFne9/7DI
   yIK7HwR0e8+Kw2KWIpdkUpIqmUlsPXCuy3ZUXXyA4v8jIg6KSSPnI3t3n
   IrbiCVI0+mxmVk1u21/QBMsdzY97nyUnFkev0iUyISG62f0JQkBM5Mxlr
   9NvWyWoX1wsUu8QP18hnQb6SHW+UJoa/f4/ezQYTJTcXVfeoQju1ksSyK
   W2YBUMIysoNs9u2IqL4LH0HPNzJdG0UOb4xTTc1uOkHzMQTD4pFrBUEma
   w==;
X-CSE-ConnectionGUID: GdnC5Ec6TyK9NU6PBXpwpQ==
X-CSE-MsgGUID: 9sTVCYSWRs6BJClQhDM/HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62186473"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62186473"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 03:58:10 -0700
X-CSE-ConnectionGUID: asZwBnRZTEGvodt2Q26vlg==
X-CSE-MsgGUID: yxrkhQoCRG6hWGFVl9RDaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173977483"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.233.96]) ([10.124.233.96])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 03:58:04 -0700
Message-ID: <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
Date: Wed, 27 Aug 2025 18:58:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, vishal.moola@gmail.com,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/2025 10:22 PM, Dave Hansen wrote:
> On 8/25/25 19:49, Baolu Lu wrote:
>>> The three separate lists are needed because we're handling three
>>> distinct types of page deallocation. Grouping the pages this way allows
>>> the workqueue handler to free each type using the correct function.
>>
>> Please allow me to add more details.
> 
> Right, I know why it got added this way: it was the quickest way to hack
> together a patch that fixes the IOMMU issue without refactoring anything.
> 
> I agree that you have three cases:
> 1. A full on 'struct ptdesc' that needs its destructor run
> 2. An order-0 'struct page'
> 3. A higher-order 'struct page'
> 
> Long-term, #2 and #3 probably need to get converted over to 'struct
> ptdesc'. They don't look _that_ hard to convert to me. Willy, Vishal,
> any other mm folks: do you agree?
> 
> Short-term, I'd just consolidate your issue down to a single list.
> 
> #1: For 'struct ptdesc', modify pte_free_kernel() to pass information in
>      to pagetable_dtor_free() to tell it to use the deferred page table
>      free list. Do this with a bit in the ptdesc or a new argument to
>      pagetable_dtor_free().
> #2. Just append these to the deferred page table free list. Easy.
> #3. The biggest hacky way to do this is to just treat the higher-order
>      non-compound page and put the pages on the deferred page table
>      free list one at a time. The other way to do it is to track down how
>      this thing got allocated in the first place and make sure it's got
>      __GFP_COMP metadata. If so, you can just use __free_pages() for
>      everything.
> 
> Yeah, it'll take a couple patches up front to refactor some things. But
> that refactoring will make things more consistent instead of adding
> adding complexity to deal with the inconsistency.

Following the insights above, I wrote the code as follows. Does it look
good?

mm/pgtable-generic.c:

#ifdef CONFIG_ASYNC_PGTABLE_FREE
/* a 'struct ptdesc' that needs its destructor run */
#define ASYNC_PGTABLE_FREE_DTOR	BIT(NR_PAGEFLAGS)

static void kernel_pgtable_work_func(struct work_struct *work);

static struct {
	struct list_head list;
	/* protect above ptdesc lists */
	spinlock_t lock;
	struct work_struct work;
} kernel_pgtable_work = {
	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, 
kernel_pgtable_work_func),
};

static void kernel_pgtable_work_func(struct work_struct *work)
{
	struct ptdesc *ptdesc, *next;
	LIST_HEAD(page_list);

	spin_lock(&kernel_pgtable_work.lock);
	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
	spin_unlock(&kernel_pgtable_work.lock);

	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);

	list_for_each_entry_safe(ptdesc, next, &page_list, pt_list) {
		list_del(&ptdesc->pt_list);
		if (ptdesc->__page_flags & ASYNC_PGTABLE_FREE_DTOR)
			pagetable_dtor_free(ptdesc);
		else
			__free_page(ptdesc_page(ptdesc));
	}
}

void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc)
{
	spin_lock(&kernel_pgtable_work.lock);
	ptdesc->__page_flags |= ASYNC_PGTABLE_FREE_DTOR;
	list_add(&ptdesc->pt_list, &kernel_pgtable_work.list);
	spin_unlock(&kernel_pgtable_work.lock);

	schedule_work(&kernel_pgtable_work.work);
}

void kernel_pgtable_async_free_page_list(struct list_head *list)
{
	spin_lock(&kernel_pgtable_work.lock);
	list_splice_tail(list, &kernel_pgtable_work.list);
	spin_unlock(&kernel_pgtable_work.lock);

	schedule_work(&kernel_pgtable_work.work);
}

void kernel_pgtable_async_free_page(struct page *page)
{
	spin_lock(&kernel_pgtable_work.lock);
	list_add(&page_ptdesc(page)->pt_list, &kernel_pgtable_work.list);
	spin_unlock(&kernel_pgtable_work.lock);

	schedule_work(&kernel_pgtable_work.work);
}
#endif

Thanks,
baolu

