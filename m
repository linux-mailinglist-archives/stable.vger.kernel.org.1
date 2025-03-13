Return-Path: <stable+bounces-124349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AAA5FF07
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453E319C1C37
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D81E8353;
	Thu, 13 Mar 2025 18:15:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC71C8631;
	Thu, 13 Mar 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889752; cv=none; b=qiqyUwyqpbgMi7dGxlJy2cSgVRSZsLb3ys5dEafkDHEXI1aEDsCXvE8P6OPKtVmJUeo9O6R+ZxYuOekWj8Tib2MGCuAxj+w0r8kG+XFcZRvFZmK8bjcaX/aGmjj2LxTZlgRDcxuk9IjKW9tzPjY6jsPbA57PbiJHW36+3Wjw6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889752; c=relaxed/simple;
	bh=790nIjekPGYAliGPAZRKB2moAt8x9SJMIpb1bPx7iVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJWwCGnQSXMGKhJJwIuNn6T5oMqFne8xthx3C4kUviwKqT18C+j9DssopQPIfBg9OKRVYz5qUoyZ8fYCHC4msVdH7ALfrt8CRAz/ECCDfkosyDcBD7BAMoCZBU0JpqDFellBre7pDpe3qGI/gyVpQ6YrlqWXGJ+HfD/abeGz+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FEE12FC;
	Thu, 13 Mar 2025 11:16:01 -0700 (PDT)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.42.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE5113F694;
	Thu, 13 Mar 2025 11:15:45 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: jroedel@suse.de,
	akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	hch@lst.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: Update mask post pxd_clear_bad()
Date: Thu, 13 Mar 2025 23:44:14 +0530
Message-Id: <20250313181414.78512-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since pxd_clear_bad() is an operation changing the state of the page tables,
we should call arch_sync_kernel_mappings() post this.

Fixes: e80d3909be42 ("mm: track page table modifications in __apply_to_page_range()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 78c7ee62795e..9a4a8c710be0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2987,6 +2987,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 			if (!create)
 				continue;
 			pmd_clear_bad(pmd);
+			*mask = PGTBL_PMD_MODIFIED;
 		}
 		err = apply_to_pte_range(mm, pmd, addr, next,
 					 fn, data, create, mask);
@@ -3023,6 +3024,7 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 			if (!create)
 				continue;
 			pud_clear_bad(pud);
+			*mask = PGTBL_PUD_MODIFIED;
 		}
 		err = apply_to_pmd_range(mm, pud, addr, next,
 					 fn, data, create, mask);
@@ -3059,6 +3061,7 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 			if (!create)
 				continue;
 			p4d_clear_bad(p4d);
+			*mask = PGTBL_P4D_MODIFIED;
 		}
 		err = apply_to_pud_range(mm, p4d, addr, next,
 					 fn, data, create, mask);
@@ -3095,6 +3098,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 			if (!create)
 				continue;
 			pgd_clear_bad(pgd);
+			mask = PGTBL_PGD_MODIFIED;
 		}
 		err = apply_to_p4d_range(mm, pgd, addr, next,
 					 fn, data, create, &mask);
-- 
2.30.2


