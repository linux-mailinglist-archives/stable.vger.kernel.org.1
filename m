Return-Path: <stable+bounces-72970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852B96B36B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6F71C24595
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22581714C9;
	Wed,  4 Sep 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv75SECy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9E1509A5;
	Wed,  4 Sep 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436201; cv=none; b=biLwYbIRCuq1iHbQQpQoY6h3/GCs5SIcyQrqb2s/hUac20rws4zi7G0hZZMIVJuPa5PuZa4qjWtBwKR1Buaz+/C+/hIx2YEKYRcUOK37KD41cqghUxdl3X2lCF2qFAEFdH2xODEDf8ijdEreWnevNF5YAuFlrd+l0Hjm5XKMakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436201; c=relaxed/simple;
	bh=n11IIAFOIZVYrv0u/r7HWhEJ8P8Nh5SNpfJZTS/XAjA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hLiEr6d5OpgcOzX8sNSHJAmt2GO+fjoBtHxSY9UebkzWoo5zcqfVPdEaReOq5EP4//LkXb9egZb2PlM1BPYthGMGRxgFcuafEhQcM5zh20NSrlLNuBlEj/gvAxYXYQCsAc5BUdibHQoAmv7fHlTr4/KnabSKVHU5MfeTpyK/DGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv75SECy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725436200; x=1756972200;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n11IIAFOIZVYrv0u/r7HWhEJ8P8Nh5SNpfJZTS/XAjA=;
  b=Uv75SECyOAJ4BEwdN1Bo8qJ7XTTvyZ5NlBkGwCuEm/6GVzQTnEhHNzyv
   /EL9irednMA+w5CQl98pVIjq6y+IQV08G5Xu+Xwgn9yGAEldTkpsehOom
   5pim1sAhXfLmqk19ijolwOs/8si5XEuhXL3PE4bKikbJcrvYDKtbgs8q3
   FBWPNg4+Ym32oV5x8c41MjGASJhtM5cBjL0dwWwyqiI/ip35pBAfrIFUU
   sgYrYkoz5QTjY6PS3pwpgy2pw7uhSPFlrykfDE7pwk2y56Lxky25rKQaM
   QCnHHRJ4U1c86/4/Vt9NLEw1E6JA1ChB2ywT9qwU0RTMgwuROl7549/wL
   w==;
X-CSE-ConnectionGUID: zsJUoWlsQGaAUFIcfdOJBw==
X-CSE-MsgGUID: HRj2S4CwS4ytRaS2tvmChA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23590569"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23590569"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:49:49 -0700
X-CSE-ConnectionGUID: J/BDhSG6SB+HftCxRzxsbA==
X-CSE-MsgGUID: ZzFbso7eSf+ZuzZcEokpwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65706875"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 00:49:47 -0700
Message-ID: <9e183ce2-060a-4e0b-a956-03d767368ca4@linux.intel.com>
Date: Wed, 4 Sep 2024 15:49:44 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276428A5462738F89190A5A8C9C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/4 14:49, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, September 4, 2024 2:07 PM
>>
>> SOC-integrated devices on some platforms require their PCI ATS enabled
>> for operation when the IOMMU is in scalable mode. Those devices are
>> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
>> field.
>>
>> The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
>> ATS on all devices. Using 'pci=noat' with devices that require PCI ATS
>> can cause a conflict, leading to boot failure, especially if the device
>> is a graphics device.
>>
>> To prevent this issue, check PCI ATS support before enumerating the IOMMU
>> devices. If any device requires PCI ATS, but PCI ATS is disabled by
>> 'pci=noats', switch the IOMMU to operate in legacy mode to ensure
>> successful booting.
> 
> I guess the reason of switching to legacy mode is because the platform
> automatically enables ATS in this mode, as the comment says in
> dmar_ats_supported(). This should be explained otherwise it's unclear
> why switching the mode can make ATS working for those devices.

Not 'automatically enable ATS,' but hardware provides something that is
equivalent to PCI ATS. The ATS capability on the device is still
disabled. That's the reason why such device must be an SOC-integrated
one.

> 
> But then doesn't it break the meaning of 'pci=noats' which means
> disabling ATS physically? It's described as "do not use PCIe ATS and
> IOMMU device IOTLB" in kernel doc, which is not equivalent to
> "leave PCIe ATS to be managed by HW".

Therefore, the PCI ATS is not used and the syntax of pci=noats is not
broken.

> and why would one want to use 'pci=noats' on a platform which
> requires ats?

We don't recommend users to disable ATS on a platform which has devices
that rely on it. But nothing can prevent users from doing so. I am not
sure why it is needed. One possible reason that I can think of is about
security. Sometimes, people don't trust ATS because it allows devices to
access the memory with translated requests directly without any
permission check on the IOMMU end.

Thanks,
baolu

