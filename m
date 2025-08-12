Return-Path: <stable+bounces-167246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE6B22E58
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84ADD3A4810
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AC2F744C;
	Tue, 12 Aug 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPawbaYE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405D280018
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017649; cv=none; b=sQB0BcNDuuxNojc3BxC2p1fJwqTTgrCwAdsCqjR64dMEaoaKMrtU1SgeZjCa0QwWTCXv6MMezkNRvrlARtAvXwxVcOXhl9ZQpaRNt1q2uDRjkMZUMo/OcauAExuf2/6WtSNMCvD5MHQhPVwxMY9IFs5bHiMsmsIV3wLPs/9AvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017649; c=relaxed/simple;
	bh=Pik7QmBfKb78Emi5FDZHO9/g29Tap05Gm42Xm91m1lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O+ufqj06C+Xhbidf+U7g/rh1LRhuWISQbPPLZh5o/7RCfydPwoRTB61BZ2lpek4vGZE06ETEiSOJLevCitRnHY9PuPtgsAik1KNAXAxB6wPbJPNYLrMncxybccDc+USIjho0vneOhHbkNVxEVa0vWAxsMZWaUkwZxHEeEplUNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPawbaYE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f322718faso4484671a91.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755017647; x=1755622447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3m5TDKUNnmPU78OK/YBQv4hX6zYqGOEdsXQE+EsuZa0=;
        b=FPawbaYEZc1vdZkEQFmEROAC9Thrbree3diclu/bliBc6CL5b80qQLUCaDCW3ICedi
         5fzoSitMKmASTuHIEytvi5s/putyLgwB6Q17WwMeARfHxiFuRiQr0ezj6w3kwAz1DVk6
         bp0vOHGPeVTRwIg8/SPHNFTTg+8uK+ge/HSianMmfvt1+3UN7/2LSaXZFiNG5XHfj3oY
         N0ubaJ7MKKeMhHgODYcHBAx70zicH80rHIW3vEw/EZsuVJcqoaJx4TshJT2rxm4mQhvG
         UquwHTgAZwWIOXYchzPdFWhGO2PSU0liCNUMobizqNFCTHMbjiZ3QKQ5maPoPk4VZeDE
         A+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017647; x=1755622447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m5TDKUNnmPU78OK/YBQv4hX6zYqGOEdsXQE+EsuZa0=;
        b=ZFtebCn0WJMTrj8/hrXuqlQ9zdUBHvpazGIn6uExgf8wwoZOliNA0lt3nSksNYjpRn
         oMmv0t57IW70p/mhb25KmRat3kRW5RjbBUZu3lPv5PsCUA2iZFVylW5vDxNaMLro9gNL
         lHUR5nkUbrDIvkLCDjf8U1osAsJh5jswSoWYrjgE1RTY91jN8csZJbKBriQjdQYGBpFv
         yBIZIQ9lwn2kI5fq+w2i16ePgW66B0MhmuYWScyODHlkmYQuG1hzdUzVAcuKw0xTFUhO
         wi/z7h6oPJ0M52/L56VQQHCFWHMPiuUc0NKDJneJO+m9oACLxL3fW6vs83zkM8lTBEw2
         l/6A==
X-Gm-Message-State: AOJu0YxELHiWethL+dQNxPA8XeU/Ft1k3YJ26dZsDGi71RzfMgWJQs0a
	+lomGCA2nXzQ/UI+/HPLAwG5X+ybiMtXjoWuc0pkx63gyjqagECcgEnax0mSOX8RTAUsct1w8R2
	RkDwnx6DQxYftFNv6jQFQRZPXaXAQE+JELFkQ6z7ssFTqbQvnbMWM+HyFtnXJXVt5FjCmGWcfBx
	uTLkUZNepxXiQedG/qxTr+/3829xnLPKbiiusz
X-Google-Smtp-Source: AGHT+IHx2eY3ruWvXtshUJvgJbilPLoFRasEzHA9+aft/6uAZQh7lGUaoHXy54K8bw4SquFTMMraIfE+bnU=
X-Received: from pjqf22.prod.google.com ([2002:a17:90a:a796:b0:31e:fac4:4723])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d606:b0:31c:36f5:d95
 with SMTP id 98e67ed59e1d1-321cf8fd07bmr429769a91.2.1755017646663; Tue, 12
 Aug 2025 09:54:06 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:54:02 -0700
In-Reply-To: <2025081237-buffed-scuba-d3f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081237-buffed-scuba-d3f3@gregkh>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812165402.1011612-1-surenb@google.com>
Subject: [PATCH 6.16.y] mm: fix a UAF when vma->mm is freed after
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
 include/linux/mmap_lock.h | 30 ++++++++++++++++++++++++++++++
 mm/mmap_lock.c            |  3 +--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 5da384bd0a26..ae9f89672574 100644
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
index 5f725cc67334..5cd2b0789500 100644
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
-- 
2.51.0.rc0.205.g4a044479a3-goog


