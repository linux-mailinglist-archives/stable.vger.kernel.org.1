Return-Path: <stable+bounces-136630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A927EA9BAE9
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325AA9A419D
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20268289342;
	Thu, 24 Apr 2025 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZmh21Gm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579C14E2E2;
	Thu, 24 Apr 2025 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534435; cv=none; b=MQTQvJyChBoiCmW1JDotdnuYfru7Jg9ckN97bO8Pr4cu4p3l+82bjxrMmHvGDhaW6PJQntWsUFTiPqnfGQRP23OtIMAlgHkxOb7GfTwSbrb6Q53d8jO9LoWwT/tGBa+mbc9UpXF8ik88LsoZeYsoQ7W4APpKuIHw0FkPq1R5i0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534435; c=relaxed/simple;
	bh=v5/+UAKc9qT69qSy9qPG/eu0NlxYHHKNbbJhCwkRNsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feswkFn+DWzbMjjYMYVdsc9IrJIWbMHBt/NZwVxRMG3KeqgidQzwsi3A/rcMUDy7rSA5p4PI+wB4c0eTfzQIK7zZkCogG/jlys4uU6j1XMdCoijuSoaIlsP4BJj0QfQFMmzll82wbDiBokBH97O6vvcDY1U3Viye6jtP58TBON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZmh21Gm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745534434; x=1777070434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v5/+UAKc9qT69qSy9qPG/eu0NlxYHHKNbbJhCwkRNsM=;
  b=iZmh21GmZzTJPSHtrqtqV/YVSjJFOpRN/4z96x+0xt5Dc4BQFngNVfM3
   RrvnxT3bZhrZmwe9dqp3eXEiYapotTP08eKIFBLlkppllmiOKuVD2iesS
   rUT6JvYtR4/07xbBaN4rUbaN2kpnHI4pgDjt2FkwHrgESJSALHZvMiLaJ
   Lc+2Bk6EmTG7eEFrr5u/nZQy616ldM3Q2TgFpNUv3/4WiRxFUUbXCZhcU
   RhGCjVynN6SgBOYC9EFHuyQBhOCzqqUmb+SzGnECN3KAhIv4F5MxvQLfP
   dy+VS7xwUVk/5NVb8cBIMokfkufs4cdzggAPFJ5dowAdAy7JCHLZtTBs8
   Q==;
X-CSE-ConnectionGUID: VL7W81txTHeYAU/lVYX3Kg==
X-CSE-MsgGUID: FJj/6U6aTWWvuCkiqQ1hNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47204980"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="47204980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 15:40:33 -0700
X-CSE-ConnectionGUID: 4TX2q2ACSeq1fI3IZjbhwg==
X-CSE-MsgGUID: /ZpJP2SFRXunevsJLKTCAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="132482508"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.108.124]) ([10.125.108.124])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 15:40:32 -0700
Message-ID: <a6e386bf-c9d4-4b3c-ad6e-dd1689330782@intel.com>
Date: Thu, 24 Apr 2025 15:40:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Jack Vogel <jack.vogel@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "shangsong2@lenovo.com" <shangsong2@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
 <4764ACC2-6D38-4CAE-8A6B-451AB3DAF3E0@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4764ACC2-6D38-4CAE-8A6B-451AB3DAF3E0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/24/25 3:34 PM, Jack Vogel wrote:
> I am having test issues with this patch, test system is running OL9, basically RHEL 9.5, the kernel boots ok, and the dmesg is clean… but the tests in accel-config dont pass. Specifically the crypto tests, this is due to vfio_pci_core not loading.  Right now I’m not sure if any of this is my mistake, but at least it’s something I need to keep looking at.
> 
> Also, since I saw that issue on the latest I did a backport to our UEK8 kernel which is 6.12.23, and on that kernel it still exhibited  these messages on boot:
> 
> *idxd*0000:6a:01.0: enabling device (0144 -> 0146)
> 
> [   21.112733] *idxd*0000:6a:01.0: failed to attach device pasid 1, domain type 4
> 
> [   21.120770] *idxd*0000:6a:01.0: No in-kernel DMA with PASID. -95
> 
> 
> Again, maybe an issue in my backporting… however I’d like to be sure.

Can you verify against latest upstream kernel plus the patch and see if you still see the error?

DJ

> 
> Cheers,
> 
> Jack
> 
> 
>> On Apr 23, 2025, at 20:41, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> The idxd driver attaches the default domain to a PASID of the device to
>> perform kernel DMA using that PASID. The domain is attached to the
>> device's PASID through iommu_attach_device_pasid(), which checks if the
>> domain->owner matches the iommu_ops retrieved from the device. If they
>> do not match, it returns a failure.
>>
>>        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>                return -EINVAL;
>>
>> The static identity domain implemented by the intel iommu driver doesn't
>> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
>> for the idxd driver if the device translation mode is set to passthrough.
>>
>> Generally the owner field of static domains are not set because they are
>> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
>> that checks if a domain is compatible with the device's iommu ops. This
>> helper explicitly allows the static blocked and identity domains associated
>> with the device's iommu_ops to be considered compatible.
>>
>> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
>> Cc: stable@vger.kernel.org
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> drivers/iommu/iommu.c | 21 ++++++++++++++++++---
>> 1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> Change log:
>> v3:
>> - Convert all places checking domain->owner to the new helper.
>> v2: https://lore.kernel.org/linux-iommu/20250423021839.2189204-1-baolu.lu@linux.intel.com/
>> - Make the solution generic for all static domains as suggested by
>>   Jason.
>> v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4f91a740c15f..b26fc3ed9f01 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2204,6 +2204,19 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
>> return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
>> }
>>
>> +static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
>> +struct iommu_domain *domain)
>> +{
>> +if (domain->owner == ops)
>> +return true;
>> +
>> +/* For static domains, owner isn't set. */
>> +if (domain == ops->blocked_domain || domain == ops->identity_domain)
>> +return true;
>> +
>> +return false;
>> +}
>> +
>> static int __iommu_attach_group(struct iommu_domain *domain,
>> struct iommu_group *group)
>> {
>> @@ -2214,7 +2227,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>> return -EBUSY;
>>
>> dev = iommu_group_first_dev(group);
>> -if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
>> +if (!dev_has_iommu(dev) ||
>> +   !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
>> return -EINVAL;
>>
>> return __iommu_group_set_domain(group, domain);
>> @@ -3435,7 +3449,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>    !ops->blocked_domain->ops->set_dev_pasid)
>> return -EOPNOTSUPP;
>>
>> -if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>> +if (!domain_iommu_ops_compatible(ops, domain) ||
>> +   pasid == IOMMU_NO_PASID)
>> return -EINVAL;
>>
>> mutex_lock(&group->mutex);
>> @@ -3511,7 +3526,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
>> if (!domain->ops->set_dev_pasid)
>> return -EOPNOTSUPP;
>>
>> -if (dev_iommu_ops(dev) != domain->owner ||
>> +if (!domain_iommu_ops_compatible(dev_iommu_ops(dev), domain) ||
>>    pasid == IOMMU_NO_PASID || !handle)
>> return -EINVAL;
>>
>> -- 
>> 2.43.0
>>
> 


