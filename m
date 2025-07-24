Return-Path: <stable+bounces-164545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C928B0FF0C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DC516B89C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4A1C8FBA;
	Thu, 24 Jul 2025 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ7gOIW+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E11BF58;
	Thu, 24 Jul 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326204; cv=none; b=FiC7TtQoXmb8o2lN0Uk5Kk2GCxIQotIZ42CYrQFrA7HbJiLnrTHhx2jjjGxOBfP4QgNPvdiRTE4wUF1FbmOGfuPdm2VddPSy94wuyYm4bnhE7gwKlSVjqrhMsEqaW4e6Whmk9qtKXIgAUFEWczFRrBKZL/CjS2de8NNu6nkDemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326204; c=relaxed/simple;
	bh=kmKfDqwToB2wQazMZlvCLP2VSC7ACpEaqy/OGDLkVTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgOUPMJyRH4HET6T/MJxPh/p5VHlgvmiX1TxIFjopfAIXNmN3oFToMVWb3oKkgf2OWEDec6hCSjLaH7xS9Rz6vVr5pGjuZqbssnHu580MKBYQAwKMjB/as3FjfVtPTjP+qv6Y8AvrUcbyil+0bwodf87tlZKsn9rATIFRF/7Vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ7gOIW+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753326203; x=1784862203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kmKfDqwToB2wQazMZlvCLP2VSC7ACpEaqy/OGDLkVTc=;
  b=fZ7gOIW+9IKbq6xarDRChBZEVlYmaEYqAZpxWZL5PWUSpW7b3QDXubEY
   K3z05xjHmxXrKvt4FGKjhy0mNbpi6KK2iUAbLa7k5fZ5SG0ouI1U9/U3r
   mU7CTWxQfnHPv6pUIOrbwAmo/xHiHqVTm+2ZaXchP6NKFvOPKrxyCzW+S
   KDWxCVjSSJg77wx2XV99wjCqeU7e74LrObwda8QeFCalieXDgrc3aALE7
   ddSaDKFuQwlzmK1nPOoSgamOfIN9JxHtZrfCpgoUBLC5NJpQ1HzZMywwR
   Iqy5CtkYvkzOl3F9mXCRJ/nXtk5QhREo5g6oxq1TB35GWR05P4QB6NvVX
   g==;
X-CSE-ConnectionGUID: Mf5cPKQFSzWKCYVkRZEIaA==
X-CSE-MsgGUID: IM0OYFkMTQ6s5Grz7TmFUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55501045"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55501045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 20:03:23 -0700
X-CSE-ConnectionGUID: NOnQGpbMQ5KTds/Btk2D2w==
X-CSE-MsgGUID: bAlQREAIR+6Es9SYo8nZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="197049249"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 20:03:18 -0700
Message-ID: <2a1ffe30-b0a6-45b3-8dcb-feaa285e1e5b@linux.intel.com>
Date: Thu, 24 Jul 2025 11:01:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Yu Zhang <zhangyu1@linux.microsoft.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
 <20250710132234.GL1599700@nvidia.com>
 <62580eab-3e68-4132-981a-84167d130d9f@intel.com>
 <6dn5n5cge7acmmfgb5zi7ctcbn5hiqyr2xhmgbdxohqydhgmtt@47nnr4tnzlnh>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6dn5n5cge7acmmfgb5zi7ctcbn5hiqyr2xhmgbdxohqydhgmtt@47nnr4tnzlnh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 16:17, Yu Zhang wrote:
> On Thu, Jul 10, 2025 at 08:26:06AM -0700, Dave Hansen wrote:
>> On 7/10/25 06:22, Jason Gunthorpe wrote:
>>>> Why does this matter? We flush the CPU TLB in a bunch of different ways,
>>>> _especially_ when it's being done for kernel mappings. For example,
>>>> __flush_tlb_all() is a non-ranged kernel flush which has a completely
>>>> parallel implementation with flush_tlb_kernel_range(). Call sites that
>>>> use_it_ are unaffected by the patch here.
>>>>
>>>> Basically, if we're only worried about vmalloc/vfree freeing page
>>>> tables, then this patch is OK. If the problem is bigger than that, then
>>>> we need a more comprehensive patch.
>>> I think we are worried about any place that frees page tables.
>> The two places that come to mind are the remove_memory() code and
>> __change_page_attr().
>>
>> The remove_memory() gunk is in arch/x86/mm/init_64.c. It has a few sites
>> that do flush_tlb_all(). Now that I'm looking at it, there look to be
>> some races between freeing page tables pages and flushing the TLB. But,
>> basically, if you stick to the sites in there that do flush_tlb_all()
>> after free_pagetable(), you should be good.
>>
>> As for the __change_page_attr() code, I think the only spot you need to
>> hit is cpa_collapse_large_pages() and maybe the one in
>> __split_large_page() as well.
>>
>> This is all disturbingly ad-hoc, though. The remove_memory() code needs
>> fixing and I'll probably go try to bring some order to the chaos in the
>> process of fixing it up. But that's a separate problem than this IOMMU fun.
>>
> Could we consider to split the flush_tlb_kernel_range() into 2 different
> versions:
> - the one which only flushes the CPU TLB
> - the one which flushes the CPU paging structure cache and then notifies
>    IOMMU to do the same(e.g., in pud_free_pmd_page()/pmd_free_pte_page())?

 From the perspective of an IOMMU, there is no need to split. IOMMU SVA
only allows the device to access user-space memory with user
permission. Access to kernel address space with privileged permission
is not allowed. Therefore, the IOMMU subsystem only needs a callback to
invalidate the paging structure cache.

Thanks,
baolu

