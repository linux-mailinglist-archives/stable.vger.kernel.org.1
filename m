Return-Path: <stable+bounces-136522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DAA9A2BC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191545A006E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC21E9B00;
	Thu, 24 Apr 2025 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeFVrQl/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEE1E7640;
	Thu, 24 Apr 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477944; cv=none; b=lVf6GsehSdEq0hOifRtg0C3HnHrlPXKRJfXwezSe+WzIzfJ3s3RpI5rK7IZDQAUegANNIraD5zgdtgZpkY8QcTYp6gt+438jga0UgLfuEO7i8gqrWMapGwbBvDlFktXtTeY8HUAu1KDAL+wXnyIAmRU9XEqFdP2emyFtj5FFSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477944; c=relaxed/simple;
	bh=P7a4A6x8UFXBNfXVk8wNvjijk3FZSS3WNYjyXXXW3OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnCHmVA16Ylgu4uwaPiMNTdu6DQG2BCSpJd/muYz1HOqxt2RIEyeDPIa8zlqHTEMOPsQ9Y94nNlVwIzdo5L223z2Dq6VuD3+zaGqgoRsrDlfMp32Exw0TcrieLsSwWJcrTf2HMqid1dtMoxGJVNXfAW17xFaWyQZhqgXhgJ7iV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeFVrQl/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745477941; x=1777013941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P7a4A6x8UFXBNfXVk8wNvjijk3FZSS3WNYjyXXXW3OA=;
  b=MeFVrQl/CBD/6DDvQ2abVXrUzELFSLCqL7AMjxtxzcLTdoJi/9bAU2ck
   5/V2wkiEUs6TJhsqEa0ZM0pxe77kkMjHNGjGNFRh5Zyoyp5vr7rLW1K4d
   3gPG0jCT3u2WIdwDu0aLWnFotIwuV/jXDqCSI35stgjjdjlz3QxKZykee
   KU4cytAE2oRgzK08Jk1f1zTx5u9Pw/LMN4Q9oWL6UQMZYR54BImvsvH+5
   bCHMyxqB5XTczr8XCcFYgBuRpwrECG0pPeN2HACmzSkDXvf80wAWxJo45
   xhbnv+05Tz/jqMdqpDT9BPb1bk3RVwum+q8fH+8kZq4P1tpRsux5JWGno
   Q==;
X-CSE-ConnectionGUID: SD02WUxbSGOsWWgs418g/w==
X-CSE-MsgGUID: QtDYO+qLQhWfSQrgNyk8gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58456014"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="58456014"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 23:59:01 -0700
X-CSE-ConnectionGUID: VmXw7/jDQp66g53tf+kJnQ==
X-CSE-MsgGUID: QXeoSsyqQLupGp8r9+9qlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137323854"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 23:58:59 -0700
Message-ID: <c6f5e533-5e60-494c-93fd-5a004a9a13a0@linux.intel.com>
Date: Thu, 24 Apr 2025 14:54:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 shangsong2@lenovo.com, Dave Jiang <dave.jiang@intel.com>
Cc: jack.vogel@oracle.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
 <6cee67bd-1bef-4b8c-96bb-da358bc2d5c3@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6cee67bd-1bef-4b8c-96bb-da358bc2d5c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/25 14:49, Vasant Hegde wrote:
> On 4/24/2025 9:11 AM, Lu Baolu wrote:
>> The idxd driver attaches the default domain to a PASID of the device to
>> perform kernel DMA using that PASID. The domain is attached to the
>> device's PASID through iommu_attach_device_pasid(), which checks if the
>> domain->owner matches the iommu_ops retrieved from the device. If they
>> do not match, it returns a failure.
>>
>>          if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>>                  return -EINVAL;
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
>> Closes:https://bugzilla.kernel.org/show_bug.cgi?id=220031
>> Cc:stable@vger.kernel.org
>> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
>> Link:https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Dave Jiang<dave.jiang@intel.com>
>> Reviewed-by: Robin Murphy<robin.murphy@arm.com>
> 
> Thanks! We have static identity domain in AMD driver as well. Some day we may
> hit similar issue 🙂
> 
> Patch looks good to me.
> 
> Reviewed-by: Vasant Hegde<vasant.hegde@amd.com>

Thank you!

> 
> W/ this change may be I should fix AMD driver like below. (No need to respin
> patch. I can send topup patch later).

I think that's a cleanup rather than a fix.

Thanks,
baolu

