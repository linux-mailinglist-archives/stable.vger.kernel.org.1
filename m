Return-Path: <stable+bounces-203265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC59CD8066
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 05:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA3D3031CF2
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3491EDA3C;
	Tue, 23 Dec 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzObc+2B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7D13DDAE;
	Tue, 23 Dec 2025 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462745; cv=none; b=jKObOjdEKftmZjTfSU1jzGoP/r0z5mzGn8MW9sTm0LtkUZD5KiflqYv6tdJpK3ZvKO9NIIWhIJizDMgaMsE+JBjiEkZhooQRgunTzy4AzeRlVuHV4fKzwGSWh9Zmqju/VultVGfMS7tOmaJtdVOEDZKCikD5wNj0LhYoyMRuLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462745; c=relaxed/simple;
	bh=XGpM1Fdl3pIWzFbZw0bYmRLO6aLVsRVc990n/X0l9l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoKXY+oPNKtpV/b0EW4gWu6msRqqkVURjRps70e6vlCb5Iz/TpzZ+r9Z+YP/GNhj9eERTu6qWQUc53pV54C3t7vPmvAG8codwUFJwo2wRkVKel+59vhgbrip3LrNA7AmBkQ4ZiEnnnvH2I8/Y8bnxG1DpFMxDLi8tu5u9yxcmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzObc+2B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766462744; x=1797998744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XGpM1Fdl3pIWzFbZw0bYmRLO6aLVsRVc990n/X0l9l8=;
  b=IzObc+2BJAu24Of44UXCwXEr3YQNgtRRXc+xq0AY2lOYxad02b1N1nOi
   a+malGfny7lnlfxIldOZU0TjqlckTOkY7s8H1XMHhrStV5oxSXPH5dVV/
   gfuCzUywmoouIHMVedd8udddd4REZS4/7XOJTjAqLNzb2ui1KE/nmGqzG
   TsVg7+AM5rLWP9YVjMJ3DyZG/+awvqjAeUpkmOGu8KolaxZgI6Fn2nsbL
   Z7nS4Ox5PIAJdoYdG7RQ//IfET7b5+gO5sNPgpuTE8zX3Qm4K/S3xCJkM
   WY89TMp7kER73ecfcoLel4AaBXjBD1sBh+1hvIgJip5sqfnpK5UkDTFl1
   Q==;
X-CSE-ConnectionGUID: 8MjsjJHiRKiIcY83UdHFFQ==
X-CSE-MsgGUID: 7633XiAoSy2rzB4Qn+jrRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79431609"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="79431609"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 20:05:43 -0800
X-CSE-ConnectionGUID: uA9OKgalSb6SWaiqyajz+w==
X-CSE-MsgGUID: evQAdVrEQ5y2J3/29RhcHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200590632"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 20:05:41 -0800
Message-ID: <aa1eda8a-4463-467a-b157-c6155882f293@linux.intel.com>
Date: Tue, 23 Dec 2025 12:06:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
To: Jinhui Guo <guojinhui.liam@bytedance.com>, kevin.tian@intel.com
Cc: dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, will@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251222111935.489-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251222111935.489-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/22/25 19:19, Jinhui Guo wrote:
> On Thu, Dec 18, 2025 08:04:20AM +0000, Tian, Kevin wrote:
>>> From: Jinhui Guo<guojinhui.liam@bytedance.com>
>>> Sent: Thursday, December 11, 2025 12:00 PM
>>>
>>> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
>>> request when device is disconnected") relies on
>>> pci_dev_is_disconnected() to skip ATS invalidation for
>>> safely-removed devices, but it does not cover link-down caused
>>> by faults, which can still hard-lock the system.
>> According to the commit msg it actually tries to fix the hard lockup
>> with surprise removal. For safe removal the device is not removed
>> before invalidation is done:
>>
>> "
>>      For safe removal, device wouldn't be removed until the whole software
>>      handling process is done, it wouldn't trigger the hard lock up issue
>>      caused by too long ATS Invalidation timeout wait.
>> "
>>
>> Can you help articulate the problem especially about the part
>> 'link-down caused by faults"? What are those faults? How are
>> they different from the said surprise removal in the commit
>> msg to not set pci_dev_is_disconnected()?
>>
> Hi, kevin, sorry for the delayed reply.
> 
> A normal or surprise removal of a PCIe device on a hot-plug port normally
> triggers an interrupt from the PCIe switch.
> 
> We have, however, observed cases where no interrupt is generated when the
> device suddenly loses its link; the behaviour is identical to setting the
> Link Disable bit in the switch’s Link Control register (offset 10h). Exactly
> what goes wrong in the LTSSM between the PCIe switch and the endpoint remains
> unknown.

In this scenario, the hardware has effectively vanished, yet the device
driver remains bound and the IOMMU resources haven't been released. I’m
just curious if this stale state could trigger issues in other places
before the kernel fully realizes the device is gone? I’m not objecting
to the fix. I'm just interested in whether this 'zombie' state creates
risks elsewhere.

> 
>>> For example, if a VM fails to connect to the PCIe device,
>> 'failed' for what reason?
>>
>>> "virsh destroy" is executed to release resources and isolate
>>> the fault, but a hard-lockup occurs while releasing the group fd.
>>>
>>> Call Trace:
>>>   qi_submit_sync
>>>   qi_flush_dev_iotlb
>>>   intel_pasid_tear_down_entry
>>>   device_block_translation
>>>   blocking_domain_attach_dev
>>>   __iommu_attach_device
>>>   __iommu_device_set_domain
>>>   __iommu_group_set_domain_internal
>>>   iommu_detach_group
>>>   vfio_iommu_type1_detach_group
>>>   vfio_group_detach_container
>>>   vfio_group_fops_release
>>>   __fput
>>>
>>> Although pci_device_is_present() is slower than
>>> pci_dev_is_disconnected(), it still takes only ~70 µs on a
>>> ConnectX-5 (8 GT/s, x2) and becomes even faster as PCIe speed
>>> and width increase.
>>>
>>> Besides, devtlb_invalidation_with_pasid() is called only in the
>>> paths below, which are far less frequent than memory map/unmap.
>>>
>>> 1. mm-struct release
>>> 2. {attach,release}_dev
>>> 3. set/remove PASID
>>> 4. dirty-tracking setup
>>>
>> surprise removal can happen at any time, e.g. after the check of
>> pci_device_is_present(). In the end we need the logic in
>> qi_check_fault() to check the presence upon ITE timeout error
>> received to break the infinite loop. So in your case even with
>> that logici in place you still observe lockup (probably due to
>> hardware ITE timeout is longer than the lockup detection on
>> the CPU?
> Are you referring to the timeout added in patch
> https://lore.kernel.org/all/20240222090251.2849702-4- 
> haifeng.zhao@linux.intel.com/ ?

This doesn't appear to be a deterministic solution, because ...

> Our lockup-detection timeout is the default 10 s.
> 
> We see ITE-timeout messages in the kernel log. Yet the system still
> hard-locks—probably because, as you mentioned, the hardware ITE timeout
> is longer than the CPU’s lockup-detection window. I’ll reproduce the
> case and follow up with a deeper analysis.

... as you see, neither the PCI nor the VT-d specifications mandate a
specific device-TLB invalidation timeout value for hardware
implementations. Consequently, the ITE timeout value may exceed the CPU
watchdog threshold, meaning a hard lockup will be detected before the
ITE even occurs.

Thanks,
baolu

