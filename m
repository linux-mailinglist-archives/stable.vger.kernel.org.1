Return-Path: <stable+bounces-4877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10651807CCA
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECC2282547
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87D367;
	Thu,  7 Dec 2023 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0eWLmlFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5087E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349A6C433C7;
	Thu,  7 Dec 2023 00:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701907996;
	bh=nJXoT0vO7lR7HssKUfUmlK2gcX8s3g1/IM5LccKfw0E=;
	h=Date:To:From:Subject:From;
	b=0eWLmlFV7GLQu73qSYXf+l6EttqQ8taMImpGNPcd/73QkpRWTeluKZxXWwiLLx0Jp
	 5kiYn3P3UwVhft3UUQ1HlGhoI+WbInEF5qH3Fov6PhxNW69FhTpfOHiwt7jVBlGG27
	 Xno6lEON7GheAzf6MDXR702WR5QQy5eSEENKynVg=
Date: Wed, 06 Dec 2023 16:13:14 -0800
To: mm-commits@vger.kernel.org,trix@redhat.com,stable@vger.kernel.org,riel@surriel.com,ndesaulniers@google.com,nathan@kernel.org,muchun.song@linux.dev,eadavis@qq.com,mike.kravetz@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch removed from -mm tree
Message-Id: <20231207001316.349A6C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write
has been removed from the -mm tree.  Its filename was
     hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Mike Kravetz <mike.kravetz@oracle.com>
Subject: hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write
Date: Mon, 13 Nov 2023 17:20:33 -0800

The routine __vma_private_lock tests for the existence of a reserve map
associated with a private hugetlb mapping.  A pointer to the reserve map
is in vma->vm_private_data.  __vma_private_lock was checking the pointer
for NULL.  However, it is possible that the low bits of the pointer could
be used as flags.  In such instances, vm_private_data is not NULL and not
a valid pointer.  This results in the null-ptr-deref reported by syzbot:

general protection fault, probably for non-canonical address 0xdffffc000000001d:
 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 0 PID: 5048 Comm: syz-executor139 Not tainted 6.6.0-rc7-syzkaller-00142-g88
8cf78c29e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 1
0/09/2023
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
...
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_write+0x93/0x200 kernel/locking/rwsem.c:1573
 hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
 hugetlb_vma_lock_write+0xae/0x100 mm/hugetlb.c:291
 __hugetlb_zap_begin+0x1e9/0x2b0 mm/hugetlb.c:5447
 hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
 unmap_vmas+0x2f4/0x470 mm/memory.c:1733
 exit_mmap+0x1ad/0xa60 mm/mmap.c:3230
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2a20 kernel/exit.c:861
 __do_sys_exit kernel/exit.c:991 [inline]
 __se_sys_exit kernel/exit.c:989 [inline]
 __x64_sys_exit+0x42/0x50 kernel/exit.c:989
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Mask off low bit flags before checking for NULL pointer.  In addition, the
reserve map only 'belongs' to the OWNER (parent in parent/child
relationships) so also check for the OWNER flag.

Link: https://lkml.kernel.org/r/20231114012033.259600-1-mike.kravetz@oracle.com
Reported-by: syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/00000000000078d1e00608d7878b@google.com/
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/hugetlb.h |    5 +----
 mm/hugetlb.c            |    7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/include/linux/hugetlb.h~hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write
+++ a/include/linux/hugetlb.h
@@ -1268,10 +1268,7 @@ static inline bool __vma_shareable_lock(
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
 
-static inline bool __vma_private_lock(struct vm_area_struct *vma)
-{
-	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
-}
+bool __vma_private_lock(struct vm_area_struct *vma);
 
 /*
  * Safe version of huge_pte_offset() to check the locks.  See comments
--- a/mm/hugetlb.c~hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write
+++ a/mm/hugetlb.c
@@ -1182,6 +1182,13 @@ static int is_vma_resv_set(struct vm_are
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
+bool __vma_private_lock(struct vm_area_struct *vma)
+{
+	return !(vma->vm_flags & VM_MAYSHARE) &&
+		get_vma_private_data(vma) & ~HPAGE_RESV_MASK &&
+		is_vma_resv_set(vma, HPAGE_RESV_OWNER);
+}
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
_

Patches currently in -mm which might be from mike.kravetz@oracle.com are



