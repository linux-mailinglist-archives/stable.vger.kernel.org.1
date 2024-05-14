Return-Path: <stable+bounces-45100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BC8C5BA6
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 21:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEEB1F2214B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511E181302;
	Tue, 14 May 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DIplDvC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903517EBBD
	for <stable@vger.kernel.org>; Tue, 14 May 2024 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714296; cv=none; b=JulTlONmPt9r39xrMFiomU+pse9qDlR5n78uDEYVcTFm1p/f28hK00KBk4d6T0etJOvJOWi0xdGY97TzcVPwq3eV3UazKwCi4iQ3cZHjOu55dzXOlKsKKBZ+3kftsOm4RXkaI2GMYbOgBu9/f5A0mzsm8ML8iqiSuLkTIVpYLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714296; c=relaxed/simple;
	bh=2+0MbbVhfwpzgandx9JAIthS253OCPOQX76PZB0bhis=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i1VyT48zlSdBPu4Y/Lexv0z5KQnu6W+NwamME8rUKos8Pk53qzANB73Fqoly6EcG4ujYYOx6JmeLbpDNShNQ1q1E8rPPO1CrE5EcSl4tL+zI8XjfrsaOIAZgvY6L6eMAwxLYlupSTBTrQTBHvyTXodl6h/c1awNIrPuNQFf6EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DIplDvC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so9634853276.3
        for <stable@vger.kernel.org>; Tue, 14 May 2024 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715714294; x=1716319094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqyaUutE/tXclPFxiVv+3e9qFm1giav03EIhpEdhlMw=;
        b=0DIplDvCGx+qplxkobg57S3o/zCFF+kBW9pgC3mJB3laDvKkyAAj1crgTH13PxKOIY
         RfR6ldQ8hiLJqJVumZQPowlSTwN2LWerVHER6mYOiOjBjzrj2BjWYHfIKrx5JHSGH1z+
         wVncmF4cNbef5nAYT1NSgZ9aXJ4uOwz2JKK4ylKKpQ2yXGPu38pl6YUrIo2kfYKjHOJC
         kOglf5eTnc9uJb0Le07czy54jrlHOpbjffzx/regVt0tVmxbxDYXuYRBNg7Or/X7K5D7
         kf1FX1wnXo72FqVvBPKJe5eLhy5sq8973ksLyIopcgnThJ88gdXHdTOociJp17X/iiqc
         TFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715714294; x=1716319094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqyaUutE/tXclPFxiVv+3e9qFm1giav03EIhpEdhlMw=;
        b=ngHWjj4aWkmOZi313Y8xyjU+iqe/XRL3LPMXLSK0kBN6xmvKhFhh4xupNk7XE4ySHo
         IfDtTaj/5ns/eKQVwwKKNnwmODQuY1tUGlIGMzB6xLWVjcR26k59TJuMi+IrxBGAXhdC
         okHa7MVM7uwiMkVtoumr0H4Skq1O+K83RPxqe5AvYrz6BLDRecopelUHfkh7DAzjt5vh
         JAmQ+uhH9F9SqrAOepetbVQK/GoJnzrOQZLfgQCBlCXV2LsckiW5dxU22mmkpqJFaD4d
         EdN4p5U+jqXnTM5SYQQv83iZmsJeQBcEo/HHPWI7EPwmr88UeWPhd4VI7oEhW4u1Au1D
         ya4g==
X-Forwarded-Encrypted: i=1; AJvYcCXvTK+GiRrvIUKQvR7Gz02LBMI8N9MaHGnLsA3ZVRbbpCktaDIdNsyZzqDmp0q9AfHHJHssQ1FrtiM52vtOpd0YU4I8Garj
X-Gm-Message-State: AOJu0YwXTk6C5r6280lXVtBHjlpEJTVe8Bs9bd4IMlKP3Y+TJgYqITUn
	sQDd2ItRGAs20ZBEJgiRCQU8VNaziJ8uMvwpZKs6DHX1DJ+xIXSeMm0NmMEJT0cROfn+6kGfD4u
	ob6mupr0euA==
