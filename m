Return-Path: <stable+bounces-112264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB2A281C8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AC51885201
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7520DD65;
	Wed,  5 Feb 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv9PqMmX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841C20C47E;
	Wed,  5 Feb 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722522; cv=none; b=pbDw6fRUkROi9HMshjXzI/L2PeIlpDpJMV/Q6sZ5q1HBeyNFEYeAOwCnNw+2Gp2pdzSedZcuwazvsBB6y5y24AeqafjaSzGnz4nwXLBH+UI/eAYd/9OirAH1tUhUNGmjKRgMsx75I6mVBO8awsmZ+vNDMBEE+Sp3oYiOBz7Xoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722522; c=relaxed/simple;
	bh=Xk8RR9GftsHj4y0HQNqLNT78o3cejeCFocN4ysQOLqQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ks7J6YFL7XSX/LI8GqgBUQ5z8FELYWd/egBAmBTfuGXrHEbXfqrfRRYQp9yI/lxsMzZQACZcUhE6u4UjAy12dc4zQZsPXHWwNdXIR1aAzoRwvLSSbAFVBILrQM0gJkuaT9Cb38SPnuaC+At6dVb5qIyO7rjCBHntmc6vyxGlH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv9PqMmX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738722521; x=1770258521;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xk8RR9GftsHj4y0HQNqLNT78o3cejeCFocN4ysQOLqQ=;
  b=Pv9PqMmXgKHSWNUSntxBwjs93kLSFhXcTIQF1nkGbSQ7fsZrch4bOHH3
   Gr9bwrKvg+RfQ/6GIt3F2aaSbLYsjs2zNqQfi0P0qB8aICYtDdHhJmRSn
   ZOSd79dbNqDueXccJebmvSP9r8iXCrueyPK/HDBvSlCg4CGcJyN+Yuj/A
   TBIul4po09EbscmXqQhjzuk6Iq8yq4jUWpup3Xy9I4lMSk8xHh5E7j7Pv
   JLv5k4ZzG3egrOjEkO8xy0yVhQWfrVoAeM3QHQdyXYnIAzexlHDwx+1hu
   ihspGe9Kii8t0RDb6j6A2YizCrALWKNOzmtL3LwXAFUJux788z2RAi+ZE
   g==;
X-CSE-ConnectionGUID: ctMCfK/2TwCY0woUqUE8Vg==
X-CSE-MsgGUID: 8YNB5lMpTw2Y/ozIIRvlnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39380945"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39380945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:28:40 -0800
X-CSE-ConnectionGUID: c0apBYhbSOSFXVZwC1lGnQ==
X-CSE-MsgGUID: U+8h4zgnRyuh/QffODtlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134012636"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.242.149]) ([10.124.242.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:28:37 -0800
Message-ID: <941d401c-c009-4dcf-bb93-00c25490dd38@linux.intel.com>
Date: Wed, 5 Feb 2025 10:28:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq()
 cover faults for RID
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>
References: <20250121023150.815972-1-baolu.lu@linux.intel.com>
 <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3cca401b-e274-471b-8910-bb30873ead1b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/1/21 15:01, Yi Liu wrote:
> On 2025/1/21 10:31, Lu Baolu wrote:
>> This driver supports page faults on PCI RID since commit <9f831c16c69e>
>> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
>> allowing the reporting of page faults with the pasid_present field 
>> cleared
>> to the upper layer for further handling. The fundamental assumption here
>> is that the detach or replace operations act as a fence for page faults.
>> This implies that all pending page faults associated with a specific RID
>> or PASID are flushed when a domain is detached or replaced from a device
>> RID or PASID.
>>
>> However, the intel_iommu_drain_pasid_prq() helper does not correctly
>> handle faults for RID. This leads to faults potentially remaining pending
>> in the iommu hardware queue even after the domain is detached, thereby
>> violating the aforementioned assumption.
>>
>> Fix this issue by extending intel_iommu_drain_pasid_prq() to cover faults
>> for RID.
>>
>> Fixes: 9f831c16c69e ("iommu/vt-d: Remove the pasid present check in 
>> prq_event_thread")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/intel/prq.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Change log:
>> v2:
>>   - Add check on page faults targeting RID.
>>
>> v1: https://lore.kernel.org/linux-iommu/20250120080144.810455-1- 
>> baolu.lu@linux.intel.com/
>>
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index c2d792db52c3..064194399b38 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, 
>> u32 pasid)
>>           struct page_req_dsc *req;
>>           req = &iommu->prq[head / sizeof(*req)];
>> -        if (!req->pasid_present || req->pasid != pasid) {
>> +        if (req->rid != sid ||
> 
> Does intel-iommu driver managed pasid per-bdf? or global? If the prior one,
> the rid check is needed even in the old time that does not PRIs in the RID
> path.

Do you mean that this fix should be back ported farther than the fix tag
commit?

The iommu driver doesn't manage the PASID. IOMMUFD and SVA do actually.
The SVA uses global PASID. IOMMUFD doesn't yet support PASIDs, pending
the merging of your patches. Therefore, per-BDF PASID management is not
currently implemented in the Linux tree. Anything I overlooked?

---
baolu

