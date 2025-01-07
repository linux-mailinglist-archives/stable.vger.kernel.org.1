Return-Path: <stable+bounces-107809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF666A038F6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73E8164F81
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51A1DC9AD;
	Tue,  7 Jan 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cv3xnUUq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009318A6B8;
	Tue,  7 Jan 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235852; cv=none; b=qBrL4DcjoZcoDyeaevvMF0im85Hautl2bKspBC2uEj97O0YYTkZDhcc3EnVU/w5/RXxlYAJr+cgYLmC9sMxoqfBLEEThexNU0CReQ1bSODx4ZUK8cGgF1DRT7xJYWIThSpuHFugey0LGNfsPePQArbaX5Mykye1LvTfmD2TWnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235852; c=relaxed/simple;
	bh=zfaGADUJIhbQel57uDfkYb39KUgV9Yu6FW0TBZ0grA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOcVaRQWUzY4RDFDIRxiOdESwCqlQKaJQhtOjS4C9pOywT0NsM9wNK5Q2Y01yV4Ni5e+zu53gEZOcqUwK+3KFB9gRhQolBZqiFxYAJFiw4X2RNibEpvEcDUewf+jq4HJCANgvckNLXV58/wmwwVNLAzZY11k8T2Z58PdhdQ7gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cv3xnUUq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5075LkOr005475;
	Tue, 7 Jan 2025 07:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tIGIMu9F6IdzSqOlLtN/Vq
	A1JAyMvcbYgh58G0wd5fI=; b=Cv3xnUUq+WbT3tSt38Us1tF/Cz2/pXq7URi0wo
	xc6pnNQQJJr3BSfYwmmmvhEPhlaCtc0ZjAAX1GldgJZDC8BAhG7OSncjQk0M38Pm
	S3vg259Z0uoq6lP9Aaxts3E7DCxQyEW8F6BwJ7b96clpH1JnSkt5yP7FopGas6bX
	eMGhq3xrHHwOa/zOTo07Cqmoc63DPQUHPWGCSc4JKWreM70oa15Md3qvn49n6F0f
	Uz6q67Im6BtsruLdQDgjbheJYFZvM/n/CU3YzDUFuY0fmxeCWE3oTXFTqOdxtA7A
	SC24aZBAlXL7gIFAm6j6qAL+FQpXbevcsMWhEDARMWH1lsuA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440x2889ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 07:43:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5077hlTb012354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 07:43:47 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 Jan 2025 23:43:43 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level for hotplugged sections
Date: Tue, 7 Jan 2025 15:42:52 +0800
Message-ID: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0AKj0_aP2Qzt9hu1PtQil328jDuAMG9i
X-Proofpoint-ORIG-GUID: 0AKj0_aP2Qzt9hu1PtQil328jDuAMG9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=784
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070063

On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
to 27, making one section 128M. The related page struct which vmemmap
points to is 2M then.
Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
vmemmap to populate at the PMD section level which was suitable
initially since hot plug granule is always one section(128M). However,
commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
existing arm64 assumptions.

Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
pmd_sect() is true, the entire PMD section is cleared, even if there is
other effective subsection. For example page_struct_map1 and
page_strcut_map2 are part of a single PMD entry and they are hot-added
sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
the entire PMD entry freeing the struct page map for the whole section,
even though page_struct_map2 is still active. Similar problem exists
with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
Tearing down the entire PMD mapping too will leave other subsections
unmapped in the linear mapping.

To address the issue, we need to prevent PMD/PUD/CONT mappings for both
linear and vmemmap for non-boot sections if corresponding size on the
given base page exceeds 2MB(SUBSECTION_SIZE). We only permit 2MB PMD block
linear mapping in 4K page size config as its PMD_SIZE matches the
SUBSECTION_SIZE.

Cc: stable@vger.kernel.org # v5.4+
Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e2739b69e11b..5e0f514de870 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,9 +42,11 @@
 #include <asm/pgalloc.h>
 #include <asm/kfence.h>
 
-#define NO_BLOCK_MAPPINGS	BIT(0)
-#define NO_CONT_MAPPINGS	BIT(1)
-#define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
+#define NO_PMD_BLOCK_MAPPINGS	BIT(0)
+#define NO_PUD_BLOCK_MAPPINGS	BIT(1)  /* Hotplug case: do not want block mapping for PUD */
+#define NO_BLOCK_MAPPINGS (NO_PMD_BLOCK_MAPPINGS | NO_PUD_BLOCK_MAPPINGS)
+#define NO_CONT_MAPPINGS	BIT(2)
+#define NO_EXEC_MAPPINGS	BIT(3)	/* assumes FEAT_HPDS is not used */
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
@@ -254,7 +256,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {
 			pmd_set_huge(pmdp, phys, prot);
 
 			/*
@@ -356,10 +358,11 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
+		 * Hotplug case: do not attempt 1GB block
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		   (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
@@ -1175,9 +1178,21 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
+	unsigned long start_pfn;
+	struct mem_section *ms;
+
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+	start_pfn = page_to_pfn((struct page *)start);
+	ms = __pfn_to_section(start_pfn);
+
+	/*
+	 * Hotplugged section does not support hugepages as
+	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
+	 * struct page range that exceeds a SUBSECTION_SIZE
+	 * i.e 2MB - for all available base page sizes.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || !early_section(ms))
 		return vmemmap_populate_basepages(start, end, node, altmap);
 	else
 		return vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1339,9 +1354,25 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
 	int ret, flags = NO_EXEC_MAPPINGS;
+	unsigned long start_pfn = page_to_pfn((struct page *)start);
+	struct mem_section *ms = __pfn_to_section(start_pfn);
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
+	/* should not be invoked by early section */
+	WARN_ON(early_section(ms));
+
+	/*
+	 * 4K base page's PMD_SIZE matches SUBSECTION_SIZE i.e 2MB. Hence
+	 * PMD section mapping can be allowed, but only for 4K base pages.
+	 * Where as PMD_SIZE (hence PUD_SIZE) for other page sizes exceed
+	 * SUBSECTION_SIZE.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+		flags |= NO_PUD_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+	else
+		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+
 	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.25.1


