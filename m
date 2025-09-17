Return-Path: <stable+bounces-179823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FBB7D177
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3807A68E5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C42E0B5B;
	Wed, 17 Sep 2025 10:59:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422D275B1F
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106757; cv=none; b=WEekLYc9LP7qTSQefcJeOWUtF+vkbnGTgrrsz28uZwqaDumbG+c4whrT3Al0xfeNsvy+sdK8vJr6BF82hQQ7E/+ii0bZ4a62CI9C3EZbjcds/plY4sF/P0edqI3YnaIu4AJIYaWKklTyp6BKXKcEdDQyT0Xko7dDQTqnUtq80Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106757; c=relaxed/simple;
	bh=4NzlQf8lExwRSMrNaxx4nhiwZ9NxJzaY6MOuilS4d0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCNIeWlYmzcVQug+wpBIAqOko0v0d7RUGhzuLy1Wh7V2LL4hqzo6FnUekoRy06z+32sUf6pbOK7X33h/obBMr6Hdld41WRcWSNEHU2lDSs9fGFiGopvWSv6wSE3ORyngf/oaaXLKiHjikbxXEr5pe2oXGuII8IcoRJVTo8qMV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E1A267F;
	Wed, 17 Sep 2025 03:59:06 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (unknown [10.169.217.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B40573F66E;
	Wed, 17 Sep 2025 03:59:11 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: ssg-linux-patches@arm.com
Cc: Jun He <Jun.He@arm.com>,
	Jia He <justin.he@arm.com>,
	stable@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 02/29] arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level
Date: Wed, 17 Sep 2025 10:58:30 +0000
Message-Id: <20250917105857.474284-3-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917105857.474284-1-justin.he@arm.com>
References: <20250917105857.474284-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

commit c910f2b65518 ("arm64/mm: Update tlb invalidation routines for
FEAT_LPA2") changed the "invalidation level unknown" hint from 0 to
TLBI_TTL_UNKNOWN (INT_MAX). But the fallback "unknown level" path in
flush_hugetlb_tlb_range() was not updated. So as it stands, when trying
to invalidate CONT_PMD_SIZE or CONT_PTE_SIZE hugetlb mappings, we will
spuriously try to invalidate at level 0 on LPA2-enabled systems.

Fix this so that the fallback passes TLBI_TTL_UNKNOWN, and while we are
at it, explicitly use the correct stride and level for CONT_PMD_SIZE and
CONT_PTE_SIZE, which should provide a minor optimization.

Cc: stable@vger.kernel.org
Fixes: c910f2b65518 ("arm64/mm: Update tlb invalidation routines for FEAT_LPA2")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20250226120656.2400136-4-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/include/asm/hugetlb.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 92a5e0879b11..eb413631edea 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -68,12 +68,22 @@ static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
 {
 	unsigned long stride = huge_page_size(hstate_vma(vma));
 
-	if (stride == PMD_SIZE)
-		__flush_tlb_range(vma, start, end, stride, false, 2);
-	else if (stride == PUD_SIZE)
-		__flush_tlb_range(vma, start, end, stride, false, 1);
-	else
-		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
+	switch (stride) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		__flush_tlb_range(vma, start, end, PUD_SIZE, false, 1);
+		break;
+#endif
+	case CONT_PMD_SIZE:
+	case PMD_SIZE:
+		__flush_tlb_range(vma, start, end, PMD_SIZE, false, 2);
+		break;
+	case CONT_PTE_SIZE:
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 3);
+		break;
+	default:
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, TLBI_TTL_UNKNOWN);
+	}
 }
 
 #endif /* __ASM_HUGETLB_H */
-- 
2.34.1


