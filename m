Return-Path: <stable+bounces-161626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D8B01189
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 05:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A225C211D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD061991D4;
	Fri, 11 Jul 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbtmI+4T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81A195B1A;
	Fri, 11 Jul 2025 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203450; cv=none; b=dxixJFjY9nRqj/gK31hJXH3z4N0o+CDu06VGQmVkBYJt24RUuc8gRw4OZNiLR+HxXJbFAtnIoEp+bmjra0ZURlKozGEWUH7C5U0SrX2ScZxukrr5g1ka3cdzjskP1nWIAYBG4CGNyvqdFXExwr2lycxR1K/XcWqLhbXyoXjpT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203450; c=relaxed/simple;
	bh=L63yaiPGvJ249Id/2RRbHTTI3GJEvsSTxsPiKmpWjPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9ZIVRL7aAv90orAA/WerDtHZ+5uSRDUWbbAOGBWyunvyN6qjwlVyk30oMe24maOL8sb1dbO/M8h/DIYMHliuE56yhOsIOMjohSaQZRoJab0BTE3prqGxeczHz0VH42C+HPdhN9pHf5fXrWi3jN13yK8E0qNZXSdZZaBFPrZEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbtmI+4T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752203448; x=1783739448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L63yaiPGvJ249Id/2RRbHTTI3GJEvsSTxsPiKmpWjPM=;
  b=hbtmI+4TVlHVTwd5TKmHpRi/YGIcHYrygR7nhkTVwvUO/gx1c7K7lEj/
   X6iM7wmEyC4F0Sp2gAztShsNU4wkWjQaNds37L4Gcu7Fpgd7AF11G4Mil
   MaPcjatWT2Z6OZ3FZrWyVyt0pSZfrAsOkhw1xZM49itWH9X/bmlBWVRF7
   S6rn1UOjIP3/195h6YsPYVpqO/IbYubIGm0kM6mBGNsZGZL07AoYKqq8i
   8vmeq/E53sysVde16wL48MRxRg/MamdPOXzZJLR1rV60mcD6zts3MRE0O
   evPI1ou7hBJgvWJh90eLfnFPozKrIGCnMIQmzyRIxVo64AODv6W3xKhIm
   Q==;
X-CSE-ConnectionGUID: acAr4UO3QIaU5LqxGaZ4CA==
X-CSE-MsgGUID: 931CjZoRRBue9xwd1eD31w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="42129636"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="42129636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:10:48 -0700
X-CSE-ConnectionGUID: nDP+ywDzQuySZNBwEIv3mQ==
X-CSE-MsgGUID: NHeP0DHvRL6QFpIo7d1iqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155675431"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:10:43 -0700
Message-ID: <e00587f2-ebfa-436b-a17a-198ff9c02f4a@linux.intel.com>
Date: Fri, 11 Jul 2025 11:09:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250710155319.GK1613633@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 23:53, Peter Zijlstra wrote:
> On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:
> 
>>> @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>>   	if (ret)
>>>   		goto out_free_domain;
>>>   	domain->users = 1;
>>> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>>>   
>>> +	if (list_empty(&iommu_mm->sva_domains)) {
>>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>>> +			if (list_empty(&iommu_sva_mms))
>>> +				static_branch_enable(&iommu_sva_present);
>>> +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
>>> +		}
>>> +	}
>>> +	list_add(&domain->next, &iommu_mm->sva_domains);
>>>   out:
>>>   	refcount_set(&handle->users, 1);
>>>   	mutex_unlock(&iommu_sva_lock);
>>> @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>>   		list_del(&domain->next);
>>>   		iommu_domain_free(domain);
>>>   	}
>>> +
>>> +	if (list_empty(&iommu_mm->sva_domains)) {
>>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>>> +			list_del(&iommu_mm->mm_list_elm);
>>> +			if (list_empty(&iommu_sva_mms))
>>> +				static_branch_disable(&iommu_sva_present);
>>> +		}
>>> +	}
>>> +
>>>   	mutex_unlock(&iommu_sva_lock);
>>>   	kfree(handle);
>>>   }
>>
>> This seems an odd coding style choice; why the extra unneeded
>> indentation? That is, what's wrong with:
>>
>> 	if (list_empty()) {
>> 		guard(spinlock_irqsave)(&iommu_mms_lock);
>> 		list_del();
>> 		if (list_empty()
>> 			static_branch_disable();
>> 	}
> 
> Well, for one, you can't do static_branch_{en,dis}able() from atomic
> context...
> 
> Was this ever tested?

I conducted unit tests for vmalloc()/vfree() scenarios, and Yi performed
fuzzing tests. We have not observed any warning messages. Perhaps
static_branch_disable() is not triggered in the test cases?

Thanks,
baolu

