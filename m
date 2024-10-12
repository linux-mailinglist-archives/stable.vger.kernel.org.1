Return-Path: <stable+bounces-83608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EA99B7B1
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4799B2190F
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A815530F;
	Sat, 12 Oct 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiGZE56o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5981145B27
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775376; cv=none; b=rswZzyq5yJmZJFkWcHJOEPI/E/B+g0GMQGKYK/GjyQftnhLrHkTc7tYFqZm/nC5+jk75ImAy62F9VQy7bTwID5mJqLYACgnMczKVQER2coaY3Rh4my8Bbz2SvBXn/Fqob+bHTydgc7ek/8RmoNA8jR8dVZ2aY/cx7YrgNOrTzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775376; c=relaxed/simple;
	bh=jiRhPumcBIrLZajgAoDOSpp+VNlOBDoFKpD8EhC5T7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7eNi4GpBV+JoVvr8DPwH68ixiAAb6HIE2Kjt7r45tLSnk62mODBc4BOeM9PhwB4egp/JhPl2ubKUFjOrrHr+f5l8huIlyO3guCOK2iFiyg1liL660fS6fXB9v6z0+K+51LVSYnPneW6psn0+eC+1alJsRHKbNwwjHGNcOEzEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiGZE56o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c9fe994daso19977475ad.2
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775374; x=1729380174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/3RYpkOiHvtYL0HnerCzp0Zn2dXN2P7c9UYmnVMvpE=;
        b=fiGZE56obTJ0Dx8LdSWN2MskSDo+Q0gsWnDgVtTOQPtVpFPSDgydypuZC3RaO5eLxN
         19yWsh67qDvhjYg2zeWSCd+IiTNyN3e+pSYTnV2YDbJeTGDmoE735CvFGh98JNFORRiV
         X1S1+qWNK9oUWiVNo9CB/M1l+bBdBaxG95NQ/KJKDDjA7uTZyVqoSrqH4dDIAHZRdzdo
         99pZ7ZnqE4AKMcyIGaWXlCum2AmUUHQZSMQw/sGrG6EMhqDVtuBJVCLZLtC5EaymAXGB
         amasiPN8ltpYXcfjYPvlmOCBiMZOulDrSbL9+0dz4ZhDEGO/26qIJWqK+xPoAus9B+zm
         V/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775374; x=1729380174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/3RYpkOiHvtYL0HnerCzp0Zn2dXN2P7c9UYmnVMvpE=;
        b=T3QrRlkUfsI0aCAwf2is5hz9sL7qkYk0wMUTlLVEYv3aQQSWlEcQbHNPuAqb/Uq/Ts
         fTn7bIt8AsyQwzBUvuTCXEfIw3099JYDt5Zuk1cEXJxhsgTwI0VBZ+4Su4cY/kTkX0mD
         r0i0tQBCZI5+yE+lfQneIGo1yN2a5rKnPniUxi32pp3+yh4h+vfx5jBUgaRIrXGlJsmr
         dxzBuxTJmbYCz5zKD1hbBvvZ53eSvWexTFGRQcHfsrxNEkDwUkfKBz56MynN1azre0P8
         9WPQsvFftSaIrYHER5IRkDB0ye0sNVKyA3R181TuV4OCbFzsy+qmcLQaIcyHqiosxTHk
         qSDA==
X-Gm-Message-State: AOJu0YxdcBsO5n5GsoT3/lImJxnvmM6juElHIUzvtEez55FOgahtpEcF
	sq9Z+zIW2YcCuqq531N1e0QIo1kyE/JS1F5tfAppxpJu5XclHFPPyCrZzdR4NM6w/6Hvf34anaz
	xL5u9eNKnJQ05hCb5dwrjX42WUxO3DlCudC5qLfY1qCgQJY7Erwha+baVUVpjmnC0EQRqZNs1sU
	mzNqSEYM5mPQ0Uone3JvLud2x1GXlZ4hTeWayj2wn8BWs=
