Return-Path: <stable+bounces-61370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C681D93BE53
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A5281AE9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63537197555;
	Thu, 25 Jul 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey08YAgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECC197A76
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898232; cv=none; b=SA9unSrg4isXu9o3r7yS3WEqfTEkoo3fqbv6HnRzHuX1ojgLuvaAxxNUQZlfPE0D7xKbJwzS4RK68E1Rc6t2HGx8VyHYvHeiM/FHDQ4VrlcMOeDP5G+s2sz5FJzGPH/OOA18048jQwep3q/S5AKma5SlRMwLkMRcJAHIWX9INzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898232; c=relaxed/simple;
	bh=ktq7M3foSa4aHhEmT7CQctdVVEd8++vnRRMJLYqAi+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnhBuqJnzHsSgNj/kwlOq/fU471iFFKLO0DVEoaW7a0QBA3OiDeGvElQE2hCBWAeoBdEnCmVRcuSSq/ljRqyX4tB3RZGF9nPNHU3WOptai65klCoTl1+hw0KoHyRYWH3fPxUNMm7i8Vjp02P3S7dz1q/NL/6V616TXC2pMCIygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey08YAgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C80AC32786;
	Thu, 25 Jul 2024 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721898231;
	bh=ktq7M3foSa4aHhEmT7CQctdVVEd8++vnRRMJLYqAi+A=;
	h=From:To:Cc:Subject:Date:From;
	b=ey08YAgWZlA+LDmC0EVMst7itd4EbUyEmIxbMcRw1XcZmSE+klIO6UOZV3jRJOTGV
	 w1a2+BJBRE8X/iEX7wkJkyXe2dJpVymNUAnmeXzIlhUgevIM5nYznmwwMnM87+wjeW
	 WL4vOSR1ECpCeylnwJaZvIFA+u7lNLzTZdg1tznZKRjF61WNRT/DHtJMgUhuENxiEK
	 6ebv555mTHnaGJ30K230oG2hfjqmSnMb7WgzEuIAXMHEqbeHuEFNMDk1suLBn3tOAc
	 spsPBWUI6IfPOEKGazox3iTdipDapJfhq6MxMFx1gxXEadnydn+EsDsDhxQKrljWWD
	 jdmEVjJDzqdKw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>
Subject: [PATCH] arm64: mm: Fix lockless walks with static and dynamic page-table folding
Date: Thu, 25 Jul 2024 10:03:45 +0100
Message-Id: <20240725090345.28461-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lina reports random oopsen originating from the fast GUP code when
16K pages are used with 4-level page-tables, the fourth level being
folded at runtime due to lack of LPA2.

In this configuration, the generic implementation of
p4d_offset_lockless() will return a 'p4d_t *' corresponding to the
'pgd_t' allocated on the stack of the caller, gup_fast_pgd_range().
This is normally fine, but when the fourth level of page-table is folded
at runtime, pud_offset_lockless() will offset from the address of the
'p4d_t' to calculate the address of the PUD in the same page-table page.
This results in a stray stack read when the 'p4d_t' has been allocated
on the stack and can send the walker into the weeds.

Fix the problem by providing our own definition of p4d_offset_lockless()
when CONFIG_PGTABLE_LEVELS <= 4 which returns the real page-table
pointer rather than the address of the local stack variable.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net
Fixes: 0dd4f60a2c76 ("arm64: mm: Add support for folding PUDs at runtime")
Reported-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..7a4f5604be3f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1065,6 +1065,28 @@ static inline bool pgtable_l5_enabled(void) { return false; }
 
 #define p4d_offset_kimg(dir,addr)	((p4d_t *)dir)
 
+static inline
+p4d_t *p4d_offset_lockless_folded(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
+{
+	/*
+	 * With runtime folding of the pud, pud_offset_lockless() passes
+	 * the 'pgd_t *' we return here to p4d_to_folded_pud(), which
+	 * will offset the pointer assuming that it points into
+	 * a page-table page. However, the fast GUP path passes us a
+	 * pgd_t allocated on the stack and so we must use the original
+	 * pointer in 'pgdp' to construct the p4d pointer instead of
+	 * using the generic p4d_offset_lockless() implementation.
+	 *
+	 * Note: reusing the original pointer means that we may
+	 * dereference the same (live) page-table entry multiple times.
+	 * This is safe because it is still only loaded once in the
+	 * context of each level and the CPU guarantees same-address
+	 * read-after-read ordering.
+	 */
+	return p4d_offset(pgdp, addr);
+}
+#define p4d_offset_lockless p4d_offset_lockless_folded
+
 #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
 
 #define pgd_ERROR(e)	\
-- 
2.45.2.1089.g2a221341d9-goog


