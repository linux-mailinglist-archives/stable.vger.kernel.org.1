Return-Path: <stable+bounces-73126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58496CDF3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 06:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD43B222F7
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4C14A0B7;
	Thu,  5 Sep 2024 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBaABYRn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2048CCC;
	Thu,  5 Sep 2024 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510277; cv=none; b=a7gguKKLOtfnvwr212K80yfQQNBXQMWOKNjU2pdzyQcSFZ/2ZsPw+/sLa/nefoQnCOtm867upy4EelqDoYFBnNKtSDCjf5kdj9Xqkv6bRu4tEtwFDFvMtZmUI0SCDFr8jhrOfDe8D0AKCvhkT1q7SC4fHsngHFJaCulhIU2jZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510277; c=relaxed/simple;
	bh=6MfL0Y9QFnUqWm2/ZVpAP33O/HYuWfUIjk+V0ytEdks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWyWeeGQqm3r4mMso5ICfDu8XDgMkv8CezNAnjEku40j7wI+9e14y/WcCunAMRbqjWiR6o8bWGew9jm0X9UNLLDQTt2rCS2CMnFT+HAasav3LIPQGHxPUr0lfVDu97IXAjQJwoC4S6DE3gzdwoSvi7KXYXT1kvY0L9+a5bQD2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBaABYRn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725510276; x=1757046276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6MfL0Y9QFnUqWm2/ZVpAP33O/HYuWfUIjk+V0ytEdks=;
  b=kBaABYRnscshrzIVdoImbiWTBNQGYTqQIu54xa1paGLx5TMTEvgenImJ
   5TJRwUsBPaaX1XQkRn+GfUDeQAKXE3ROIQj2aQ7C594TldJ2GkA/8rEzq
   LKnULRwkoiyLGr3jTL5StI96WAUYVmHJo1/Klu2ax38tMVOrVvi0uUpQS
   sLy8JB4x03DfoWitbmZG8jyx5saN8erBN9miPjjrgo2L66LiiX68NP7Yy
   IdiQUtyntI0ZYF0n9f9CLG1D/N+UxRZNaURjelFavxv++NRk/EPoa3nJi
   eM4E0u4ciRmClTHhURVRSrIkuF4qsb2nsJVVf86ne9Nfu3yIVoW8nqde+
   A==;
X-CSE-ConnectionGUID: 0I32WCAGTFCsUv5KgTRL8Q==
X-CSE-MsgGUID: uKLlz3CYSgG/lcVXFTpFQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24319998"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24319998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 21:24:35 -0700
X-CSE-ConnectionGUID: AuTVCwsDS/m+Cgh02KTsmg==
X-CSE-MsgGUID: AF3U6TvdTyW0jYKR7O4jvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="96284840"
Received: from shuangy2-mobl.ccr.corp.intel.com (HELO [10.238.129.122]) ([10.238.129.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 21:24:33 -0700
Message-ID: <98de8dbd-1a83-40e1-ad5a-a86b1441bb08@linux.intel.com>
Date: Thu, 5 Sep 2024 12:24:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: "Saarinen, Jani" <jani.saarinen@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276428A5462738F89190A5A8C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/2024 3:49 PM, Baolu Lu wrote:
> On 2024/9/4 14:49, Tian, Kevin wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Wednesday, September 4, 2024 2:07 PM
>>>
>>> SOC-integrated devices on some platforms require their PCI ATS enabled
>>> for operation when the IOMMU is in scalable mode. Those devices are
>>> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
>>> field.
>>>
>>> The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
>>> ATS on all devices. Using 'pci=noat' with devices that require PCI ATS
>>> can cause a conflict, leading to boot failure, especially if the device
>>> is a graphics device.
>>>
>>> To prevent this issue, check PCI ATS support before enumerating the 
>>> IOMMU
>>> devices. If any device requires PCI ATS, but PCI ATS is disabled by
>>> 'pci=noats', switch the IOMMU to operate in legacy mode to ensure
>>> successful booting.
>>
>> I guess the reason of switching to legacy mode is because the platform
>> automatically enables ATS in this mode, as the comment says in
>> dmar_ats_supported(). This should be explained otherwise it's unclear
>> why switching the mode can make ATS working for those devices.
>
> Not 'automatically enable ATS,' but hardware provides something that is
> equivalent to PCI ATS. The ATS capability on the device is still
> disabled. That's the reason why such device must be an SOC-integrated
> one.

That is confusing, how to know the "hardware provides something that is
equivalent to PCI ATS" ? any public docs to say that ?

>
>>
>> But then doesn't it break the meaning of 'pci=noats' which means
>> disabling ATS physically? It's described as "do not use PCIe ATS and
>> IOMMU device IOTLB" in kernel doc, which is not equivalent to
>> "leave PCIe ATS to be managed by HW".
>
> Therefore, the PCI ATS is not used and the syntax of pci=noats is not
> broken.
>
>> and why would one want to use 'pci=noats' on a platform which
>> requires ats?
>
> We don't recommend users to disable ATS on a platform which has devices
> that rely on it. But nothing can prevent users from doing so. I am not
> sure why it is needed. One possible reason that I can think of is about
> security. Sometimes, people don't trust ATS because it allows devices to
> access the memory with translated requests directly without any
> permission check on the IOMMU end.

Appears that would happen with CXL link, while PCI link still will do
some checking (per VT-d spec sec 4.2.4). I have question here, such behaviour
happens with HW passthrough, also does to software passthrough (removed identity
mapping) ?


Thanks,
Ethan

>
> Thanks,
> baolu
>

