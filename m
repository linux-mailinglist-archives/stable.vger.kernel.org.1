Return-Path: <stable+bounces-113822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39DA293FF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D311C16B475
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE41FCCE2;
	Wed,  5 Feb 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNqJJbwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EF1FC7FA;
	Wed,  5 Feb 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768276; cv=none; b=gZL+6md0NBd3Xztr55RksXojYCTzSHzBpUfxyLtn5rXbfDnYZj1AwA0WwxyKw1wyAo86yHAtMxHynbf6u+fh0OLRrZ/uMlqblIxanrHEKXhs3F3/q0mzHAaWxyG6wmdA/MKCYIGns6sFVJoPSt98qDSQ0f02nGXsqpuayCEOmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768276; c=relaxed/simple;
	bh=vRVDvN5EvXOgZCjJDDT9ppbtUpJcmcahP/uIr5Z1igg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH7jjdOUTxjXFCeLmemNgBCjMVUYlos2R3QyOODBNic/HmslqLf3erJ5Zjek634cvL84PE3lP68gJhqFfXFRs8ma3QssKZzbs1PGLMtLGgx0NQLN+sjYiGWjpCk5kxD6FGm/Fel+uUi8oFNuWlRTgOHeJ24SgVihMR1fRv1L8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNqJJbwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6242CC4CED1;
	Wed,  5 Feb 2025 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768275;
	bh=vRVDvN5EvXOgZCjJDDT9ppbtUpJcmcahP/uIr5Z1igg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNqJJbwSFWO/KgwzB5uEI4jQWdXLqm8+H44C1mHWvK7dUNGndFJa6SHgakgCQH30S
	 FNl46ymRutFNM/1aKBTLGWFDjRVUO/xCzmd5Fc0pnkNlRr0zhv3YHBS1dasPzM2A8K
	 FB7wN2L7m3oOkDFdzsqkMuJikywquMe+0TQ/En3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 520/623] s390/mm: Allow large pages for KASAN shadow mapping
Date: Wed,  5 Feb 2025 14:44:22 +0100
Message-ID: <20250205134516.120632036@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit e70452c4ba2ce1e24a3fdc18bd623edb7b56013c ]

Commit c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address
spaces") introduced a large_allowed() helper that restricts which mapping
modes can use large pages. This change unintentionally prevented KASAN
shadow mappings from using large pages, despite there being no reason
to avoid them. In fact, large pages are preferred for performance.

Since commit d8073dc6bc04 ("s390/mm: Allow large pages only for aligned
physical addresses"), both can_large_pud() and can_large_pmd() call _pa()
to check if large page physical addresses are aligned. However, _pa()
has a side effect: it allocates memory in POPULATE_KASAN_MAP_SHADOW
mode.

Rename large_allowed() to large_page_mapping_allowed() and add
POPULATE_KASAN_MAP_SHADOW to the allowed list to restore large page
mappings for KASAN shadows.

While large_page_mapping_allowed() isn't strictly necessary with current
mapping modes since disallowed modes either don't map anything or fail
alignment and size checks, keep it for clarity.

Rename _pa() to resolve_pa_may_alloc() for clarity and to emphasize
existing side effect. Rework can_large_pud()/can_large_pmd() to take
the side effect into consideration and actually return physical address
instead of just checking conditions.

Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address spaces")
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/vmem.c | 74 +++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 3fa28db2fe59f..41f0159339dbb 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -13,6 +13,7 @@
 #include "decompressor.h"
 #include "boot.h"
 
+#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 struct ctlreg __bootdata_preserved(s390_invalid_asce);
 
 #ifdef CONFIG_PROC_FS
@@ -236,11 +237,12 @@ static pte_t *boot_pte_alloc(void)
 	return pte;
 }
 
