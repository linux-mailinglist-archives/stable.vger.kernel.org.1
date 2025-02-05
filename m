Return-Path: <stable+bounces-113809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACAA293CB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD3C16AC7E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7B18A922;
	Wed,  5 Feb 2025 15:10:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C243188704;
	Wed,  5 Feb 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768238; cv=none; b=GQRipW5+Q4kotHR4ffxHTjpioqucGBZeKQ8AVIMys8xBNJWsGNg/hm+ivr/uF9+62sTjAMzwmHX5mkOk3uiUbX42hSsqwGT5ObNsCUTPFUZj4Em2AmpKmu6NTq/LHgXZKUUuTDBM4mOWqLKXUV4HQIFHhn93UdlYMOzYcJCkQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768238; c=relaxed/simple;
	bh=3Q54yKXRdvqhDGPtg9zs6/cCiSVCV9GAhtafDq5qpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpP0Arv/2+Zob2lVoKX/H4Aw9XpLyqa9Wwteu6xp8XJGUFiEkOiXaEYFAiVFdCuVnieZ4J85GZ023XfPXKMVHgSPJjyxnBIVseDQ5iXn2OrNEAepbYvMZiY0r1njFB5BUnEc6rYlCFk09nkCEooevjk+lrKukr1J60tX7NZ1T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB141C01;
	Wed,  5 Feb 2025 07:10:59 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242593F5A1;
	Wed,  5 Feb 2025 07:10:33 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Steve Capper <steve.capper@linaro.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 03/16] arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level
Date: Wed,  5 Feb 2025 15:09:43 +0000
Message-ID: <20250205151003.88959-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205151003.88959-1-ryan.roberts@arm.com>
References: <20250205151003.88959-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c910f2b65518 ("arm64/mm: Update tlb invalidation routines for
FEAT_LPA2") changed the "invalidation level unknown" hint from 0 to
TLBI_TTL_UNKNOWN (INT_MAX). But the fallback "unknown level" path in
flush_hugetlb_tlb_range() was not updated. So as it stands, when trying
to invalidate CONT_PMD_SIZE or CONT_PTE_SIZE hugetlb mappings, we will
spuriously try to invalidate at level 0 on LPA2-enabled systems.

Fix this so that the fallback passes TLBI_TTL_UNKNOWN, and while we are
at it, explicitly use the correct stride and level for CONT_PMD_SIZE and
CONT_PTE_SIZE, which should provide a minor optimization.

Cc: <stable@vger.kernel.org>
Fixes: c910f2b65518 ("arm64/mm: Update tlb invalidation routines for FEAT_LPA2")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/hugetlb.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 03db9cb21ace..8ab9542d2d22 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -76,12 +76,20 @@ static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
 {
 	unsigned long stride = huge_page_size(hstate_vma(vma));
 
-	if (stride == PMD_SIZE)
-		__flush_tlb_range(vma, start, end, stride, false, 2);
-	else if (stride == PUD_SIZE)
-		__flush_tlb_range(vma, start, end, stride, false, 1);
-	else
-		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
+	switch (stride) {
+	case PUD_SIZE:
+		__flush_tlb_range(vma, start, end, PUD_SIZE, false, 1);
+		break;
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
2.43.0


