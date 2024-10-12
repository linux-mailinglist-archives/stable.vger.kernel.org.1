Return-Path: <stable+bounces-83610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8C99B7B2
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 01:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7197D1F21A9E
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22541487ED;
	Sat, 12 Oct 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bepJ/PoH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC134146D5A
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775379; cv=none; b=fYisT+Ch0fRlrIGh2jc1XjrZ4IvIo0wM82BeWKP2RJLeQiN5ms7l+/dZ7gOr+qutRDFDq5zDE9a1OvM0XzqVtcXQOnTsJdK4AQdu+L8JI+VNBJSRWIUgcoqREH+LmF44mk+s2eNhvXTeFrU1IM4FUAGmSAO22uE0B53bgj+xG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775379; c=relaxed/simple;
	bh=K2ZnICRT5Pn3XToKtnPgIFSQzKPyLgCEFexV0gwRd2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rqsZdMnNh7Z3xuhJgWgoImxkcXwZFeb2jzD7eAmJLD/wU06BfnwRr/eWZxyxSxjKRhaUTzxGnw792Vo4XfDwJWKnc5v33Cbwb9lOyPlh7cXLaNqjeG8/tPkg6f4t4KLxtTx0quYl2iY/pQbFhpLwNnMF4OMQ2xf9gPYP6gDm8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bepJ/PoH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so4171047a12.3
        for <stable@vger.kernel.org>; Sat, 12 Oct 2024 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728775377; x=1729380177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ9y7rnbWmnkSBwQn1bEOijyVD5r8kZnvSuiy2l2opU=;
        b=bepJ/PoHhMBtqJwwueUqnMxinFf6kSBnZkp7dZYkQL5vylDOoE6jMsPYnLkHULjLsR
         CYiXzEdxxk+4UzU6VoXRDmzH7ZZgfGI5leQ+sjDV0ny0fFs+zX6YvaKikW2YrwIiqOTx
         JfdVbUgQ6ZVKjpr6V57dVRMl3SO7pbwhdxl/Bf0XNXYhLzkWfhp5rl7dhVqERDUYj47f
         Or1pE4VgxwW6j4tfJUqcEgeaj8eP2QhjtBCnMaTI68QKh/y0lWjA0WKN4if7qxitZE9a
         UQhOSfB2hCVBkn/L/QBxtdRoxgmjey6IoXTlpNsbn/Ek0BKavPf3gwg+M/6m9duLSP6A
         u+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775377; x=1729380177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ9y7rnbWmnkSBwQn1bEOijyVD5r8kZnvSuiy2l2opU=;
        b=Fags1SSLOu2T2AZw2tggGZI59dm5kyKELZtwMtZt35vZ32oDNt6DQ8zlBCHpKXSqP4
         s6zfOrlIIyGdqWbQ9vi2oPu68hKvPFwPj+gUVPfgLliAYDbbYNpqh0ApG8fA46aOiNx6
         pzqszWhc+C5iHQTzCBwKqWqdZqbJfdcE4lN/uGko1Yrsz4VyCyEWLBBDJx18tsl3MO1s
         B7zwXsaxQtdjtQGQMFU3WcvnZmbxIjmJi0OuNzt7fzGBPUc9dz93GZBVoQTLb5RjnXjH
         CYQ6FT7WC3wmaJVkSCq0QrjX75FLDCVrv9jyCggA+d4aH2KgJ6RvlzAMffANZaO6DFy7
         sQ3w==
X-Gm-Message-State: AOJu0Yyb3N9jRax5wsFpFME6y/5DQElWFZdxRo9xEVnUimW5xi7tenz+
	Q8hDaXrSRgsfBOa9rmJvswVX9tqEJKNEubUDVOYnRlLaFQr0G7bBqL+fcfqTV2m/aBwp2rX/52Y
	xZkcYLkA8FuAGEZG9TOT/Pb1TNnZnOzedFVtI8F3wqJJ5H8QtsXxblAQ9A2Idbx4uiCmIWeyZ66
	z8ye+3JniHT+xB4gkcfmBwy2KdafzO2dtGBdz6giTOifA=
X-Google-Smtp-Source: AGHT+IFEuvlYfoWH/O8Fv7x6CLptcApGtsbKsJAp6jcM3DQxXvEJ1n9wuCu8blhed2F7OWqiVpWVZiNDZwPxnQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:8c5c:0:b0:7ea:7ad1:32e6 with SMTP id
 41be03b00d2f7-7ea7ad13303mr1050a12.5.1728775376220; Sat, 12 Oct 2024 16:22:56
 -0700 (PDT)
Date: Sat, 12 Oct 2024 23:22:44 +0000
In-Reply-To: <20241012232244.2768048-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241012232244.2768048-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012232244.2768048-5-cmllamas@google.com>
Subject: [PATCH 5.4.y 4/4] lockdep: fix deadlock issue between lockdep and rcu
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, boqun.feng@gmail.com, bvanassche@acm.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, longman@redhat.com, 
	paulmck@kernel.org, xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com, 
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

commit a6f88ac32c6e63e69c595bfae220d8641704c9b7 upstream.

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
Cc: stable@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240620225436.3127927-1-cmllamas@google.com
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8e0351970a1d..7cc790a262de 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5054,25 +5054,27 @@ static struct pending_free *get_pending_free(void)
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
@@ -5098,6 +5100,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
@@ -5109,14 +5112,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
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
@@ -5156,6 +5163,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	init_data_structures_once();
 
@@ -5163,10 +5171,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
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
@@ -5260,6 +5269,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
+	bool need_callback = false;
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
@@ -5268,11 +5278,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
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
@@ -5316,6 +5328,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
+	bool need_callback = false;
 
 	might_sleep();
 
@@ -5336,11 +5349,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
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
2.47.0.rc1.288.g06298d1525-goog


