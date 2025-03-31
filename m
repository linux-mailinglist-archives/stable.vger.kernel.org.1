Return-Path: <stable+bounces-127135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DCA768AC
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AA51617EB
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30D22DF8A;
	Mon, 31 Mar 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBotbjEy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA722DF83;
	Mon, 31 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431861; cv=none; b=nIox++IBa5f8ltqckHZW4dEpHeM+Vgo3qWqiWkQYl+7KvqsjWS97Y/aILD/ZLGd18R/RTADMM7odSs/cfDg/5t33yVdds6jKNpWKWScTy23YDcnzOKz2Dh4huiDdSHSosoROO3o+KuL64NDQh69U4zFCmiuGf2tG3yJUrI1HhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431861; c=relaxed/simple;
	bh=5ADO/3ZB6u14eIhTvT/hIqhq1OHtuLq3qs53bMniVfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/N5EdSRTI5hC8WNKj3X73SAaAusTFVtAfkQacBvDyw7h/JEduuEunoLqsJL5X9iQ9e6Rt9DKrALuDju2GehDx6GCPaK5JWw9UIccX5I9Fi4l1Ns0HpmUgy89cVc22SfVoKZaJGu0jmg3se9Z3ZxprqcOHbu8oq2VD9acPx5UPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBotbjEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123F7C4CEE3;
	Mon, 31 Mar 2025 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431861;
	bh=5ADO/3ZB6u14eIhTvT/hIqhq1OHtuLq3qs53bMniVfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBotbjEyaJmCOqfUdISjI5DQ9K7g4N1xAtBQI6A93FJNyx73x5kiVyIkn7kofO2n+
	 3r8llhIp8Pqu9lys2/3hc8e3Oi2lC/+YGZx1/a4Yr3N+ItBbRb3Baz4WOkhA1TkXib
	 sVBNH8Ppjjl01RFTWY0a9zP6CDmt7P4ZkUtNa5QV7hxbTT7c+War6HGRL2fgEYDgrb
	 aOi/cMIVO3BiLjzrQz6eohBBuM7agAhFCWLLCRgFCtn6nfhQblcNdticn8vt+l8mjg
	 oPEf1jjlXEOrK01RAaIi05VyqX21d+3mKzAIFR5qMXyI9bV44n8Eu9RgZyUsCnPyUI
	 kDdK7CZBBZ7XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Subject: [PATCH AUTOSEL 5.4 5/5] x86/mm/ident_map: Fix theoretical virtual address overflow to zero
Date: Mon, 31 Mar 2025 10:37:26 -0400
Message-Id: <20250331143728.1686696-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143728.1686696-1-sashal@kernel.org>
References: <20250331143728.1686696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

[ Upstream commit f666c92090a41ac5524dade63ff96b3adcf8c2ab ]

The current calculation of the 'next' virtual address in the
page table initialization functions in arch/x86/mm/ident_map.c
doesn't protect against wrapping to zero.

This is a theoretical issue that cannot happen currently,
the problematic case is possible only if the user sets a
high enough x86_mapping_info::offset value - which no
current code in the upstream kernel does.

( The wrapping to zero only occurs if the top PGD entry is accessed.
  There are no such users upstream. Only hibernate_64.c uses
  x86_mapping_info::offset, and it operates on the direct mapping
  range, which is not the top PGD entry. )

Should such an overflow happen, it can result in page table
corruption and a hang.

To future-proof this code, replace the manual 'next' calculation
with p?d_addr_end() which handles wrapping correctly.

[ Backporter's note: there's no need to backport this patch. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241016111458.846228-2-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/ident_map.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a72..2f383e288c430 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -27,9 +27,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
+		next = pud_addr_end(addr, end);
 
 		if (info->direct_gbpages) {
 			pud_t pudval;
@@ -68,10 +66,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		p4d_t *p4d = p4d_page + p4d_index(addr);
 		pud_t *pud;
 
-		next = (addr & P4D_MASK) + P4D_SIZE;
-		if (next > end)
-			next = end;
-
+		next = p4d_addr_end(addr, end);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
 			result = ident_pud_init(info, pud, addr, next);
@@ -113,10 +108,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
 
-		next = (addr & PGDIR_MASK) + PGDIR_SIZE;
-		if (next > end)
-			next = end;
-
+		next = pgd_addr_end(addr, end);
 		if (pgd_present(*pgd)) {
 			p4d = p4d_offset(pgd, 0);
 			result = ident_p4d_init(info, p4d, addr, next);
-- 
2.39.5


