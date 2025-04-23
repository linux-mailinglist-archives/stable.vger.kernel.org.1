Return-Path: <stable+bounces-135225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5EA97D0E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 04:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A4F3A92F1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5251E9917;
	Wed, 23 Apr 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9t6xX4A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C304A06;
	Wed, 23 Apr 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376782; cv=none; b=VylIg/sG07+YiBYpKD8q4ioQLwrupwVIfQpvCowEdqIyvG79w8RxWcfQvNXTY1zfYVEqJtWCSHyRolW5abZ5ycwbSQKUH1GChE0Ju+0XANbgTg4U1ifDRDwpC1JDizfocUll3UMZdfVm//jUi68tM3xyJSeD5ZigI4eLE0XAZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376782; c=relaxed/simple;
	bh=ZGwgRxU7TgHz4loAywBrbTaxHRYU8e2cK+DDh/0YWvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOFR0x/NDapMqfHCgQBBdyDz4OH8zbo4KYW75r33RqVPKwStpen6INDOuMjyERv6liYh6HQQozfcGvAFEZJgU9OMw+wCWMWXUiObGynNYJSHSdni+UsRWOL7sPYzRkllsnGYYytrPKXtcdv2VZcL6cdyyq7S+E7eCSMy4aL/DaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9t6xX4A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745376780; x=1776912780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZGwgRxU7TgHz4loAywBrbTaxHRYU8e2cK+DDh/0YWvg=;
  b=h9t6xX4AhxL+THUT6iLpYZWURgI5yx8zpZWcrfggjOSFGS9XmY24keZh
   oxPTQJuq0/IkW2ih4MRUGvAQyXZOz3yrZ4Gy5lRQLyajL1QYqOnXy/dX7
   i/58P7TO7IquXqC6jwgHcu/0GZuPZa4miI0C+n4TSpkV410vvJ49o0hTE
   IQUv/CTldjxMGYhtTLQU/K+EcMoEM/CXx61tZq552Ipipd7hcnKiaOig5
   S78TEDFtat1IfUWy9WloHhGBYFE9Ixj4emhxFifVNSYc0hCtEmz1gOAmn
   Z4cAbNmvirAvIBozhiq15tHoVE+oCyzIunKuXidjoCvg91Bmay7gBSOjK
   Q==;
X-CSE-ConnectionGUID: TyGueeMDT4qZJJmtyoi2Rg==
X-CSE-MsgGUID: SWUV/e3fSda+hMw3daxOmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="34569048"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="34569048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 19:52:59 -0700
X-CSE-ConnectionGUID: AyTCTGscTnS+ojz6PZaJzA==
X-CSE-MsgGUID: wYxfaAbqRTOCeXemxmQDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="155394831"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.199]) ([10.125.111.199])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 19:52:58 -0700
Message-ID: <80e1ce33-70d6-4e82-b823-e96069278cb8@intel.com>
Date: Tue, 22 Apr 2025 19:52:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 shangsong2@lenovo.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 7:18 PM, Lu Baolu wrote:
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
> Generally the owner field of static domains are not set because they are
> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
> that checks if a domain is compatible with the device's iommu ops. This
> helper explicitly allows the static blocked and identity domains associated
> with the device's iommu_ops to be considered compatible.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/iommu/iommu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> Change log:
> -v2:
>  - Make the solution generic for all static domains as suggested by
>    Jason.
> -v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4f91a740c15f..abda40ec377a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3402,6 +3402,19 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>  		iommu_remove_dev_pasid(device->dev, pasid, domain);
>  }
>  
> +static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
> +					struct iommu_domain *domain)
> +{
> +	if (domain->owner == ops)
> +		return true;
> +
> +	/* For static domains, owner isn't set. */
> +	if (domain == ops->blocked_domain || domain == ops->identity_domain)
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * iommu_attach_device_pasid() - Attach a domain to pasid of device
>   * @domain: the iommu domain.
> @@ -3435,7 +3448,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  	    !ops->blocked_domain->ops->set_dev_pasid)
>  		return -EOPNOTSUPP;
>  
> -	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
> +	if (!domain_iommu_ops_compatible(ops, domain) ||
> +	    pasid == IOMMU_NO_PASID)
>  		return -EINVAL;
>  
>  	mutex_lock(&group->mutex);


