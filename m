Return-Path: <stable+bounces-106857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7EFA028D2
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7331885122
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4670820;
	Mon,  6 Jan 2025 15:11:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504C35971;
	Mon,  6 Jan 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176300; cv=none; b=FWFqz5CafJlJ6Z4XAqmuonWgC3Yc4IWkffezInUnJFFOzxn4H70ZqUkUO47SbeXA0cfvtv4kmmWgBF95K4p0J/Vf23Rl2oBEgrKqiOnO3TLX4wbM9jXa+DiYIXSMnAbAcW13puJWz4cm2wCebZfpRhaXL88mswSJZJh5G2MEhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176300; c=relaxed/simple;
	bh=ptd8o47a1a0EjnlYtgCY0wElQyzXvS8GL2f5BayYJzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KW/0DwBdXkj+17fGLkTKVtMA9kFJeUD79so32yzeyRDYZ+xLeWdSblSrgoeiyjJLptlzepbdRQbk5hv7mBPBexZ3LlbXMPfMRoXSDRK7xPrA1w5CG5Exss5m1eF9wHUV0q5JDik0NL+c5we4Wvk1l/38EGMmLbI/yu0N+7fA6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F161143D;
	Mon,  6 Jan 2025 07:12:05 -0800 (PST)
Received: from [10.163.54.142] (unknown [10.163.54.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EFC93F59E;
	Mon,  6 Jan 2025 07:11:31 -0800 (PST)
Message-ID: <34dab81b-1b53-4ff0-89fd-2b5279a29942@arm.com>
Date: Mon, 6 Jan 2025 20:41:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: mm: Populate vmemmap at the page level for
 hotplugged sections
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, catalin.marinas@arm.com
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250103085002.27243-1-quic_zhenhuah@quicinc.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250103085002.27243-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Zhenhua,

On 1/3/25 14:20, Zhenhua Huang wrote:
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hotplugging granule is always 128M. However,

A small nit s/hotplugging/hot plug/

Also please do mention that 128M is SECTION_SIZE_BITS == 27 on arm64
platform for 4K base pages which is the page size in context here.


> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> which added 2M hotplugging granule disrupted the arm64 assumptions.

A small nit s/hotplugging/hot plug/

Also please do mention that 2M is SUB_SECTION_SIZE.

> 
> Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
> pmd_sect() is true, the entire PMD section is cleared, even if there is
> other effective subsection. For example pagemap1 and pagemap2 are part
> of a single PMD entry and they are hot-added sequentially. Then pagemap1
> is removed, vmemmap_free() will clear the entire PMD entry freeing the
> struct page metadata for the whole section, even though pagemap2 is still
> active.

I guess pagemap1/2 here indicates the struct pages virtual regions for two
different vmemmap mapped sub sections covered via a single PMD entry ? But
please do update the above paragraph appropriately because pagemap<N> might
be confused with /proc/<pid>/pagemap mechanism.

Also please do mention that similar problems exist with linear mapping for
16K (PMD = 32M) and 64K (PMD = 512M) base pages as their block mappings
exceed SUBSECTION_SIZE. Hence tearing down the entire PMD mapping too will
leave other subsections unmapped in the linear mapping.

> 
> To address the issue, we need to prevent PMD/PUD/CONT mappings for both
> linear and vmemmap for non-boot sections if the size exceeds 2MB

s/if the size/if corresponding size on the given base page/

> (considering sub-section is 2MB). We only permit 2MB blocks in a 4KB page
> configuration.

PMD block in 4K page size config as it's PMD_SIZE matches the SUBSECTION_SIZE
but only for linear mapping.


> 
> Cc: stable@vger.kernel.org # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
> Hi Catalin and Anshuman,
> Based on your review comments, I concluded below patch and tested with my setup.
> I have not folded patchset #2 since this patch seems to be enough for backporting..
> Please see if you have further suggestions.
> 
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e2739b69e11b..2b4d23f01d85 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,9 +42,11 @@
>  #include <asm/pgalloc.h>
>  #include <asm/kfence.h>
>  
> -#define NO_BLOCK_MAPPINGS	BIT(0)
> +#define NO_PMD_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define NO_PUD_BLOCK_MAPPINGS	BIT(3)  /* Hotplug case: do not want block mapping for PUD */
> +#define NO_BLOCK_MAPPINGS (NO_PMD_BLOCK_MAPPINGS | NO_PUD_BLOCK_MAPPINGS)


Should not NO_PMD_BLOCK_MAPPINGS and NO_PUD_BLOCK_MAPPINGS be adjacent bits
for better readability ? But that will also cause some additional churn.

>  
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
> @@ -254,7 +256,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  
>  		/* try section mapping first */
>  		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {

Behavior will remain unchanged for all existing users of NO_BLOCK_MAPPINGS
as it will now contain NO_PMD_BLOCK_MAPPINGS.

>  			pmd_set_huge(pmdp, phys, prot);
>  
>  			/*
> @@ -356,10 +358,11 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  
>  		/*
>  		 * For 4K granule only, attempt to put down a 1GB block
> +		 * Hotplug case: do not attempt 1GB block
>  		 */
>  		if (pud_sect_supported() &&
>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		   (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {

Behavior will remain unchanged for all existing users of NO_BLOCK_MAPPINGS
as it will now contain NO_PUD_BLOCK_MAPPINGS.

>  			pud_set_huge(pudp, phys, prot);
>  
>  			/*
> @@ -1175,9 +1178,16 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
> +	unsigned long start_pfn;
> +	struct mem_section *ms;
> +
>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>  
> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	start_pfn = page_to_pfn((struct page *)start);
> +	ms = __pfn_to_section(start_pfn);
> +
> +	/* Hotplugged section not support hugepages */

Please update the comment as

	/*
	 * Hotplugged section does not support hugepages as
	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
	 * struct page range that exceeds a SUBSECTION_SIZE
	 * i.e 2MB - for all available base page sizes.
	 */

> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || !early_section(ms))
>  		return vmemmap_populate_basepages(start, end, node, altmap);
>  	else
>  		return vmemmap_populate_hugepages(start, end, node, altmap);
> @@ -1339,9 +1349,24 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
>  	int ret, flags = NO_EXEC_MAPPINGS;
> +	unsigned long start_pfn = page_to_pfn((struct page *)start);
> +	struct mem_section *ms = __pfn_to_section(start_pfn);
>  
>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>  
> +	/* Should not be invoked by early section */
> +	WARN_ON(early_section(ms));
> +
> +	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	/*
> +	 * As per subsection granule is 2M, allow PMD block mapping in
> +	 * case 4K PAGES.
> +	 * Other cases forbid section mapping.
> +	 */

IIUC subsection size is 2M regardless of the page size. But with 4K pages
on arm64, PMD_SIZE happen to be 2M. Hence there is no problem in creating
linear mappings at PMD block level, which will not be the case with other
page sizes i.e 16K and 64K.

include/linux/mmzone.h

#define SUBSECTION_SHIFT 21
#define SUBSECTION_SIZE (1UL << SUBSECTION_SHIFT)

Please update the comment with following changes but above IS_ENABLED()
statement as it talks about all page size configs.

	/*
	 * 4K base page's PMD_SIZE matches SUBSECTION_SIZE i.e 2MB. Hence
	 * PMD section mapping can be allowed, but only for 4K base pages.
	 * Where as PMD_SIZE (hence PUD_SIZE) for other page sizes exceed
	 * SUBSECTION_SIZE.
	 */
> +		flags |= NO_PUD_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> +	else
> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> +
>  	if (can_set_direct_map())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  

