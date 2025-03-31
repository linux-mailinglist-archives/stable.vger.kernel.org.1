Return-Path: <stable+bounces-127118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7BA7688A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB307A33E8
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71F22A1EF;
	Mon, 31 Mar 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOPA1XFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3B22A1ED;
	Mon, 31 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431811; cv=none; b=a2pFVyV/WYWAKQChdx30mdx1iC/tlPpLVwe2Nn21mWW4l1ZABi2DFSs+bmQK5u1jNc7G4AtQTQJvtSb4j8SvIZaw5oh3xhK2lHGrJqBph2iv1rLExDwMCsItNVRgivLXjwvzADtJsRnAKGGjul19chv+pxUtYOpS/LEWEfHMGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431811; c=relaxed/simple;
	bh=5ADO/3ZB6u14eIhTvT/hIqhq1OHtuLq3qs53bMniVfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieVO3fN9ilr560v3y4zTlFqmmdjL+hMwWlvPupT4ymweh4wRZx55xxS5dYig6zN4hlxW4+5OB6PlpyxiLKqiV/K0VVsoH7uNDPIcAeC+k9mxv1UX3FdI9cJ7hzEZAJWw63JEJn3KvrEY9TpJEsfMtpMGGpaiRXr2ixgkjsFn9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOPA1XFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D27FC4CEE3;
	Mon, 31 Mar 2025 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431810;
	bh=5ADO/3ZB6u14eIhTvT/hIqhq1OHtuLq3qs53bMniVfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOPA1XFz/ckNdaJUYSCiCjwsPqUbHUca8rgo6BeaEIwgP5VYP2tSMX8rJ/ZCxc+Y5
	 P0MHOqXOj14Tm8RwNzEkkwbgE0Vjq5RL1mU9hN4V2I4Qd/4BEEEyBekBv46ErOSFYO
	 8eRLXOa4BlGgjzUzr9F7t7+p1Ue9CELPa7Z0JSI72XmCsZqIq1+o8JRZk4apWesl4+
	 z/22w3/RvkswPrdYyY7Q/N7/HMIvDLqQL68mIZlLADpWYxGsA0xNKT4iF8QbBwxVIw
	 3Wq23UMamQnTCyyzD27M1qfhNRRbEioCbkYZH7b1c1rWX39YBSdAbmZ/gLh1CEv9of
	 e5jMF5YAameLA==
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
Subject: [PATCH AUTOSEL 6.1 6/6] x86/mm/ident_map: Fix theoretical virtual address overflow to zero
Date: Mon, 31 Mar 2025 10:36:32 -0400
Message-Id: <20250331143634.1686409-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143634.1686409-1-sashal@kernel.org>
References: <20250331143634.1686409-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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


