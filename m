Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD147C033C
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJJSRe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjJJSRd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 14:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC194;
        Tue, 10 Oct 2023 11:17:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E64C433C7;
        Tue, 10 Oct 2023 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696961851;
        bh=n08KAtxs2MVTqYiW7dIJ3ZUqre1aDEV3KgtOiG/G9/U=;
        h=Date:To:From:Subject:From;
        b=ElivzVsA0XztGB7/9i+StEXAzUxIsoPs9IUZ8CBjIgL6B9cKYI4Ncml+9MNkXvG0K
         fhu9QrxviwE2JSpph/OICxeFHoIpBw0YNEcHXPBKZMdklES1QKUc3xvR6Ockc8Wp4W
         Q6AGfTuvfYoJ8MJvwER/Ab5zOBVMh8laxE7/5Zpw=
Date:   Tue, 10 Oct 2023 11:17:18 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        jason.sim@samsung.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries.patch added to mm-hotfixes-unstable branch
Message-Id: <20231010181729.49E64C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries.patch

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
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()
Date: Tue, 10 Oct 2023 10:17:37 -0400

Users complained about OOM errors during fork without triggering
compaction.  This can be fixed by modifying the flags used in
mas_expected_entries() so that the compaction will be triggered in low
memory situations.  Since mas_expected_entries() is only used during fork,
the extra argument does not need to be passed through.

Additionally, the testing in the maple tree fork testing needed to be
altered to use the correct locking type so that allocations would not
trigger sleeping and thus failures in the testing.  The additional locking
change requires rwsem support additions to the tools/ directory through
the use of pthreads pthread_rwlock_t.  With this change test_maple_tree
works in userspace, as a module, and in-kernel.

Users may notice that the system gave up early on attempting to start new
processes instead of attempting to reclaim memory.

Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4
Link: https://lkml.kernel.org/r/20231010141737.1592866-1-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <jason.sim@samsung.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/maple_tree.c            |    2 -
 lib/test_maple_tree.c       |   13 +++++++----
 tools/include/linux/rwsem.h |   40 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

--- a/lib/maple_tree.c~maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries
+++ a/lib/maple_tree.c
@@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count(mas, nr_nodes + 3);
+	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
--- a/lib/test_maple_tree.c~maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries
+++ a/lib/test_maple_tree.c
@@ -9,6 +9,7 @@
 
 #include <linux/maple_tree.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
 #define CONFIG_MAPLE_SEARCH
@@ -2616,6 +2617,10 @@ static noinline void __init check_dup_ga
 	void *tmp;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	if (!zero_start)
 		i = 1;
@@ -2625,9 +2630,9 @@ static noinline void __init check_dup_ga
 		mtree_store_range(mt, i*10, (i+1)*10 - gap,
 				  xa_mk_value(i), GFP_KERNEL);
 
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_non_kernel(99999);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	ret = mas_expected_entries(&newmas, nr_entries);
 	mt_set_non_kernel(0);
 	MT_BUG_ON(mt, ret != 0);
@@ -2640,9 +2645,9 @@ static noinline void __init check_dup_ga
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
--- /dev/null
+++ a/tools/include/linux/rwsem.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _TOOLS__RWSEM_H
+#define _TOOLS__RWSEM_H
+
+#include <pthread.h>
+
+struct rw_semaphore {
+	pthread_rwlock_t lock;
+};
+
+static inline int init_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_init(&sem->lock, NULL);
+}
+
+static inline int exit_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_destroy(&sem->lock);
+}
+
+static inline int down_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_rdlock(&sem->lock);
+}
+
+static inline int up_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+
+static inline int down_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_wrlock(&sem->lock);
+}
+
+static inline int up_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+#endif /* _TOOLS_RWSEM_H */
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

maple_tree-add-gfp_kernel-to-allocations-in-mas_expected_entries.patch
mmap-add-clarifying-comment-to-vma_merge-code.patch
radix-tree-test-suite-fix-allocation-calculation-in-kmem_cache_alloc_bulk.patch

