Return-Path: <stable+bounces-108663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D6A1171F
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB1F188B14A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F01581F2;
	Wed, 15 Jan 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lALW9OYt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEABE6C;
	Wed, 15 Jan 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907247; cv=none; b=ba3ddE4S3C0/NTx93NzwfNGv4QKgptNxebI2/2EhzrYrihw5y49eRtJ/MGYohRjgO3j6CGmpKGR0KH8e6M4MQyWpm8Ma0jGx7I4graMy5BWzXN01TuTreLLvHWdtPGk32Nx6ypn+YsIhj87Hb/yp9Pr0fyE7PHPwz7W3wq3dZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907247; c=relaxed/simple;
	bh=kWeRQdyat6TiZOrY10DmCqvzZNoQtHCcR9ebQNu0lVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HQP/UZlws+ykbLMWxbAkKcTuJJgwdENLmY1a4fGckV8Avynf729mJRPjQToBCjDmYR+0pB/YmvjHvfxs8FXbyg+z6aBWWbOGzvtDWv+1W3sPwtV2/6OZ6gqsGvQVq2Y1l6zOe+v0pGoPgALfanfRXKeN4AHMmQfh6f45ngi22XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lALW9OYt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EBEY3T000879;
	Wed, 15 Jan 2025 02:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+eUp8lGe+ej895FJwwzd/ghRECdXZi8mrUuHFzRS3Q=; b=lALW9OYt/Djbf7wz
	bG4qGyG2+OK6615H0gsfXe1ZGrN5VAHEBqERcUKiLWLg+Pt1+v62jpPyNjbJC4yP
	uvBLfSE4WC2jh+ot/5ZHBwU8dIPZeKvwbdkUTp12Iy73dUj9uB4DEX0wfoP8is0Z
	iRyUxNX5VHA+LAFaTXCDIKBlFNeFytedlE8UnMlCt06nz/+YXtbLQWreQaYQ5DC+
	/5DQeMsiYYe778p/RPpIGYQnxs3NXcfc1Mf9xqu8D68PshRAgSQhhNJ2UH1Fq5t6
	CEJu4mARmWZqgklBqyuCFmyyQKY+pzDsxfxpbEBk5GTuX3Fvd4Y6IFP5WsEQrlG8
	Q4KJew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445pvnsugm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 02:13:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F2DXhG003342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 02:13:33 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 18:13:28 -0800
Message-ID: <9ae36424-2cb6-491d-8ac2-95bfe39828a2@quicinc.com>
Date: Wed, 15 Jan 2025 10:13:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250109093824.452925-1-quic_zhenhuah@quicinc.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20250109093824.452925-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YZhbkYNUb3w3w3vxjGdgWjHV3gLmQkpJ
X-Proofpoint-ORIG-GUID: YZhbkYNUb3w3w3vxjGdgWjHV3gLmQkpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_09,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150013

Gentle reminder if you happened to miss it :)

