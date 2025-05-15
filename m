Return-Path: <stable+bounces-144476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F02AB7E1A
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9651BA3F6B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1329713B;
	Thu, 15 May 2025 06:35:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE41297113;
	Thu, 15 May 2025 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290903; cv=none; b=c0+Scm0ZQmDGX1SZbx7KCKrwSt1/w9eUFUIT7Tssu+nSi77irzyAIchBUmG1OZVzlrCADx45/2e2PrBTca1nN5fZIVtzW9RcoxBIBrUx1jfwD0CN3DYCl4MRrCQU45HuR1c+W8nrUDGgTunixOuFBQEzLdAiXgGGgC+Dx4AipD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290903; c=relaxed/simple;
	bh=Erl0SPt11aJoFWyoj9Bf/MmQK/vgKE9AjHiwCwJVS00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvZ5ZbWPFAP/0M0d3oZfdz4PXVwvLbCUp7Kq9bgJ7CdJIpmNBVB1VqD1IlkdDkAfPFsy3oaLzd1A+DDim3ViaLHn0MA8KcZFJM92ef0pqUOcwgT+gu5sV6lOHPrPel9ilv2tP7wBCmQI5zx9TINaZxqBKYOaEdL7b7ppmyr5cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B50113E;
	Wed, 14 May 2025 23:34:48 -0700 (PDT)
Received: from K4MQJ0H1H2.emea.arm.com (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 156673F673;
	Wed, 14 May 2025 23:34:55 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: david@redhat.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	mark.rutland@arm.com,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while tearing down page tables
Date: Thu, 15 May 2025 12:04:50 +0530
Message-Id: <20250515063450.86629-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9c006972c3fe removes the pxd_present() checks because the caller
checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
checks pud_present(); pud_free_pmd_page() recurses on each pmd through
pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
hit a warning in the latter, since pmd_none => !pmd_table(). Thus, enforce
these checks again through pxd_leaf().
This problem was found by code inspection.
The patch is based on 6.15-rc6.

Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
Cc: <stable@vger.kernel.org>
Reported-by: Ryan Roberts <ryan.roberts@arm.com> 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ea6695d53fb9..3d6789413a9b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1255,7 +1255,7 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 
 	pmd = READ_ONCE(*pmdp);
 
-	if (!pmd_table(pmd)) {
+	if (pmd_leaf(pmd)) {
 		VM_WARN_ON(1);
 		return 1;
 	}
@@ -1276,7 +1276,7 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 
 	pud = READ_ONCE(*pudp);
 
-	if (!pud_table(pud)) {
+	if (pud_leaf(pud)) {
 		VM_WARN_ON(1);
 		return 1;
 	}
-- 
2.30.2


