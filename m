Return-Path: <stable+bounces-73123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E096CCDB
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24CB1C21F43
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557D13D297;
	Thu,  5 Sep 2024 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWJo1sfH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337A13A25B;
	Thu,  5 Sep 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504825; cv=none; b=przQztrM2dmGhNHLkLQdkneT4UgO6j3rzc47JtdvI3O0L80qpjuYSgCipeUTxCZgRzItxFejNBvTKuBXvjPH+UMuBBujU0LKAUtjRYpOMieZZ4pWXxKErRSX2QZIaeYscpnnPrC04uRAH5tAlA3gSxGygAonoX2OrF0VGwRUpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504825; c=relaxed/simple;
	bh=U89eQ8SdgXFSXc/zEG9fbPHWHTUgChKGQrC3oE8NS48=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OJ4+mN6tpCOWXNtLnBfxry57CU1cn1XBS+JRXcG61DGkxDOCnG4eJ9AQFIIB/DaY2lH+RBCpIlcXaA7n3qY6+f1+NV3s9GoY2mRheh4m+Es+v8D5oCuupx2vMi/Ud7cODWooulukVvgMSZ3LWM4zWaupfHfEAEO5eI+AFYSLheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWJo1sfH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725504823; x=1757040823;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U89eQ8SdgXFSXc/zEG9fbPHWHTUgChKGQrC3oE8NS48=;
  b=ZWJo1sfHJXwkLVr3yskdIz2Bbzdmf6EKWOYtLul8fixGWMMrJTCWj/+E
   Goltdtdt9Vlr19Lf6hAdZx/0uOj+dX9Iu+aeV0AoBgJqzaWyVRv0DLXel
   g8oWnLRfq6m6GMNcUDveBER6q1AlCbZ8v23YlaVlgcTE3wgpg6S5AgIOQ
   DBoi6E9IPKrpJhvyUtgu9NEXNv2AuSwV7Ov1yowW7yIxMBOrVrWF65PEp
   R7fmFmYxOA49jpn0iWDvrNlh5Jook9fZKeEIkWUA86qAv+R+u8xe5xQG4
   4NKtraDAlEVS2j2H4WHoRMSGHlGQoTUpbBOne61FJ0g6pc+v84sivh0g8
   A==;
X-CSE-ConnectionGUID: TU6U/ocmTHyBOA33PVhcnA==
X-CSE-MsgGUID: l09SIHh8SIKSF7tPOaNx/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24072479"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24072479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 19:53:42 -0700
X-CSE-ConnectionGUID: vI0myhXKSoyUuMFmqv3NQw==
X-CSE-MsgGUID: gevWJgb+TLadOfsz4CM8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="96270103"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 04 Sep 2024 19:53:40 -0700
Message-ID: <b8d1069c-ebbc-4700-adf8-69810bef6c0a@linux.intel.com>
Date: Thu, 5 Sep 2024 10:49:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Saarinen, Jani" <jani.saarinen@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices
 requiring ATS
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276428A5462738F89190A5A8C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
 <BN9PR11MB5276D640C4E906EBBC3EA6D08C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D640C4E906EBBC3EA6D08C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 4:17 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, September 4, 2024 3:50 PM
>>
>> On 2024/9/4 14:49, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, September 4, 2024 2:07 PM
>>>>
>>>> SOC-integrated devices on some platforms require their PCI ATS enabled
>>>> for operation when the IOMMU is in scalable mode. Those devices are
>>>> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
>>>> field.
>>>>
>>>> The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
>>>> ATS on all devices. Using 'pci=noat' with devices that require PCI ATS
>>>> can cause a conflict, leading to boot failure, especially if the device
>>>> is a graphics device.
>>>>
>>>> To prevent this issue, check PCI ATS support before enumerating the
>> IOMMU
>>>> devices. If any device requires PCI ATS, but PCI ATS is disabled by
>>>> 'pci=noats', switch the IOMMU to operate in legacy mode to ensure
>>>> successful booting.
>>>
>>> I guess the reason of switching to legacy mode is because the platform
>>> automatically enables ATS in this mode, as the comment says in
>>> dmar_ats_supported(). This should be explained otherwise it's unclear
>>> why switching the mode can make ATS working for those devices.
>>
>> Not 'automatically enable ATS,' but hardware provides something that is
>> equivalent to PCI ATS. The ATS capability on the device is still
>> disabled. That's the reason why such device must be an SOC-integrated
>> one.
> 
> well does that equivalent means use PCI ATS protocol at all (i.e. do
> untranslated request followed by translated request based on device
> TLB)?
> 
> If yes it's still ATS under the hood.
> 
> If not could you elaborate how it works in PCI world?

I'm not a hardware expert, so I can't provide specific details. :-)

Anyway, from the Linux box's perspective, if 'pci=noats' is used on a
Meteorlake device, the 'lspci' tool shows that PCI ATS is disabled:

# dmesg
[...]
[    2.419806] pci 0000:00:02.0: DMAR: PCI/ATS not supported, system 
working in IOMMU legacy mode
[...]

# lspci -s 0000:00:02.0 -vv
00:02.0 VGA compatible controller: Intel Corporation Meteor Lake-M 
[Intel Graphics] (prog-if 00 [VGA controller])
[...]
         Capabilities: [200 v1] Address Translation Service (ATS)
                 ATSCap: Invalidate Queue Depth: 00
                 ATSCtl: Enable-, Smallest Translation Unit: 00
[...]

As for how hardware works, it appears to be transparent to the software.

> 
>>
>>>
>>> But then doesn't it break the meaning of 'pci=noats' which means
>>> disabling ATS physically? It's described as "do not use PCIe ATS and
>>> IOMMU device IOTLB" in kernel doc, which is not equivalent to
>>> "leave PCIe ATS to be managed by HW".
>>
>> Therefore, the PCI ATS is not used and the syntax of pci=noats is not
>> broken.
> 
> I'm not sure the point of noats is to just disable the PCI capability
> while allowing the underlying hw to continue sending ATS protocol...
> 
>>
>>> and why would one want to use 'pci=noats' on a platform which
>>> requires ats?
>>
>> We don't recommend users to disable ATS on a platform which has devices
>> that rely on it. But nothing can prevent users from doing so. I am not
>> sure why it is needed. One possible reason that I can think of is about
>> security. Sometimes, people don't trust ATS because it allows devices to
>> access the memory with translated requests directly without any
>> permission check on the IOMMU end.
>>
> 
> but this doesn't make sense. If the user doesn't trust ATS and deliberately
> wants to disable ats then it should be followed and whatever usage
> requiring ATS is then broken. The user should decide which is more
> favored between security vs. usage to make the right call.

Yes. That's just a reason that I could think of.

Anyway, for a client platform, we should avoid any boot failure no
matter what kernel parameters the users are using.

Instead, perhaps we could emit a big fat warning to the user, informing
them that a device relies on ATS for functionality, thus 'pci=noats'
might be compromised.

Thanks,
baolu

