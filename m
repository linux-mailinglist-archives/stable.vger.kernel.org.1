Return-Path: <stable+bounces-163210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097AB08296
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 03:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FB4A58FA
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEF1A3167;
	Thu, 17 Jul 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gi/yguL5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AB1411EB;
	Thu, 17 Jul 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716720; cv=none; b=tXcRzUucYG3SqjDNn46XivAa5jMxJG32FVAjbft8IKYO3pdbVfnuny0VMsRShiGvotgByuFOGku6GnAkhv9ZtQ3X4gY7FFazjRgqT0gOxgdgxmON8SMzdYui+C+60iwjULuTnox3a7mZ6GC6CB0+2L7/g7adRUxRcwNalU7H1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716720; c=relaxed/simple;
	bh=/RbAH5gsGsI/vSlzeaWK3wAywHETxlvVMYZZu9wtIAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLnOEs54ksTQnRn9DUtOLCbsHKSzgj2nM8vRmjps/dtAlVyFHMtyJVHm6NUJJYwKfHhAN50GlHMnm5ZoDhXSqDo/U+ukCJBDVnENcdTc8uOMt7bqty7dGpsAduBuKFO87Tj2KLlOfZyv+MwupjCBHui4HRypsak83rKFH6zIDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gi/yguL5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752716719; x=1784252719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/RbAH5gsGsI/vSlzeaWK3wAywHETxlvVMYZZu9wtIAc=;
  b=Gi/yguL5CR9a5O8MlmBfDZ0HJMl/Rciv4prGbkYC+7v8JQdNyPWeq1og
   y2BIHu+QFo9SgR57jDzGhnUZvyJ7NFVWx4oTEGvsJnEgbD+ZwRUAQQm1b
   HHkRs5x28LwwApBpQGdy6b7x3/Y5Tf3YM9YB9qELSOF8sqqZ1npEeoNh9
   YOXKzgEx80AaURrKtj2M41/WPqTJnFqr70ARAUvfXok1jI17sl14t2XRj
   u3K/nDffqzzxaBXp0vPifNEFO6D8Hc3UDqqvuWTKUmhuiJUJVjk+siClp
   80IqFMzRkX/MJqY3lrgWdeO7toCP53DhvSjfoaUkAl3mWfpJl3O5x86XC
   w==;
X-CSE-ConnectionGUID: 7DYuFzd0Sg6sDXxoXBvJkA==
X-CSE-MsgGUID: fHfd/zEzQ52j5Qd9JFtR9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72546445"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="72546445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:45:17 -0700
X-CSE-ConnectionGUID: 6UKYyFDdSqa817g2UuA1EA==
X-CSE-MsgGUID: kbyc6LnuSFqjH0eZnWHQqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="163288796"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:45:12 -0700
Message-ID: <df5353e2-1d54-476b-90ab-e673686dcc41@linux.intel.com>
Date: Thu, 17 Jul 2025 09:43:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
 <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
 <20250715122504.GK2067380@nvidia.com>
 <f58a6825-e53a-4751-97cc-0891052936f1@linux.intel.com>
 <20250716120817.GY2067380@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250716120817.GY2067380@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 20:08, Jason Gunthorpe wrote:
> On Wed, Jul 16, 2025 at 02:34:04PM +0800, Baolu Lu wrote:
>>>> @@ -654,6 +656,9 @@ struct iommu_ops {
>>>>
>>>>    	int (*def_domain_type)(struct device *dev);
>>>>
>>>> +	void (*paging_cache_invalidate)(struct iommu_device *dev,
>>>> +					unsigned long start, unsigned long end);
>>>
>>> How would you even implement this in a driver?
>>>
>>> You either flush the whole iommu, in which case who needs a rage, or
>>> the driver has to iterate over the PASID list, in which case it
>>> doesn't really improve the situation.
>>
>> The Intel iommu driver supports flushing all SVA PASIDs with a single
>> request in the invalidation queue.
> 
> How? All PASID !=0 ? The HW has no notion about a SVA PASID vs no-SVA
> else. This is just flushing almost everything.

The intel iommu driver allocates a dedicated domain id for all sva
domains. It can flush all cache entries with that domain id tagged.

> 
>>> If this is a concern I think the better answer is to do a defered free
>>> like the mm can sometimes do where we thread the page tables onto a
>>> linked list, flush the CPU cache and push it all into a work which
>>> will do the iommu flush before actually freeing the memory.
>>
>> Is it a workable solution to use schedule_work() to queue the KVA cache
>> invalidation as a work item in the system workqueue? By doing so, we
>> wouldn't need the spinlock to protect the list anymore.
> 
> Maybe.
> 
> MM is also more careful to pull the invalidation out some of the
> locks, I don't know what the KVA side is like..
How about something like the following? It's compiled but not tested.

struct kva_invalidation_work_data {
	struct work_struct work;
	unsigned long start;
	unsigned long end;
	bool free_on_completion;
};

static void invalidate_kva_func(struct work_struct *work)
{
	struct kva_invalidation_work_data *data =
		container_of(work, struct kva_invalidation_work_data, work);
	struct iommu_mm_data *iommu_mm;

	guard(mutex)(&iommu_sva_lock);
	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm,
				data->start, data->end);

	if (data->free_on_completion)
		kfree(data);
}

void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
{
	struct kva_invalidation_work_data stack_data;

	if (!static_branch_unlikely(&iommu_sva_present))
		return;

	/*
	 * Since iommu_sva_mms is an unbound list, iterating it in an atomic
	 * context could introduce significant latency issues.
	 */
	if (in_atomic()) {
		struct kva_invalidation_work_data *data =
			kzalloc(sizeof(*data), GFP_ATOMIC);

		if (!data)
			return;

		data->start = start;
		data->end = end;
		INIT_WORK(&data->work, invalidate_kva_func);
		data->free_on_completion = true;
		schedule_work(&data->work);
		return;
	}

	stack_data.start = start;
	stack_data.end = end;
	invalidate_kva_func(&stack_data.work);
}

Thanks,
baolu

