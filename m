Return-Path: <stable+bounces-136631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342CA9BB1F
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FBA4A7F24
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF69A221FD5;
	Thu, 24 Apr 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWbAQA2t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986219F471;
	Thu, 24 Apr 2025 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536526; cv=none; b=cVLp7GRxfvbjajnp3qwppS1EtOt5kc7P7eRdHOLr8N0NQ32IPIMWlwCFfPNgc2XbcXxpenYcFHr3VSlbfypoDwwEW/cexVPSLYCjGn+9LBrxjsFsAZffwdo+JN0/eJKRzj63qFddbcbNm1rf0zOOMDlKeJfszpYSplkxBbqm1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536526; c=relaxed/simple;
	bh=6SyhhketwlB5LMuLGRnQsF4PJvD9gPMv/t87N1ZYNXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bonBS6rH7Epix7TOZVFIqBYUva90+cE0X96Pg7vIh2YzgOIXkLhObT7jKc+I3NCDt3qEvXBplDhx3UriCQ382SOz14HOLpM6+NDm2pVCBa+T3+BjyMjusP1CO+7017K4KKinnGUIdujnmhPZ62TACPk0lI6e5VesaXAQfsnZbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWbAQA2t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745536525; x=1777072525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6SyhhketwlB5LMuLGRnQsF4PJvD9gPMv/t87N1ZYNXY=;
  b=bWbAQA2t0yO/XwPkDYUQeyQmdzqA6AZbgorJGYIozM9lz5XQ5fP0WNfO
   7GgYiY7EtpmgjgwASZH1AAvPq4KnxQiuaFmepabdoWt90AyL/mJvidKj0
   AMug2qGl4IgWpsz2mObQeVydmB7pfMY+J3TUehbIeXaEOzjaAYh9fTsfh
   Kp2VRDvhsahZ1cbMGxWpwcl+brMTTfD1jjLorfsjlOMdWrzEhjX+VA0E3
   bSyuuU0nQdJlXG5lmcphBOVLEPDWL/b2R8ZoFhhBXIW5rgoMv/FFbJ8Kz
   cVJZ7xYYoF0DQ4QdqfbgKkOS/0lau5384FUkz7HHBovCZKTvO04r3vWGH
   w==;
X-CSE-ConnectionGUID: 1rFlus4rRN+BhCrGZprsjA==
X-CSE-MsgGUID: lE2UG8j1S+KNk+NDWGi/XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57839050"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="57839050"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 16:15:24 -0700
X-CSE-ConnectionGUID: OD4g2ZjcSJ28xd+NZyNxRw==
X-CSE-MsgGUID: PB4TFZcqSRapbAKixOTmyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="163708209"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.108.124]) ([10.125.108.124])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 16:15:24 -0700
Message-ID: <9b67710b-07bf-4c18-824a-27bc5df4fdfa@intel.com>
Date: Thu, 24 Apr 2025 16:15:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Jack Vogel <jack.vogel@oracle.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "shangsong2@lenovo.com" <shangsong2@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
 <4764ACC2-6D38-4CAE-8A6B-451AB3DAF3E0@oracle.com>
 <a6e386bf-c9d4-4b3c-ad6e-dd1689330782@intel.com>
 <0A18D37F-7457-49CC-9D67-369A3A8C9E7E@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0A18D37F-7457-49CC-9D67-369A3A8C9E7E@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/24/25 3:59 PM, Jack Vogel wrote:
> 
> 
>> On Apr 24, 2025, at 15:40, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 4/24/25 3:34 PM, Jack Vogel wrote:
>>> I am having test issues with this patch, test system is running OL9, basically RHEL 9.5, the kernel boots ok, and the dmesg is clean… but the tests in accel-config dont pass. Specifically the crypto tests, this is due to vfio_pci_core not loading.  Right now I’m not sure if any of this is my mistake, but at least it’s something I need to keep looking at.
>>>
>>> Also, since I saw that issue on the latest I did a backport to our UEK8 kernel which is 6.12.23, and on that kernel it still exhibited  these messages on boot:
>>>
>>> *idxd*0000:6a:01.0: enabling device (0144 -> 0146)
>>>
>>> [   21.112733] *idxd*0000:6a:01.0: failed to attach device pasid 1, domain type 4
>>>
>>> [   21.120770] *idxd*0000:6a:01.0: No in-kernel DMA with PASID. -95
>>>
>>>
>>> Again, maybe an issue in my backporting… however I’d like to be sure.
>>
>> Can you verify against latest upstream kernel plus the patch and see if you still see the error?
>>
>> DJ
> 
> Yes, the kernel was build from the tip this morning. Like I said, it got no messages booting up, all looked fine. But when running the actual test suite in the accel-config tarball specifically the iaa crypt tests, they failed and the dmesg was from vfio_pci_core failed to load with an unknown symbol.

