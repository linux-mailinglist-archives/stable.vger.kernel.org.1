Return-Path: <stable+bounces-136492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67307A99E61
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 03:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE665A5510
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E61CDA2E;
	Thu, 24 Apr 2025 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdJSl9zL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6A2701C3;
	Thu, 24 Apr 2025 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458839; cv=none; b=anAR4Q+6B5aWIMnXlcN/ZhtJ+faK5MPMMAjkOYwPmiJZwimOyR1VlSQZtVrY2HoCeBQdNCBs/M8lQTkF6EJ7RQEwcyN8SxzUlunBjzVtWUAP5nw8v0oXoIeZdMmdw++KcksvXUruT6zVMnzWBi2hArfnlPRmDotRTddZgbMK2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458839; c=relaxed/simple;
	bh=GxcZbzXAsyopNmam3IbbTcoy0AzAFCempRRT2l3+OW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ga8FgmgI9ESAEdtDEd7RHOM2YMwvcQqhzHbssvTp3ZJKo50/YwwFmvjXNWTBsN4o/PjBVGt+tLLmlFazIJs2LiH/ffT47g8vTZjHhAEr8j4+fVM7PopHOmNgkELjxAaMlCtPy6pJI4ku9smo9jcshku+fu/2FBPA8QbCaqQblbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdJSl9zL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745458838; x=1776994838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GxcZbzXAsyopNmam3IbbTcoy0AzAFCempRRT2l3+OW8=;
  b=GdJSl9zLlzecN3enylysJHdd7d+K52ZttbogMYO1hN9q5JCXp6slzzEl
   c9bjQSP0vLSg0J2bslth1TD02nWJhJl4QGdtM/7/BVyE5EunZ27DVRIpT
   3Dn4VIPhA0tTQQYQUIAbC8oXuoElh4fuF8hrHrVDvvK/jCawTAArAJvuk
   zru8mhdNAAtz/1SP20ELvaqPiO3eSWLLZH3K7evTREVAKWAn25tUQRm6h
   GdAVT9XzudwddSDEaI8GHqCtEgN22K1But/EJCpXnndhZ7UX/m4/fdLKc
   AxFD0bwB0qkxgEkBFiUhbSGqTE/YbAW/3bGfUGtxz51AY5AHEJCuIZi/Y
   w==;
X-CSE-ConnectionGUID: TjuD8FZkRJGgQRyM2n8/1w==
X-CSE-MsgGUID: UjpVXT5hTa2fX+ZPwKLBPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57718078"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57718078"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:40:37 -0700
X-CSE-ConnectionGUID: 6+oKY1WXSyKUROLt/jVNnw==
X-CSE-MsgGUID: krdCVcNfT4+8MsuMpGylSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132999771"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:40:35 -0700
Message-ID: <d9756d68-9d40-4fa7-8d11-5a260dc4f4cd@linux.intel.com>
Date: Thu, 24 Apr 2025 09:36:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 shangsong2@lenovo.com, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
 <20250423142102.GL1648741@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250423142102.GL1648741@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 22:21, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 10:18:39AM +0800, Lu Baolu wrote:
>> @@ -3435,7 +3448,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   	    !ops->blocked_domain->ops->set_dev_pasid)
>>   		return -EOPNOTSUPP;
>>   
>> -	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>> +	if (!domain_iommu_ops_compatible(ops, domain) ||
>> +	    pasid == IOMMU_NO_PASID)
>>   		return -EINVAL;
> Convert all the places checking domain->owner to the new function..
> 
> static int __iommu_attach_group(struct iommu_domain *domain,
> 				struct iommu_group *group)
> 
> int iommu_replace_device_pasid(struct iommu_domain *domain,
> 			       struct device *dev, ioasid_t pasid,
> 			       struct iommu_attach_handle *handle)

Sure. Will make it in a new version.

Thanks,
baolu

