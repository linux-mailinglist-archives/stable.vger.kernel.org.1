Return-Path: <stable+bounces-165000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20EB141AC
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1367AC5FA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B0628937B;
	Mon, 28 Jul 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrovw2XU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B42877E9
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725242; cv=none; b=Uo4Cr1NU5kfMxo967DJ4Q+Qa3Bi8RQVfV/idBaS3JmpW2GsLY/UTg0SV7zh3YuhvdvNL9a7WlS/nvH3r8lgBwbwPgtP+OzKqj013zFCK4FAaH4v7mSXvUbcCnQ5/bG4NMEbrpc4LLhrW+dMKqVykCcsSypGcsAHLIpmIswhgqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725242; c=relaxed/simple;
	bh=2Cwe+MGmj/I+AL0nZ7h4AzKfFmp+A2BonqkMwz7EQOk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUgrpeoLjbuYS9TNlVH6+RtZub/XRcKgFOcOpjx3giEfzS+1MU2yg7Uz/24BXPu+NP0CTnJmpA8/frN7CoUfKhUpeUktLctMtAS72oQJkg1IUIW7veZpGJS0L2a4fr1rdNREKv1jlPaVvwlCujREJiisz/L49x35TeEj07H7Cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrovw2XU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso4833333a91.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725239; x=1754330039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CsmkSz7oeq7HMJDzlu8bMB8qretQ/dwlis7q/g4uBKU=;
        b=rrovw2XU5Auhqrq09h3Nw+Tb4+Mp0u3DgCBONswcAKyqPg6VocrpRvqesGIrlqHBAD
         hrHyeb03grMfnoYKrpU0NZl+IPU+9S52yDBXy+0XsdfSPaTBC1++QSEDOzGiT9zv2emP
         vQpogbWvhHhNyYVdnVhu841s2nDA5NFyaxVkefB7PuxUbiDVZKBtw0SwMugiXXN5dNMW
         QROJUrtaKdgmqWp6tU6FFbqHETe9ZDhmU0lR5drIEy/TnM9B6PsD5dF3HrUx+XchdDOa
         iwUmNB/TU8o7lhtvqhH1ngJF0QdbuKuTIkm+AnDNXT6lI0ldp2VwSC180a5Pdfp82b51
         pAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725239; x=1754330039;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsmkSz7oeq7HMJDzlu8bMB8qretQ/dwlis7q/g4uBKU=;
        b=wnza985UghPCU5K+jR04rVLSDLixDgqVWRrdWJW7fFqwUIFQ0kdKyIBcE0DTVHbxQA
         Uv2lqeyvRjDB2ShBK2UiTXh+ulH9r6oUyhdbh5V2tiP3fl5jqZvkVcIcAvyWADaW76hx
         wsBgE8XyKNDzwQ1bf1KEEDJHkqrmA0oH5+8YloOBB5nSXgtpvgR2iKO/RfKpj+smlfYY
         wYRyMrZ/mBBFP9R40lVzi/Ott5BdJA+rrLJoTwugOexolZnazJ0c0LHx9SKZWnUu4dAh
         AJOqA36VluZH3ZIw9+JqvJxd5GMX3OgRvLh5ADAwON8/AD4/CCDlCiQEJMzoB7J3Syum
         lDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEU4mIhivrw9J71VFPpL9gjeTAGLqudauNno4L+WcmApCGLGwy5PGljAb0veP1H+K85sh20pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2AjtyjIwCLLqVleLPQLSI42Y0/STX0TTQ2uC+HsBou8hTY9G
	P0wf1/STErGYD3ULTA0XPiEdG1yRhr3eIpj7a7/SZVwSjS6+obH7r/1dYMH2DD8FdbbnMfOUQDq
	7jWY8Ug==
X-Google-Smtp-Source: AGHT+IGWBAtmMVPRkSv2vbxg+lJ0GqdvX81gg47Uv9TyhPMSsOBhXdi9Q/f4gBG5YR7+TJysH+MScLJ/WmU=
X-Received: from pjtu8.prod.google.com ([2002:a17:90a:c888:b0:31c:2fe4:33b7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514c:b0:31c:c434:dec8
 with SMTP id 98e67ed59e1d1-31e77af1e9amr18091051a91.20.1753725238711; Mon, 28
 Jul 2025 10:53:58 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:53:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250728175355.2282375-1-surenb@google.com>
Subject: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
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
Cc: <stable@vger.kernel.org>
---
Changes since v1 [1]
- Made a copy of vma->mm before using it in vma_start_read(),
per Vlastimil Babka

Notes:
- Applies cleanly over mm-unstable.
- Should be applied to 6.15 and 6.16 but these branches do not
have lock_next_vma() function, so the change in lock_next_vma() should be
skipped when applying to those branches.

[1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.com/

 include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
 mm/mmap_lock.c            | 10 +++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 1f4f44951abe..da34afa2f8ef 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
 #include <linux/cleanup.h>
+#include <linux/sched/mm.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
@@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
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
+		/*
+		 * __mmdrop() is a heavy operation and we don't need RCU
+		 * protection here. Release RCU lock during these operations.
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
index 729fb7d0dd59..aa3bc42ecde0 100644
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
+	/* Verify the vma is not behind of the last search position. */
+	if (unlikely(from_addr >= vma->vm_end))
 		goto fallback_unlock;
 
 	/*

base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
-- 
2.50.1.487.gc89ff58d15-goog


