Return-Path: <stable+bounces-165085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBCB14FB3
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D155F18A3E79
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B93269B01;
	Tue, 29 Jul 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="St2+gAfV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA21EA7E4
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801034; cv=none; b=Fu0t2XSRjHvYD88o+/PUSwOMQR+5UST9gUX9//RtrFlZCXaIAHr6uJcFJDXwYQpE6PD9SyVee8EuZJErKmtlRgr3twFM2J2hVDqH8qIf1hRh6kOR/hoHZOcLe/dlKGnnZtlYOgR1craXFwbe0FdzbUdqMvZuG3ExWNBUbaOr3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801034; c=relaxed/simple;
	bh=UYlrDG+p90cEotYS2k8pU4954aF5Dz3y9FS1+wHx0AI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NlY/pOPsXw1QmWAuIZwY5/LRAtj+GvXIVHrl30QL6xh/IEjgWv1QWF4twzA1ch5nHkAsf0FJZc1TYNPsCauvawqQZJ/llXpz1pKWE4yP9ApNuESYMZvMX4viUg21U5qD5QGiw9/vIxHkTaTX4aXx8GaUu7HTg+1JSIz//ziTIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=St2+gAfV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7641e7c233cso3362451b3a.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753801032; x=1754405832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rE5QaqGtBbgEZH/uZ7FzXjyerj3ccqofJgA61gtYGaw=;
        b=St2+gAfVGm+S/409YlUIE8i3x51IUDOCncDH4PWlPrZdlIaQsy3HOUIUCiwrkP7sei
         eCZgl4XgeZDvxwkAY8JJ3WJZYE9rAmU5t0jwrzvPgJxG1UQc89j2Wm1Gp3syIuRz+Y18
         sqsTujzXMt96YU8037bh0bEl1f/1rdq8Yvauk9S+EuK0pwKIJXbpP4J30NYvBPaceSL5
         TfAKL/eQOfJrQAQ+fYcxUQ+zHDzNH7nBYao2Tj/TN6U7U03kTffSGzZf+/M1nyK1WcCd
         iQYK5Mz7Gc94QRD5CBF+ay0kDsDGjpMe/luzEy7Jo7MBGZFR2Q3xl2N3KC+thIte9Gts
         Dh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801032; x=1754405832;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rE5QaqGtBbgEZH/uZ7FzXjyerj3ccqofJgA61gtYGaw=;
        b=LP1BaOKB30WbqHSolCXw3sSCmUuCo9GLJ37zESl3E2/h+Ql+q69TKpxJs2WxwU55PY
         FKrWQTikpxu26Z8j+k244EMzsJf3ADANza0S00x+DD3RHxxFVeHqZObKVP4cxHMnhRpq
         Odc2zD6PvTFrHPjFhoXKebPFSxvosyHc5NacN2K3bQazczkZ7hnSXM6CU8+fv/7L/bmp
         O1htMp/OY5WPAfaEkiWV/FCcy8oVgYWQZEkUfm4ktuc4nPUmEDSCQz1VyjlYz0ItinD7
         OsKX4Y5E/YDdr5H4MaMQUEWU+Wi3I+x3MxqFwTlAeQMDLjIxh0M+BOKQY3RqkBH9rIDg
         vhQw==
X-Forwarded-Encrypted: i=1; AJvYcCVbqQC79QNsvoHQSoM/SlvZQPXqvHRILKViKTxzVD0pNbVq01hXY1K/Dj95J085ah70t3JxC1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICN9q7t2kTzgCi6RbDYwkqu3cAaVB+b2PP6Dyn+tNme/7nFOu
	ec/zDo/3v4+wcRPsnvU6c8G03fKQmpqpLuWkBvT5kUNm0D81he8L7mJ5Wpe4rpD/o30568IsXHZ
	nL6iOWQ==
X-Google-Smtp-Source: AGHT+IEyb7DFh1Ctr01+r2+P02e+x/ttb54C/yw3CRQSNoviHIgWG2NyMvi3eNyzh9bqPdN2qlAcWUvfG4c=
X-Received: from pfbhm20.prod.google.com ([2002:a05:6a00:6714:b0:748:f270:c438])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9999:b0:235:2cd8:6cd1
 with SMTP id adf61e73a8af0-23d701886f8mr24958186637.34.1753801032262; Tue, 29
 Jul 2025 07:57:12 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:57:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729145709.2731370-1-surenb@google.com>
Subject: [PATCH v3 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

By inducing delays in the right places, Jann Horn created a reproducer
for a hard to hit UAF issue that became possible after VMAs were allowed
to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.

Race description is borrowed from Jann's discovery report:
lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
rcu_read_lock(). At that point, the VMA may be concurrently freed, and
it can be recycled by another process. vma_start_read() then
increments the vma->vm_refcnt (if it is in an acceptable range), and
if this succeeds, vma_start_read() can return a recycled VMA.

In this scenario where the VMA has been recycled, lock_vma_under_rcu()
will then detect the mismatching ->vm_mm pointer and drop the VMA
through vma_end_read(), which calls vma_refcount_put().
vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
the caller is keeping the VMA's mm alive, but in this scenario the caller
has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF.

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

Note that rcuwait_wait_event() in T3 does not block because refcount
was already dropped by T1. At this point T3 can exit and free the mm
causing UAF in T1.
To avoid this we move vma->vm_mm verification into vma_start_read() and
grab vma->vm_mm to stabilize it before vma_refcount_put() operation.

Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: <stable@vger.kernel.org>
---
Changes since v2 [1]
- Addressed Lorenzo's nits, per Lorenzo Stoakes
- Added a warning comment for vma_start_read()
- Added Reviewed-by and Acked-by, per Vlastimil Babka and Lorenzo Stoakes

Notes:
- Applies cleanly over mm-unstable after reverting previous version of
this patch [1].
- Should be applied to 6.15 and 6.16 but these branches do not
have lock_next_vma() function, so the change in lock_next_vma() should be
skipped when applying to those branches.

[1] https://lore.kernel.org/all/20250728175355.2282375-1-surenb@google.com/

 include/linux/mmap_lock.h | 30 ++++++++++++++++++++++++++++++
 mm/mmap_lock.c            | 10 +++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

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
-- 
2.50.1.487.gc89ff58d15-goog