X-Google-Smtp-Source: AGHT+IHrJC0vIKxTMCyR1p6M4/tpm5aN+cOt3ae6AhXoyd/HusFF4OqcgWqtMyHpEZ/WYRqidff6EVA+lllA0w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:ecc7:b0:20b:9522:6564 with SMTP
 id d9443c01a7336-20ca16ddcefmr148985ad.9.1728775372645; Sat, 12 Oct 2024
 16:22:52 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:22:42 +0000
In-Reply-To: <20241012232244.2768048-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241012232244.2768048-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012232244.2768048-3-cmllamas@google.com>
Subject: [PATCH 5.4.y 2/4] locking/lockdep: Rework lockdep_lock
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, boqun.feng@gmail.com, bvanassche@acm.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, longman@redhat.com, 
	paulmck@kernel.org, xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com, 
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

commit 248efb2158f1e23750728e92ad9db3ab60c14485 upstream.

A few sites want to assert we own the graph_lock/lockdep_lock, provide
a more conventional lock interface for it with a number of trivial
debug checks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313102107.GX12561@hirez.programming.kicks-ass.net
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep.c | 89 ++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0a2be60e4aa7..b9fabbab3918 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,12 +84,39 @@ module_param(lock_stat, int, 0644);
  * to use a raw spinlock - we really dont want the spinlock
  * code to recurse back into the lockdep code...
  */
-static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t __lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static struct task_struct *__owner;
+
+static inline void lockdep_lock(void)
+{
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
+	arch_spin_lock(&__lock);
+	__owner = current;
+	current->lockdep_recursion++;
+}
+
+static inline void lockdep_unlock(void)
+{
+	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
+		return;
+
+	current->lockdep_recursion--;
+	__owner = NULL;
+	arch_spin_unlock(&__lock);
+}
+
+static inline bool lockdep_assert_locked(void)
+{
+	return DEBUG_LOCKS_WARN_ON(__owner != current);
+}
+
 static struct task_struct *lockdep_selftest_task_struct;
 
+
 static int graph_lock(void)
 {
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -97,27 +124,15 @@ static int graph_lock(void)
 	 * dropped already)
 	 */
 	if (!debug_locks) {
-		arch_spin_unlock(&lockdep_lock);
+		lockdep_unlock();
 		return 0;
 	}
-	/* prevent any recursions within lockdep from causing deadlocks */
-	current->lockdep_recursion++;
 	return 1;
 }
 
-static inline int graph_unlock(void)
+static inline void graph_unlock(void)
 {
-	if (debug_locks && !arch_spin_is_locked(&lockdep_lock)) {
-		/*
-		 * The lockdep graph lock isn't locked while we expect it to
-		 * be, we're confused now, bye!
-		 */
-		return DEBUG_LOCKS_WARN_ON(1);
-	}
-
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
-	return 0;
+	lockdep_unlock();
 }
 
 /*
@@ -128,7 +143,7 @@ static inline int debug_locks_off_graph_unlock(void)
 {
 	int ret = debug_locks_off();
 
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 
 	return ret;
 }
@@ -1476,6 +1491,8 @@ static int __bfs(struct lock_list *source_entry,
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
+	lockdep_assert_locked();
+
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
 		ret = 0;
@@ -1498,8 +1515,6 @@ static int __bfs(struct lock_list *source_entry,
 
 		head = get_dep_list(lock, offset);
 
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
-
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
@@ -1726,11 +1741,9 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_forward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1755,11 +1768,9 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_backward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -2930,7 +2941,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
 	 * lockdep won't complain about its own locking errors.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (lockdep_assert_locked())
 		return 0;
 
 	chain = alloc_lock_chain();
@@ -5092,8 +5103,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -5105,8 +5115,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5151,13 +5160,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
@@ -5179,10 +5186,10 @@ static void lockdep_free_key_range_imm(void *start, unsigned long size)
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_free_key_range(pf, start, size);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5278,10 +5285,10 @@ static void lockdep_reset_lock_imm(struct lockdep_map *lock)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_reset_lock(pf, lock);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