X-Google-Smtp-Source: AGHT+IFdDacH/jd9wchBAosfs0uALEbjVQaMnhta/CmF0GvJ5me+eLXuTQ1EUN72qk/nK/8lKDSNa65XF1TWvw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:18c6:b0:dee:6f2b:20a8 with SMTP
 id 3f1490d57ef6-dee6f2b271bmr819105276.0.1715714293720; Tue, 14 May 2024
 12:18:13 -0700 (PDT)
Date: Tue, 14 May 2024 19:15:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514191547.3230887-1-cmllamas@google.com>
Subject: [PATCH v4 RESEND] lockdep: fix deadlock issue between lockdep and rcu
From: Carlos Llamas <cmllamas@google.com>
To: "Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

There is a deadlock scenario between lockdep and rcu when
rcu nocb feature is enabled, just as following call stack:

     rcuop/x
-000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
-001|queued_spin_lock(inline) // try to hold nocb_gp_lock
-001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
-002|__raw_spin_lock_irqsave(inline)
-002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
-003|wake_nocb_gp_defer(inline)
-003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
-004|__call_rcu_common(inline)
-004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
-005|call_rcu_zapped(inline)
-005|free_zapped_rcu(ch = ?)// hold graph lock
-006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
-007|nocb_cb_wait(inline)
-007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
-008|kthread(_create = 0xFFFFFF80803122C0)
-009|ret_from_fork(asm)

     rcuop/y
-000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
-001|queued_spin_lock()
-001|lockdep_lock()
-001|graph_lock() // try to hold graph lock
-002|lookup_chain_cache_add()
-002|validate_chain()
-003|lock_acquire
-004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
-005|lock_timer_base(inline)
-006|mod_timer(inline)
-006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
-006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
-007|__call_rcu_common(inline)
-007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
-008|call_rcu_hurry(inline)
-008|rcu_sync_call(inline)
-008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
-009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
-010|nocb_cb_wait(inline)
-010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
-011|kthread(_create = 0xFFFFFF8080363740)
-012|ret_from_fork(asm)

rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
This patch release the graph lock before lockdep call_rcu.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Cc:  <stable@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..3468d8230e5f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
 static void free_zapped_rcu(struct rcu_head *cb);
 
 /*
- * Schedule an RCU callback if no RCU callback is pending. Must be called with
- * the graph lock held.
- */
-static void call_rcu_zapped(struct pending_free *pf)
+* See if we need to queue an RCU callback, must called with
+* the lockdep lock held, returns false if either we don't have
+* any pending free or the callback is already scheduled.
+* Otherwise, a call_rcu() must follow this function call.
+*/
+static bool prepare_call_rcu_zapped(struct pending_free *pf)
 {
 	WARN_ON_ONCE(inside_selftest());
 
 	if (list_empty(&pf->zapped))
-		return;
+		return false;
 
 	if (delayed_free.scheduled)
-		return;
+		return false;
 
 	delayed_free.scheduled = true;
 
 	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
 	delayed_free.index ^= 1;
 
-	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+	return true;
 }
 
 /* The caller must hold the graph lock. May be called from RCU context. */
@@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
@@ -6239,14 +6242,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
 	__free_zapped_classes(pf);
 	delayed_free.scheduled = false;
+	need_callback =
+		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	lockdep_unlock();
+	raw_local_irq_restore(flags);
 
 	/*
-	 * If there's anything on the open list, close and start a new callback.
-	 */
-	call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	* If there's pending free and its callback has not been scheduled,
+	* queue an RCU callback.
+	*/
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	lockdep_unlock();
-	raw_local_irq_restore(flags);
 }
 
 /*
@@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	init_data_structures_once();
 
@@ -6293,10 +6301,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
-
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 	/*
 	 * Wait for any possible iterators from look_up_lock_class() to pass
 	 * before continuing to free the memory they refer to.
@@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
+	bool need_callback = false;
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
@@ -6398,11 +6408,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
 	pf = get_pending_free();
 	__lockdep_reset_lock(pf, lock);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 
 	graph_unlock();
 out_irq:
 	raw_local_irq_restore(flags);
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 }
 
 /*
@@ -6446,6 +6458,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
+	bool need_callback = false;
 
 	might_sleep();
 
@@ -6466,11 +6479,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (found) {
 		pf = get_pending_free();
 		__lockdep_free_key_range(pf, key, 1);
-		call_rcu_zapped(pf);
+		need_callback = prepare_call_rcu_zapped(pf);
 	}
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


