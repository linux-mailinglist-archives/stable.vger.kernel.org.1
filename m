Return-Path: <stable+bounces-177735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB07B43EC2
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BD73A5D89
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A431197D;
	Thu,  4 Sep 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="f2wciTt1"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FF3112C4
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995998; cv=none; b=R3BlmCx0+naD3qIdu35mJ9T79gZmIF+INsXXSTarzKVomFwxn09zyrxIDjt+zGKO4VvYYM/Vmk+kAIMxwjuYYe0ZfzQd0VlYXqRrNp74qa65QmwTw/dWeUrT2h2NJwvkL35/xZYylnlv5Z0SYqAY/vePsXsS80NKy2V++gr9PYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995998; c=relaxed/simple;
	bh=TuDHyBhIQTitquMWEI7QdsE8OCOA+rndYH/lWFxoJnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAGEubdnQaRsYfsnjLKtfxSrysxW2tj2iaCROVColslHy1HtMVFYe2W3Ikupj73tC/u2BbL6msWUSypy4SlD3m87sVX2GbORhANO1Ol0Zi6z+YWxlbaJQ5nsH39sUzbVddd+5FaSA++0RzzoQnL5JYYC10w+nIDQO2aW8YUUECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=f2wciTt1; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756995996; x=1788531996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WjDpZycUCAoas9tu7D84DTpaNaLMaCT2sRjsaJcsao=;
  b=f2wciTt1tgz0jRK/yJ3QvPsQsWCNaPOtAuHuBa5gr9+WQccbbob7eHD7
   hB1cXOXWkJ9yMHbm8t84ctja12KggXIqVBqRZqyXD/C+X7rwk5UvJ/hCI
   dQ0Df/hA6NmdQ0NmIz1ETM5lVB/wqdpN25kJBoHsEmtKI4QehBOD8Rhz0
   4z9hhzcFsMY3kuHD998903B72+AF/hOahb5n90+lTOq24S4+VLBUJHlRF
   FudK61NGOARNqs4TVMgjnXsRr8+QgpyheSZ2nOmYCCQHerGjdhvt0r9x2
   zHrWoO6DB/f2wMRAkSNh26cLj14e+xe1z9jjIdWB3Neeslio2nNADJtOB
   g==;
X-CSE-ConnectionGUID: 4LloKcYdSkC9kHN5BNdP1A==
X-CSE-MsgGUID: TtSCIehdRKeyoHUxLaaggA==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2280679"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:26:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:20959]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.48:2525] with esmtp (Farcaster)
 id 47227be0-f90b-484e-b462-8f25dac8f845; Thu, 4 Sep 2025 14:26:33 +0000 (UTC)
X-Farcaster-Flow-ID: 47227be0-f90b-484e-b462-8f25dac8f845
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:26:33 +0000
Received: from dev-dsk-doebel-1c-c6d5f274.eu-west-1.amazon.com (10.13.240.106)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:26:32 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <doebel@amazon.de>
CC: Jann Horn <jannh@google.com>, Zach O'Keefe <zokeefe@google.com>, "Kirill
 A. Shutemov" <kirill.shutemov@intel.linux.com>, Yang Shi
	<shy828301@gmail.com>, David Hildenbrand <david@redhat.com>,
	<stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/khugepaged: fix ->anon_vma race
Date: Thu, 4 Sep 2025 14:26:10 +0000
Message-ID: <20250904142615.98207-1-doebel@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jann Horn <jannh@google.com>

commit 023f47a8250c6bdb4aebe744db4bf7f73414028b upstream.

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
[doebel@amazon.de: Kernel 5.15 uses a different control flow pattern,
    context adjustments.]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 mm/khugepaged.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 203792e70ac1..e318c1abc81f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1609,7 +1609,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * has higher cost too. It would also probably require locking
 		 * the anon_vma.
 		 */
-		if (vma->anon_vma)
+		if (READ_ONCE(vma->anon_vma))
 			continue;
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK)
@@ -1631,6 +1631,19 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
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


