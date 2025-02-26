Return-Path: <stable+bounces-119668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4AA45E97
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2647AAC90
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0072E221549;
	Wed, 26 Feb 2025 12:16:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAC215776;
	Wed, 26 Feb 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572182; cv=none; b=UxbBgvgc98tEN1Al2/kUUcOp54mAuHuM1ijfvXr7oHiTY4kmQDdzKSaQOmQ5kw8ZIEml93w3Glom8xHjIocEB7/N3oicEr9mjNcBxPOwM6TMoKA3kPYHSBcjk56g/fVpsB0tJby9yR/99/pfsyHRnf5um3qnLWTToQfI23iaCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572182; c=relaxed/simple;
	bh=ZsJuNP0Q+g22XU3VVxPN7bEPerI7yY57kFjRVanT8uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sci35a0i5xW2RE41cCKGBDfAIYZhWwXsmBelsABxyDU8XeGuLjmkqxjaoeZaGx0oiwWn01l3LOIlfXLV8BpOS5Vd4Sh9snp3RxKqX0aEdCyVS3GkfifICZHxc1mzUrA1/renew1ECufXXSskBk0yi2QjjsoUMQ03b+r71xXxiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B424F13D5;
	Wed, 26 Feb 2025 04:16:36 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008333F5A1;
	Wed, 26 Feb 2025 04:16:18 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3] mm: Don't skip arch_sync_kernel_mappings() in error paths
Date: Wed, 26 Feb 2025 12:16:09 +0000
Message-ID: <20250226121610.2401743-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
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

Cc: stable@vger.kernel.org
Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Fixes: 0c95cba49255 ("mm: apply_to_pte_range warn and fail if a large pte is encountered")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi All,

This patch was originally tacked onto the series at [1]. But things have changed
a bit and this is no longer a dependency. So I've decoupled it and now prefer
this to go via mm.

Thanks,
Ryan

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
index a6e7acebe9ad..61981ee1c9d2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -586,13 +586,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
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


