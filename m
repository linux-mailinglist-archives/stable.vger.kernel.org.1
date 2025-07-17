Return-Path: <stable+bounces-163211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51811B0829C
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 03:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481B63B07E6
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CAFBF0;
	Thu, 17 Jul 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxlbOOzM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00819597F;
	Thu, 17 Jul 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716991; cv=none; b=Ot1up3uWj/JzoxkorqEUP2duU92xtKF33AJeIrSGgMKYBN16se3L1az/7Cp1TlyUe/fRlL5zsWBDeUxtVJgR0tZoBmhjyNOnGFdV7zmVlDxBltY2L2E9y1hsf4qKOCYOPgIo342atDrQ1tqHmdOgT1kp61LvkyoiJOiin1vlDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716991; c=relaxed/simple;
	bh=eAkyQhOyPhw7BLN3o+9XWHxqhchLNhKu0wZLeZ+xjC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ59TbEZUeHCggbqGpYjweknpvhyRKc/hwUDI8eRLJmoQDgvoK2Z0NfEPe5Au9dTfT2Ur1BDs/gjjQyhql2NAqYc8ajp9tosnXG7dr4kyYQ4Bp+YidQ1qn4LdfazqM5kTZcqX6szOxGNTE/Vnv7EKYdrZS34A0cg64HNbHDE/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxlbOOzM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752716990; x=1784252990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eAkyQhOyPhw7BLN3o+9XWHxqhchLNhKu0wZLeZ+xjC4=;
  b=FxlbOOzMRbTNjVI5X7ecHm6sqzu0BxK34m5kdf97lBpgLcZGKBwFD96R
   BsP5bqFRr/DzYIxnfibsmdIrkbWEitkQtTjyuUz5pgf8/lsP/sW4vRn+4
   soEGN9hsX0Kl7FL3qZTtHSYSfk6+1cvk397sgzKRNW8QztHg14vKINYTz
   RvmfSBUO8yEsQqXN7lJUGHmuv0VjFg/Q2fH0FvmjP360lnrkL43KzmBMg
   YiYaGgVKjJB3YDwQvpckn3k2uWB1Cml5hoX/nJN50R8Rsxlhk6Ef3IfIm
   0hxzJ6KjR2WDDuj7r4NL7rYJLvP6tAvOZeT8inZnlY1mE+RzlD8Z2fI9g
   A==;
X-CSE-ConnectionGUID: I6EknQSiTvSk8lsRP0wvzQ==
X-CSE-MsgGUID: e1ylIafpQAaoJH6ECmYrIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72546673"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="72546673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:49:49 -0700
X-CSE-ConnectionGUID: kq5cbfU1QmKl0pu+6mUnXA==
X-CSE-MsgGUID: tC5/M5KKReCe0iYKi2flUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="158367440"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:49:45 -0700
Message-ID: <a5840f8c-26e6-4aab-9f24-02f9b28177b8@linux.intel.com>
Date: Thu, 17 Jul 2025 09:47:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: David Laight <david.laight.linux@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
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
 <20250716125725.37aa3f38@pumpkin>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250716125725.37aa3f38@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 19:57, David Laight wrote:
> On Thu, 10 Jul 2025 17:53:19 +0200
> Peter Zijlstra<peterz@infradead.org> wrote:
> 
>> On Thu, Jul 10, 2025 at 03:54:32PM +0200, Peter Zijlstra wrote:
>>
>>>> @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>>>   	if (ret)
>>>>   		goto out_free_domain;
>>>>   	domain->users = 1;
>>>> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>>>>   
>>>> +	if (list_empty(&iommu_mm->sva_domains)) {
>>>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>>>> +			if (list_empty(&iommu_sva_mms))
>>>> +				static_branch_enable(&iommu_sva_present);
>>>> +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
>>>> +		}
>>>> +	}
>>>> +	list_add(&domain->next, &iommu_mm->sva_domains);
>>>>   out:
>>>>   	refcount_set(&handle->users, 1);
>>>>   	mutex_unlock(&iommu_sva_lock);
>>>> @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>>>   		list_del(&domain->next);
>>>>   		iommu_domain_free(domain);
>>>>   	}
>>>> +
>>>> +	if (list_empty(&iommu_mm->sva_domains)) {
>>>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>>>> +			list_del(&iommu_mm->mm_list_elm);
>>>> +			if (list_empty(&iommu_sva_mms))
>>>> +				static_branch_disable(&iommu_sva_present);
>>>> +		}
>>>> +	}
>>>> +
>>>>   	mutex_unlock(&iommu_sva_lock);
>>>>   	kfree(handle);
>>>>   }
>>> This seems an odd coding style choice; why the extra unneeded
>>> indentation? That is, what's wrong with:
>>>
>>> 	if (list_empty()) {
>>> 		guard(spinlock_irqsave)(&iommu_mms_lock);
>>> 		list_del();
>>> 		if (list_empty()
>>> 			static_branch_disable();
>>> 	}
>> Well, for one, you can't do static_branch_{en,dis}able() from atomic
>> context...
> Aren't they also somewhat expensive - so you really want to use them
> for configuration options which pretty much don't change.

Yeah! Fair enough.

Thanks,
baolu

