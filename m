Return-Path: <stable+bounces-166762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77492B1D2B8
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA1725996
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7FE214210;
	Thu,  7 Aug 2025 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpwR0rZ4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA681C862D;
	Thu,  7 Aug 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549782; cv=none; b=mkNt5c5e97WVeIY++4VuwR1v+9OMQ8WVk9CBoPit8TsYjpDJxOeU5i+YDvQOO02pR5YGDBiwhrQXW2emTuOeApkZ/A1FKtyLsUKWKYbTbE8grAZubqDtJcbkjqOg5laOhXQM0adv3uuBAWjKZmOP3B1LN02MK0NHAqizX/b0LMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549782; c=relaxed/simple;
	bh=r5ZCaUWe5Zj67D/I0QB99rgW+0T7bCVTt1DYQGPGn4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/xg30KS5Drg0PyDqxIiAdriryq8ydlqhFR/wZDcnEr7HuOtIzq6nSo/9hCiMbl3wOcBG0GrGnENN2pov1CTXohTE4+tXsHnkoRXXrMSsH8DftLQPwY/ZzHcHHt9VbVhHTIUySQjwApAIjUIK+bKWOp/k1g2yz6Fk4Y3OHfCqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpwR0rZ4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754549781; x=1786085781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r5ZCaUWe5Zj67D/I0QB99rgW+0T7bCVTt1DYQGPGn4g=;
  b=bpwR0rZ4icq++nOzgk+V3Ehw2jZalGnaa73PreIbCQGQipCjZHD6T2Po
   Z2RmrqQsINC1tdfM5viibQkAEulRDk6AWl78lRyraWYNuK0zxPPLgx56s
   E0udygxdkcudf+tlbkWl0AYvnBAVH5ul68H3EDtoN0P45gRilpSxPID5E
   c7mP5LVofdOIquyzh8kgy2L572PxyzpBaWE82sfaoG9hh+NtnCyRrSbmn
   9uNx8eX9kqnWUItHdMKdL7sY7NSEht8PxgkloUrdjYudGqPn0XMk+1Rl9
   0ZpgRLD/wzbhibVWUa7+IjdEGo7GPYIZGLbmPtRBtwtoeFQ0JKVsSO0RH
   g==;
X-CSE-ConnectionGUID: +3qoUz3IRLGSWKjexmOaeg==
X-CSE-MsgGUID: KnY6/i2NQq25HwxVH6dQ7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56839931"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56839931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 23:56:20 -0700
X-CSE-ConnectionGUID: dKh6cH87Qva1jMqbriMu/Q==
X-CSE-MsgGUID: O2RcK+slTCW7q0yLaxtgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169439423"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 23:56:17 -0700
Message-ID: <f0d561a1-231d-495e-a91a-9724d4037f05@linux.intel.com>
Date: Thu, 7 Aug 2025 14:53:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/25 23:03, Dave Hansen wrote:
> On 8/5/25 22:25, Lu Baolu wrote:
>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
>> shares and walks the CPU's page tables. The Linux x86 architecture maps
>> the kernel address space into the upper portion of every process’s page
>> table. Consequently, in an SVA context, the IOMMU hardware can walk and
>> cache kernel space mappings. However, the Linux kernel currently lacks
>> a notification mechanism for kernel space mapping changes. This means
>> the IOMMU driver is not aware of such changes, leading to a break in
>> IOMMU cache coherence.
> FWIW, I wouldn't use the term "cache coherence" in this context. I'd
> probably just call them "stale IOTLB entries".
> 
> I also think this over states the problem. There is currently no problem
> with "kernel space mapping changes". The issue is solely when kernel
> page table pages are freed and reused.
> 
>> Modern IOMMUs often cache page table entries of the intermediate-level
>> page table as long as the entry is valid, no matter the permissions, to
>> optimize walk performance. Currently the iommu driver is notified only
>> for changes of user VA mappings, so the IOMMU's internal caches may
>> retain stale entries for kernel VA. When kernel page table mappings are
>> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
>> entries, Use-After-Free (UAF) vulnerability condition arises.
>>
>> If these freed page table pages are reallocated for a different purpose,
>> potentially by an attacker, the IOMMU could misinterpret the new data as
>> valid page table entries. This allows the IOMMU to walk into attacker-
>> controlled memory, leading to arbitrary physical memory DMA access or
>> privilege escalation.
> Note that it's not just use-after-free. It's literally that the IOMMU
> will keep writing Accessed and Dirty bits while it thinks the page is
> still a page table. The IOMMU will sit there happily setting bits. So,
> it's_write_ after free too.
> 
>> To mitigate this, introduce a new iommu interface to flush IOMMU caches.
>> This interface should be invoked from architecture-specific code that
>> manages combined user and kernel page tables, whenever a kernel page table
>> update is done and the CPU TLB needs to be flushed.
> There's one tidbit missing from this:
> 
> 	Currently SVA contexts are all unprivileged. They can only
> 	access user mappings and never kernel mappings. However, IOMMU
> 	still walk kernel-only page tables all the way down to the leaf
> 	where they realize that the entry is a kernel mapping and error
> 	out.

Thank you for the guidance. I will improve the commit message
accordingly, as follows.

iommu/sva: Invalidate stale IOTLB entries for kernel address space

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables. The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table. Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings. This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

A Use-After-Free (UAF) and Write-After-Free (WAF) condition arises when
kernel page table pages are freed and later reallocated. The IOMMU could
misinterpret the new data as valid page table entries. The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation. This is also a Write-After-Free
issue, as the IOMMU will potentially continue to write Accessed and Dirty
bits to the freed memory while attempting to walk the stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings. However, the IOMMU will still walk kernel-only page tables
all the way down to the leaf entries, where it realizes the mapping
is for the kernel and errors out. This means the IOMMU still caches
these intermediate page table entries, making the described vulnerability
a real concern.

To mitigate this, a new IOMMU interface is introduced to flush IOTLB
entries for the kernel address space. This interface is invoked from the
x86 architecture code that manages combined user and kernel page tables,
specifically when a kernel page table update requires a CPU TLB flush.

Thanks,
baolu

