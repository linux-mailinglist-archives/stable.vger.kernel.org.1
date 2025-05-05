Return-Path: <stable+bounces-140529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E55AAAE07
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A73E3ADDDE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4D52BCF50;
	Mon,  5 May 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Z++15l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90227E1DC;
	Mon,  5 May 2025 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485043; cv=none; b=iDuZV9kstvGDc+QVOSo/ieCYDqorSNc3OKwA8AG3NMyxGa0iQyctIT5FyQ5US4XeD6EgybQuOZ+7P4ZjWGWpjOF+R65uayx78ZBFf3ZPnBa8mmWcG8ea969nAYLDRa+77p6FTPqCihrgzgaEXUHRz0/+QIH8b/LDzEEI6yu4BTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485043; c=relaxed/simple;
	bh=ILuU5mUox98kRSvahMMITcFsLpKEN2lWclTNJeUIJPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAy4OmR9RuuzIhE32GQPgy8pisV2wZhrNK/yp9Rm52ga2MkT9KfhB5Mndk4kbXAtjQ+PGrOdife/cNYHT6av55XRlcbSTBFZHBdGXiMXxo0FTtlgtx43KXDdxFSiruoDaiJ3kUHVME0sIYEKLMmxQrtn1Tnl7bdYcFkiUAjGBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Z++15l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E876C4CEE4;
	Mon,  5 May 2025 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485043;
	bh=ILuU5mUox98kRSvahMMITcFsLpKEN2lWclTNJeUIJPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/Z++15l53s0L2N/1E8pKE9xkLY34ryrZnQkxDqWXp49BliYMLBGP5eZbO9F6mH15
	 ZoL5sgWBeZRolMpPGbeyCGDtOkZsZPpLvfiVe0qlKMljOu3V6lkQwdChzzGN1zHzcq
	 1eGKT104o5HOVrlQGyjXnnMa58oKyf4RtyS28weRcyC4lUtSk+obWHCvzCt+ZS3hIo
	 x9wByhxs52LSVfTqUPCApdUOluvDplNVhnIdHBblj64WW9/ObiMCpxJC1nfyefcP7o
	 9uzK1hqYRGJVIJF06gGnZjkQIeTO5ns+ZzrPZf61ixoTgzsVPol4+8uzsNfF/ARk1/
	 WjEi99C62uAdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	gshan@redhat.com,
	peterx@redhat.com,
	joey.gouly@arm.com,
	yangyicong@hisilicon.com,
	ioworker0@gmail.com
Subject: [PATCH AUTOSEL 6.12 138/486] arm64/mm: Check pmd_table() in pmd_trans_huge()
Date: Mon,  5 May 2025 18:33:34 -0400
Message-Id: <20250505223922.2682012-138-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit d1770e909898c108e8c7d30ca039053e8818a9c9 ]

Check for pmd_table() in pmd_trans_huge() rather then just checking for the
PMD_TABLE_BIT. But ensure all present-invalid entries are handled correctly
by always setting PTE_VALID before checking with pmd_table().

Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250221044227.1145393-8-anshuman.khandual@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc98..8ee56ae999c16 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -554,18 +554,6 @@ static inline int pmd_protnone(pmd_t pmd)
 #endif
 
 #define pmd_present(pmd)	pte_present(pmd_pte(pmd))
-
-/*
- * THP definitions.
- */
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
@@ -725,6 +713,18 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
 #define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	/*
+	 * If pmd is present-invalid, pmd_table() won't detect it
+	 * as a table, so force the valid bit for the comparison.
+	 */
+	return pmd_val(pmd) && pmd_present(pmd) &&
+	       !pmd_table(__pmd(pmd_val(pmd) | PTE_VALID));
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
 static inline bool pud_table(pud_t pud) { return true; }
-- 
2.39.5


