Return-Path: <stable+bounces-73879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196C970735
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EFC1F21AE1
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1315B132;
	Sun,  8 Sep 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4FOtq4X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419815B0E0
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797464; cv=none; b=J1nX+pTqjNE/uksiTZNvkzV5/iRpXf9IhU5+QIaSS5G0kCV9e+5JqErM5zu90gZfrRygKDpYY4nh2F+Q2oQlAVZimv99AGrXYbyWYtBi/0nHQlWtA0V1FXH3tuy3f3BSFTmeULZNH5s8vdNBhCFWb7E+cLz3Dwd2SN3W2NXvHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797464; c=relaxed/simple;
	bh=gneE7I1ZMsHo0b8jCQSoF3oSfgLTfw9SF89pOLJ6sug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GUIcOty1SMcJ+Q77ywk7weFgf4RSVv919TBfd72OANJvtnb70OfdeDrBwi0dvn1gMnYziWVYhpBwOPRBQx54UhuCK2ZppNOirOVM/dbyp1HZBKgIcfjG3mgQmSbimgQTeuXK0ldyCoBZFjY76GSITqBPz8kJhPNqniM97IcJ5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4FOtq4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0052C4CEC3;
	Sun,  8 Sep 2024 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797464;
	bh=gneE7I1ZMsHo0b8jCQSoF3oSfgLTfw9SF89pOLJ6sug=;
	h=Subject:To:Cc:From:Date:From;
	b=V4FOtq4X7R3/MiuRWLA5P660zQ3yvkF29w5cWyswC+5Csthq6oh0W1WikXVlg2GyY
	 Fu1M2esMlGM3yQJeSB57PtPHUwX6U5xmijwCIzZnuz+DQ2nrdIItXElDyEM5YknPUr
	 O+sNE4XT1dsie+Us+BdKc+NPI13KrEJp0obk0Nn0=
Subject: FAILED: patch "[PATCH] userfaultfd: fix checks for huge PMDs" failed to apply to 5.4-stable tree
To: jannh@google.com,aarcange@redhat.com,akpm@linux-foundation.org,david@redhat.com,hughd@google.com,stable@vger.kernel.org,xemul@virtuozzo.com,zhengqi.arch@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:10:57 +0200
Message-ID: <2024090857-wieldable-pedicure-19b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090857-wieldable-pedicure-19b9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

71c186efc1b2 ("userfaultfd: fix checks for huge PMDs")
dab6e717429e ("mm: Rename pmd_read_atomic()")
024d232ae4fc ("mm: Fix pmd_read_atomic()")
fbfdec9989e6 ("x86/mm/pae: Make pmd_t similar to pte_t")
bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
f1e1a7be4718 ("mm/vmscan.c: refactor shrink_node()")
d3629af59f41 ("mm/vmscan: make the annotations of refaults code at the right place")
e9c2dbc8bf71 ("mm/vmscan: define macros for refaults in struct lruvec")
507228044236 ("mm/khugepaged: record SCAN_PMD_MAPPED when scan_pmd() finds hugepage")
6614a3c3164a ("Merge tag 'mm-stable-2022-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71c186efc1b2cf1aeabfeff3b9bd5ac4c5ac14d8 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:25:21 +0200
Subject: [PATCH] userfaultfd: fix checks for huge PMDs

Patch series "userfaultfd: fix races around pmd_trans_huge() check", v2.

The pmd_trans_huge() code in mfill_atomic() is wrong in three different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. As pointed out by Qi Zheng, pmd_trans_huge() is not sufficient for
   detecting PMDs that don't point to page tables.
   On older kernels (before 6.5), you'd just have to win a single fairly
   wide race to hit this.
   I've tested this on 6.1 stable by racing migration (with a mdelay()
   patched into try_to_migrate()) against UFFDIO_ZEROPAGE - on my x86
   VM, that causes a kernel oops in ptlock_ptr().
3. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these (one fix for bugs 1+2, one
fix for bug 3), so that the first fix can be backported to kernels
affected by bugs 1+2.


This patch (of 2):

This fixes two issues.

I discovered that the following race can occur:

  mfill_atomic                other thread
  ============                ============
                              <zap PMD>
  pmdp_get_lockless() [reads none pmd]
  <bail if trans_huge>
  <if none:>
                              <pagefault creates transhuge zeropage>
    __pte_alloc [no-op]
                              <zap PMD>
  <bail if pmd_trans_huge(*dst_pmd)>
  BUG_ON(pmd_none(*dst_pmd))

I have experimentally verified this in a kernel with extra mdelay() calls;
the BUG_ON(pmd_none(*dst_pmd)) triggers.

On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
a BUG_ON(), since the page table access helpers are actually designed to
deal with page tables concurrently disappearing; but on older kernels
(<=6.4), I think we could probably theoretically race past the two
BUG_ON() checks and end up treating a hugepage as a page table.

The second issue is that, as Qi Zheng pointed out, there are other types
of huge PMDs that pmd_trans_huge() can't catch: devmap PMDs and swap PMDs
(in particular, migration PMDs).

On <=6.4, this is worse than the first issue: If mfill_atomic() runs on a
PMD that contains a migration entry (which just requires winning a single,
fairly wide race), it will pass the PMD to pte_offset_map_lock(), which
assumes that the PMD points to a page table.

Breakage follows: First, the kernel tries to take the PTE lock (which will
crash or maybe worse if there is no "struct page" for the address bits in
the migration entry PMD - I think at least on X86 there usually is no
corresponding "struct page" thanks to the PTE inversion mitigation, amd64
looks different).

If that didn't crash, the kernel would next try to write a PTE into what
it wrongly thinks is a page table.

As part of fixing these issues, get rid of the check for pmd_trans_huge()
before __pte_alloc() - that's redundant, we're going to have to check for
that after the __pte_alloc() anyway.

Backport note: pmdp_get_lockless() is pmd_read_atomic() in older kernels.

Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com
Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..290b2a0d84ac 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -787,21 +787,23 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		}
 
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
-		/*
-		 * If the dst_pmd is mapped as THP don't
-		 * override it and just be strict.
-		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
-			err = -EEXIST;
-			break;
-		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
 		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
 			err = -ENOMEM;
 			break;
 		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		/*
+		 * If the dst_pmd is THP don't override it and just be strict.
+		 * (This includes the case where the PMD used to be THP and
+		 * changed back to none after __pte_alloc().)
+		 */
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
+			     pmd_devmap(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
+		if (unlikely(pmd_bad(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}


