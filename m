Return-Path: <stable+bounces-159189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC7AF0A6A
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B80B1C01DD2
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 05:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5B14D2A0;
	Wed,  2 Jul 2025 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrPshvA4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E4221FCA;
	Wed,  2 Jul 2025 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433344; cv=none; b=Wc5as4u+yrHXmOKChs4X8/xP0ARj0w5/k32hwVm1ecHJcs4VXMi6ZAp+gxcQOTHvjqLgnksvHVMqPa+LbvX/mCe1jHTsb0VYIBS/0/e5XsqDgwItcC878miZvpa60I3fVyeynQ6MxwSPDUO+WpmmC0Pxtwy0Ceo7kWG48OU34BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433344; c=relaxed/simple;
	bh=yA/VFyXgbsNQmFMOwhT88/9R1hkxNmEietIiNZ5dXEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I+6Vp9fUvMqCaftxA9au02Onxn80JE9GLgzH2ruNbko69yyAhLcNpDwXQtv0tYMMV2GRNfSWsOuFE7rC40pWXRyJymhDPKiGlh+GWPIEV7g036YVkX/ILCCxWVPea14qiDf5UwhPFLwMjd+wJ+/9VMwwt8brFXjm6yL0s16PdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrPshvA4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751433343; x=1782969343;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yA/VFyXgbsNQmFMOwhT88/9R1hkxNmEietIiNZ5dXEs=;
  b=JrPshvA4DAbeHm97OcT1DZ3zBFbElQ7EpadkKyhgd/Jn0mXVuX7JAkqf
   hAIKYWcubkk95IaDM9WMnMxynr9Y6Cbt0Kej2DtsbQczxUuMDphcoKh27
   2TnH32vB3fMPOc9sjj5BKDDdNuhdrlAiDxT9Vx/tVwkoxG1ydoaT1zlv4
   2RGM0AVxu/V/Nd0Q2r0bfpKQXXSya2JXFdXJ5EFV9LoVIj2MyT3WmWCYl
   dsMn9DP6GnlnhUnjm8xfEuUeHxce+pnyH/A39MHyqt4gVoAb371XbZyF1
   pGKGI1LIEnqZOOUHigp6UaVVy4keAyo1vL8hzWpuJaKvew7MzGMd6wXX7
   g==;
X-CSE-ConnectionGUID: 9SkMQcdORMmqPRkBQf5rRg==
X-CSE-MsgGUID: JRSS3i14TXCmFaGro3MaHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53583406"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53583406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 22:15:42 -0700
X-CSE-ConnectionGUID: oTaVz3k6S1qnLv+V1IVrug==
X-CSE-MsgGUID: reW8n6DgSlCO/tJh9SjkFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153748196"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 22:15:39 -0700
Message-ID: <7d2214f3-3b54-4b74-a18b-aca1fdf4fdb4@linux.intel.com>
Date: Wed, 2 Jul 2025 13:14:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since
 Kernel 6.10
To: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
 kevin.tian@intel.com, jroedel@suse.de, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 01:11, Ioanna Alifieraki wrote:
> #regzbot introduced: 129dab6e1286
> 
> Hello everyone,
> 
> We've identified a performance regression that starts with linux
> kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
> Bisection pointed to commit:
> 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map").
> 
> The issue occurs when running fio against two NVMe devices located
> under the same PCIe bridge (dual-port NVMe configuration). Performance
> drops compared to configurations where the devices are on different
> bridges.
> 
> Observed Performance:
> - Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
> - After the commit:
>    -- Same PCIe bridge: ~4985 MiB/s
>    -- Different PCIe bridges: ~6150 MiB/s
> 
> 
> Currently we can only reproduce the issue on a Z3 metal instance on
> gcp. I suspect the issue can be reproducible if you have a dual port
> nvme on any machine.
> At [1] there's a more detailed description of the issue and details
> on the reproducer.

This test was running on bare metal hardware instead of any
virtualization guest, right? If that's the case,
cache_tag_flush_range_np() is almost a no-op.

Can you please show me the capability register of the IOMMU by:

#cat /sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap

> 
> Could you please advise on the appropriate path forward to mitigate or
> address this regression?
> 
> Thanks,
> Jo
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738

Thanks,
baolu

