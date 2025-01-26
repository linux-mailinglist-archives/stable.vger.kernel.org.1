Return-Path: <stable+bounces-110467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C86A1C8B9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116A11883B62
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629EA16CD1D;
	Sun, 26 Jan 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p32zk/F5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB121A0712;
	Sun, 26 Jan 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902961; cv=none; b=kZcZcGI8b41Jj/qS+6ZL1xMvH2UJyiS/9Gfr3bj24Dn+wGyaUeiC+pBc2bIRIuYx//8HWErW09Nqwog9b2Q+t+gb/JYYut/F9qqUEe8dSP6tVc5A9ZFDTza5X5xgsYNLRIODaokBpmSbCbJfdurZdZcqpP1F3Hwsr/KHUXHyukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902961; c=relaxed/simple;
	bh=9+3vIQ8Nh0j2jwAEnfMYPpWVa7eNRZ3rs/rkruTrFUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOb9RO0Qk5I37gOnyAimBHvQ7N98Z0/kdKtzgrryQixOeOx3se4YMpuKRVl5YKjjvJO3FFREvJYfNwSZI0dMSt1awc4BDODHN/XuJ5O9NLM90Z6m3AJJV/4hhCkgOPcCuqno+Vo18BSJvoNDFIMKaa2D4o7TOj97/NdX9RwcjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p32zk/F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B54C4CED3;
	Sun, 26 Jan 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902961;
	bh=9+3vIQ8Nh0j2jwAEnfMYPpWVa7eNRZ3rs/rkruTrFUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=p32zk/F5ZNblwvQJAtASViDHLwN3gTzCa95a/B+yAcSWEGBxC9a6gfekefgt3n3iW
	 CXCpE/mRfocMTnVQPO9E8vXHjG5ZTbO2wT9ZUMWRPNNhRCHBXlIMCd+xPTUFvoQMrZ
	 6ZCuD6lSuoaOYoXV9BEM9XyrBS842A86nGWutBmGQOGHpJaFBAA8eA7xyX7Jg3nhXc
	 3U3BidMiTFbaDqfBD7joscIWe44S6h2qolsPZqNoBtcyDvo9OFC/CNURINNtSnruZ8
	 WvG5fWWHl1KsY7Qe9gh7teztpFMJnTI87JHRz+lNKfB6B47IcRMbBUCxDMtr1WYGkV
	 JPkLpJj0W8akw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Gavin Shan <gshan@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterx@redhat.com,
	christophe.leroy@csgroup.eu
Subject: [PATCH AUTOSEL 6.1 1/4] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
Date: Sun, 26 Jan 2025 09:49:14 -0500
Message-Id: <20250126144918.925549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit 1e5823c8e86de83a43d59a522b4de29066d3b306 ]

This asserts that HUGE_MAX_HSTATE is sufficient enough preventing potential
hugetlb_max_hstate runtime overflow in hugetlb_add_hstate() thus triggering
a BUG_ON() there after.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Link: https://lore.kernel.org/r/20241202064407.53807-1-anshuman.khandual@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/hugetlbpage.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 134dcf6bc650c..99810310efdda 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -544,6 +544,18 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 
 static int __init hugetlbpage_init(void)
 {
+	/*
+	 * HugeTLB pages are supported on maximum four page table
+	 * levels (PUD, CONT PMD, PMD, CONT PTE) for a given base
+	 * page size, corresponding to hugetlb_add_hstate() calls
+	 * here.
+	 *
+	 * HUGE_MAX_HSTATE should at least match maximum supported
+	 * HugeTLB page sizes on the platform. Any new addition to
+	 * supported HugeTLB page sizes will also require changing
+	 * HUGE_MAX_HSTATE as well.
+	 */
+	BUILD_BUG_ON(HUGE_MAX_HSTATE < 4);
 	if (pud_sect_supported())
 		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
 
-- 
2.39.5


