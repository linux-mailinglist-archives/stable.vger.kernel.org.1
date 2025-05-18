Return-Path: <stable+bounces-144715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED22ABAF1F
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D643B0A6B
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120A20D509;
	Sun, 18 May 2025 09:55:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21D15624D;
	Sun, 18 May 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562104; cv=none; b=RmI2bLedo3CHkK9u56L2PWsKTDe1LZXcmzEBD7HrCjankAGBPRqFA1/SbxsW6rZ0hBRNo9IMZWLKrWy+VJbhJSLtU1rD/vSp0VEuE0bDbdsp07palqMYfA8Vc4DM3xJyOn0NHCuNa4am68GS3HKKFaAH6keDCC8kBf4AcmlCPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562104; c=relaxed/simple;
	bh=GPXt7yrDAXgUzVEqDKWM6kasfQ42+eP9tdA1xqv6jRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRdHZYK1jW4bzQYym8ATZ6yqgv6YYpSSMI0m7bKEPixwglbXTGJhTw8vSOh0L2VaUuEdZ8Ba8xuEW63F+5LTRWYoUliF+I3rvFUkdg+gcemm0axkkyZ8rikfr3g5T9uBrpathdpgeCIecu2RtxbbFnuY69Q1knWe2Nofbid7s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C250E169C;
	Sun, 18 May 2025 02:54:47 -0700 (PDT)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.82.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF0613F5A1;
	Sun, 18 May 2025 02:54:56 -0700 (PDT)
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
Subject: [PATCH v2] arm64: Restrict pagetable teardown to avoid false warning
Date: Sun, 18 May 2025 15:24:45 +0530
Message-Id: <20250518095445.31044-1-dev.jain@arm.com>
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
hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
a pmd_present() check in pud_free_pmd_page().

This problem was found by code inspection.

This patch is based on 6.15-rc6.

Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())

Cc: <stable@vger.kernel.org>
Reported-by: Ryan Roberts <ryan.roberts@arm.com> 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
v1->v2:
 - Enforce check in caller

 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ea6695d53fb9..5b1f4cd238ca 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(*pmdp))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);
-- 
2.30.2


