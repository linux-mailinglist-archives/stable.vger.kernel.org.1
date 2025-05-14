Return-Path: <stable+bounces-144282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101CAB6050
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65F24A4351
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23912E1CD;
	Wed, 14 May 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="an/y97NQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B370288A5;
	Wed, 14 May 2025 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747184221; cv=none; b=eYvHwBeXZM0cAhpEJZy6UwIraQhXB8Rr7xK50VTdfdcX84jnOkrqdNNwPearX+/r2llgvXkIc8C7NndSURdFtUD5ZA5Okx5TY3mf59Ybh76n0HNMOjySTC6H1TCssAYSna1RnIN+SjYV+rwemBtiTjvHoywYqyUe2dorSh99CSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747184221; c=relaxed/simple;
	bh=Ov8paTZ/Fb/DtjhxYafV9qA0hMZwe9IOJOJ74/qkJe0=;
	h=Date:To:From:Subject:Message-Id; b=bOp/uIY2HcEL52gnBBM6+7XeF18kaU4I6hGv0vGBvG0VU2k9gKydkueuRT1ebAevryOq0pw/jHrm6y6tCDl/YAn9Bieh2Jaw435uYLN+V9M79VAmHENYlLdDRpUwypkOiKoAoLA3PkiwlddnTuMvfAjNwbeLttkvIGxR7tdp/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=an/y97NQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A837BC4CEE4;
	Wed, 14 May 2025 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747184220;
	bh=Ov8paTZ/Fb/DtjhxYafV9qA0hMZwe9IOJOJ74/qkJe0=;
	h=Date:To:From:Subject:From;
	b=an/y97NQXAXtXfSlmGfquCc2HyxyPEFavOn21KSgtctB2pu6IwkyxLAuoqMBnkAaz
	 aZRAvwaaCKB7DusRyL5BV3SoEpEGekDOOWOamFQSzzNAdnsAFETCFVbIpUESM4xylC
	 RZJTVC+4gLtUKqlxrPE0b1kmfju5e7J0txkAn38E=
Date: Tue, 13 May 2025 17:57:00 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,revest@google.com,osalvador@suse.de,muchun.song@linux.dev,hughd@google.com,gshan@redhat.com,byungchul@sk.com,gavinguo@igalia.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-hugetlb-fix-a-deadlock-with-pagecache_folio-and-hugetlb_fault_mutex_table.patch added to mm-new branch
Message-Id: <20250514005700.A837BC4CEE4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/hugetlb: fix a deadlock with pagecache_folio and hugetlb_fault_mutex_table
has been added to the -mm mm-new branch.  Its filename is
     mm-hugetlb-fix-a-deadlock-with-pagecache_folio-and-hugetlb_fault_mutex_table.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-fix-a-deadlock-with-pagecache_folio-and-hugetlb_fault_mutex_table.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Gavin Guo <gavinguo@igalia.com>
Subject: mm/hugetlb: fix a deadlock with pagecache_folio and hugetlb_fault_mutex_table
Date: Tue, 13 May 2025 17:34:48 +0800

Fix a deadlock which can be triggered by an internal syzkaller [1]
reproducer and captured by bpftrace script [2] and its log [3] in this
scenario:

Process 1                              Process 2
---				       ---
hugetlb_fault
  mutex_lock(B) // take B
  filemap_lock_hugetlb_folio
    filemap_lock_folio
      __filemap_get_folio
        folio_lock(A) // take A
  hugetlb_wp
    mutex_unlock(B) // release B
    ...                                hugetlb_fault
    ...                                  mutex_lock(B) // take B
                                         filemap_lock_hugetlb_folio
                                           filemap_lock_folio
                                             __filemap_get_folio
                                               folio_lock(A) // blocked
    unmap_ref_private
    ...
    mutex_lock(B) // retake and blocked

This is a ABBA deadlock involving two locks:
- Lock A: pagecache_folio lock
- Lock B: hugetlb_fault_mutex_table lock

The deadlock occurs between two processes as follows:

