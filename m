Return-Path: <stable+bounces-135220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C4A97BFD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 03:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B63B7B6A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09547257AFB;
	Wed, 23 Apr 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCPD8f5e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBA1FF1B3;
	Wed, 23 Apr 2025 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370391; cv=none; b=tZM9gpGYlTg6f/UTZCdgvMGQ/eMKfGH4BtTyHyymDWosQ4pntU6BOmqBN4rbk6GHiRCTOTHefPHFOZbOFyPESn/53yix0MlL1w0UWLDnu57yeMNRX2JCgogHbPaGBItl96LRxl7GJgUTwc/0VTDNVPZBjfkeZ8bXcWysZJizOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370391; c=relaxed/simple;
	bh=5FL00H151L5Z3QgWwRdWFf/PgsMBwrntLP30xruLvhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQUXqdckxcFpRmFnfFa4v/Te9smnawxzYAV3FEOnItNhPZ6YrJA2WoLMA8BpNy3P8DkbALUtigKI7rsADMlKm/rHOvMjvS8jlDXQ9nMczinMOsodx+e1FpcmTbLxZ4+iGqPyBwq5y3tM6MKZyJ59DSOm0Qz+ihQd1h3iHKQ4Oak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCPD8f5e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745370389; x=1776906389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5FL00H151L5Z3QgWwRdWFf/PgsMBwrntLP30xruLvhQ=;
  b=kCPD8f5eQMKCGZkQ5ZFSCfQZo/f/FNinJfvQrfrYSxH2JJmwItg1eHa6
   I+XDdbJXuDJu4ES0RKIBlfMKiTYkVtFuKnyMajMssmjIjjhg+swXq96OK
   901UVJXgx1Jb7kXA9I7+JPM45j1hFu3S+tvDybvDsZY32hUYT+f6A3ASN
   dUG5HzLG+IU4g4kwHs0fvEeBJKGRltcgrtyAur3CHspO4qI8QFzQFj/gx
   fjA1Df2jt+BO2zn/lByMUxiiy2I2JVKOYKY54EGNYAifBufErNoqqX5Cp
   LVYLy+gR7IMYidB3pA2nCjwm0CmAqcevJ4QpOJgqG3OF3m5l3EMJKqYn7
   Q==;
X-CSE-ConnectionGUID: M5XHa37JTkCmsCrxzJyTzQ==
X-CSE-MsgGUID: IwBrxVksREet+KNYRydgsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46183887"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46183887"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 18:06:29 -0700
X-CSE-ConnectionGUID: MiTI0MmMREeviwNkeKd8Hg==
X-CSE-MsgGUID: jiVYuWdISJWYw27G/O6x+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132699785"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 18:06:27 -0700
Message-ID: <6ff1216d-ef10-4948-a2e7-6c66627a024e@linux.intel.com>
Date: Wed, 23 Apr 2025 09:02:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity
 domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 shangsong2@lenovo.com, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
 <20250422191554.GC1213339@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250422191554.GC1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 03:15, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2025 at 03:54:22PM +0800, Lu Baolu wrote:
> 
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cb0b993bebb4..63c9c97ccf69 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
>>   		.attach_dev	= identity_domain_attach_dev,
>>   		.set_dev_pasid	= identity_domain_set_dev_pasid,
>>   	},
>> +	.owner = &intel_iommu_ops,
>>   };
> 
> Is this a systemic mistake in all the static domains in all the
> drivers?

Yes. The owner field is not set for all static domains.

> Maybe a bigger check is a more complete fix:
> 
> static bool iommu_domain_compatible(struct device *dev,
> 				    struct iommu_domain *domain)
> {
> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 
> 	if (domain->owner == ops)
> 		return true;
> 
> 	/* For static domains owner isn't set */
> 	if (ops->blocked_domain == domain || ops->identity_domain == domain)
> 		return true;
> 	return false;
> }

That's better. I will post a v2 accordingly.

> Jason

Thanks,
baolu


