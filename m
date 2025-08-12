Return-Path: <stable+bounces-167253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3DB22ED4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0ED622588
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF42FAC07;
	Tue, 12 Aug 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vfz+Rm7I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC5286D61
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018897; cv=none; b=jogDmPFLU9jgSEat292N7DrFnbalDfpUMx4cXTVP2UWW88I8JJ5/IbWbzrgK1s2d/XgTXGbWopuR8R/W0XrDHhjrF/tkbEpk8zpJLVlJ4qIh/wjzGsgkYeAI6B5pUyQHPzS2OUPuPDL3YnEcFRvptakMTeMAlvsmigr5SyEfazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018897; c=relaxed/simple;
	bh=8vTKHl45N4AhFVxKFEYFfiGN2gyak1F4ANp3W13yaqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LknZzeGQc1r4Pi6jMFQjfDuWwSiQtyFuyDHwt1ItQ0i/XtCmwNnwjOINKVJHk6+qdnGQf+6a8Ok/hg48B3tAY3dihbBdIwoG4c0BxX/AE79NoDEbRtfS6uJOsQqjGUIy2qQxTa3ruAwy3zU9wwIn2/+l4DvunI3Y52ZmKmRDU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vfz+Rm7I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-240607653f4so50449725ad.3
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755018895; x=1755623695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyPh+WlT/cXs/PV/ltxEw4bBi1wgiwCy9bDiGWm7zLo=;
        b=Vfz+Rm7Inpay5Tn47+a6Av8OTSFYwza6nbx6ECZoHtUiKkl8/BoeQ0/j2CuBYSjiuV
         9yG5dw03j+bqcr1z5CXX9kLPPdzenr92s7NdSw2EUNpHyCYiTiS+nhHizLpsXtIGfOih
         SffeV14D3a40xJaXZVGFugLTwrQLVJXi62PmcK1meKMDP28vFOMWTPq5JnAjueQ7u8Ze
         oPywwtKpRzjF8/8Ai1b9l9GXP6i+ftTyEIS+Bwd656C9qr6WqZuumtq6YBaxHLL8lIvI
         bgG+dbpgHRS6i7hAbW37fdtA4FsbQ9w5osAusHdN6jJKg0WvUhLW1V370x4InL/YbdSj
         jv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018895; x=1755623695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyPh+WlT/cXs/PV/ltxEw4bBi1wgiwCy9bDiGWm7zLo=;
        b=Xzlsben7CFZVs77aOFPkRA8R51Qbvr8I8lz9bGqnvIcPpOCNbt/Ev89Vyf9L60lkCJ
         cOrImqYT+ELxvemhiG9VT6oG7J4cJPNQdnPYiaYZ+vrdO50BqPYT2UCorJ/bApQ/TTdV
         6DZT0pWcFMRjpuWmPQsCWsEdOC/v2R/dXuDGC8hfILReCLJ1TtSQumhzNBalXNbMVPrp
         FNVMrnHNk4Tqipywrm6QD1Saz/N6UUh6YpDCZd6gPKrtlc/a9vOjHNLB3qKmpDN6H9lI
         oDZAyn9U3ryVTITzChUeq+00UBJ98lvvTdEgCKbbTMouo6d1oINXjxDqw8eFer43uvYM
         iLjQ==
X-Gm-Message-State: AOJu0YxaQFULkJIlVGvO78vt/gA4aoUCb6S3ruBErO5J9lkWDKRin8E7
	x/mcmlrsYR1gEqCuS6TXrN8STM+ZfUiBkgWdc18x6pbwl1UfEjrJV0MGsRQ+dFYuc2UoMD8T6bp
	VtHsmgLkcnSQaG06T52WSIn2RxZTWhGHOXztXFDcos/tdDnjeuZpoEFg5y3t/IzfSSrxEDWb2xy
	lVWIcslPoOpMmw5vwrkMxovVrjpaQd1gFwbGiY
X-Google-Smtp-Source: AGHT+IECVU+uSgxrLHlHE/tcm5GmxH2mF91w5qzuBvCH0pNU3vq1D8hgKglh7Aa5M2uJzxeDDTV0+djvuUw=
X-Received: from pjboe1.prod.google.com ([2002:a17:90b:3941:b0:31e:c61e:663b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f544:b0:240:5523:6658
 with SMTP id d9443c01a7336-2430c10d580mr6560915ad.29.1755018895013; Tue, 12
 Aug 2025 10:14:55 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:14:51 -0700
In-Reply-To: <2025081243-dense-paragraph-ed33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081243-dense-paragraph-ed33@gregkh>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812171451.1047505-1-surenb@google.com>
Subject: [PATCH 6.15.y] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

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
(cherry picked from commit 9bbffee67ffd16360179327b57f3b1245579ef08)
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 30 ++++++++++++++++++++++++++++++
 mm/memory.c        |  3 +--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2e4584e1bfcd..82b7bea9fa7c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/rcuwait.h>
+#include <linux/sched/mm.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -716,6 +717,10 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
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
@@ -745,6 +750,31 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
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
diff --git a/mm/memory.c b/mm/memory.c
index 2c7d9bb28e88..1df793ce2e6e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6554,8 +6554,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 */
 
 	/* Check if the vma we locked is the right one. */
-	if (unlikely(vma->vm_mm != mm ||
-		     address < vma->vm_start || address >= vma->vm_end))
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
 
 	rcu_read_unlock();
-- 
2.51.0.rc0.205.g4a044479a3-goog


