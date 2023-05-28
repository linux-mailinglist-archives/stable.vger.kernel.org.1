Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9721E713865
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1Hem (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1Hel (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864EB4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D6E61702
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37749C433EF;
        Sun, 28 May 2023 07:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259279;
        bh=EWZ7w6sbN4/vpanPDB+NG7rFB+I4vtHecZmMIDhfnl4=;
        h=Subject:To:Cc:From:Date:From;
        b=eD6wQPHHTYPOmBCc+svLkZZkaRc6I7RfPXA8tOTA25z31I39gv6rt/JRlMJcvhhsr
         SoDeriYQvH5TAuIZry/zJ5CRPKU4e5eH79mjOvu0As27QUlNmOFRA1YQLqEgBJVYjk
         3vF7jZ2iFHaPe5N0fL9RQzJxm6Gch/j7SgfCEAzM=
Subject: FAILED: patch "[PATCH] binder: fix UAF of alloc->vma in race with munmap()" failed to apply to 5.4-stable tree
To:     cmllamas@google.com, gregkh@linuxfoundation.org, jannh@google.com,
        liam.howlett@oracle.com, minchan@kernel.org,
        stable@vger.kernel.org, tkjos@google.com,
        yang.shi@linux.alibaba.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:34:34 +0100
Message-ID: <2023052834-shakable-mobile-fdb0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052834-shakable-mobile-fdb0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d1d8875c8c13 ("binder: fix UAF of alloc->vma in race with munmap()")
c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
7b0dbd940765 ("binder: fix binder_alloc kernel-doc warnings")
d6d04d71daae ("binder: remove binder_alloc_set_vma()")
e66b77e50522 ("binder: rename alloc->vma_vm_mm to alloc->mm")
50e177c5bfd9 ("Merge 6.0-rc4 into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Fri, 19 May 2023 19:59:49 +0000
Subject: [PATCH] binder: fix UAF of alloc->vma in race with munmap()

[ cmllamas: clean forward port from commit 015ac18be7de ("binder: fix
  UAF of alloc->vma in race with munmap()") in 5.10 stable. It is needed
  in mainline after the revert of commit a43cfc87caaf ("android: binder:
  stop saving a pointer to the VMA") as pointed out by Liam. The commit
  log and tags have been tweaked to reflect this. ]

In commit 720c24192404 ("ANDROID: binder: change down_write to
down_read") binder assumed the mmap read lock is sufficient to protect
alloc->vma inside binder_update_page_range(). This used to be accurate
until commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
munmap"), which now downgrades the mmap_lock after detaching the vma
from the rbtree in munmap(). Then it proceeds to teardown and free the
vma with only the read lock held.

This means that accesses to alloc->vma in binder_update_page_range() now
will race with vm_area_free() in munmap() and can cause a UAF as shown
in the following KASAN trace:

  ==================================================================
  BUG: KASAN: use-after-free in vm_insert_page+0x7c/0x1f0
  Read of size 8 at addr ffff16204ad00600 by task server/558

  CPU: 3 PID: 558 Comm: server Not tainted 5.10.150-00001-gdc8dcf942daa #1
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x0/0x2a0
   show_stack+0x18/0x2c
   dump_stack+0xf8/0x164
   print_address_description.constprop.0+0x9c/0x538
   kasan_report+0x120/0x200
   __asan_load8+0xa0/0xc4
   vm_insert_page+0x7c/0x1f0
   binder_update_page_range+0x278/0x50c
   binder_alloc_new_buf+0x3f0/0xba0
   binder_transaction+0x64c/0x3040
   binder_thread_write+0x924/0x2020
   binder_ioctl+0x1610/0x2e5c
   __arm64_sys_ioctl+0xd4/0x120
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  Allocated by task 559:
   kasan_save_stack+0x38/0x6c
   __kasan_kmalloc.constprop.0+0xe4/0xf0
   kasan_slab_alloc+0x18/0x2c
   kmem_cache_alloc+0x1b0/0x2d0
   vm_area_alloc+0x28/0x94
   mmap_region+0x378/0x920
   do_mmap+0x3f0/0x600
   vm_mmap_pgoff+0x150/0x17c
   ksys_mmap_pgoff+0x284/0x2dc
   __arm64_sys_mmap+0x84/0xa4
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  Freed by task 560:
   kasan_save_stack+0x38/0x6c
   kasan_set_track+0x28/0x40
   kasan_set_free_info+0x24/0x4c
   __kasan_slab_free+0x100/0x164
   kasan_slab_free+0x14/0x20
   kmem_cache_free+0xc4/0x34c
   vm_area_free+0x1c/0x2c
   remove_vma+0x7c/0x94
   __do_munmap+0x358/0x710
   __vm_munmap+0xbc/0x130
   __arm64_sys_munmap+0x4c/0x64
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  [...]
  ==================================================================

To prevent the race above, revert back to taking the mmap write lock
inside binder_update_page_range(). One might expect an increase of mmap
lock contention. However, binder already serializes these calls via top
level alloc->mutex. Also, there was no performance impact shown when
running the binder benchmark tests.

Fixes: c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/20230518144052.xkj6vmddccq4v66b@revolver
Cc: <stable@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Link: https://lore.kernel.org/r/20230519195950.1775656-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e7c9d466f8e8..662a2a2e2e84 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -212,7 +212,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->mm;
 
 	if (mm) {
-		mmap_read_lock(mm);
+		mmap_write_lock(mm);
 		vma = alloc->vma;
 	}
 
@@ -270,7 +270,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		trace_binder_alloc_page_end(alloc, index);
 	}
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return 0;
@@ -303,7 +303,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 err_no_vma:
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;

