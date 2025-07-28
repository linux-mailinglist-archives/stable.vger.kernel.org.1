Return-Path: <stable+bounces-164990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0EB140F7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63804168B8D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199327510F;
	Mon, 28 Jul 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbzjYWYn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DB274B52
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722597; cv=none; b=eteMP9ktolXHGGZygbKpNg6JCTPT6OWpdgPboiNonDlFaMux1eRqyVDZfD+p8Zt4eb+rGtulKf+Iuu52HDW36XN9CGaOgAZwOtG3HDgOSHGinix9Vyr38oRTGzvbfcq/EUxGVVHQhTZE4fJw93FCVYp0eqTvUxskliyySYmVsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722597; c=relaxed/simple;
	bh=x9Cc64+uX9uy7kysTTeQw3VcqvwgtcaGPnvVgkhGfC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S9hD14Exixdea5/prmhdJawvADLIYP9CJFeUaF857ia4z6kBEHaRwpaosfjCcR/fxl9LnDSDqOQORNCyOVi76H1Xced37twJvOzlguRC2w8yYuznYsZZSNsbH/exqKeCBeYgmyI/1CiB1eeDDG9XLND6BZ66rVioW1pgdtUXjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbzjYWYn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2403c86ff97so10888705ad.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753722595; x=1754327395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eh6IvKrrVHAEt11I1o/Ron2ZJq2dRDEO+l/5Ggjas3E=;
        b=tbzjYWYntnOrl+xZeMx3WwbGKe9QS6I/TuxAeNAlhaARlwNh//Vlw3f2e2snENkZi2
         Rq9MMy0vuoPPXnRlNQgIc9iSX02LdqY13xFbPOT9or6J/odyCscxTMZTNaNcJfB3s1J4
         ZiBJe/pQBD4Gq7TQ/4tFuryxp9xKT3BFLqQiSdI8HLtPSVvhVrXmpXEvfMTSNZrEiwa1
         IZaub4mh7hHvjJLulGMRPGxeDGrgjqAm7dB3jfbWP20e5xW4RZTnlKQ5K4ISiS7TLfBX
         cJWpaQR1NovJkwuwEwrxhsSPR76Qy4wchn+pF38DXpsZAyGOzjD+VKuMJDqA2PYkkODO
         aNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722595; x=1754327395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh6IvKrrVHAEt11I1o/Ron2ZJq2dRDEO+l/5Ggjas3E=;
        b=RRhNePqnMfyhrB4R9wAJwfHlmFyofn4LCySOy6OESTObj9a0uoz2rMZvVR+Ykm9D8e
         3F78K76YF09TqXjTEd9tIYhpcGLmq3Ca4tFdCLndhc1Wj/10lk9lczctYuNG427er8D+
         dRcZrVbNzdyXmv+4G7Kdlb1uyyjiK+cAPXpTFND2WtMUvSUa5bJZlOrF8Qz4tSnuFAq3
         swqjZarzyZwrTSauHas13CjjxfmJKnZAPtC8n1o3uZQAXhdt1gEXItCCszAWSGhONS+h
         t7Gc279+fCmiMDzr9ifZJ9t9p/UQiQeMRm1xPIx+NlDRffrNiR/VGc7iLpmDuqPVozMx
         emfw==
X-Forwarded-Encrypted: i=1; AJvYcCX0iAcTuADOhQbsnhDmI9eOMJ5owcHIXhsKHF6zHjnBeEkflkFT9Ti7BYlgCBtG1B8hKcboh6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRb2/DV/9kXlbP2AIsQVr7lEVQ1OE0yYQqttD1NcAoo4kgBTyL
	UyOQU4Sn/4dcugX6i/RG/SqZmgXL8x58yBvdL3l79yoMYRH2ofT5sEzPZEIK5UwQlGJGw3aAjH8
	28P6kCw==
X-Google-Smtp-Source: AGHT+IFd2+VRWI3M+Kfoauwo/cT4HXIsIJL90+W0WrGWufYg6PKRrmk/3I6NP6HrbQ2n89hPQHxfP8Zj3x4=
X-Received: from plwp15.prod.google.com ([2002:a17:903:248f:b0:240:1be2:19ee])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b07:b0:240:4b3b:334f
 with SMTP id d9443c01a7336-2404b3b34a8mr26618875ad.34.1753722595188; Mon, 28
 Jul 2025 10:09:55 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:09:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250728170950.2216966-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix a UAF when vma->mm is freed after vma->vm_refcnt
 got dropped
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
- Applies cleanly over mm-unstable.
- Should be applied to 6.15 and 6.16 but these branches do not
have lock_next_vma() function, so the change in lock_next_vma() should be
skipped when applying to those branches.

 include/linux/mmap_lock.h | 21 +++++++++++++++++++++
 mm/mmap_lock.c            | 10 +++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 1f4f44951abe..4ee4ab835c41 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
 #include <linux/cleanup.h>
+#include <linux/sched/mm.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
@@ -183,6 +184,26 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
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
+		/*
+		 * __mmdrop() is a heavy operation and we don't need RCU
+		 * protection here. Release RCU lock during these operations.
+		 */
+		rcu_read_unlock();
+		mmgrab(vma->vm_mm);
+		vma_refcount_put(vma);
+		mmdrop(vma->vm_mm);
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


