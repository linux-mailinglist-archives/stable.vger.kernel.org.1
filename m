Return-Path: <stable+bounces-163068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B37B06E0C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A637B3B11CA
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398522877CD;
	Wed, 16 Jul 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd4ZFrpY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B5285404;
	Wed, 16 Jul 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647762; cv=none; b=SLZc+rMN7Ag6cFfKCPsFNhPca/1NBu9riTBLUNzGzouG5qFU9rrgY1ex4wxHKMNEA5+EwozMeOdI4G1uuQuvKbBE6AQggOkOdnNisXYVvwtc+plvNm76NAyq4JaV9tWM9I9R9BirzbKELizOSMedIwA+/seMY0PPR+dHPBzJvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647762; c=relaxed/simple;
	bh=reLDrD8pVjEqExLXcIq2Cd/GqiLV03i+3iRA6OWVVpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJOyA3e9TEbGM9K03Gq/snRQVCA6IjR9Oht2q+CZ+B5zXY5tgvMBVq/rRmjoS1Aq8ukIlJOa3kAVn0UnopXSYD+EykTIpI+jDYMa0HpUmka/L7+Pok2lQ/srDZYyZDCG2Eauw9BrCzzEffMwibbs11c6cRhEm3zQeLjcrg/NjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd4ZFrpY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752647760; x=1784183760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=reLDrD8pVjEqExLXcIq2Cd/GqiLV03i+3iRA6OWVVpI=;
  b=fd4ZFrpY9ZiCTvZoQPZp4QxGkQK2f5TYsMLwpfxSaZtl81Gv75ttd3uX
   bmGnc2gEKzeJM7mfRKXyY9/kWtFPs1LyUeNlVFjFCiAzhslwCVrZlOFct
   QfYdEKOqzjjIHD3zFxQc5GKH5fAm+QEyJQ6BQ8Q3tkO20Yx3cnrd55NHq
   KLsEpSaP4+EOXz7V/RByUVoHDTGZo9IHOGNsfFnjOJkOU+iAFwTEAqa5s
   adzOyreBkO5o7HIB6krEMciq0f2D1J9IT5RAHYwQIY6S/TeQq9SMfb92/
   pacFV74SdCiSQQDyJRLLuXfRs6raWFwTxkVplPe1gQt3kIpu4+HksisTX
   g==;
X-CSE-ConnectionGUID: 5aT5vMUTTyaK2XQoPNt5Og==
X-CSE-MsgGUID: 32xrQfsnTI6ca8anML6+5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58696118"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58696118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:35:59 -0700
X-CSE-ConnectionGUID: BipnkTfCQ8G1IqDclPUDzA==
X-CSE-MsgGUID: OwQ2SwkCRTSl33pl+v70jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157770073"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:35:56 -0700
Message-ID: <f58a6825-e53a-4751-97cc-0891052936f1@linux.intel.com>
Date: Wed, 16 Jul 2025 14:34:04 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250715122504.GK2067380@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 20:25, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 01:55:01PM +0800, Baolu Lu wrote:
>> Yes, the mm (struct mm of processes that are bound to devices) list is
>> an unbounded list and can theoretically grow indefinitely. This results
>> in an unpredictable critical region.
> 
> Every MM has a unique PASID so I don't see how you can avoid this.
>   
>> @@ -654,6 +656,9 @@ struct iommu_ops {
>>
>>   	int (*def_domain_type)(struct device *dev);
>>
>> +	void (*paging_cache_invalidate)(struct iommu_device *dev,
>> +					unsigned long start, unsigned long end);
> 
> How would you even implement this in a driver?
> 
> You either flush the whole iommu, in which case who needs a rage, or
> the driver has to iterate over the PASID list, in which case it
> doesn't really improve the situation.

The Intel iommu driver supports flushing all SVA PASIDs with a single
request in the invalidation queue. I am not sure if other IOMMU
implementations also support this, so you are right, it doesn't
generally improve the situation.

> 
> If this is a concern I think the better answer is to do a defered free
> like the mm can sometimes do where we thread the page tables onto a
> linked list, flush the CPU cache and push it all into a work which
> will do the iommu flush before actually freeing the memory.

Is it a workable solution to use schedule_work() to queue the KVA cache
invalidation as a work item in the system workqueue? By doing so, we
wouldn't need the spinlock to protect the list anymore.

Perhaps we would need another interface, perhaps named
iommu_sva_flush_kva_inv_wq(), to guarantee that all flush work is
completed before actually freeing the pages.

> One of the KPTI options might be easier at that point..
> 
> Jason

Thanks,
baolu