-static unsigned long _pa(unsigned long addr, unsigned long size, enum populate_mode mode)
+static unsigned long resolve_pa_may_alloc(unsigned long addr, unsigned long size,
+					  enum populate_mode mode)
 {
 	switch (mode) {
 	case POPULATE_NONE:
-		return -1;
+		return INVALID_PHYS_ADDR;
 	case POPULATE_DIRECT:
 		return addr;
 	case POPULATE_LOWCORE:
@@ -258,33 +260,55 @@ static unsigned long _pa(unsigned long addr, unsigned long size, enum populate_m
 		return addr;
 #endif
 	default:
-		return -1;
+		return INVALID_PHYS_ADDR;
 	}
 }
 
-static bool large_allowed(enum populate_mode mode)
+static bool large_page_mapping_allowed(enum populate_mode mode)
 {
-	return (mode == POPULATE_DIRECT) || (mode == POPULATE_IDENTITY) || (mode == POPULATE_KERNEL);
+	switch (mode) {
+	case POPULATE_DIRECT:
+	case POPULATE_IDENTITY:
+	case POPULATE_KERNEL:
+#ifdef CONFIG_KASAN
+	case POPULATE_KASAN_MAP_SHADOW:
+#endif
+		return true;
+	default:
+		return false;
+	}
 }
 
-static bool can_large_pud(pud_t *pu_dir, unsigned long addr, unsigned long end,
-			  enum populate_mode mode)
+static unsigned long try_get_large_pud_pa(pud_t *pu_dir, unsigned long addr, unsigned long end,
+					  enum populate_mode mode)
 {
-	unsigned long size = end - addr;
+	unsigned long pa, size = end - addr;
+
+	if (!machine.has_edat2 || !large_page_mapping_allowed(mode) ||
+	    !IS_ALIGNED(addr, PUD_SIZE) || (size < PUD_SIZE))
+		return INVALID_PHYS_ADDR;
 
-	return machine.has_edat2 && large_allowed(mode) &&
-	       IS_ALIGNED(addr, PUD_SIZE) && (size >= PUD_SIZE) &&
-	       IS_ALIGNED(_pa(addr, size, mode), PUD_SIZE);
+	pa = resolve_pa_may_alloc(addr, size, mode);
+	if (!IS_ALIGNED(pa, PUD_SIZE))
+		return INVALID_PHYS_ADDR;
+
+	return pa;
 }
 
-static bool can_large_pmd(pmd_t *pm_dir, unsigned long addr, unsigned long end,
-			  enum populate_mode mode)
+static unsigned long try_get_large_pmd_pa(pmd_t *pm_dir, unsigned long addr, unsigned long end,
+					  enum populate_mode mode)
 {
-	unsigned long size = end - addr;
+	unsigned long pa, size = end - addr;
+
+	if (!machine.has_edat1 || !large_page_mapping_allowed(mode) ||
+	    !IS_ALIGNED(addr, PMD_SIZE) || (size < PMD_SIZE))
+		return INVALID_PHYS_ADDR;
+
+	pa = resolve_pa_may_alloc(addr, size, mode);
+	if (!IS_ALIGNED(pa, PMD_SIZE))
+		return INVALID_PHYS_ADDR;
 
-	return machine.has_edat1 && large_allowed(mode) &&
-	       IS_ALIGNED(addr, PMD_SIZE) && (size >= PMD_SIZE) &&
-	       IS_ALIGNED(_pa(addr, size, mode), PMD_SIZE);
+	return pa;
 }
 
 static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long end,
@@ -298,7 +322,7 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long e
 		if (pte_none(*pte)) {
 			if (kasan_pte_populate_zero_shadow(pte, mode))
 				continue;
-			entry = __pte(_pa(addr, PAGE_SIZE, mode));
+			entry = __pte(resolve_pa_may_alloc(addr, PAGE_SIZE, mode));
 			entry = set_pte_bit(entry, PAGE_KERNEL);
 			if (!machine.has_nx)
 				entry = clear_pte_bit(entry, __pgprot(_PAGE_NOEXEC));
@@ -313,7 +337,7 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long e
 static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next, pages = 0;
+	unsigned long pa, next, pages = 0;
 	pmd_t *pmd, entry;
 	pte_t *pte;
 
@@ -323,8 +347,9 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long e
 		if (pmd_none(*pmd)) {
 			if (kasan_pmd_populate_zero_shadow(pmd, addr, next, mode))
 				continue;
-			if (can_large_pmd(pmd, addr, next, mode)) {
-				entry = __pmd(_pa(addr, _SEGMENT_SIZE, mode));
+			pa = try_get_large_pmd_pa(pmd, addr, next, mode);
+			if (pa != INVALID_PHYS_ADDR) {
+				entry = __pmd(pa);
 				entry = set_pmd_bit(entry, SEGMENT_KERNEL);
 				if (!machine.has_nx)
 					entry = clear_pmd_bit(entry, __pgprot(_SEGMENT_ENTRY_NOEXEC));
@@ -346,7 +371,7 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long e
 static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next, pages = 0;
+	unsigned long pa, next, pages = 0;
 	pud_t *pud, entry;
 	pmd_t *pmd;
 
@@ -356,8 +381,9 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 		if (pud_none(*pud)) {
 			if (kasan_pud_populate_zero_shadow(pud, addr, next, mode))
 				continue;
-			if (can_large_pud(pud, addr, next, mode)) {
-				entry = __pud(_pa(addr, _REGION3_SIZE, mode));
+			pa = try_get_large_pud_pa(pud, addr, next, mode);
+			if (pa != INVALID_PHYS_ADDR) {
+				entry = __pud(pa);
 				entry = set_pud_bit(entry, REGION3_KERNEL);
 				if (!machine.has_nx)
 					entry = clear_pud_bit(entry, __pgprot(_REGION_ENTRY_NOEXEC));
-- 
2.39.5




