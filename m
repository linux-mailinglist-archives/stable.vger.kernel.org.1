Return-Path: <stable+bounces-127112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF6A768AE
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BF33A5B87
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A67B227B8C;
	Mon, 31 Mar 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVYr95AK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA752227599;
	Mon, 31 Mar 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431791; cv=none; b=sVfahEkehCseXtdZPlTuKb2oDXQwa7d8EFDotbqY95lvSF+kEO+PfFDzWb9/Xm+Q6BCsn7N448KXm4ivDwVcEGZOzyUbU4aUaI9z1e3qns59sB7TkoWeSU+9DJsxZE/JUr55WaZMTJ3oW9dAwbtsOOMcfKxI4J2APX/nPxG4MWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431791; c=relaxed/simple;
	bh=8KI2vcAonFYEcFnRA7fUT66S7PeMBDbGzjmE3qr7M+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlC2LhCH3io66SYH9i2NVwESR8zpFcptlkYNjEAdFuqzNI9fKy5c7e+om/gT813DrWQ9O67N7FauIpXCyjhC00sTvM0AWQbbrASqyvug/2ZKt2cjdAzbgc947WooioXscdFtxnPUooNMyog29Rry5XrWSJllNlpH+OoD9ncONCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVYr95AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEEAC4CEE4;
	Mon, 31 Mar 2025 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431790;
	bh=8KI2vcAonFYEcFnRA7fUT66S7PeMBDbGzjmE3qr7M+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVYr95AKQMFTKVgezAW8ZMuXlmOzDp2GmsY/nFO26OU3FHUu7v/tWtvz7HbSLYf2M
	 O+CSCh61y+doQcN2yKltFbluLOjJnjhOVpR4X0zKs5v1tNj6uFH0hGb389sDHwjRVT
	 Er3bL3845VxR2acYZFv3wKx/kylXOsVPk5kNBtF9iokjJNXxfFk+0zrOC8lttXX1HE
	 c6+sbNQQOgcr0kQUGjmNDqWCLcWs2/qllTNdrYGnBDxpuEYRNBVlH1Sta6qjks2jVZ
	 Ev1eMcPYVjO73kT/+JBuVBLzFXkZghmW91aCPdnGasoy6phMjL6q21RG5dRAg3VWwB
	 3XBVxDCeFdyWA==
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
Subject: [PATCH AUTOSEL 6.6 8/9] x86/mm/ident_map: Fix theoretical virtual address overflow to zero
Date: Mon, 31 Mar 2025 10:36:01 -0400
Message-Id: <20250331143605.1686243-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143605.1686243-1-sashal@kernel.org>
References: <20250331143605.1686243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index fe0b2e66ded93..7adf7001473e7 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -28,9 +28,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pmd_t *pmd;
 		bool use_gbpage;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
+		next = pud_addr_end(addr, end);
 
 		/* if this is already a gbpage, this portion is already mapped */
 		if (pud_leaf(*pud))
@@ -81,10 +79,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
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
@@ -126,10 +121,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
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


