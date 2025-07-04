Return-Path: <stable+bounces-160136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A63AF8534
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 03:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AF5545DF3
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF71311AC;
	Fri,  4 Jul 2025 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Py0056Bi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276386340;
	Fri,  4 Jul 2025 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751592446; cv=none; b=I+V075yaRyqJ2zEX8I2Sy8mI7ERohlTFLGlFmp3VtCsP79UWJvJQnHYy6EgQJvngwfHd99WXqIRiBBz3sjqejQy5aDWsEzX+JKpMnjtmW9p40snH9VlMc/JKNJaU4S1hTp/Wu/NtuDPpIKoZsdsmVPaQc4wrqtRSXQUfPjJJaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751592446; c=relaxed/simple;
	bh=wiEAgWU9/grMvoZLEsMM2n7Py0FumSs1+9V6ieSrx/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXxRJhluaiB1H2pZij6ae/+/tukOPRPKGgFliSIsfPB3vJtyC0Zu81xPfyemitNsg/Q6yx0Q/y3OABtniPyAxXEVquwjiPcumkiTBkVLOfLKU0rnVAJUzIrUX+dkjKevp+sBCPavD72om+o6nKULQ2u19lezhutZTf08fIH8iJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Py0056Bi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751592445; x=1783128445;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wiEAgWU9/grMvoZLEsMM2n7Py0FumSs1+9V6ieSrx/k=;
  b=Py0056Bi2x+KZ6WkYUcj6ToNWsj0BADBou5taW1pn0XQb56GxQI7/Yfp
   KqjU7LgVRJcLk3Wa5op0cYKP7k4gfm305U2W3G1Qtz3V/Gzg2+rcLv630
   7IzfCArEahOzCeZt9VxVb/BVslzBZK4riaTHPU1JtNKpQpCRy3DSyk0Fh
   FahwCQyBA0t++ZWW9GB12XxsSmXcNZYgK4LaHM72vYyI5yx/suvkeOAfu
   L81chfbi5UuQyTf0DMqJPsI8ae4vqIEEkoU0kKbyIcjlHW1FRoM39Ko63
   qSvmdochst0GBPfzCQlTBterzNyToDGx9RzRrNikgenirixcxBfBrivcH
   g==;
X-CSE-ConnectionGUID: m4ydZx6IT0iz0rQW9h1JFA==
X-CSE-MsgGUID: ja75FxzqSS+KBMGDHvVPEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71498627"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="71498627"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:27:24 -0700
X-CSE-ConnectionGUID: SwyYW4yaQP+GjHkzz78g+g==
X-CSE-MsgGUID: doSsbApTQNO2hzDH2dd9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154277007"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:27:22 -0700
Message-ID: <b95b6a35-e6b5-46df-9a5f-4cc7f4e823bb@linux.intel.com>
Date: Fri, 4 Jul 2025 09:25:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F7B7E0F6091334A7A3128C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F7B7E0F6091334A7A3128C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 15:16, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, July 3, 2025 11:16 AM
>>
>> The iotlb_sync_map iommu ops allows drivers to perform necessary cache
>> flushes when new mappings are established. For the Intel iommu driver,
>> this callback specifically serves two purposes:
>>
>> - To flush caches when a second-stage page table is attached to a device
>>    whose iommu is operating in caching mode (CAP_REG.CM==1).
>> - To explicitly flush internal write buffers to ensure updates to memory-
>>    resident remapping structures are visible to hardware (CAP_REG.RWBF==1).
>>
>> However, in scenarios where neither caching mode nor the RWBF flag is
>> active, the cache_tag_flush_range_np() helper, which is called in the
>> iotlb_sync_map path, effectively becomes a no-op.
>>
>> Despite being a no-op, cache_tag_flush_range_np() involves iterating
>> through all cache tags of the iommu's attached to the domain, protected
>> by a spinlock. This unnecessary execution path introduces overhead,
>> leading to a measurable I/O performance regression. On systems with
>> NVMes
>> under the same bridge, performance was observed to drop from
>> approximately
>> ~6150 MiB/s down to ~4985 MiB/s.
> so for the same bridge case two NVMe disks likely are in the same
> iommu group sharing a domain. Then there is contention on the
> spinlock from two parallel threads on two disks. when disks come
> from different bridges they are attached to different domains hence
> no contention.
> 
> is it a correct description for the difference between same vs.
> different bridge?

Yes. I have the same understanding.

Thanks,
baolu

