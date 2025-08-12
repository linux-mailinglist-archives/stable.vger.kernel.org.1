Return-Path: <stable+bounces-167218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A6B22D61
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68919626966
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DB2F83D4;
	Tue, 12 Aug 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lps602OF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E22F659B
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015527; cv=none; b=OUIvL1SoRpa/YsPQhUB52Ks/2zJ7+jmWZYefx3qV/Vlel9N+sYWALc0GxDJjsYaPWh3MTMK5QnCGdSGk89yq85YPEI0Us+3nT6ppkEVnONl57XBROflQzgpxLttIUQ878+6QEvaH2tobPqGQTMia84FsK7Kv2Iff22Uy4Mzjd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015527; c=relaxed/simple;
	bh=a1jhJa7Dprc2yiYuLvP3+6v+4liLH1oTMz7k7gohuy8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BAvZxUZp0CHqb1+UCp3cZDOfj7X+oCkFNniQd6U+IaIh8pTIFN7wUEEk3YgL3HG/ZZe0t4ZvQng+23kLgxdE8cqafk15kG+1WvN76fUp0d8njBK/1UitpLD6J4e/V6ePrpPFKJK9b1HQ6KZL5yUSssQBp9iayzELVwOt9dfX1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lps602OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B13C4CEF6;
	Tue, 12 Aug 2025 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015526;
	bh=a1jhJa7Dprc2yiYuLvP3+6v+4liLH1oTMz7k7gohuy8=;
	h=Subject:To:Cc:From:Date:From;
	b=Lps602OF7dZOce9sMwlP76b5jXZd91GjW+MjHifiDhEMMf1lS2P6fabG4OBctRlFz
	 ShKOGtw78IKkkO0XQHsgnE7hni/Y1vcWf5pFFMAT21P2ShasVF+kzMXV+ZOpRpP8t9
	 dbCM6d5ifMq8LfaXQWhoJlPwuOn4MSzLqZRDm5ik=
Subject: FAILED: patch "[PATCH] mm: fix a UAF when vma->mm is freed after vma->vm_refcnt got" failed to apply to 6.16-stable tree
To: surenb@google.com,akpm@linux-foundation.org,jannh@google.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:18:37 +0200
Message-ID: <2025081237-buffed-scuba-d3f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 9bbffee67ffd16360179327b57f3b1245579ef08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081237-buffed-scuba-d3f3@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bbffee67ffd16360179327b57f3b1245579ef08 Mon Sep 17 00:00:00 2001
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:53:55 -0700
Subject: [PATCH] mm: fix a UAF when vma->mm is freed after vma->vm_refcnt got
 dropped

By inducing delays in the right places, Jann Horn created a reproducer for
a hard to hit UAF issue that became possible after VMAs were allowed to be
recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.

Race description is borrowed from Jann's discovery report:
lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
rcu_read_lock().  At that point, the VMA may be concurrently freed, and it
can be recycled by another process.  vma_start_read() then increments the
vma->vm_refcnt (if it is in an acceptable range), and if this succeeds,
vma_start_read() can return a recycled VMA.

In this scenario where the VMA has been recycled, lock_vma_under_rcu()
will then detect the mismatching ->vm_mm pointer and drop the VMA through
vma_end_read(), which calls vma_refcount_put().  vma_refcount_put() drops
the refcount and then calls rcuwait_wake_up() using a copy of vma->vm_mm.
This is wrong: It implicitly assumes that the caller is keeping the VMA's
mm alive, but in this scenario the caller has no relation to the VMA's mm,
so the rcuwait_wake_up() can cause UAF.

The diagram depicting the race:
T1         T2         T3
==         ==         ==
lock_vma_under_rcu
  mas_walk
          <VMA gets removed from mm>
                      mmap
                        <the same VMA is reallocated>
  vma_start_read
    __refcount_inc_not_zero_limited_acquire
                      munmap
                        __vma_enter_locked
                          refcount_add_not_zero
  vma_end_read
    vma_refcount_put
      __refcount_dec_and_test
                          rcuwait_wait_event
                            <finish operation>
      rcuwait_wake_up [UAF]

Note that rcuwait_wait_event() in T3 does not block because refcount was
already dropped by T1.  At this point T3 can exit and free the mm causing
UAF in T1.

To avoid this we move vma->vm_mm verification into vma_start_read() and
grab vma->vm_mm to stabilize it before vma_refcount_put() operation.

[surenb@google.com: v3]
  Link: https://lkml.kernel.org/r/20250729145709.2731370-1-surenb@google.com
Link: https://lkml.kernel.org/r/20250728175355.2282375-1-surenb@google.com
Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com/
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 1f4f44951abe..11a078de9150 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
 #include <linux/cleanup.h>
+#include <linux/sched/mm.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
@@ -154,6 +155,10 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
  * reused and attached to a different mm before we lock it.
  * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
  * detached.
+ *
+ * WARNING! The vma passed to this function cannot be used if the function
+ * fails to lock it because in certain cases RCU lock is dropped and then
+ * reacquired. Once RCU lock is dropped the vma can be concurently freed.
  */
 static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 						    struct vm_area_struct *vma)
@@ -183,6 +188,31 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	}
 
 	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
+
+	/*
+	 * If vma got attached to another mm from under us, that mm is not
+	 * stable and can be freed in the narrow window after vma->vm_refcnt
+	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
+	 * releasing vma->vm_refcnt.
+	 */
+	if (unlikely(vma->vm_mm != mm)) {
+		/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
+		struct mm_struct *other_mm = vma->vm_mm;
+
+		/*
+		 * __mmdrop() is a heavy operation and we don't need RCU
+		 * protection here. Release RCU lock during these operations.
+		 * We reinstate the RCU read lock as the caller expects it to
+		 * be held when this function returns even on error.
+		 */
+		rcu_read_unlock();
+		mmgrab(other_mm);
+		vma_refcount_put(vma);
+		mmdrop(other_mm);
+		rcu_read_lock();
+		return NULL;
+	}
+
 	/*
 	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 729fb7d0dd59..b006cec8e6fe 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 */
 
 	/* Check if the vma we locked is the right one. */
-	if (unlikely(vma->vm_mm != mm ||
-		     address < vma->vm_start || address >= vma->vm_end))
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
 
 	rcu_read_unlock();
@@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 		goto fallback;
 	}
 
-	/*
-	 * Verify the vma we locked belongs to the same address space and it's
-	 * not behind of the last search position.
-	 */
-	if (unlikely(vma->vm_mm != mm || from_addr >= vma->vm_end))
+	/* Verify the vma is not behind the last search position. */
+	if (unlikely(from_addr >= vma->vm_end))
 		goto fallback_unlock;
 
 	/*


