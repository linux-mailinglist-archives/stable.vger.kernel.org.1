Return-Path: <stable+bounces-179521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA05B562AB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 21:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1391D189D98A
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D023D7E2;
	Sat, 13 Sep 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6yqkjYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08776234973
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790636; cv=none; b=Hur5rzT8PwgNvHDz3ZvcWwWZpTHyKMwf8NO4O+UCZVgYijIh+QLoSoVF6Az/dsvogrw5fVFl3JReFyZSxZvHo1fUe+RNaWj50+MebfQkRzBD9ULEDFRwCy7ieGcTAlXbGzeahTQh1UB39b2XdPbLt+ZpABkbqZUt1WWsTsCOKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790636; c=relaxed/simple;
	bh=5yLeecKbK8IeX1veRCqXlDGeIOLswckq3yApUwzkphQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhCjel6oiVOFtssOas/8LMRMzNObzHWH1NWL7XlLbxhScavMXC6SsqkCMbc14UO+r8ISUEnoQ8ck+KHOhi9TBx8BUGF1KC3efUU2fJ6DUZUPxyiAzPw2uibHD83g3UnC59LQOEy9D0Sj7Iaegf1HrnIjUEtCi+XbcmiBHf+1mlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6yqkjYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C4EC4CEEB;
	Sat, 13 Sep 2025 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757790635;
	bh=5yLeecKbK8IeX1veRCqXlDGeIOLswckq3yApUwzkphQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6yqkjYZ21hUKEX3c+LZChEDhSF8XR7UoLu2ywrdYYDlJth3ef3GgPiXtBmhczd1E
	 1ounJIed9XZwj4pd4PCYhjK3f8qwQorp9GsQknc5qwKYVaqVnPAnO2h48I2t5SKhCO
	 CS3KzzmnKo28z/qlHH6kWSIQMINwAyJPTxiMRuOqb2WizTMggmF0F8lVVMeJssRB0y
	 6WpMNb6w3PgMJQRAq/4e9bzHypOquPD2GHhz1CZCNHRLG1QEiWdT+xAetENDg4FMM1
	 xk/RbSeOnV85QLvDMk+n8KC5yky9a23pc+wKz1sTqAOawRADWOKHonhTgKjwIn1FH+
	 ahND3xVgf5SXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Breno Leitao <leitao@debian.org>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
Date: Sat, 13 Sep 2025 15:10:32 -0400
Message-ID: <20250913191032.1527419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091332-pretzel-gating-6744@gregkh>
References: <2025091332-pretzel-gating-6744@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 21cc2b5c5062a256ae9064442d37ebbc23f5aef7 ]

When restoring a reservation for an anonymous page, we need to check to
freeing a surplus.  However, __unmap_hugepage_range() causes data race
because it reads h->surplus_huge_pages without the protection of
hugetlb_lock.

And adjust_reservation is a boolean variable that indicates whether
reservations for anonymous pages in each folio should be restored.
Therefore, it should be initialized to false for each round of the loop.
However, this variable is not initialized to false except when defining
the current adjust_reservation variable.

This means that once adjust_reservation is set to true even once within
the loop, reservations for anonymous pages will be restored
unconditionally in all subsequent rounds, regardless of the folio's state.

To fix this, we need to add the missing hugetlb_lock, unlock the
page_table_lock earlier so that we don't lock the hugetlb_lock inside the
page_table_lock lock, and initialize adjust_reservation to false on each
round within the loop.

Link: https://lkml.kernel.org/r/20250823182115.1193563-1-aha310510@gmail.com
Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Reported-by: syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=417aeb05fd190f3a6da9
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Page vs folio differences ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c6a4e855481a..f116af53a9392 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5512,7 +5512,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation = false;
+	bool adjust_reservation;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5604,6 +5604,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(page_folio(page));
+		spin_unlock(ptl);
 
 		/*
 		 * Restore the reservation for anonymous page, otherwise the
@@ -5611,14 +5612,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
+		adjust_reservation = false;
+
+		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
 		    folio_test_anon(page_folio(page))) {
 			folio_set_hugetlb_restore_reserve(page_folio(page));
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
 		}
-
-		spin_unlock(ptl);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/*
 		 * Adjust the reservation for the region that will have the
-- 
2.51.0