1. The first process (let's call it Process 1) is handling a
   copy-on-write (COW) operation on a hugepage via hugetlb_wp.  Due to
   insufficient reserved hugetlb pages, Process 1, owner of the reserved
   hugetlb page, attempts to unmap a hugepage owned by another process
   (non-owner) to satisfy the reservation.  Before unmapping, Process 1
   acquires lock B (hugetlb_fault_mutex_table lock) and then lock A
   (pagecache_folio lock).  To proceed with the unmap, it releases Lock B
   but retains Lock A.  After the unmap, Process 1 tries to reacquire Lock
   B.  However, at this point, Lock B has already been acquired by another
   process.

2. The second process (Process 2) enters the hugetlb_fault handler
   during the unmap operation.  It successfully acquires Lock B
   (hugetlb_fault_mutex_table lock) that was just released by Process 1,
   but then attempts to acquire Lock A (pagecache_folio lock), which is
   still held by Process 1.

As a result, Process 1 (holding Lock A) is blocked waiting for Lock B
(held by Process 2), while Process 2 (holding Lock B) is blocked waiting
for Lock A (held by Process 1), constructing a ABBA deadlock scenario.

The solution here is to unlock the pagecache_folio and provide the
pagecache_folio_unlocked variable to the caller to have the visibility
over the pagecache_folio status for subsequent handling.

The error message:
INFO: task repro_20250402_:13229 blocked for more than 64 seconds.
      Not tainted 6.15.0-rc3+ #24
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro_20250402_ state:D stack:25856 pid:13229 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 __schedule+0x1755/0x4f50
 schedule+0x158/0x330
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock+0x75f/0xeb0
 hugetlb_wp+0xf88/0x3440
 hugetlb_fault+0x14c8/0x2c30
 trace_clock_x86_tsc+0x20/0x20
 do_user_addr_fault+0x61d/0x1490
 exc_page_fault+0x64/0x100
 asm_exc_page_fault+0x26/0x30
RIP: 0010:__put_user_4+0xd/0x20
 copy_process+0x1f4a/0x3d60
 kernel_clone+0x210/0x8f0
 __x64_sys_clone+0x18d/0x1f0
 do_syscall_64+0x6a/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x41b26d
 </TASK>
INFO: task repro_20250402_:13229 is blocked on a mutex likely owned by task repro_20250402_:13250.
task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
Call Trace:
 <TASK>
 __schedule+0x1755/0x4f50
 schedule+0x158/0x330
 io_schedule+0x92/0x110
 folio_wait_bit_common+0x69a/0xba0
 __filemap_get_folio+0x154/0xb70
 hugetlb_fault+0xa50/0x2c30
 trace_clock_x86_tsc+0x20/0x20
 do_user_addr_fault+0xace/0x1490
 exc_page_fault+0x64/0x100
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x402619
 </TASK>
INFO: task repro_20250402_:13250 blocked for more than 65 seconds.
      Not tainted 6.15.0-rc3+ #24
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
Call Trace:
 <TASK>
 __schedule+0x1755/0x4f50
 schedule+0x158/0x330
 io_schedule+0x92/0x110
 folio_wait_bit_common+0x69a/0xba0
 __filemap_get_folio+0x154/0xb70
 hugetlb_fault+0xa50/0x2c30
 trace_clock_x86_tsc+0x20/0x20
 do_user_addr_fault+0xace/0x1490
 exc_page_fault+0x64/0x100
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x402619
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/35:
 #0: ffffffff879a7440 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180
2 locks held by repro_20250402_/13229:
 #0: ffff888017d801e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x37/0x300
 #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_wp+0xf88/0x3440
3 locks held by repro_20250402_/13250:
 #0: ffff8880177f3d08 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x41b/0x1490
 #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_fault+0x3b8/0x2c30
 #2: ffff8880129500e8 (&resv_map->rw_sema){++++}-{4:4}, at: hugetlb_fault+0x494/0x2c30

Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
Link: https://github.com/bboymimi/bpftracer/blob/master/scripts/hugetlb_lock_debug.bt [2]
Link: https://drive.google.com/file/d/1bWq2-8o-BJAuhoHWX7zAhI6ggfhVzQUI/view?usp=sharing [3]
Link: https://lkml.kernel.org/r/20250513093448.592150-1-gavinguo@igalia.com
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Florent Revest <revest@google.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Byungchul Park <byungchul@sk.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

--- a/mm/hugetlb.c~mm-hugetlb-fix-a-deadlock-with-pagecache_folio-and-hugetlb_fault_mutex_table
+++ a/mm/hugetlb.c
@@ -6131,7 +6131,8 @@ static void unmap_ref_private(struct mm_
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
 static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
-		       struct vm_fault *vmf)
+		       struct vm_fault *vmf,
+		       bool *pagecache_folio_unlocked)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
@@ -6229,6 +6230,22 @@ retry_avoidcopy:
 
 			folio_put(old_folio);
 			/*
+			 * The pagecache_folio needs to be unlocked to avoid
+			 * deadlock and we won't re-lock it in hugetlb_wp(). The
+			 * pagecache_folio could be truncated after being
+			 * unlocked. So its state should not be relied
+			 * subsequently.
+			 *
+			 * Setting *pagecache_folio_unlocked to true allows the
+			 * caller to handle any necessary logic related to the
+			 * folio's unlocked state.
+			 */
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				if (pagecache_folio_unlocked)
+					*pagecache_folio_unlocked = true;
+			}
+			/*
 			 * Drop hugetlb_fault_mutex and vma_lock before
 			 * unmapping.  unmapping needs to hold vma_lock
 			 * in write mode.  Dropping vma_lock in read mode
@@ -6581,7 +6598,7 @@ static vm_fault_t hugetlb_no_page(struct
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(folio, vmf);
+		ret = hugetlb_wp(folio, vmf, NULL);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6653,6 +6670,7 @@ vm_fault_t hugetlb_fault(struct mm_struc
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
+	bool pagecache_folio_unlocked = false;
 	struct vm_fault vmf = {
 		.vma = vma,
 		.address = address & huge_page_mask(h),
@@ -6807,7 +6825,8 @@ vm_fault_t hugetlb_fault(struct mm_struc
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(pagecache_folio, &vmf);
+			ret = hugetlb_wp(pagecache_folio, &vmf,
+					&pagecache_folio_unlocked);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
@@ -6824,10 +6843,14 @@ out_put_page:
 out_ptl:
 	spin_unlock(vmf.ptl);
 
-	if (pagecache_folio) {
+	/*
+	 * If the pagecache_folio is unlocked in hugetlb_wp(), we skip
+	 * folio_unlock() here.
+	 */
+	if (pagecache_folio && !pagecache_folio_unlocked)
 		folio_unlock(pagecache_folio);
+	if (pagecache_folio)
 		folio_put(pagecache_folio);
-	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
 
_

Patches currently in -mm which might be from gavinguo@igalia.com are

mm-hugetlb-fix-a-deadlock-with-pagecache_folio-and-hugetlb_fault_mutex_table.patch


