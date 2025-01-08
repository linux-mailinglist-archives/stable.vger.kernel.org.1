Return-Path: <stable+bounces-107979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC8A0579D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FFC1627BE
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A11F5403;
	Wed,  8 Jan 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CEfJkXXE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCA1ACEA2;
	Wed,  8 Jan 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330901; cv=none; b=gDg18qjCd6SNebozKSYZY0Eh8/LA3v0ICeovI/CZAcl2N8rb94/fp90eP056tiY+DLs+FEjcigXCa96ZWYXHZCuayDy9PcspRZQIiaSSbJBuj8L1ZF07DDA6EuBqDiIxNsTPIuNYKQGhFvCugNbEIDD9cEW9+EjypLzt7xYn028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330901; c=relaxed/simple;
	bh=EZ6RFjLuOZ88SVTrr3RQdilNyeL8PWIemtRc61dkEYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GbQ4e19zFKHxpID5cUCp+x+rqtp7MNCmB8LrAL6B+scNKj1r0xf71FWXkMEjFRHqy83n/sTgb0uG7aa3m5EawERrjrV8fktH9O8DeGtnsZNTbB6EQlV7NlVRR7E7ySrrLGZNa6Ai1hD9/r6vddQPVWhkGHlx/tjm2EwTigCakKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CEfJkXXE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5089AoMY010561;
	Wed, 8 Jan 2025 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sT5CCRYl+x4dUMtMSCes2pYR6c6hZptBJnGGqNrq6lU=; b=CEfJkXXEDquByBeV
	lI9OtE+hzxpCj9ZdQ45dpLF4n2WcYh3dipYHDBoL7owkKBsUx2uzJkujv36+nEqu
	z+xiF+7ouA8eqiIwfxQtvG977MNLjpoUXFw2tSreDXcujUyLhr9iT4oe//OS8maT
	W8MYKb7hxzr6vu+7lirzyzM76mCIeEmZkj58uopaOF+IzMIIU8GO2DwD2tMugtYL
	Q3NBxNEJduIvIRGs/MgpQhDeyuNF6tZ7qdp268vhw9yvkGBdwupP0/YyNzbgpnmK
	WyJbdd6IGpFsVW9gF4Cpm48Vhx4xpa5yWwdHpatfs7DPPKN6fHZNoQDhNf+ctFxg
	GC/P1w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441pgnr4nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:08:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508A7xG0002623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 10:07:59 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 02:07:55 -0800
Message-ID: <406d5113-ff3d-4c2a-81f0-de791bcbeffb@quicinc.com>
Date: Wed, 8 Jan 2025 18:07:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <anshuman.khandual@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <Z31--x4unDHRU5Zo@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YieeDtkFTNv0W_kqZ0sQDqfqPlypTFuo
X-Proofpoint-ORIG-GUID: YieeDtkFTNv0W_kqZ0sQDqfqPlypTFuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080082

Hi Catalin,

On 2025/1/8 3:22, Catalin Marinas wrote:
> On Tue, Jan 07, 2025 at 03:42:52PM +0800, Zhenhua Huang wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e2739b69e11b..5e0f514de870 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -42,9 +42,11 @@
>>   #include <asm/pgalloc.h>
>>   #include <asm/kfence.h>
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
>>   u64 kimage_voffset __ro_after_init;
>>   EXPORT_SYMBOL(kimage_voffset);
>> @@ -254,7 +256,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   
>>   		/* try section mapping first */
>>   		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>> +		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {
>>   			pmd_set_huge(pmdp, phys, prot);
>>   
>>   			/*
>> @@ -356,10 +358,11 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   
>>   		/*
>>   		 * For 4K granule only, attempt to put down a 1GB block
>> +		 * Hotplug case: do not attempt 1GB block
>>   		 */
> 
> I don't think we need this comment added here. The hotplug case is a
> decision of the caller, so better to have the comment there.

Yeah, will remove.

> 
>>   		if (pud_sect_supported() &&
>>   		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>> +		   (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {
>>   			pud_set_huge(pudp, phys, prot);
> 
> Nit: something wrong with the alignment here. I think the unmodified
> line after the 'if' one above was misaligned before your patch.

Noted and will correct in next patch.

> 
>>   
>>   			/*
>> @@ -1175,9 +1178,21 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>>   int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>   		struct vmem_altmap *altmap)
>>   {
>> +	unsigned long start_pfn;
>> +	struct mem_section *ms;
>> +
>>   	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>   
>> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +	start_pfn = page_to_pfn((struct page *)start);
>> +	ms = __pfn_to_section(start_pfn);
> 
> Hmm, it would have been better if the core code provided the start pfn
> as it does for vmemmap_populate_compound_pages() but I'm fine with
> deducting it from 'start'.

I found another bug, that even for early section, when vmemmap_populate 
is called, SECTION_IS_EARLY is not set. Therefore, early_section() 
always return false.

Since vmemmap_populate() occurs during section initialization, it may be 
hard to say it is a bug..
However, should we instead using SECTION_MARKED_PRESENT to check? I 
tested well in my setup.

Hot plug flow:
1. section_activate -> vmemmap_populate
2. mark PRESENT

In contrast, the early flow:
1. memblocks_present -> mark PRESENT
2. __populate_section_memmap -> vmemmap_populate

> 
>> +	/*
>> +	 * Hotplugged section does not support hugepages as
>> +	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
>> +	 * struct page range that exceeds a SUBSECTION_SIZE
>> +	 * i.e 2MB - for all available base page sizes.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || !early_section(ms))
>>   		return vmemmap_populate_basepages(start, end, node, altmap);
>>   	else
>>   		return vmemmap_populate_hugepages(start, end, node, altmap);
>> @@ -1339,9 +1354,25 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   		    struct mhp_params *params)
>>   {
>>   	int ret, flags = NO_EXEC_MAPPINGS;
>> +	unsigned long start_pfn = page_to_pfn((struct page *)start);
>> +	struct mem_section *ms = __pfn_to_section(start_pfn);
> 
> This looks wrong. 'start' here is a physical address, you want
> PFN_DOWN() instead.

Sorry, my mistake.Thanks for catching it.

> 
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
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
> 
>> +	else
>> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 
> Similarly with 16K/64K pages we can allow contiguous PTEs as they all go
> up to 2MB blocks.

Yes!

> 
> I think we should write the flags setup in a more readable way than
> trying to do mental maths on the possible combinations, something like:
> 
> 	flags = NO_PUD_BLOCK_MAPPINGS | NO_PMD_CONT_MAPPINGS;
> 	if (SUBSECTION_SHIFT < PMD_SHIFT)
> 		flags |= NO_PMD_BLOCK_MAPPINGS;
> 	if (SUBSECTION_SHIFT < CONT_PTE_SHIFT)
> 		flags |= NO_PTE_CONT_MAPPINGS;

Good idea indeed. We no longer need to worry about PAGE SIZE CONFIG.

> 
> This way we don't care about the page size and should cover any changes
> to SUBSECTION_SHIFT making it smaller than 2MB.
> 


