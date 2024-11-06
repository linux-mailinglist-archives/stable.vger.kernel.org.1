Return-Path: <stable+bounces-91440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05179BEDFA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400D41F25917
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C701E32D3;
	Wed,  6 Nov 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w9yFyO3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC21E0B63;
	Wed,  6 Nov 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898740; cv=none; b=Dfqe1yZFsuLa1MKJWVqCJCsJHx8y86uzORHLb19KrSJb+C9KnGSyCVQW6xU5B5cv1NsHtFYjDLn5ywbVpH8+3T4lc9iynRZBIW17KfJAy5eGIn2L2mZJG7zI58DzLcYYuQ38ocWkZGmT6V7jzxXJt6GSEWUXvESMQbp6/+iMraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898740; c=relaxed/simple;
	bh=VmLX4p8G0cVQeIwD0AB/v46tTLudkg/u3Fpwx+kzre0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJYX7ZceNCIC2hwkjw6sWNQ9cspUCeoK5kB4jYQOjJIogK/2IpQ0NljBbK8lr35a/8b8glukc2MpsD9f5J12mhAciiCHL2WHyXLAsyaTF65s3BAs2hiaXOAT5IDFZR359+4kboCwsJMZjvmxHhipfr7i9UFV9e03lLBWkzU5QWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w9yFyO3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5217AC4CECD;
	Wed,  6 Nov 2024 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898739;
	bh=VmLX4p8G0cVQeIwD0AB/v46tTLudkg/u3Fpwx+kzre0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w9yFyO3wlXMhNKxG5khpF6nHmp/mqXAf15fPZ8LgS/QXc0/6l3B/RrZ5ihP5222SJ
	 AzyxRdWUURxa9iy9r/iUVwF3W9btjdEf7U/r0dGguG5Kf3u4pIDUTIqcWb25++MYkI
	 eUAnheN6l1FoqMq9B5FwtvzS0DIm9TmMl5k9ptZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Carlos Llamas <cmllamas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 338/462] locking/lockdep: Fix bad recursion pattern
Date: Wed,  6 Nov 2024 13:03:51 +0100
Message-ID: <20241106120339.873257461@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 10476e6304222ced7df9b3d5fb0a043b3c2a1ad8 upstream.

There were two patterns for lockdep_recursion:

Pattern-A:
	if (current->lockdep_recursion)
		return

	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

Pattern-B:
	current->lockdep_recursion++;
	/* do stuff */
	current->lockdep_recursion--;

But a third pattern has emerged:

Pattern-C:
	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

And while this isn't broken per-se, it is highly dangerous because it
doesn't nest properly.

Get rid of all Pattern-C instances and shore up Pattern-A with a
warning.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313093325.GW12561@hirez.programming.kicks-ass.net
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 74 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0d9ff8b621e6d..0a2be60e4aa7b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -389,6 +389,12 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+static inline void lockdep_recursion_finish(void)
+{
+	if (WARN_ON_ONCE(--current->lockdep_recursion))
+		current->lockdep_recursion = 0;
+}
+
 void lockdep_set_selftest_task(struct task_struct *task)
 {
 	lockdep_selftest_task_struct = task;
@@ -1720,11 +1726,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1749,11 +1755,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -3550,9 +3556,9 @@ void lockdep_hardirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__trace_hardirqs_on_caller(ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
@@ -3608,7 +3614,7 @@ void trace_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -3623,7 +3629,7 @@ void trace_softirqs_on(unsigned long ip)
 	 */
 	if (curr->hardirqs_enabled)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 
 /*
@@ -3877,9 +3883,9 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion = 1;
+		current->lockdep_recursion++;
 		register_lock_class(lock, subclass, 1);
-		current->lockdep_recursion = 0;
+		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
 	}
 }
@@ -4561,11 +4567,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
@@ -4578,11 +4584,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
@@ -4603,11 +4609,11 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
@@ -4622,11 +4628,11 @@ void lock_release(struct lockdep_map *lock, int nested,
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_release);
@@ -4642,9 +4648,9 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	ret = __lock_is_held(lock, read);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -4663,9 +4669,9 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	cookie = __lock_pin_lock(lock);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return cookie;
@@ -4682,9 +4688,9 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_repin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_repin_lock);
@@ -4699,9 +4705,9 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_unpin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
@@ -4837,10 +4843,10 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_contended);
@@ -4857,9 +4863,9 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_acquired(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
@@ -5087,7 +5093,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -5099,7 +5105,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
@@ -5146,11 +5152,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
-- 
2.43.0




