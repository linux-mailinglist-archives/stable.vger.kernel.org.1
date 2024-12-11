Return-Path: <stable+bounces-100540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4559EC5A3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4551B1685CC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF21C5CCD;
	Wed, 11 Dec 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buhQyWSk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAD2451E2;
	Wed, 11 Dec 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902528; cv=none; b=CwBtyt4VgWmgdzJqtaKnfjdHI0dEDg+qiMTLP3qjyOfM1EzjC10+k4RaR2MA2CnvYRnX/HsI523I0sXeti1PlQIyez5py+NZuoEDsdE3k98a6mv+9UD157Jd4JBIzLdDMYLJ76V1udjma1+kHApx1UYJnwNJXwgm/MK3HxIL/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902528; c=relaxed/simple;
	bh=ZOsW9T/RQIKkvQNLrDviFnvIxqxoGeLx2z5wJ9Vz2wM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GFCA/l9PE8+GctS/wnCf5t6ujIU4Vg3jJXlgBfjr0PFTEGJk//zJSzLFPvK6SUTVz98Qoy63aVgkIbds/jXymPikz4f2QM4xWt2Oz6MgAyvME7O9mpsgxGpuoRN82Mhw/v5PmSodYNA93tqrg90+JkBrUOe5qxDeCgn8qu/VCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buhQyWSk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733902527; x=1765438527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZOsW9T/RQIKkvQNLrDviFnvIxqxoGeLx2z5wJ9Vz2wM=;
  b=buhQyWSkUwZEn/VwHr57OQdlnyUcKUx22lfK38rCYLs0pHWjpizwWqib
   +KuRBKlHwv2XO2FTSdIWUoZi5CBCa16fQbRdA9tuR3wZy1umdvTEzdzaj
   Xew9iIWbtuBfpR/Mhp8pPHMoV+WZI1LWmIUCRer6ZkuvqJING7TKAFjJn
   WtH47qeW65T1wgiUEaKzERLGfjTBTj7M1sjNd8WO99LKbSgtMsP+M5hCl
   0mW56M+HRMnP4VxAbOiBIAQBcWIPxcfODFm2idsMLsptazxPpO2aqCD23
   sX/K5c22oWtSLHObjdc5t+ype2pvwzVYm3ptVXayphbbOsjhTKYOOhInV
   w==;
X-CSE-ConnectionGUID: FATim6RxTT6CdEVe92VXUA==
X-CSE-MsgGUID: ld+PuEYdQLWymlTsIzAMaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51801489"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="51801489"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:35:26 -0800
X-CSE-ConnectionGUID: x1mCeSqwTSSF4EUR1Mh7PA==
X-CSE-MsgGUID: YrdA2sZLRyWWBU1W7UjDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126622442"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.18]) ([10.124.241.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:35:23 -0800
Message-ID: <0899838f-7845-48e3-a5b6-7a2d00ce0bac@linux.intel.com>
Date: Wed, 11 Dec 2024 15:35:20 +0800
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
Subject: Re: [PATCH] iommu/vt-d: Remove cache tags before disabling ATS
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20241129020506.576413-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D13B14053E5B6CFE7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766D13B14053E5B6CFE7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/11 15:21, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, November 29, 2024 10:05 AM
>>
>> The current implementation removes cache tags after disabling ATS,
>> leading to potential memory leaks and kernel crashes. Specifically,
>> CACHE_TAG_DEVTLB type cache tags may still remain in the list even
>> after the domain is freed, causing a use-after-free condition.
>>
>> This issue really shows up when multiple VFs from different PFs
>> passed through to a single user-space process via vfio-pci. In such
>> cases, the kernel may crash with kernel messages like:
> Is "multiple VFs from different PFs" the key to trigger the problem?

This is the real test case that triggered this issue. It's definitely
not the only case that could trigger this issue.

> 
> what about multiple VFs from the same PF or just assigning multiple
> devices to a single process/vm?

I think it's possible.

> My understanding from the below fix is that this issue will be triggered
> as long as the domain is still being actively used after one device with
> ATS is detached from it, i.e. sounds like a problem in multi-device
> assignment scenario.

Yes.

Thanks,
baolu

