Return-Path: <stable+bounces-110456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE9A1C88F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6F43A7253
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AC190685;
	Sun, 26 Jan 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwragsIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F415747D;
	Sun, 26 Jan 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902937; cv=none; b=gQp015Y+yvucW66garPLmsgenXXPSrcxSpqRmbloSZvbQFmacpGb/GfqwfHjqCtl65ZLg5HlUqMH7RRye/OJyrxZGWOVgClN+Ur3vHNLV3nycKhHFmuTBby4URkSniuwaI2cvxkw68HqeyczblJC/WYa1MZ0dGR4KgENhzCjw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902937; c=relaxed/simple;
	bh=J+ZSzrTvWqPoHLJ15Ix5PgxvQGdPfmfBslnYH0ZC1/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XRQGIUfFyerq+WFCXp7VUPL5KpEsL1ZOMc2wZikYbCzq19467c9FTougr77W24CfqqVAZgIrxk6c0kLvwrp0Wl1BZuhEnuhv/dFtrTWUMPdBvLBvQNKYjdAk41RvCePA5NGOfK+D9h/tsLKi3f6vgpilMdVNxls1/WaekO///f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwragsIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7C8C4CED3;
	Sun, 26 Jan 2025 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902936;
	bh=J+ZSzrTvWqPoHLJ15Ix5PgxvQGdPfmfBslnYH0ZC1/k=;
	h=From:To:Cc:Subject:Date:From;
	b=HwragsIoqQs/jFbzGNVjRZRlmCj4FUSHNEui/ZQk+b4n0nH8N1XmqkXFnxrviDBDU
	 oXdYBEzJ8tovLMMqmTraW+mD/C7IBVy0lYN8Knnad8lYyDVJ4Ho3xSoyE/rwR1u3kW
	 OdeEr0hIXfez85rx+sXwgdHsE34AK0sZxPMSOfjUYmL3AqN8rpYTnNIg+0IFlXgs82
	 6K99wqKNjLlWBrPCvHeKbj1rEWzcREBYJA3aihZtGti/f3NqCHC0BByf25DdEBDwHL
	 dAdafIk/Gf/DhrYbyLVwMX7D9IgMxV4340QfLEceHZ4rlFD74cG4ST1glMP2KH/EkX
	 MK4auCkeCqwKw==
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
Subject: [PATCH AUTOSEL 6.12 1/6] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
Date: Sun, 26 Jan 2025 09:48:48 -0500
Message-Id: <20250126144854.925377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 5f1e2103888b7..0a6956bbfb326 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -508,6 +508,18 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 
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


