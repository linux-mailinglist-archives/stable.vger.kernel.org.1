Return-Path: <stable+bounces-179446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB7B560B3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2028B1B24E3E
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31BB2EC085;
	Sat, 13 Sep 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U42VF06z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77726057A
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766275; cv=none; b=eV1B7lKJiLJE3Oe9ud5k1DKfG4CKoFVHnFMI6dqQv6ppYX/qRfA20HPuhOdaLNx2F87JdNK3qJC0/7nnpQ/dOLA+5EYrwWAeKAJ4HI80H3Imc55/Y8CtxvPUGkjQoIToNjcZYI8q1NtqFVfgehEH/r2Wj2lsFWHoJhxQNYnBh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766275; c=relaxed/simple;
	bh=44HYysHQs5dt1HfheDBnsc1t6uIo9Jh8z1+VCIpx5OE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gwf4/UN6xRSRA0n05kjS1Wn/3B1wlA5fAvpXzPY4PKji/ufg0uqlSAIOTh2du0bfwUuz/qL6+uBeHHpaFQh4UIdNBFWexryzSPPxVi45wsA1DsaZP3hSehEs8FKA/s3CiROC92Bo7FFz6KiG/y3l0TWLTAY/elPGYKaeYYpOdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U42VF06z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85B3C4CEEB;
	Sat, 13 Sep 2025 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766275;
	bh=44HYysHQs5dt1HfheDBnsc1t6uIo9Jh8z1+VCIpx5OE=;
	h=Subject:To:Cc:From:Date:From;
	b=U42VF06zIXoAgcdRnsaoIb93s0Xs10/pAkhd+yn/4wXCegKJ4Hwt4QOxk+Yxp+NSY
	 dKHisK7LTzO0pjrq4/kGHWjBNnbcBQuPBvZ1sZF4Y0ZWUskKLtlxr2RCPtfVd65tCG
	 LVuxssPKGIprF83YKh3BhdUJEhHSEYZlx9hyYiB8=
Subject: FAILED: patch "[PATCH] mm/hugetlb: add missing hugetlb_lock in" failed to apply to 6.12-stable tree
To: aha310510@gmail.com,akpm@linux-foundation.org,david@redhat.com,leitao@debian.org,muchun.song@linux.dev,osalvador@suse.de,sidhartha.kumar@oracle.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:24:32 +0200
Message-ID: <2025091332-pretzel-gating-6744@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 21cc2b5c5062a256ae9064442d37ebbc23f5aef7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091332-pretzel-gating-6744@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21cc2b5c5062a256ae9064442d37ebbc23f5aef7 Mon Sep 17 00:00:00 2001
From: Jeongjun Park <aha310510@gmail.com>
Date: Sun, 24 Aug 2025 03:21:15 +0900
Subject: [PATCH] mm/hugetlb: add missing hugetlb_lock in
 __unmap_hugepage_range()

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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..eed59cfb5d21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5851,7 +5851,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation = false;
+	bool adjust_reservation;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5944,6 +5944,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(folio);
+		spin_unlock(ptl);
 
 		/*
 		 * Restore the reservation for anonymous page, otherwise the
@@ -5951,14 +5952,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
+		adjust_reservation = false;
+
+		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
 		    folio_test_anon(folio)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
 		}
-
-		spin_unlock(ptl);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/*
 		 * Adjust the reservation for the region that will have the


