Return-Path: <stable+bounces-73473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3D96D504
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C611C24ACC
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3D194A64;
	Thu,  5 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H91cCCN7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5483CC8;
	Thu,  5 Sep 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530347; cv=none; b=RTylabuPMdPtwtm73tcRpNKSFimb6WaFqxWTfxT9LutXCCX1RURqmdl2mUjQDvDOigEmztA3r1afTBiBPr6yZSyb7QYW+ffDhfEfXmHfSSmsqMXTux177/vPKsae6+Can50turevliJa0b9t3Xq/V20nQFWgm5KTgtW4/pDYidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530347; c=relaxed/simple;
	bh=vokbAvlTrxZ/KsuCVUkbOPHDiA918E5VbKKUzC5qezc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnIXqrhRMOFbGD8hv3Z5Dy2AN9RitOL0WHpxOky+mVFmMFJKk7T8zgZtr8IonoNCgJWVZgiBokkPZs8zRDM1mEBvaitE4EF7cLg84fcK/dQEHy3Nx356AgiifYFm6xXL4QASjp12JH2LDT3QPI6FycxuI6wE1jU+f3FiuwJpirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H91cCCN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2DC4CEC3;
	Thu,  5 Sep 2024 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530346;
	bh=vokbAvlTrxZ/KsuCVUkbOPHDiA918E5VbKKUzC5qezc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H91cCCN7JlNXpUtZiODJCmGzx/7RQ9EmJfzLJCuGWCFcXj9amdpN0UVhtqx06anol
	 NRHinK3k7eQ0m7zqp/+O+VD7Qv1LjEg1zgq+isOmVS1pk5iimuqXS/AG9PPNxw3HMQ
	 UbyEsuKIIBEFQItFBzawRUjuB6GBHPMWyFdgpjb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 098/132] rcu/nocb: Remove buggy bypass lock contention mitigation
Date: Thu,  5 Sep 2024 11:41:25 +0200
Message-ID: <20240905093726.053344560@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit e4f78057291608f6968a6789c5ebb3bde7d95504 ]

The bypass lock contention mitigation assumes there can be at most
2 contenders on the bypass lock, following this scheme:

1) One kthread takes the bypass lock
2) Another one spins on it and increment the contended counter
3) A third one (a bypass enqueuer) sees the contended counter on and
  busy loops waiting on it to decrement.

However this assumption is wrong. There can be only one CPU to find the
lock contended because call_rcu() (the bypass enqueuer) is the only
bypass lock acquire site that may not already hold the NOCB lock
beforehand, all the other sites must first contend on the NOCB lock.
Therefore step 2) is impossible.

The other problem is that the mitigation assumes that contenders all
belong to the same rdp CPU, which is also impossible for a raw spinlock.
In theory the warning could trigger if the enqueuer holds the bypass
lock and another CPU flushes the bypass queue concurrently but this is
prevented from all flush users:

1) NOCB kthreads only flush if they successfully _tried_ to lock the
   bypass lock. So no contention management here.

2) Flush on callbacks migration happen remotely when the CPU is offline.
   No concurrency against bypass enqueue.

3) Flush on deoffloading happen either locally with IRQs disabled or
   remotely when the CPU is not yet online. No concurrency against
   bypass enqueue.

4) Flush on barrier entrain happen either locally with IRQs disabled or
   remotely when the CPU is offline. No concurrency against
   bypass enqueue.

For those reasons, the bypass lock contention mitigation isn't needed
and is even wrong. Remove it but keep the warning reporting a contended
bypass lock on a remote CPU, to keep unexpected contention awareness.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 32 ++++++--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..9eb43b501ff5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -224,7 +224,6 @@ struct rcu_data {
 	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
-	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2b24405b9cd2..30b34f215ca3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -91,8 +91,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
  * Acquire the specified rcu_data structure's ->nocb_bypass_lock.  If the
- * lock isn't immediately available, increment ->nocb_lock_contended to
- * flag the contention.
+ * lock isn't immediately available, perform minimal sanity check.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	__acquires(&rdp->nocb_bypass_lock)
@@ -100,29 +99,12 @@ static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
 		return;
-	atomic_inc(&rdp->nocb_lock_contended);
+	/*
+	 * Contention expected only when local enqueue collide with
+	 * remote flush from kthreads.
+	 */
 	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	smp_mb__after_atomic(); /* atomic_inc() before lock. */
 	raw_spin_lock(&rdp->nocb_bypass_lock);
-	smp_mb__before_atomic(); /* atomic_dec() after lock. */
-	atomic_dec(&rdp->nocb_lock_contended);
-}
-
-/*
- * Spinwait until the specified rcu_data structure's ->nocb_lock is
- * not contended.  Please note that this is extremely special-purpose,
- * relying on the fact that at most two kthreads and one CPU contend for
- * this lock, and also that the two kthreads are guaranteed to have frequent
- * grace-period-duration time intervals between successive acquisitions
- * of the lock.  This allows us to use an extremely simple throttling
- * mechanism, and further to apply it only to the CPU doing floods of
- * call_rcu() invocations.  Don't try this at home!
- */
-static void rcu_nocb_wait_contended(struct rcu_data *rdp)
-{
-	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended)))
-		cpu_relax();
 }
 
 /*
@@ -510,7 +492,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	}
 
 	// We need to use the bypass.
-	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
@@ -1668,12 +1649,11 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
-		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
 		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
 		"sS"[!!rdp->nocb_cb_sleep],
 		".W"[swait_active(&rdp->nocb_cb_wq)],
-- 
2.43.0




