Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D577716DD9
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjE3ToD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjE3ToC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:44:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F87E11D
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b00f70e6b0so50824785ad.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685475839; x=1688067839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c86zkUCwKdsoLRGucF9puo1Mr+PPtZAU7fBECOIO6a8=;
        b=xWkOoMd97ndmLOrDTY/zxcCbACnluzEtTwTSQaBTXWGHB8z/XWLrhbglgvfR4NI+2q
         6pSFep9NvDWdAsdwRIuf7ULKDp6Kf15MAtPWNbwnR+KxJakKX1uWRem1ci7EmrOt7a34
         rNSnR+GnIBTU+wjNS/vklwups/GxhAHBwTHFqKnwaJ58YZQkyYs5sEdSJJMQQw2YPJMh
         KlxkL/zN8ZbnzGNh02awQ3+8zWnKVzvEixpbLmjrJPPdsSbQLc7Ij/k33R+crm0Se0bc
         2yC5Ycqe/odi8q6FUZJnW50Z/nUszwH3LM5N5GClFd45Ul2Nc59ZgLacYhAKaeetEZN5
         pCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475839; x=1688067839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c86zkUCwKdsoLRGucF9puo1Mr+PPtZAU7fBECOIO6a8=;
        b=bc1l/NU/DiaAGg1LHkiphJqLzJNQrrOPnjhMimOPmS4rCcvlqn4xa3FMcgaBQF23k+
         ZtM7E0LKHBTrzUWVdHCA5xMZs9NaLLHhgLiEAGD+Dm9dT+LaHHTJKIMWz0uuGpbGjsUO
         eQuHroglMvE0d17171cGXACnfKfGd1r/INuDocdu8WxrlGRboF6RvrkBb4CVxIP9LkR4
         UCVu+sRZeXU6aTmJTaubunMXdFgLU4ex94iVVEhT/PVYR+oT/2wp3rVrOJ9QuYJiRYmj
         TevY8cI3iXyUPVf661Ej3rLmPuQ9mxGpvQW58OYtPGd/PYAbgtT0DYdPgWttc8QdQecN
         w1MA==
X-Gm-Message-State: AC+VfDyosLfZEU1JR2h+MbhSD9sk04SYJ0dzMn2L3Mmv32aQpRKTDMDa
        HSQ385PvoPX0wF+pKAKwvFqzWAY6IF1RJHvNOPGUZ3wc1KFgaMAkphBEJTxkb+XIpy4Ai3zlLr1
        1zGtpOCR1oCCZa80jfgOccHlUlnGN0gqmiRtSLYE0gRNO56KGi4kstSfT0MJXOsL71tk=
X-Google-Smtp-Source: ACHHUZ6vIoyFmSLKRPP0qMrJJiEWaxKwSF3yUzYenYkwN9tBpND/aQ8KLAI0T4bJqvRv0lgQGyJQ/2QpaGN+Bg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:b194:b0:1b0:2aca:1413 with SMTP
 id s20-20020a170902b19400b001b02aca1413mr953373plr.10.1685475839320; Tue, 30
 May 2023 12:43:59 -0700 (PDT)
Date:   Tue, 30 May 2023 19:43:38 +0000
In-Reply-To: <20230530194338.1683009-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230530194338.1683009-1-cmllamas@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530194338.1683009-5-cmllamas@google.com>
Subject: [PATCH 5.15.y 5/5] binder: fix UAF of alloc->vma in race with munmap()
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@vger.kernel.org
Cc:     Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07 upstream.

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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a54deddafc6d..db01c5d423e6 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -212,7 +212,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->vma_vm_mm;
 
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
-- 
2.41.0.rc0.172.g3f132b7071-goog

