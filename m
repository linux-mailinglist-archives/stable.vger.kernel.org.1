Return-Path: <stable+bounces-161505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3214AFF6A6
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8D13B045A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 02:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1F26E14C;
	Thu, 10 Jul 2025 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8hZwqcE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB3A944;
	Thu, 10 Jul 2025 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113803; cv=none; b=hiqAZDKlFnPU5/oFcLhUdibxI8vk9ojuUBMQT3kNaXkvmID0NwIoTKyUWWKdPCqsL7yv4JKpF9MT+BwpqB8GrUNfKio1OuStAG3tcESBDZ5QlR4l/HhOI8e0IGhClRTq7m5n+wYwUJUVGEPwMGLruvtwofDn3NFI3wbCBZsIeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113803; c=relaxed/simple;
	bh=EyqwCncsgl6qAwYEVSz/MtYJS7SeGpr3zIv6jcm5xBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2bd+rrH1/PdT6CupSBVAMiXOI/n/thk5+VM740J3ea7MGeNYF1UfF6Uf8/rETDrCnutiNtenckMcW+5Rf36KE8gd9B3k+D3XGXNg4TYenj7vLDV59suG95yg6VIufvLNc4PILLuKexYuaLysMvlGObhPHZi8XfskEhXR5v8jOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8hZwqcE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752113802; x=1783649802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EyqwCncsgl6qAwYEVSz/MtYJS7SeGpr3zIv6jcm5xBk=;
  b=S8hZwqcEsU7ClmeHA5Q0r/YkXjY8p8aa39YEKZrPyi/univPKb9kedNN
   5O6i8qAU/dfzIBxNq/KqmL7x4yy2I9YrRO38cBg6ryWCAYlESiVVpT8lU
   qvmieNFwXInyWY/Alcge9kmpUh0xWTf9BaDP/+137NS/vI4yxJOzwxtU8
   KdoO33mhle6gOLmM/2B+0JmLKfldTAhLYbpgaUkjQgfmoZ1Mi3yiQ1Lfw
   kk+QwxJMU4NeOhCxagWZAdQAzW7D9Q54ObxQwtfy02UEaVnagVWpB58kG
   pKgdj5Y1QgeBtP30qPaXUCyxF11RynBNnuYpK/bRfuWGHYlw7Q576OEtC
   A==;
X-CSE-ConnectionGUID: Q9jXkI/pRZGnrS5P9adFAw==
X-CSE-MsgGUID: K+218n0kTwmrUg79XXNj1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54478315"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54478315"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:16:41 -0700
X-CSE-ConnectionGUID: CtSF3vhWQlOmlEHQTgPpDw==
X-CSE-MsgGUID: ueASjIQ0T+SeGsf66lCpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="155588610"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:16:37 -0700
Message-ID: <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
Date: Thu, 10 Jul 2025 10:14:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 23:29, Dave Hansen wrote:
> On 7/8/25 23:28, Lu Baolu wrote:
>> Modern IOMMUs often cache page table entries to optimize walk performance,
>> even for intermediate page table levels. If kernel page table mappings are
>> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
>> entries, Use-After-Free (UAF) vulnerability condition arises. If these
>> freed page table pages are reallocated for a different purpose, potentially
>> by an attacker, the IOMMU could misinterpret the new data as valid page
>> table entries. This allows the IOMMU to walk into attacker-controlled
>> memory, leading to arbitrary physical memory DMA access or privilege
>> escalation.
> 
> The approach here is certainly conservative and simple. It's also not
> going to cause big problems on systems without fancy IOMMUs.
> 
> But I am a _bit_ worried that it's _too_ conservative. The changelog
> talks about page table page freeing, but the actual code:
> 
>> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>   		kernel_tlb_flush_range(info);
>>   
>>   	put_flush_tlb_info();
>> +	iommu_sva_invalidate_kva_range(start, end);
>>   }
> 
> is in a very generic TLB flushing spot that's used for a lot more than
> just freeing page tables.
> 
> If the problem is truly limited to freeing page tables, it needs to be
> commented appropriately.

Yeah, good comments. It should not be limited to freeing page tables;
freeing page tables is just a real case that we can see in the vmalloc/
vfree paths. Theoretically, whenever a kernel page table update is done
and the CPU TLB needs to be flushed, the secondary TLB (i.e., the caches
on the IOMMU) should be flushed accordingly. It's assumed that this
happens in flush_tlb_kernel_range().

Thanks,
baolu

