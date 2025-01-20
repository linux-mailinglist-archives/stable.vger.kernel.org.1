Return-Path: <stable+bounces-109504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73417A16A07
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9E33A3064
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C51AD403;
	Mon, 20 Jan 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+aQZ2CS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37618801A;
	Mon, 20 Jan 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366934; cv=none; b=dJRlv0YrX+j7irnepia+CJ9SvEzMo5wvcantJx6B1Z0WY6ws1hVyRQmDMqKY3LQ2oAlsDNKvA8KRzjh0SN0eEypM569ZJiKbie92TmgmWRt0BvNFvkBMqiLfBYtv302ju7Ve1IInYeJrWQOIRtGPNQYuthOXcgdqUzp88hb7CWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366934; c=relaxed/simple;
	bh=Ar0s3S+/G7GZxdK7Sqlra642dLMDXszVe/6GQA5xyGI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcsmdfC7OkADcagnmc6d4xSjQuOVZCxVRn9n26i3Vdcxoys3j9Le5BYTply8DvmJiZBhpX8MHNupPVGPANtRn6IIoN8wE7RzHmh/EtmBzWzRgKvtLBYJ8cTeSxTLe9V7CqH+h9mcT3bEdg9+Tgm/dwQRMmEiDlb52zY/bhZHfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+aQZ2CS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737366932; x=1768902932;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ar0s3S+/G7GZxdK7Sqlra642dLMDXszVe/6GQA5xyGI=;
  b=G+aQZ2CSZGRQBq5bVdkx/Zr0H32PYB8FoVxxtspNqwmJg5FZAMN+MXop
   nBDQ++dTcnZWOUIPaTRRo3CTvPP3koApq9hesa8NGGUSnaLIB95BvIheF
   D28Sb8NH7OcZ6eCNOj9RIcysXVP7o+AEpPow0s7iDzPWU6K912ZdSnUmu
   rlkCUz0CstMFe0EI0P17PvTiF2SG2KHsHXCE0au8Goe6ZBuIV4QpWBNv5
   u77Ju8kYyzoz4qGQkzzdbtVpxWwvQ6RQxxkyE8yR+TBn/Tu4rY2GSbm64
   kXLH14kfxm8C9lUhhbfck0E1klEChiPas95NhDxXuw/biMnnXiWNPpn0G
   Q==;
X-CSE-ConnectionGUID: X+f4iK/uQ4uE9MDb7Gbmgw==
X-CSE-MsgGUID: EmJ0c2mGSeijvQkMCVXDaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37904108"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37904108"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 01:55:21 -0800
X-CSE-ConnectionGUID: FE3aNI6aRii8xJ0YKo7J6g==
X-CSE-MsgGUID: dKPl5HXmSiGxrHiYL77IIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106468051"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.242.149]) ([10.124.242.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 01:55:19 -0800
Message-ID: <a58b8c10-2d7d-4b26-9e9b-fa0f1cb90d2e@linux.intel.com>
Date: Mon, 20 Jan 2025 17:54:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover
 faults for RID
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20250120080144.810455-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276B3F78599A00476AA2CDC8CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276B3F78599A00476AA2CDC8CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/1/20 17:26, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 20, 2025 4:02 PM
>>
>> This driver supports page faults on PCI RID since commit <9f831c16c69e>
>> ("iommu/vt-d: Remove the pasid present check in prq_event_thread") by
>> allowing the reporting of page faults with the pasid_present field cleared
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
>> ---
>>   drivers/iommu/intel/prq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index c2d792db52c3..043f02d7b460 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -87,7 +87,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev,
>> u32 pasid)
>>   		struct page_req_dsc *req;
>>
>>   		req = &iommu->prq[head / sizeof(*req)];
>> -		if (!req->pasid_present || req->pasid != pasid) {
>> +		if (req->rid != sid ||
>> +		    (req->pasid_present && req->pasid != pasid)) {
>>   			head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>   			continue;
>>   		}
> 
> Ah you'd also want to skip (!req->pasid_present &&
> pasid != IOMMU_NO_PASID)
> 

Yes. Will make it like this,

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index c2d792db52c3..064194399b38 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -87,7 +87,9 @@ void intel_iommu_drain_pasid_prq(struct device *dev, 
u32 pasid)
                 struct page_req_dsc *req;

                 req = &iommu->prq[head / sizeof(*req)];
-               if (!req->pasid_present || req->pasid != pasid) {
+               if (req->rid != sid ||
+                   (req->pasid_present && pasid != req->pasid) ||
+                   (!req->pasid_present && pasid != IOMMU_NO_PASID)) {
                         head = (head + sizeof(*req)) & PRQ_RING_MASK;
                         continue;
                 }

Thanks,
baolu

