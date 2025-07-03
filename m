Return-Path: <stable+bounces-159273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BFFAF67B0
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 04:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF151C4579D
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C591AD3FA;
	Thu,  3 Jul 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqEgVNpW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04681F94A;
	Thu,  3 Jul 2025 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508300; cv=none; b=Nv4dAy7+kWyOgWFhpVdnOp5WUveOLv+d7HtBbLt2Ggz5FiGkw+B1jomlM58mCFOQAoNBZQr8fFqk6bTAgmmMrs1SFR5Wf5Fw62lQLgPL3QW3yvdcI6S9lsSCqVvgItO8Ass0e0WwGJWf8iIAjr7Ib/Smaf1gh25utMCiqMskksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508300; c=relaxed/simple;
	bh=ghjz4C75wfN8JRFKxQVod63LoXDkM1idBHHdqSL8WoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aosWRUu31QMLzw5QgZ466LXujApbcv8CyxNnDRTjOgnPLwc1vJNSySgGVhLMhang8V9kTOYqswcFXzHECNkccts30LkMz2D+L9Dz/oba4oQuursxcakJdd19ionMePgUvwRbr8+SWIE/W5bAhYRAoXVHJaRHqyn46xFPq5fWFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqEgVNpW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751508299; x=1783044299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ghjz4C75wfN8JRFKxQVod63LoXDkM1idBHHdqSL8WoM=;
  b=kqEgVNpWcGJ7DWOUpbZ1oS3Sh/qGE2zts23zh/9oFIb0wD58PRdINH5T
   q5K5UWFXivBWVQSrm0N5hMi6rjV5xVHUP97xykFgsQZi+gcbR4H6GPodL
   ofvZRmwgyuY5Ijd8ngJhOpa7AaI5EN2RRxBiudH4TMK1PX3TmFkhbEenl
   Y8VfpSyN6++26ts/Wf+NtWhWKMM1KYGLchO3E1Np8+nFlczVqFOAjHceF
   9BX5LLImhwODbDOU4ElhFs/japUmrHD0c+Ftmu0oQQozdRgr0qfaGXxcm
   /9r0f3mREyU6mHmHmylcsB/s/UBSFZgcdSC38X6lFvlAHF//OYRdNBcD7
   g==;
X-CSE-ConnectionGUID: l84M8Vp5QwOq6w59v2kfTw==
X-CSE-MsgGUID: XDkpN9gMSiWnGKyEF4hUaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53965269"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53965269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 19:04:58 -0700
X-CSE-ConnectionGUID: MBuCpl/xSs+B1epg0BstbA==
X-CSE-MsgGUID: NNfpWYmrT82c63w5IBxKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="153999973"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 19:04:56 -0700
Message-ID: <b25e6891-89cc-4ead-88b3-c1c548615daa@linux.intel.com>
Date: Thu, 3 Jul 2025 10:03:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since
 Kernel 6.10
To: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc: kevin.tian@intel.com, jroedel@suse.de, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
 <7d2214f3-3b54-4b74-a18b-aca1fdf4fdb4@linux.intel.com>
 <96d68cb2-9240-4179-bca0-8ad2d70ab281@linux.intel.com>
 <CAOLeGd3a63_za6cYs3HyzFn1A=j7gaEcWurT9yuXknMspa80fA@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAOLeGd3a63_za6cYs3HyzFn1A=j7gaEcWurT9yuXknMspa80fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/25 00:45, Ioanna Alifieraki wrote:
> On Wed, Jul 2, 2025 at 12:00 PM Baolu Lu<baolu.lu@linux.intel.com> wrote:
>> On 7/2/2025 1:14 PM, Baolu Lu wrote:
>>> On 7/2/25 01:11, Ioanna Alifieraki wrote:
>>>> #regzbot introduced: 129dab6e1286
>>>>
>>>> Hello everyone,
>>>>
>>>> We've identified a performance regression that starts with linux
>>>> kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
>>>> Bisection pointed to commit:
>>>> 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in
>>>> iotlb_sync_map").
>>>>
>>>> The issue occurs when running fio against two NVMe devices located
>>>> under the same PCIe bridge (dual-port NVMe configuration). Performance
>>>> drops compared to configurations where the devices are on different
>>>> bridges.
>>>>
>>>> Observed Performance:
>>>> - Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
>>>> - After the commit:
>>>>     -- Same PCIe bridge: ~4985 MiB/s
>>>>     -- Different PCIe bridges: ~6150 MiB/s
>>>>
>>>>
>>>> Currently we can only reproduce the issue on a Z3 metal instance on
>>>> gcp. I suspect the issue can be reproducible if you have a dual port
>>>> nvme on any machine.
>>>> At [1] there's a more detailed description of the issue and details
>>>> on the reproducer.
>>> This test was running on bare metal hardware instead of any
>>> virtualization guest, right? If that's the case,
>>> cache_tag_flush_range_np() is almost a no-op.
>>>
>>> Can you please show me the capability register of the IOMMU by:
>>>
>>> #cat/sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap
>> Also, can you please try whether the below changes make any difference?
>> I've also attached a patch file to this email so you can apply the
>> change more easily.
> Thanks for the patch Baolu, I've tested and I can confirm we get ~6150MiB/s
> for nvme pairs both under the same and different bridge.
> The output of
> cat/sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap
> 19ed008c40780c66
> for all nvmes.
> I got confirmation there's no virtualization happening on this instance
> at all.
> FWIW, I had run perf when initially investigating the issue and it was
> showing quite some time spent in cache_tag_flush_range_np().

Okay, I will post a formal fix patch for this. Thank you!

Thanks,
baolu

