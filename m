Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D577EBA38
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 00:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjKNXam (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 18:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKNXal (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 18:30:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01062D6;
        Tue, 14 Nov 2023 15:30:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4CAC433C7;
        Tue, 14 Nov 2023 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700004637;
        bh=WVvPbwWzMGMDE4mFnX/HWM7Bq0MAxL2n7slMfJSeaCE=;
        h=Date:To:From:Subject:From;
        b=J3YSDP+gvbUlv3qtJZ2qhs/eF5efKcbMSCUodD1BLxkCzlLNa1XbGzBJaeWruXiNx
         M/Q01d4IXiZ1FIBIu8oC34wwU32OUgX2MprwcCupkev41JJxYI27PcXTGFA30Eu/9l
         FV0s9nD7WTry2DbRicmbMTwE24MdeK+S/+UuS38U=
Date:   Tue, 14 Nov 2023 15:30:36 -0800
To:     mm-commits@vger.kernel.org, trix@redhat.com,
        stable@vger.kernel.org, riel@surriel.com, ndesaulniers@google.com,
        nathan@kernel.org, muchun.song@linux.dev, eadavis@qq.com,
        mike.kravetz@oracle.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch added to mm-hotfixes-unstable branch
Message-Id: <20231114233037.8D4CAC433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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

hugetlb-fix-null-ptr-deref-in-hugetlb_vma_lock_write.patch

