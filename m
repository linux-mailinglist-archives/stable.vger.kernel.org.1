Return-Path: <stable+bounces-161801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CFB03572
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 07:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73321189905C
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 05:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5451F0994;
	Mon, 14 Jul 2025 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ml+e+nJj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D31B87E9;
	Mon, 14 Jul 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469381; cv=none; b=QhBTi9vdbtvllnBv8RXOX6v+TyhHjZzfwRz6YJ1GCzaCPrxYLVxF0HxZZ6lCTj56qdMQwv6ySq/w0ef3vO+y5KQ2AmLWWntwEO409aqP2fvD1UfVjpyjQSg4JQV4qTYhjItQBn8Xw3ICjmC3Yx8Nl2nh8jhFTvY+FvhIefiTqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469381; c=relaxed/simple;
	bh=bk+D5GWjlKkrsF4m2p4rY+C+7RTHgzpB647/hMjATqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYmv66BxcbdvzF48usgJOoiJc2TognewSFoh97IK03bDE3LgR0mWHbqRepT6C2gt6XD4tTLydq2/EO7as56NE9rCRYy+k6jPs41ZAUqdmCSThIzdMERGx3tAslB76TI+/et59TQgAmWiWXJcPW+J1icmSwBzRNx/Pg2NGQetBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ml+e+nJj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752469380; x=1784005380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bk+D5GWjlKkrsF4m2p4rY+C+7RTHgzpB647/hMjATqM=;
  b=ml+e+nJjq4AWNWbFiDfE9DXHfaO+kq9AoBG/ICziveZYt5qOXj8Zm8M6
   gEFyq3apqq8FlQ3DAr0YpjBVhZsE6lHX0Gp1ZMi8DRY9snRb1BxRbVajY
   1Oi+PqEUNFfGBeEmGCLU4bx/Uj6BT/lr96Ofva51JnPuAZfcL8bGNUNP9
   FV03uFpScNrj+x5Llmxa0UjYewkRd89T7izMls/6xkkhGJRnUnguiBJro
   sgewKmWSzv8SXhx8xWLDC6SLGeLq69cDRbUykptzMrEiX5kZcji08fGWu
   uIAdL/krQS0BSRhNcX4zeSLR9S12j8LDoL8mVTclton+mItmuOz3RireW
   Q==;
X-CSE-ConnectionGUID: hxhX03CVRniDCmwPFPMpOQ==
X-CSE-MsgGUID: kdOOqJjZTQWgTGuTUAXBPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765664"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765664"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:02:59 -0700
X-CSE-ConnectionGUID: BWuprgykSqi8fDTzocsl4Q==
X-CSE-MsgGUID: rhP02i+NTCGJ7P8FPinBkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="157185381"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 22:02:57 -0700
Message-ID: <131705ba-95f6-4ad5-9249-400b0ae97dee@linux.intel.com>
Date: Mon, 14 Jul 2025 13:01:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 11:15, Lu Baolu wrote:
> The iotlb_sync_map iommu ops allows drivers to perform necessary cache
> flushes when new mappings are established. For the Intel iommu driver,
> this callback specifically serves two purposes:
> 
> - To flush caches when a second-stage page table is attached to a device
>    whose iommu is operating in caching mode (CAP_REG.CM==1).
> - To explicitly flush internal write buffers to ensure updates to memory-
>    resident remapping structures are visible to hardware (CAP_REG.RWBF==1).
> 
> However, in scenarios where neither caching mode nor the RWBF flag is
> active, the cache_tag_flush_range_np() helper, which is called in the
> iotlb_sync_map path, effectively becomes a no-op.
> 
> Despite being a no-op, cache_tag_flush_range_np() involves iterating
> through all cache tags of the iommu's attached to the domain, protected
> by a spinlock. This unnecessary execution path introduces overhead,
> leading to a measurable I/O performance regression. On systems with NVMes
> under the same bridge, performance was observed to drop from approximately
> ~6150 MiB/s down to ~4985 MiB/s.
> 
> Introduce a flag in the dmar_domain structure. This flag will only be set
> when iotlb_sync_map is required (i.e., when CM or RWBF is set). The
> cache_tag_flush_range_np() is called only for domains where this flag is
> set.
> 
> Reported-by: Ioanna Alifieraki<ioanna-maria.alifieraki@canonical.com>
> Closes:https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738
> Link:https://lore.kernel.org/r/20250701171154.52435-1-ioanna- 
> maria.alifieraki@canonical.com
> Fixes: 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
>   drivers/iommu/intel/iommu.h |  3 +++
>   2 files changed, 21 insertions(+), 1 deletion(-)

Queued for linux-next.

--
baolu