On 2025/1/9 17:38, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
> pmd_sect() is true, the entire PMD section is cleared, even if there is
> other effective subsection. For example page_struct_map1 and
> page_strcut_map2 are part of a single PMD entry and they are hot-added
> sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
> the entire PMD entry freeing the struct page map for the whole section,
> even though page_struct_map2 is still active. Similar problem exists
> with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
> base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
> Tearing down the entire PMD mapping too will leave other subsections
> unmapped in the linear mapping.
> 
> To address the issue, we need to prevent PMD/PUD/CONT mappings for both
> linear and vmemmap for non-boot sections if corresponding size on the
> given base page exceeds SUBSECTION_SIZE(2MB now).
> 
> Cc: stable@vger.kernel.org # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
> Hi Catalin and Anshuman,
> I have addressed comments so far, please help review.
> One outstanding point which not finalized is in vmemmap_populate(): how to judge hotplug
> section. Currently I am using system_state, discussion:
> https://lore.kernel.org/linux-mm/1515dae4-cb53-4645-8c72-d33b27ede7eb@quicinc.com/
>   arch/arm64/mm/mmu.c | 46 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e2739b69e11b..8718d6e454c5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,9 +42,13 @@
>   #include <asm/pgalloc.h>
>   #include <asm/kfence.h>
>   
> -#define NO_BLOCK_MAPPINGS	BIT(0)
> -#define NO_CONT_MAPPINGS	BIT(1)
> -#define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define NO_PMD_BLOCK_MAPPINGS	BIT(0)
> +#define NO_PUD_BLOCK_MAPPINGS	BIT(1)  /* Hotplug case: do not want block mapping for PUD */
> +#define NO_BLOCK_MAPPINGS	(NO_PMD_BLOCK_MAPPINGS | NO_PUD_BLOCK_MAPPINGS)
> +#define NO_PTE_CONT_MAPPINGS	BIT(2)
> +#define NO_PMD_CONT_MAPPINGS	BIT(3)  /* Hotplug case: do not want cont mapping for PMD */
> +#define NO_CONT_MAPPINGS	(NO_PTE_CONT_MAPPINGS | NO_PMD_CONT_MAPPINGS)
> +#define NO_EXEC_MAPPINGS	BIT(4)	/* assumes FEAT_HPDS is not used */
>   
>   u64 kimage_voffset __ro_after_init;
>   EXPORT_SYMBOL(kimage_voffset);
> @@ -224,7 +228,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
>   		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_PTE_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
>   		init_pte(ptep, addr, next, phys, __prot);
> @@ -254,7 +258,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   
>   		/* try section mapping first */
>   		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {
>   			pmd_set_huge(pmdp, phys, prot);
>   
>   			/*
> @@ -311,7 +315,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
>   		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_PMD_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
>   		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
> @@ -358,8 +362,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>   		 * For 4K granule only, attempt to put down a 1GB block
>   		 */
>   		if (pud_sect_supported() &&
> -		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		    ((addr | next | phys) & ~PUD_MASK) == 0 &&
> +		    (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {
>   			pud_set_huge(pudp, phys, prot);
>   
>   			/*
> @@ -1177,7 +1181,13 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   {
>   	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>   
> -	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	/*
> +	 * Hotplugged section does not support hugepages as
> +	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
> +	 * struct page range that exceeds a SUBSECTION_SIZE
> +	 * i.e 2MB - for all available base page sizes.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || system_state != SYSTEM_BOOTING)
>   		return vmemmap_populate_basepages(start, end, node, altmap);
>   	else
>   		return vmemmap_populate_hugepages(start, end, node, altmap);
> @@ -1339,9 +1349,27 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   		    struct mhp_params *params)
>   {
>   	int ret, flags = NO_EXEC_MAPPINGS;
> +	unsigned long start_pfn = PFN_DOWN(start);
> +	struct mem_section *ms = __pfn_to_section(start_pfn);
>   
>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>   
> +	/* should not be invoked by early section */
> +	WARN_ON(early_section(ms));
> +
> +	/*
> +	 * Disallow BlOCK/CONT mappings if the corresponding size exceeds
> +	 * SUBSECTION_SIZE which now is 2MB.
> +	 *
> +	 * PUD_BLOCK or PMD_CONT should consistently exceed SUBSECTION_SIZE
> +	 * across all variable page size configurations, so add them directly
> +	 */
> +	flags |= NO_PUD_BLOCK_MAPPINGS | NO_PMD_CONT_MAPPINGS;
> +	if (SUBSECTION_SHIFT < PMD_SHIFT)
> +		flags |= NO_PMD_BLOCK_MAPPINGS;
> +	if (SUBSECTION_SHIFT < CONT_PTE_SHIFT)
> +		flags |= NO_PTE_CONT_MAPPINGS;
> +
>   	if (can_set_direct_map())
>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>   


