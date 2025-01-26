Return-Path: <stable+bounces-110449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A7BA1C87A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D393A6813
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591A149DF4;
	Sun, 26 Jan 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI3WUmnz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5961E89C;
	Sun, 26 Jan 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902923; cv=none; b=UYBBn7U8I3SG3lWAPdaogWVRxmELg9ga+YcpJcUHSbLSWO4UG4VLNxpoKb7pvynivx4elkTxrMAbP0KDTv1ssGs1UKF6UUMPlvwKNKDfZ4PAU4rGcdJiflIg7zq5/pT1KVI/UoBrYzgnmyl2rzZZVC8tru60iC3Vg4F4+hGwfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902923; c=relaxed/simple;
	bh=K2pCBPWAw7TDuoasXtDys6u4pkvag8mnuiMnnXgupIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l7jCGeWod5FIHZAsQ3GBW0+64LFjqmVb5H/wJNCSAwsHjiznOF01MTPXZ5dj0CzbI30rzBJlTDGFhzGSjA4/YulcTtJOQPwgaoRI8AV9d1RBuH2+51HV5CD+3Di7PD8mPNjwFgzJu/wsa9hjAG8QFu/9ngCuuAoV+dbiCa3k+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI3WUmnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E18BC4CED3;
	Sun, 26 Jan 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902922;
	bh=K2pCBPWAw7TDuoasXtDys6u4pkvag8mnuiMnnXgupIY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZI3WUmnzzwrw50AUk967oOUgPV0VrpkWQ1S1oWjsbKyKDjDwQaNj0PO+GuVjTmTU9
	 DmaaX/yJgAIhVE5WQUcIfnvdP+1VlU4+EqXSSGy8h/BiiW7dVdEODHaXgosG3yI38D
	 LrreVigPLtSowIr+8bMGg0AvDltGOFk+lkw89xrE8tMoeQDKlwRe397oc+jHHYpQsc
	 Fmil0Jc2ZMVcgZSm2IND7MZMU92rmasrbAzZvqtYCPKP1ZSuTqS0bp12hhNp+3AKP9
	 hyXnqW3cm86XN8P3aBX3O5v7ed5m2n6QtVLEMT1JurATmX2wZPXGPA051YITWzp2u+
	 BFwwRTnqv9pJQ==
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
Subject: [PATCH AUTOSEL 6.13 1/7] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
Date: Sun, 26 Jan 2025 09:48:32 -0500
Message-Id: <20250126144839.925271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 3215adf48a1b6..98a2a0e64e255 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -519,6 +519,18 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 
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