I'm not sure what the test consists of (haven't worked on this device for almost 2 years). But usually the device is either bound to the idxd driver or the vfio_pci driver. Not both. And if the idxd driver didn't emit any errors while loading, then the test failure may be something else...

Another way to verify is to set CONFIG_IOMMU_DEFAULT_DMA_LAZY vs PASSTHROUGH. If the tests still fail then it's something else. 

DJ

> 
> This sounds like the module was wrong, but i would think it was installed with the v6.15 kernel….. 
> 
> Jack
> 
>>
>>>
>>> Cheers,
>>>
>>> Jack
>>>
>>>
>>>> On Apr 23, 2025, at 20:41, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> The idxd driver attaches the default domain to a PASID of the device to
>>>> perform kernel DMA using that PASID. The domain is attached to the
>>>> device's PASID through iommu_attach_device_pasid(), which checks if the
>>>> domain->owner matches the iommu_ops retrieved from the device. If they
>>>> do not match, it returns a failure.
>>>>
>>>>        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>>>                return -EINVAL;
>>>>
>>>> The static identity domain implemented by the intel iommu driver doesn't
>>>> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
>>>> for the idxd driver if the device translation mode is set to passthrough.
>>>>
>>>> Generally the owner field of static domains are not set because they are
>>>> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
>>>> that checks if a domain is compatible with the device's iommu ops. This
>>>> helper explicitly allows the static blocked and identity domains associated
>>>> with the device's iommu_ops to be considered compatible.
>>>>
>>>> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>> drivers/iommu/iommu.c | 21 ++++++++++++++++++---
>>>> 1 file changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> Change log:
>>>> v3:
>>>> - Convert all places checking domain->owner to the new helper.
>>>> v2: https://lore.kernel.org/linux-iommu/20250423021839.2189204-1-baolu.lu@linux.intel.com/
>>>> - Make the solution generic for all static domains as suggested by
>>>>   Jason.
>>>> v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 4f91a740c15f..b26fc3ed9f01 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2204,6 +2204,19 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
>>>> return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>>>> }
>>>>
>>>> +static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
>>>> +struct iommu_domain *domain)
>>>> +{
>>>> +if (domain->owner == ops)
>>>> +return true;
>>>> +
>>>> +/* For static domains, owner isn't set. */
>>>> +if (domain == ops->blocked_domain || domain == ops->identity_domain)
>>>> +return true;
>>>> +
>>>> +return false;
>>>> +}
>>>> +
>>>> static int __iommu_attach_group(struct iommu_domain *domain,
>>>> struct iommu_group *group)
>>>> {
>>>> @@ -2214,7 +2227,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>>>> return -EBUSY;
>>>>
>>>> dev = iommu_group_first_dev(group);
>>>> -if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>>>> +if (!dev_has_iommu(dev) ||
>>>> +   !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
>>>> return -EINVAL;
>>>>
>>>> return __iommu_group_set_domain(group, domain);
>>>> @@ -3435,7 +3449,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>>>    !ops->blocked_domain->ops->set_dev_pasid)
>>>> return -EOPNOTSUPP;
>>>>
>>>> -if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>>> +if (!domain_iommu_ops_compatible(ops, domain) ||
>>>> +   pasid == IOMMU_NO_PASID)
>>>> return -EINVAL;
>>>>
>>>> mutex_lock(&group->mutex);
>>>> @@ -3511,7 +3526,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>> if (!domain->ops->set_dev_pasid)
>>>> return -EOPNOTSUPP;
>>>>
>>>> -if (dev_iommu_ops(dev) != domain->owner ||
>>>> +if (!domain_iommu_ops_compatible(dev_iommu_ops(dev), domain) ||
>>>>    pasid == IOMMU_NO_PASID || !handle)
>>>> return -EINVAL;
>>>>
>>>> -- 
>>>> 2.43.0
> 


