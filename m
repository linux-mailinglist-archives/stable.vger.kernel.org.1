Return-Path: <stable+bounces-177740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5BAB43F7F
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E8188EDCD
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DE72618;
	Thu,  4 Sep 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ipyf+2wP"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4091F1518
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996914; cv=none; b=F5IevaIuWc7TKKgXs0igAnkH9+NhVlH4YDV1h5gPl2/TJNgA6J+UeIyMzmtuCUDje/NINN6MWH8gZdI2NCct9iJGTwYM2AHh4Yk9zsDuXuv35IJjKMxhlJIlkisJRJGjHYcCX7KDsI6Ix2dGKVnLf1rsaFpsMOdO02qlNhCYs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996914; c=relaxed/simple;
	bh=TuDHyBhIQTitquMWEI7QdsE8OCOA+rndYH/lWFxoJnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Goew+8pJTnkBNjsw5L96MXYD56VGfdGO0k9mFhPXRBvgpVsisSMj6Vk15yoDOQ36BlylKLnOYyCpG/S/LGSXTrxD0vcMH1/EIP1ZJMHAg393FkraXeKS9rKPnk7PYkZ0FUlKI4GhljUzf7rwUzc0wrot/EMPwwzmmr/0cISmijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Ipyf+2wP; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756996911; x=1788532911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WjDpZycUCAoas9tu7D84DTpaNaLMaCT2sRjsaJcsao=;
  b=Ipyf+2wP3ttYaEKExI1Gu1KbkVFtng7aoCekdmixQY7O0DDcGbAjZpl6
   urMZGSNygry4ijqB5mvYv6zkh1TAkYIgBLbdhK4GqD0qwd2M5bz9OFTGC
   MrYAZnP6ra7L71JmzfflbFC77cdf7FRMeiptsMGczfXF9SU/OXqjQyre2
   bdFGVTXAF5A1b4txCsWFdBTomHovTCE4b42eCb666SWbComk+r9jXcfMZ
   uUhuvFZTAMN9h5PuGdDlhygEGUD/BQ7VaZi3VhJkrI6pSamFcTjT2LA1p
   YOlxdBNp5DQC/AjiAtvL0kjop+veMlYPZPWHx/MmVbA8rfx0PZ4L7Dtsq
   w==;
X-CSE-ConnectionGUID: hahVcVH1QoiDnvMB8SBPZQ==
X-CSE-MsgGUID: QYG1WJ8tSW+fCRK2LPning==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2397785"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:41:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:15128]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id 977644e9-b354-4e02-a978-b38f59649c53; Thu, 4 Sep 2025 14:41:49 +0000 (UTC)
X-Farcaster-Flow-ID: 977644e9-b354-4e02-a978-b38f59649c53
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:41:49 +0000
Received: from dev-dsk-doebel-1c-c6d5f274.eu-west-1.amazon.com (10.13.240.106)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 14:41:47 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Jann Horn <jannh@google.com>, Zach O'Keefe <zokeefe@google.com>, "Kirill
 A. Shutemov" <kirill.shutemov@intel.linux.com>, Yang Shi
	<shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 5.15] mm/khugepaged: fix ->anon_vma race
Date: Thu, 4 Sep 2025 14:41:30 +0000
Message-ID: <20250904144136.58706-1-doebel@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
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


