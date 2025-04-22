Return-Path: <stable+bounces-135143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEBA96F3A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A833188C8D3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D567DA66;
	Tue, 22 Apr 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K82VEGXY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEA14EC46;
	Tue, 22 Apr 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333191; cv=none; b=q/pUFAAET1SqCK1Sm3+n2h24Fp8kCTrDPeTIawUGOyZHuc7LU0n30rQchaGS00kfkaFWUOe21oQM6yN2HdjMIWUXqLMY9bzJrCTQvxvx2rZ/6HyTztl5COs/LDLfIfhsfs8tJbrblo7B3eHJ/0uGK3Yc6XA3KLthOOcMQ9pe7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333191; c=relaxed/simple;
	bh=4ZOxOHGaYZ7XnNdBiJCPQxJUvP74KyPgI+gTEuJB1zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRYmGagqL3EWWDGGpktph8D+dVXzT05UC91meFgu/uscS4w2ZlKtoqibMp8SQYPdUQ9x3tL2/u2kaMjENYqDIKzyrCEVWawyCh02geEhq9oWVCCt229Vl9KlW+kLinCXLvhU8BVuUEYYip9O3s8bPG9mzZhnS9ELLyfPi+ekBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K82VEGXY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745333190; x=1776869190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ZOxOHGaYZ7XnNdBiJCPQxJUvP74KyPgI+gTEuJB1zQ=;
  b=K82VEGXYLxU3g8Q/vA9sqXdLhqOoivm7AnMnA3UPC6C1ARSEtNp3jMlB
   VBJ40u4O1DBP9Q0Dn97kV1XbHWxgeTAbHGfTgkElUQRuNmHSWY/In4feh
   5X3zLl9SSlbU84DW6+GyFslp0rzKSI21EmOIRht/TkyWZjZRwh7Z0b4c7
   d+dj9rxz5yuXH0vuEuwm/fMC1s9hqLdVnyWCxSVm8a6mWsk4+cqJ7UOxO
   8B1gcG/5nPlyPRwUE1LlpppIXBe24piNlmOvpHx8rETCJ6FupeIg3XU/s
   5WvBMsnEtmZg2m1KIhESUwbvHVRUcUwnWFpUvZ/3JW0LGbeJZNmi3SPIZ
   g==;
X-CSE-ConnectionGUID: aCg9K9JsQXKgdiaYiwfqkA==
X-CSE-MsgGUID: 8+52QV0wSAK03JCNNwxnoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57086522"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57086522"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 07:46:30 -0700
X-CSE-ConnectionGUID: ZZQ3jrKsQ5akuS+ddnGxrA==
X-CSE-MsgGUID: PtZkqb46R2eCWWoIkHHL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="163085646"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.111.159]) ([10.125.111.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 07:46:28 -0700
Message-ID: <9dda1860-2919-434b-9d85-71b79296f1f2@intel.com>
Date: Tue, 22 Apr 2025 07:46:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity
 domain
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 12:54 AM, Lu Baolu wrote:
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
> 
>         if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>                 return -EINVAL;
> 
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
> 
> Fix this by specifying the domain owner for the static identity domain.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..63c9c97ccf69 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
>  		.attach_dev	= identity_domain_attach_dev,
>  		.set_dev_pasid	= identity_domain_set_dev_pasid,
>  	},
> +	.owner = &intel_iommu_ops,
>  };
>  
>  const struct iommu_ops intel_iommu_ops = {


