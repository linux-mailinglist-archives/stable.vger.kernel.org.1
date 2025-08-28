Return-Path: <stable+bounces-176565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A905CB393E5
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E2C687151
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F72727EA;
	Thu, 28 Aug 2025 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxcGHTrB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02113DDAA;
	Thu, 28 Aug 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362965; cv=none; b=j0Ia2ESQrC+a83/AGzO81F5+blP214jf2PKsnWpKj3NzIlGQHfd1nnhPLV1+kqJquimvIMfA0VXctLCE3wYxElrqSvNL5GB7wDQ1pyveeq48GSxi359Yzokb3fFYkfkETmJTSyb3SLhb9CxsdhYuPxKkkma13KqvY4nZDXujyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362965; c=relaxed/simple;
	bh=szTe0dTbwwG5MWJhylxFr9OxQ7bczUM8OGrRq2+Ivwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JptB7O1n8kiX6APynnPKtsO8/kXIAoOkggfGtJYUGhS2UX+wAFj/OiONySLCBZ0oX2g+0Bsw29emvxFYTIEfWMUG/QbKIclCc/lH6bZtlGGlOFR44UcEVAsxWlCwi+VZpL+yliTQBUAhpikVZcIVFf3M6saEOAjcidDskCqfMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxcGHTrB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756362963; x=1787898963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=szTe0dTbwwG5MWJhylxFr9OxQ7bczUM8OGrRq2+Ivwc=;
  b=BxcGHTrBuO4J1SuGzDARzuCDpb3TB2bZZcg/FkQb8HkOZ9STTcIM24xJ
   FqUwp3Lf8DPSjodj1NvPYb2E6a11dzwMTOquKVMVq3hYsHoy0v24b7Q8R
   wtebTe8PchOHj7DjBT9UwMOIRPbl/g4oLCeweoVXiyEXj2h8l3lcXk1ZJ
   dt1rXYaOGvCmN2MZqDvpeMf9jOq5mgEr776RyG1N3L3VhZoFIdaRq5/4W
   nv5busI6n0mDoTgsiyYqZRTZHxak/f82ecyuWOpwFRXrPV4h5IAD3dh8u
   iSXHxgxEBLTyPkHHEm8ZvRlMkaPM+opqdSq1dHHoGG9H80p6HHUBihUyk
   Q==;
X-CSE-ConnectionGUID: bV3mPBPkRoyi+I0+YINM7g==
X-CSE-MsgGUID: MY4C0sKBR+2jiAr8f2usng==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69994260"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69994260"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:36:01 -0700
X-CSE-ConnectionGUID: FvopSwX+TDyhC9bLjSSbSQ==
X-CSE-MsgGUID: 7QGIVFLxQmyrszb20JVXeg==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:35:59 -0700
Message-ID: <0b9492bc-b033-46c3-acf2-6fca3d19148b@linux.intel.com>
Date: Thu, 28 Aug 2025 14:33:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/intel: Fix __domain_mapping()'s usage of
 switch_to_super_page()
To: David Woodhouse <dwmw2@infradead.org>, Eugene Koira
 <eugkoira@amazon.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 longpeng2@huawei.com, graf@amazon.de, nsaenz@amazon.com,
 nh-open-source@amazon.com, stable@vger.kernel.org
References: <20250826143816.38686-1-eugkoira@amazon.com>
 <37c9ae89eb6cf879e5b984d53d590a69bcf1666a.camel@infradead.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <37c9ae89eb6cf879e5b984d53d590a69bcf1666a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/25 23:48, David Woodhouse wrote:
> On Tue, 2025-08-26 at 14:38 +0000, Eugene Koira wrote:
>> switch_to_super_page() assumes the memory range it's working on is aligned
>> to the target large page level. Unfortunately, __domain_mapping() doesn't
>> take this into account when using it, and will pass unaligned ranges
>> ultimately freeing a PTE range larger than expected.
>>
>> Take for example a mapping with the following iov_pfn range [0x3fe400,
>> 0x4c0600], which should be backed by the following mappings:
> 
> The range is [0x3fe400, 0x4c0600) ?
> 
>>     iov_pfn [0x3fe400, 0x3fffff] covered by 2MiB pages
>>     iov_pfn [0x400000, 0x4bffff] covered by 1GiB pages
>>     iov_pfn [0x4c0000, 0x4c05ff] covered by 2MiB pages
>>
>> Under this circumstance, __domain_mapping() will pass [0x400000, 0x4c05ff]
>> to switch_to_super_page() at a 1 GiB granularity, which will in turn
>> free PTEs all the way to iov_pfn 0x4fffff.
>>
>> Mitigate this by rounding down the iov_pfn range passed to
>> switch_to_super_page() in __domain_mapping()
>> to the target large page level.
>>
>> Additionally add range alignment checks to switch_to_super_page.
>>
>> Fixes: 9906b9352a35 ("iommu/vt-d: Avoid duplicate removing in __domain_mapping()")
>> Signed-off-by: Eugene Koira <eugkoira@amazon.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/iommu/intel/iommu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9c3ab9d9f69a..dff2d895b8ab 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1575,6 +1575,10 @@ static void switch_to_super_page(struct dmar_domain *domain,
>>   	unsigned long lvl_pages = lvl_to_nr_pages(level);
>>   	struct dma_pte *pte = NULL;
>>   
>> +	if (WARN_ON(!IS_ALIGNED(start_pfn, lvl_pages) ||
>> +		    !IS_ALIGNED(end_pfn + 1, lvl_pages)))
>> +		return;
>> +
>>   	while (start_pfn <= end_pfn) {
>>   		if (!pte)
>>   			pte = pfn_to_dma_pte(domain, start_pfn, &level,
>> @@ -1650,7 +1654,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>>   				unsigned long pages_to_remove;
>>   
>>   				pteval |= DMA_PTE_LARGE_PAGE;
>> -				pages_to_remove = min_t(unsigned long, nr_pages,
>> +				pages_to_remove = min_t(unsigned long,
>> +							round_down(nr_pages, lvl_pages),
>>   							nr_pte_to_next_page(pte) * lvl_pages);
>>   				end_pfn = iov_pfn + pages_to_remove - 1;
>>   				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
> 
> I'm mildly entertained by the fact that the *only* comment in this
> block of code is a lie. Would you care to address that while you're
> here? Maybe the comment could look something like...
> 
> 			/* If the new mapping is eligible for a large page, then
> 			 * remove all smaller pages that the existing pte at this
> 			 * level references.
> 			 * XX: do we even need to bother calling switch_to_super_page()
> 			 * if this PTE wasn't *present* before?
> 			 */
> 
> I bet it would benefit from one or two other one-line comments to make
> it clearer what's going on, too...
> 
> But in general, I think this looks sane even though this code makes my
> brain hurt. Could do with a test case, in an ideal world. Maybe we can
> work on that as part of the generic pagetable support which is coming?

Agreed. The generic pagetable work will replace this code, so this will
be removed. Therefore, we need a fix patch that can be backported before
the generic pagetable for vt-d lands.

Thanks,
baolu

