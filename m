Return-Path: <stable+bounces-159112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC988AEED3B
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 06:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046031BC0279
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 04:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A61CF5C0;
	Tue,  1 Jul 2025 04:27:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F591805A
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751344034; cv=none; b=Nlqdo+xTBspuG9JuoqL0xCDIqgV8/1IwT2pBRSKdp35XP6ptNgLpQTLY7I/BiThj+OheVi2pb4NjgK8Nii8MMVQMY0MDHpxZtDKLLtavf+a/ImY7567ADDfcyMXI5ciFsq9K0VXTi7YOqC4cTOIBg4Tzz6+lGFGaNcRXbGN+PAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751344034; c=relaxed/simple;
	bh=XQEp5pT9VUCtr5c+mDMHDWdkcJbJDyOjdUPFYv1TCJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ac8MXXh7NfH4iK2JkXhDFQ5Ljh4cC08APiDDUuOV9RZ1jBWJ1Zz3YQ0W5oBYRt6At8omhZl+kqrJvtQefNJSb2iGVmg7GTBHD7Mfjz4RM27QIJGIMZK44uEpGetqCP1tFHJ/18sVDe1zPlN8y8QT5foEGT3Wen7h7UOLkYRj8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53DD15A1;
	Mon, 30 Jun 2025 21:26:56 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83ED23F58B;
	Mon, 30 Jun 2025 21:27:09 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: gregkh@linuxfoundation.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	david@redhat.com,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 5.15.y] arm64: Restrict pagetable teardown to avoid false warning
Date: Tue,  1 Jul 2025 09:57:05 +0530
Message-Id: <20250701042705.22120-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2025062304-prune-getup-2943@gregkh>
References: <2025062304-prune-getup-2943@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Commit 650768c512faba8070bf4cfbb28c95eb5cd203f3 upstream]

Commit 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from
pXd_free_pYd_table()") removes the pxd_present() checks because the
caller checks pxd_present(). But, in case of vmap_try_huge_pud(), the
caller only checks pud_present(); pud_free_pmd_page() recurses on each
pmd through pmd_free_pte_page(), wherein the pmd may be none. Thus it is
possible to hit a warning in the latter, since pmd_none => !pmd_table().
Thus, add a pmd_present() check in pud_free_pmd_page().

This problem was found by code inspection.

Fixes: 9c006972c3fe ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
Cc: stable@vger.kernel.org
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20250527082633.61073-1-dev.jain@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
(cherry picked from commit 650768c512faba8070bf4cfbb28c95eb5cd203f3)
(use READ_ONCE since pmdp_get() is not defined)
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fc86e7465df4..e3e4defdea42 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1466,7 +1466,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(READ_ONCE(*pmdp)))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);
-- 
2.30.2


