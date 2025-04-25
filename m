Return-Path: <stable+bounces-136647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DCA9BC16
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 03:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F9E3B031C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0419BBC;
	Fri, 25 Apr 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daBcB89E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3517BD3;
	Fri, 25 Apr 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542863; cv=none; b=ZaIWCISBOhfyk9+6Wxh7hu0qR8OY0JvKT06ofYlxUXjGlD2muq0hfUuKgj095+YyiHgpbq7oNOa5v2SSpd8ykS0OVHDdwGDdppPcFMVmBVsWyY+xt7k3uqF+CDwISP9BezAawn8sxWzs1a1LLFTiGcJlA30qqMkdr7Wh1Z/wizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542863; c=relaxed/simple;
	bh=3NBBCGeKr2m5IBaqIkjQPLgZ1gmvbV+miikL5I2UHb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqQN/wTMMcH89uLMZSqr4IV3Xvyt2xfBJqxgmm8D5yaED6xrdSnvsoEXUVPC0CG1Tnj/vpnfQbGSx6vN24fkz8YyKCAfz/XyL1i9eJvK1AOjKkCJfH4hM7QtDfyuJXHAHAqnnsj7DvEZZqiQdmiaqbguYm1gQ+wMshbkEkPTSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daBcB89E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745542863; x=1777078863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3NBBCGeKr2m5IBaqIkjQPLgZ1gmvbV+miikL5I2UHb0=;
  b=daBcB89Evau0SLmPlPDp0xqFaOCXDwhq0DB+Vn/dA5QYL/HWrIZ9BdS+
   Y2Kx8G0vXwdiT2Mz98bBXhfTq+9HsCzX/c9em2T3sBmVkELrqoUwJ9xxx
   Fn135fDkb3cywYZC7vW5wEu7nE13LAWtuODtEM73q6ITx5uQM1nYG2ZuJ
   ax7sYr3QdpwgNbONq/0FANUaKucKGnxeJvhoJFePUWd1rTG/KsOZezO1q
   7YM+7jZaWhrD8Z6LtECnLlI3kVlVz3VHM/PBzu8V4KIsyoOQcIBApu20l
   ZTL7xvI8rk8z6QAESnfBNr3xOOfPgb/laFgafUrP0wNs/3TqBMhxNVesQ
   w==;
X-CSE-ConnectionGUID: NskdFmtoTOWJW217aaceDA==
X-CSE-MsgGUID: W9h6q9TOSOKyT7wzkiBRdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58187333"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="58187333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 18:01:02 -0700
X-CSE-ConnectionGUID: zYinjX53Rq2xK987hBUNDA==
X-CSE-MsgGUID: s5TphgHrQyuN1UkyCzHYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="163827607"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.108.124]) ([10.125.108.124])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 18:01:00 -0700
Message-ID: <bf3e0b9b-1cf5-4ee5-8487-46851a84230d@intel.com>
Date: Thu, 24 Apr 2025 18:00:58 -0700
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
 <9b67710b-07bf-4c18-824a-27bc5df4fdfa@intel.com>
 <C85B4AA4-793D-45CA-915A-4C7F4FB4CA64@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <C85B4AA4-793D-45CA-915A-4C7F4FB4CA64@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/24/25 5:55 PM, Jack Vogel wrote:
> 
> 
>> On Apr 24, 2025, at 16:15, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 4/24/25 3:59 PM, Jack Vogel wrote:
>>>
>>>
>>>> On Apr 24, 2025, at 15:40, Dave Jiang <dave.jiang@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/24/25 3:34 PM, Jack Vogel wrote:
>>>>> I am having test issues with this patch, test system is running OL9, basically RHEL 9.5, the kernel boots ok, and the dmesg is clean… but the tests in accel-config dont pass. Specifically the crypto tests, this is due to vfio_pci_core not loading.  Right now I’m not sure if any of this is my mistake, but at least it’s something I need to keep looking at.
>>>>>
>>>>> Also, since I saw that issue on the latest I did a backport to our UEK8 kernel which is 6.12.23, and on that kernel it still exhibited  these messages on boot:
>>>>>
>>>>> *idxd*0000:6a:01.0: enabling device (0144 -> 0146)
>>>>>
>>>>> [   21.112733] *idxd*0000:6a:01.0: failed to attach device pasid 1, domain type 4
>>>>>
>>>>> [   21.120770] *idxd*0000:6a:01.0: No in-kernel DMA with PASID. -95
>>>>>
>>>>>
>>>>> Again, maybe an issue in my backporting… however I’d like to be sure.
>>>>
>>>> Can you verify against latest upstream kernel plus the patch and see if you still see the error?
>>>>
>>>> DJ
>>>
>>> Yes, the kernel was build from the tip this morning. Like I said, it got no messages booting up, all looked fine. But when running the actual test suite in the accel-config tarball specifically the iaa crypt tests, they failed and the dmesg was from vfio_pci_core failed to load with an unknown symbol.
>>
>> I'm not sure what the test consists of (haven't worked on this device for almost 2 years). But usually the device is either bound to the idxd driver or the vfio_pci driver. Not both. And if the idxd driver didn't emit any errors while loading, then the test failure may be something else...
>>
>> Another way to verify is to set CONFIG_IOMMU_DEFAULT_DMA_LAZY vs PASSTHROUGH. If the tests still fail then it's something else. 
>>
>> DJ
> 
> There isn’t a lot of ways to test this driver, yes DPDK will use it, but apart from that? So, the tests that are part of your (Intel) accel-config package are the only convenient way that I’ve found to do so. It is also convenient, there is a “make check” target in the top Makefile that will invoke both set of DMA tests, and some crypto (IAA) tests. I have been planning to give this to our QA group as a verification suite. Do you have an alternative to this?

