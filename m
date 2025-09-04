Return-Path: <stable+bounces-177742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE46B43FC2
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8097C4BCC
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AFA303C96;
	Thu,  4 Sep 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="aVn4PKTU"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09E303CA1
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997881; cv=none; b=H6rH3Il9JizBPOUMiWpKV0V2RFq2NX+6pbnR2NgkCHIL7Cuvj3Rg7OrNc+k0sssUOdhUSVy9y1ZOjh2xJiZYLSl5hjH0moTPtT5hNsZZzdYuMMLtBe6KjX3CyVN5KjXtIWMAyEV6xwQgXc7itAR8ZI0QCbir6R4r2kNWCfy0P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997881; c=relaxed/simple;
	bh=THvo+IuFaE2Q35LXdtkP1h4/RHc9UecHhJdtlDxegeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAU5MJj3lhiXg8Pwe1mLcKck0csq09igsbYaDCyWif7wwK99MifVnUXxZ+GtymLk/bpBmU43L17Zb1x+KRANl8pHfDDXYUkuVUmHaIdGi9s0S4NbSZAtZwIfYc5eKO10Qe7h21AgLrAzOCbhdAnwjTHy4ZvlR/249NGLhCNYb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=aVn4PKTU; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756997879; x=1788533879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXvajQgRYZRd+P6iBj2MGYoMuU9iJEKIFoMB+VBSmhw=;
  b=aVn4PKTUvwfBRVfhvLI4C/fHhGEXSdL8hEtuoW/1RG2Mpekax5IKb2BW
   lQs/JD9W7QEqGJ8vRdrrfkRQyNyOrUA/2laSXKo0ZUAUFrshjeUhcpVUj
   O6nH+/Yd67vb2XoHv6kVuyBhsUjIsHf0BX8Om/ny7YGexCh0tNAV7iZnQ
   loU4mmsaJW9mHowOc2iqEh6tnmHsKdHyHIY+TvRfOpBPN+GfePwbG6lwr
   afOgNQcudZ2DMsBveWPFMEj+/Cd6QK8uDU5pMOLOUOLYNPSJIcLgdSi1i
   3NZgwa2NKVUDuwitmp29G2kxoGUfIpydhLX/jmu39Bk+Dc3qdyGqOx7AO
   A==;
X-CSE-ConnectionGUID: uYhktJI/R5aH3x8w0ERj9Q==
X-CSE-MsgGUID: 1nB+vSdkTgSmibULi0D4qw==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2402189"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:57:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:27863]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.144:2525] with esmtp (Farcaster)
 id bd010056-25b8-4338-a371-d33c2fe501a0; Thu, 4 Sep 2025 14:57:57 +0000 (UTC)
X-Farcaster-Flow-ID: bd010056-25b8-4338-a371-d33c2fe501a0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:57:57 +0000
Received: from dev-dsk-doebel-1c-c6d5f274.eu-west-1.amazon.com (10.13.240.106)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:57:55 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Jann Horn <jannh@google.com>, Zach O'Keefe <zokeefe@google.com>, "Kirill
 A. Shutemov" <kirill.shutemov@intel.linux.com>, Yang Shi
	<shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 5.10] mm/khugepaged: fix ->anon_vma race
Date: Thu, 4 Sep 2025 14:57:46 +0000
Message-ID: <20250904145752.95252-1-doebel@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
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
[doebel@amazon.de: Kernel 5.10 uses different control flow pattern,
    context adjustments]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
Testing
- passed the Amazon Linux kernel release tests
- already shipped in Amazon Linux 2
- compile-tested against v5.10.142
---
 mm/khugepaged.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 28e18777ec51..511499e8e29a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1611,7 +1611,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * has higher cost too. It would also probably require locking
 		 * the anon_vma.
 		 */
-		if (vma->anon_vma)
+		if (READ_ONCE(vma->anon_vma))
 			continue;
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK)
@@ -1633,6 +1633,19 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			if (!khugepaged_test_exit(mm)) {
 				struct mmu_notifier_range range;
 
+				/*
+				 * Re-check whether we have an ->anon_vma, because
+				 * collapse_and_free_pmd() requires that either no
+				 * ->anon_vma exists or the anon_vma is locked.
+				 * We already checked ->anon_vma above, but that check
+				 * is racy because ->anon_vma can be populated under the
+				 * mmap lock in read mode.
+				 */
+				if (vma->anon_vma) {
+					mmap_write_unlock(mm);
+					continue;
+				}
+
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


