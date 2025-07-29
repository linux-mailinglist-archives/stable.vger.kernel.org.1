Return-Path: <stable+bounces-165023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32BB1460F
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BB0541993
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BEB1FAC37;
	Tue, 29 Jul 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msgBhzu6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32881F7580;
	Tue, 29 Jul 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755074; cv=none; b=YCmtI5Ep/sMOTEn+daVf8oOszZulqg5GFOKpwFryAuJGTPII+0tHmdW8pruYyajHg8Xn7y8O11WEwR4aFZkCYZBvJWewO0hAcLl9d5/8JN424M70fM1a7COUmdE4UBJR/qJslMgjmdLT/UhkELk5WmLbHYRfl/llvhCIH94Tz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755074; c=relaxed/simple;
	bh=zC0nRcR6cty3AjQe02kjM9LHjo84K3+8o1Zpfqdf6SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2KVX5fY69nhXFrQ38SEXY4ajmOvN7hdp2uPONYRvwsEZnmwKwHB42Qeqw4PbYoVx68Mt2sndHMZmVXP3q0h7bM7Dxb9tAt6vcJPNkkwS8g+Ht2CJHuflBER5F7BxSSghjhZXH6d48WCsEVYsRYzk1GkIMqttn0htO5N4qTP+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msgBhzu6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753755073; x=1785291073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zC0nRcR6cty3AjQe02kjM9LHjo84K3+8o1Zpfqdf6SM=;
  b=msgBhzu6JSo4ru3qONmzQlkkqYsxALBWGt6HPmAhP8yuiOOVURPIQj50
   9EZ1H22t51rbzMMnU2Z0CsERoj1l7epidKb2dRindNRYX9Io0R6NXUHmE
   AcerVyhNXOxBQIQcxTGJjkQ3YE6MX7zEh7bc4hfZL2U9fF5TvxOao2j+l
   9dz6EmBqS+avbnPgUqxcvcdL/X3htfUU05Ds7wflSsbK1cl/cKePZZYGI
   Wrt1WL5Q6Cad7A080y+L+OcahNUicYKBnLsnncpIHO0G7LGJkb4p8GnzN
   OgaUX0xXGSoqAY0Moh88W0OQADtSGOlhyOojV7A/C1MFpDHqYtgW4fvxf
   w==;
X-CSE-ConnectionGUID: uZBxJ5CjRHK6YbhvVIyWXA==
X-CSE-MsgGUID: u1I7EyXPQM+Klq/+BY+g3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="81453523"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="81453523"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 19:11:12 -0700
X-CSE-ConnectionGUID: qp5D/NjOQaW+rJZ9uIvDKQ==
X-CSE-MsgGUID: PM8nO3jzRBC7wsv6bJjHtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162615706"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 19:11:08 -0700
Message-ID: <d3cd4427-58a3-417b-a409-81d31110faeb@linux.intel.com>
Date: Tue, 29 Jul 2025 10:08:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
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
 <2a1ffe30-b0a6-45b3-8dcb-feaa285e1e5b@linux.intel.com>
 <pk2b4xgxewxotp557osucliagmziv3erepsret4hbnxnvhff2n@p2gark4kdiqw>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <pk2b4xgxewxotp557osucliagmziv3erepsret4hbnxnvhff2n@p2gark4kdiqw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 01:36, Yu Zhang wrote:
> On Thu, Jul 24, 2025 at 11:01:12AM +0800, Baolu Lu wrote:
>> On 7/11/25 16:17, Yu Zhang wrote:
>>> On Thu, Jul 10, 2025 at 08:26:06AM -0700, Dave Hansen wrote:
>>>> On 7/10/25 06:22, Jason Gunthorpe wrote:
>>>>>> Why does this matter? We flush the CPU TLB in a bunch of different ways,
>>>>>> _especially_ when it's being done for kernel mappings. For example,
>>>>>> __flush_tlb_all() is a non-ranged kernel flush which has a completely
>>>>>> parallel implementation with flush_tlb_kernel_range(). Call sites that
>>>>>> use_it_ are unaffected by the patch here.
>>>>>>
>>>>>> Basically, if we're only worried about vmalloc/vfree freeing page
>>>>>> tables, then this patch is OK. If the problem is bigger than that, then
>>>>>> we need a more comprehensive patch.
>>>>> I think we are worried about any place that frees page tables.
>>>> The two places that come to mind are the remove_memory() code and
>>>> __change_page_attr().
>>>>
>>>> The remove_memory() gunk is in arch/x86/mm/init_64.c. It has a few sites
>>>> that do flush_tlb_all(). Now that I'm looking at it, there look to be
>>>> some races between freeing page tables pages and flushing the TLB. But,
>>>> basically, if you stick to the sites in there that do flush_tlb_all()
>>>> after free_pagetable(), you should be good.
>>>>
>>>> As for the __change_page_attr() code, I think the only spot you need to
>>>> hit is cpa_collapse_large_pages() and maybe the one in
>>>> __split_large_page() as well.
>>>>
>>>> This is all disturbingly ad-hoc, though. The remove_memory() code needs
>>>> fixing and I'll probably go try to bring some order to the chaos in the
>>>> process of fixing it up. But that's a separate problem than this IOMMU fun.
>>>>
>>> Could we consider to split the flush_tlb_kernel_range() into 2 different
>>> versions:
>>> - the one which only flushes the CPU TLB
>>> - the one which flushes the CPU paging structure cache and then notifies
>>>     IOMMU to do the same(e.g., in pud_free_pmd_page()/pmd_free_pte_page())?
>>  From the perspective of an IOMMU, there is no need to split. IOMMU SVA
>> only allows the device to access user-space memory with user
>> permission. Access to kernel address space with privileged permission
>> is not allowed. Therefore, the IOMMU subsystem only needs a callback to
>> invalidate the paging structure cache.
> Thanks Baolu.
> 
> Indeed. That's why I was wondering if we could split flush_tlb_kernel_range()
> into 2 versions - one used only after a kernal virtual address range is
> unmapped, and another one used after a kernel paging structure is freed.
> Only the 2nd one needs to notify the IOMMU subsystem.

Yeah! That sounds better.

Thanks,
baolu