This should be the right test package. Let me talk to our QA people and see if there are any issues. We can resolve this off list. If there's any issues that end up pointing to the original bug, we can raise that then. 

DJ

> 
> Jack
> 
>>
>>>
>>> This sounds like the module was wrong, but i would think it was installed with the v6.15 kernel….. 
>>>
>>> Jack
>>>
>>>>
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Jack
>>>>>
>>>>>
>>>>>> On Apr 23, 2025, at 20:41, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>>
>>>>>> The idxd driver attaches the default domain to a PASID of the device to
>>>>>> perform kernel DMA using that PASID. The domain is attached to the
>>>>>> device's PASID through iommu_attach_device_pasid(), which checks if the
>>>>>> domain->owner matches the iommu_ops retrieved from the device. If they
>>>>>> do not match, it returns a failure.
>>>>>>
>>>>>>        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>>>>>                return -EINVAL;
>>>>>>
>>>>>> The static identity domain implemented by the intel iommu driver doesn't
>>>>>> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
>>>>>> for the idxd driver if the device translation mode is set to passthrough.
>>>>>>
>>>>>> Generally the owner field of static domains are not set because they are
>>>>>> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
>>>>>> that checks if a domain is compatible with the device's iommu ops. This
>>>>>> helper explicitly allows the static blocked and identity domains associated
>>>>>> with the device's iommu_ops to be considered compatible.
>>>>>>
>>>>>> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
>>>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>>>> ---
>>>>>> drivers/iommu/iommu.c | 21 ++++++++++++++++++---
>>>>>> 1 file changed, 18 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> Change log:
>>>>>> v3:
>>>>>> - Convert all places checking domain->owner to the new helper.
>>>>>> v2: https://lore.kernel.org/linux-iommu/20250423021839.2189204-1-baolu.lu@linux.intel.com/
>>>>>> - Make the solution generic for all static domains as suggested by
>>>>>>   Jason.
>>>>>> v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/
>>>>>>
>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>> index 4f91a740c15f..b26fc3ed9f01 100644
>>>>>> --- a/drivers/iommu/iommu.c
>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>> @@ -2204,6 +2204,19 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
>>>>>> return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>>>>>> }
>>>>>>
>>>>>> +static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
>>>>>> +struct iommu_domain *domain)
>>>>>> +{
>>>>>> +if (domain->owner == ops)
>>>>>> +return true;
>>>>>> +
>>>>>> +/* For static domains, owner isn't set. */
>>>>>> +if (domain == ops->blocked_domain || domain == ops->identity_domain)
>>>>>> +return true;
>>>>>> +
>>>>>> +return false;
>>>>>> +}
>>>>>> +
>>>>>> static int __iommu_attach_group(struct iommu_domain *domain,
>>>>>> struct iommu_group *group)
>>>>>> {
>>>>>> @@ -2214,7 +2227,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>>>>>> return -EBUSY;
>>>>>>
>>>>>> dev = iommu_group_first_dev(group);
>>>>>> -if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>>>>>> +if (!dev_has_iommu(dev) ||
>>>>>> +   !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
>>>>>> return -EINVAL;
>>>>>>
>>>>>> return __iommu_group_set_domain(group, domain);
>>>>>> @@ -3435,7 +3449,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>>>>>    !ops->blocked_domain->ops->set_dev_pasid)
>>>>>> return -EOPNOTSUPP;
>>>>>>
>>>>>> -if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>>>>> +if (!domain_iommu_ops_compatible(ops, domain) ||
>>>>>> +   pasid == IOMMU_NO_PASID)
>>>>>> return -EINVAL;
>>>>>>
>>>>>> mutex_lock(&group->mutex);
>>>>>> @@ -3511,7 +3526,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>>>> if (!domain->ops->set_dev_pasid)
>>>>>> return -EOPNOTSUPP;
>>>>>>
>>>>>> -if (dev_iommu_ops(dev) != domain->owner ||
>>>>>> +if (!domain_iommu_ops_compatible(dev_iommu_ops(dev), domain) ||
>>>>>>    pasid == IOMMU_NO_PASID || !handle)
>>>>>> return -EINVAL;
>>>>>>
>>>>>> -- 
>>>>>> 2.43.0
> 


