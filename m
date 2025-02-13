Return-Path: <stable+bounces-115110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542FA33967
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201043A20AA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3020C021;
	Thu, 13 Feb 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ffz7bUjJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677220C005;
	Thu, 13 Feb 2025 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433461; cv=none; b=DG8yUwlrzZpPur52qZlH/DwvraeFPN4tMKv2nNbATjVuf4txiS25p0mLr2b9Fm9UP1tklAdfJ6HR6V9RxJolETwemUKtQbHrCHDoYJak6kKwFBoGY3S4rOHoHyrGJmhB6pfyiOHQ1v30baYjJHwz3O9jajTY1dy3WCWt3NP6m2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433461; c=relaxed/simple;
	bh=DzC8p66uMDtBbLzxN7sVrz7HCwyBdAGILEnjXu6aA7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KjMXzsm1q6Chl3k5asalggWRdlTT2YrPOrfOdcsR2GN9LbC7CckP1E8p9773SrUIQa9Tqd1rfaz21RkIBsxQjiF4YQsqI+kzjQAD4974EIVVEVfl6D5CndyvQA2MFWbmeRWTc2ctdMLm2gU3O1piogFQ+kKAUXui/3x701oEWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ffz7bUjJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CNcAes015814;
	Thu, 13 Feb 2025 07:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LK8EMWkhMYS1gFdylRdOCv
	m20LCWNN8FbFwebWxLra8=; b=Ffz7bUjJwfQI3Ux112kDArRdwoWc/P9XT9/yCE
	QZj1FPM6JpQb8qZB/hKj//Im5etRF3WuCoPI9pXcNvihjXvXWfai5sPYTnavL2hv
	w41TqOiy06u7hCkP66GPCgj7LtNteG6vcxXXfSSBYaVbLA6kNiLYuYrJE6wXAVuL
	SY4el6i2BTTLvxsgm9pcKHJgpCVyDCCHPS4BEyHOf/Gyyk1puHCw0P7uwzAyN4A0
	pJKJzzVEVZtgXm5TxQxfc6pb5gS7uqUCKFpZzFBQQwAqUkB1eI3uF+aHzsm9VfY4
	4ngg/9VPwet83eazGD76euZEv8behCJE2410Svp4ALkGINHA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgm9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:57:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D7vL86012406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:57:21 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 23:57:16 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v6] arm64: mm: Populate vmemmap/linear at the page level for hotplugged sections
Date: Thu, 13 Feb 2025 15:57:03 +0800
Message-ID: <20250213075703.1270713-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YteP1zGpHsG1DEWBdEJIhBRiGC-ECWUK
X-Proofpoint-GUID: YteP1zGpHsG1DEWBdEJIhBRiGC-ECWUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130059

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
given base page exceeds SUBSECTION_SIZE(2MB now).

Cc: <stable@vger.kernel.org> # v5.4+
Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..b1089365f3e7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,9 +42,13 @@
 #include <asm/pgalloc.h>
 #include <asm/kfence.h>
 
-#define NO_BLOCK_MAPPINGS	BIT(0)
-#define NO_CONT_MAPPINGS	BIT(1)
-#define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
+#define NO_PMD_BLOCK_MAPPINGS	BIT(0)
+#define NO_PUD_BLOCK_MAPPINGS	BIT(1)  /* Hotplug case: do not want block mapping for PUD */
+#define NO_BLOCK_MAPPINGS	(NO_PMD_BLOCK_MAPPINGS | NO_PUD_BLOCK_MAPPINGS)
+#define NO_PTE_CONT_MAPPINGS	BIT(2)
+#define NO_PMD_CONT_MAPPINGS	BIT(3)  /* Hotplug case: do not want cont mapping for PMD */
+#define NO_CONT_MAPPINGS	(NO_PTE_CONT_MAPPINGS | NO_PMD_CONT_MAPPINGS)
+#define NO_EXEC_MAPPINGS	BIT(4)	/* assumes FEAT_HPDS is not used */
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
@@ -224,7 +228,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_PTE_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pte(ptep, addr, next, phys, __prot);
@@ -254,7 +258,7 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_PMD_BLOCK_MAPPINGS) == 0) {
 			pmd_set_huge(pmdp, phys, prot);
 
 			/*
@@ -311,7 +315,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		/* use a contiguous mapping if the range is suitably aligned */
 		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
-		    (flags & NO_CONT_MAPPINGS) == 0)
+		    (flags & NO_PMD_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
 		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
@@ -358,8 +362,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
 		if (pud_sect_supported() &&
-		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    ((addr | next | phys) & ~PUD_MASK) == 0 &&
+		    (flags & NO_PUD_BLOCK_MAPPINGS) == 0) {
 			pud_set_huge(pudp, phys, prot);
 
 			/*
@@ -1178,7 +1182,13 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+	/*
+	 * Hotplugged section does not support hugepages as
+	 * PMD_SIZE (hence PUD_SIZE) section mapping covers
+	 * struct page range that exceeds a SUBSECTION_SIZE
+	 * i.e 2MB - for all available base page sizes.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) || system_state != SYSTEM_BOOTING)
 		return vmemmap_populate_basepages(start, end, node, altmap);
 	else
 		return vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1340,9 +1350,27 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
 	int ret, flags = NO_EXEC_MAPPINGS;
+	unsigned long start_pfn = PFN_DOWN(start);
+	struct mem_section *ms = __pfn_to_section(start_pfn);
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
+	/* should not be invoked by early section */
+	WARN_ON(early_section(ms));
+
+	/*
+	 * Disallow BLOCK/CONT mappings if the corresponding size exceeds
+	 * SUBSECTION_SIZE which now is 2MB.
+	 *
+	 * PUD_BLOCK or PMD_CONT should consistently exceed SUBSECTION_SIZE
+	 * across all variable page size configurations, so add them directly
+	 */
+	flags |= NO_PUD_BLOCK_MAPPINGS | NO_PMD_CONT_MAPPINGS;
+	if (SUBSECTION_SHIFT < PMD_SHIFT)
+		flags |= NO_PMD_BLOCK_MAPPINGS;
+	if (SUBSECTION_SHIFT < CONT_PTE_SHIFT)
+		flags |= NO_PTE_CONT_MAPPINGS;
+
 	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.25.1


