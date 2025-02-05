Return-Path: <stable+bounces-113818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF606A29427
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0AC3ABCAF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30A1F3FF8;
	Wed,  5 Feb 2025 15:11:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412341DF98F;
	Wed,  5 Feb 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768265; cv=none; b=bWTER2lDicq0pgpiJw6ACPP/GwbT+An95Wphl0QfKCpoLAAHDL76pV1YdtQcoHK2vrXR/yEtwfZyLOSATGx53XXbiAG8s624G0/YeVeJEhzv06XFr0uZwwVDUC7AuebYg+SKHXw0RRx5ouEXCpzWUG2ka5n/2tcEMbnCUT8i0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768265; c=relaxed/simple;
	bh=ma+w0E6ocwSGzO+YhsXjcwBW6CsGmyczv/5KrNgRbAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4jyLGFXFf7+LoNXUbG/Wpcn8I091eDusCBEHIETnzzQ4wvVD+iuxZXz8Xli9XqCmbx78IY8mboRlMGWNjGlS/axDxuTjE+3gu48xller0M1Od0b/seFyLaFp67tGzcAXyhTDIYUjnMzbC5QuNG8vbBTwQi2lB7DaSttUuKwfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7589B1063;
	Wed,  5 Feb 2025 07:11:27 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC763F5A1;
	Wed,  5 Feb 2025 07:11:01 -0800 (PST)
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
Subject: [PATCH v1 13/16] mm: Don't skip arch_sync_kernel_mappings() in error paths
Date: Wed,  5 Feb 2025 15:09:53 +0000
Message-ID: <20250205151003.88959-14-ryan.roberts@arm.com>
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

Fix callers that previously skipped calling arch_sync_kernel_mappings()
if an error occurred during a pgtable update. The call is still required
to sync any pgtable updates that may have occurred prior to hitting the
error condition.

These are theoretical bugs discovered during code review.

Cc: <stable@vger.kernel.org>
Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Fixes: 0c95cba49255 ("mm: apply_to_pte_range warn and fail if a large pte is encountered")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c  | 6 ++++--
 mm/vmalloc.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..a15f7dd500ea 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3040,8 +3040,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(*pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
+			err = -EINVAL;
+			break;
+		}
 		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
 			if (!create)
 				continue;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6111ce900ec4..68950b1824d0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -604,13 +604,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
-			return err;
+			break;
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
-	return 0;
+	return err;
 }
 
 /*
-- 
2.43.0


