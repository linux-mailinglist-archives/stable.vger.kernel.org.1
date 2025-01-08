Return-Path: <stable+bounces-107980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B547CA057BA
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E921883FCE
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E0D1F5407;
	Wed,  8 Jan 2025 10:11:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C41F0E33;
	Wed,  8 Jan 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331105; cv=none; b=PY0owZQfXtJDTjAnQpJq4kykGnMWbEF81372wjjplVL9zjULU5VDlXo5KPLvpm81cMD6VPnKCzpxSCokorRTUBihuWZY/1G6rlqzv76F8vttLTZZIkckGKxOapoFs1FRJ6LwM108AQj5eR6TwuQSOOU0aXhiOdeQDo3TcDpWpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331105; c=relaxed/simple;
	bh=/iomu8VSdurjJS35EXRsfIqMW5H9Dmf4S5DhifQTUYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMzZRy/ESRPPnNxVTRhWJIoA0ZidFZAhvPkf1mmVbmZLSF3KYN58mu008udZsiZVKH/9zByxCtNtb/JldcqJn4Im4ZT4aZRnYFMVQXzUj3vRtvaA5z7M4m+8b5myupT0Zlrb7aHe670a3TFTTH3w7Zv8b1ntmpLvAff3PASyl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB47213D5;
	Wed,  8 Jan 2025 02:12:10 -0800 (PST)
Received: from [10.162.16.95] (a077893.blr.arm.com [10.162.16.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D1833F59E;
	Wed,  8 Jan 2025 02:11:37 -0800 (PST)
Message-ID: <fbb134e0-cfeb-4c6e-98b4-d945f95383db@arm.com>
Date: Wed, 8 Jan 2025 15:41:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Catalin Marinas <catalin.marinas@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z31--x4unDHRU5Zo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 00:52, Catalin Marinas wrote:
> On Tue, Jan 07, 2025 at 03:42:52PM +0800, Zhenhua Huang wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e2739b69e11b..5e0f514de870 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -42,9 +42,11 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/kfence.h>
>>  
>> -#define NO_BLOCK_MAPPINGS	BIT(0)
>> -#define NO_CONT_MAPPINGS	BIT(1)
>> -#define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>> +#define NO_PMD_BLOCK_MAPPINGS	BIT(0)
>> +#define NO_PUD_BLOCK_MAPPINGS	BIT(1)  /* Hotplug case: do not want block mapping for PUD */
>> +#define NO_BLOCK_MAPPINGS (NO_PMD_BLOCK_MAPPINGS | NO_PUD_BLOCK_MAPPINGS)
> 
> Nit: please use a tab instead of space before (NO_PMD_...)
> 
>> +#define NO_CONT_MAPPINGS	BIT(2)
>> +#define NO_EXEC_MAPPINGS	BIT(3)	/* assumes FEAT_HPDS is not used */
>>  
>>  u64 kimage_voffset __ro_after_init;
>>  EXPORT_SYMBOL(kimage_voffset);
>> @@ -254,7 +256,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>  
>>  		/* try section mapping first */
>>  		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>> +		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {
>>  			pmd_set_huge(pmdp, phys, prot);
>>  
>>  			/*
>> @@ -356,10 +358,11 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>  
>>  		/*
>>  		 * For 4K granule only, attempt to put down a 1GB block
>> +		 * Hotplug case: do not attempt 1GB block
>>  		 */
> 
> I don't think we need this comment added here. The hotplug case is a
> decision of the caller, so better to have the comment there.

Agreed.

> 
>>  		if (pud_sect_supported() &&
>>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>> +		   (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {
>>  			pud_set_huge(pudp, phys, prot);
> 
> Nit: something wrong with the alignment here. I think the unmodified
> line after the 'if' one above was misaligned before your patch.
> 
>>  
>>  			/*
>> @@ -1175,9 +1178,21 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  		struct vmem_altmap *altmap)
>>  {
>> +	unsigned long start_pfn;
>> +	struct mem_section *ms;
>> +
>>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>  
>> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +	start_pfn = page_to_pfn((struct page *)start);
>> +	ms = __pfn_to_section(start_pfn);
> 
> Hmm, it would have been better if the core code provided the start pfn
> as it does for vmemmap_populate_compound_pages() but I'm fine with
> deducting it from 'start'.

Right, that will require changing arguments in generic vmemmap_populate(). 

> 
>> +	/*
>> +	 * Hotplugged section does not support hugepages as
>> +	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
>> +	 * struct page range that exceeds a SUBSECTION_SIZE
>> +	 * i.e 2MB - for all available base page sizes.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || !early_section(ms))
>>  		return vmemmap_populate_basepages(start, end, node, altmap);
>>  	else
>>  		return vmemmap_populate_hugepages(start, end, node, altmap);
>> @@ -1339,9 +1354,25 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  		    struct mhp_params *params)
>>  {
>>  	int ret, flags = NO_EXEC_MAPPINGS;
>> +	unsigned long start_pfn = page_to_pfn((struct page *)start);
>> +	struct mem_section *ms = __pfn_to_section(start_pfn);
> 
> This looks wrong. 'start' here is a physical address, you want
> PFN_DOWN() instead.

Agreed.

> 
>>  
>>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>  
>> +	/* should not be invoked by early section */
>> +	WARN_ON(early_section(ms));
>> +
>> +	/*
>> +	 * 4K base page's PMD_SIZE matches SUBSECTION_SIZE i.e 2MB. Hence
>> +	 * PMD section mapping can be allowed, but only for 4K base pages.
>> +	 * Where as PMD_SIZE (hence PUD_SIZE) for other page sizes exceed
>> +	 * SUBSECTION_SIZE.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +		flags |= NO_PUD_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 
> In theory we can allow contiguous PTE mappings but not PMD. You could
> probably do the same as a NO_BLOCK_MAPPINGS and split it into multiple
> components - NO_PTE_CONT_MAPPINGS and so on.

That's a good idea.

> 
>> +	else
>> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 
> Similarly with 16K/64K pages we can allow contiguous PTEs as they all go
> up to 2MB blocks.
> 
> I think we should write the flags setup in a more readable way than
> trying to do mental maths on the possible combinations, something like:
> 
> 	flags = NO_PUD_BLOCK_MAPPINGS | NO_PMD_CONT_MAPPINGS;
> 	if (SUBSECTION_SHIFT < PMD_SHIFT)
> 		flags |= NO_PMD_BLOCK_MAPPINGS;
> 	if (SUBSECTION_SHIFT < CONT_PTE_SHIFT)
> 		flags |= NO_PTE_CONT_MAPPINGS;

Just wondering why not start with PUD level itself ? Although SUBSECTION_SHIFT
might never reach the PUD level but this will help keep the flags calculations
bit simple and ready for all future changes.

	flags = 0;
 	if (SUBSECTION_SHIFT < PUD_SHIFT)
 		flags |= NO_PUD_BLOCK_MAPPINGS;
 	if (SUBSECTION_SHIFT < CONT_PMD_SHIFT)
 		flags |= NO_PMD_CONT_MAPPINGS;

> 
> This way we don't care about the page size and should cover any changes
> to SUBSECTION_SHIFT making it smaller than 2MB.
> 
Agreed.

