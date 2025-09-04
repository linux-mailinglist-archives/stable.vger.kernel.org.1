Return-Path: <stable+bounces-177743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DABB43FF3
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5247A72D9
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC452FB624;
	Thu,  4 Sep 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="K3JPSMK+"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AF1EB9F2
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998357; cv=none; b=k/nL2DTdPSABcBDYJgkyZrq7QvYqUQZvvTKFT79M7ABFTA+1c1BhWUKteF6YSFQzJJs5TmDN2z9X+pTMDeSFMLwXbss5unz9g0GsD2RRnQMk7GRcFsX+OzByQyxv8Oquxkbjd84oEr3TS/NVDBLVaynGnSK+2yRNbod9JEcue0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998357; c=relaxed/simple;
	bh=vuiZtRl4YQkuLOEE3FQgO7woe2hZv6/qkP6+VLCSrF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l9U3jk+o4YQnHaVLiUEjTvnsR/XnYC5e6FZ2OxS/5KsMAp1AltKk3yhPr4v2Uo49eH1eme65t843wRP5qpZ9Njn/YoGWlV4bSorAWoeb4wu+aGLJMShASVe+fN0MP2k/WUbb7HYQYDu6UObOXD+QcHTABz6b4YO7JEZWdgQtmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=K3JPSMK+; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756998355; x=1788534355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2MtprZCy9g2JVJUzZFEN3am3fmbGexM5fgUscILhIFk=;
  b=K3JPSMK+uVCHsyR3dTRqwZmk8pdZEFtJUjTJN2+FhkZgf9oCj/GoyzjS
   eqWmMX/mlSrj3OO06Y0sxem7K4jqjphzerRK8WYuFfennJBsaKqu/+CFG
   FIqsx9z/NqmU8b5N1hg9cCIxGOwLHoFSK8Sfr6xpJrCr2xa8Fu3SxwkeP
   uP7DPgPxvR3qToKRjDpgbwojwCF6NeM9VRpM0Rn+jHdCxzAu7txUvE5Sj
   rIJ8khDCY614OgjqcZB8XdD82Ufu3PSjG5Msoa/T3PzYJn8PEbzg5Vonn
   JuUinP3F/x1jqyeBOad2nY3clpyCi4nVhTVSd9EBsXbBpkC14HmHU0Ym5
   Q==;
X-CSE-ConnectionGUID: lk1eP/vPS/W4k4HmdPK7Gw==
X-CSE-MsgGUID: xWHqRtO7RmGuZ9f+DoVOxQ==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2284810"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 15:05:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:25591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.106:2525] with esmtp (Farcaster)
 id 51c155d1-8630-4337-a89d-794bfb8c86dc; Thu, 4 Sep 2025 15:05:52 +0000 (UTC)
X-Farcaster-Flow-ID: 51c155d1-8630-4337-a89d-794bfb8c86dc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 15:05:52 +0000
Received: from dev-dsk-doebel-1c-c6d5f274.eu-west-1.amazon.com (10.13.240.106)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 15:05:51 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Jann Horn <jannh@google.com>, Zach O'Keefe <zokeefe@google.com>, "Kirill
 A. Shutemov" <kirill.shutemov@intel.linux.com>, Yang Shi
	<shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 5.4] mm/khugepaged: fix ->anon_vma race
Date: Thu, 4 Sep 2025 15:05:40 +0000
Message-ID: <20250904150547.56150-1-doebel@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jann Horn <jannh@google.com>

[Upstream commit 023f47a8250c6bdb4aebe744db4bf7f73414028b]

If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
it to be locked.

Page table traversal is allowed under any one of the mmap lock, the
anon_vma lock (if the VMA is associated with an anon_vma), and the
mapping lock (if the VMA is associated with a mapping); and so to be
able to remove page tables, we must hold all three of them.
retract_page_tables() bails out if an ->anon_vma is attached, but does
this check before holding the mmap lock (as the comment above the check
explains).

If we racily merged an existing ->anon_vma (shared with a child
process) from a neighboring VMA, subsequent rmap traversals on pages
belonging to the child will be able to see the page tables that we are
concurrently removing while assuming that nothing else can access them.

Repeat the ->anon_vma check once we hold the mmap lock to ensure that
there really is no concurrent page table access.

Hitting this bug causes a lockdep warning in collapse_and_free_pmd(),
in the line "lockdep_assert_held_write(&vma->anon_vma->root->rwsem)".
It can also lead to use-after-free access.

Link: https://lore.kernel.org/linux-mm/CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230111133351.807024-1-jannh@google.com
Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Jann Horn <jannh@google.com>
Reported-by: Zach O'Keefe <zokeefe@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[doebel@amazon.de: Kernel 5.4 uses different control flow and locking
    mechanism. Context adjustments.]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
Testing
- passed the Amazon Linux kernel release tests
- already shipped in Amazon Linux 2
- compile-tested against v5.4.298
---
 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f1f98305433e..d6da1fcbef6f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1476,7 +1476,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * has higher cost too. It would also probably require locking
 		 * the anon_vma.
 		 */
-		if (vma->anon_vma)
+		if (READ_ONCE(vma->anon_vma))
 			continue;
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK)
@@ -1498,6 +1498,18 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			if (!khugepaged_test_exit(mm)) {
 				struct mmu_notifier_range range;
 
+				/*
+				 * Re-check whether we have an ->anon_vma, because
+				 * collapse_and_free_pmd() requires that either no
+				 * ->anon_vma exists or the anon_vma is locked.
+				 * We already checked ->anon_vma above, but that check
+				 * is racy because ->anon_vma can be populated under the
+				 * mmap_sem in read mode.
+				 */
+				if (vma->anon_vma) {
+					up_write(&mm->mmap_sem);
+					continue;
+				}
 				mmu_notifier_range_init(&range,
 							MMU_NOTIFY_CLEAR, 0,
 							NULL, mm, addr,
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


