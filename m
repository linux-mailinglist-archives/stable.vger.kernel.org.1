Return-Path: <stable+bounces-62004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8B93E1E2
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC24E1C20B8E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA029811F1;
	Sun, 28 Jul 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odNYNAac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B780617;
	Sun, 28 Jul 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127708; cv=none; b=fym6OJe9t3MXY69kAXwzY4BxxB70H4+EThf6gxeVPsgfFSbEU8XkX8cXBPqAHAOZVNMG2n52HKzK4XJ81nd/y5dCjb/4gUYtr29uD5iFh2hStH9Ab+0lncviUtUQvKh+X/gNaupzhJAU1OcEsepd4Hkek9N2lVmtL28UhLcscH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127708; c=relaxed/simple;
	bh=ZHPIC3z5mKcFU5quGPiAlq/c7cDr/avhdOWzlDzwzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCbfG7xhLLLPaxOR4zvwQZgILGBn7XqdpWaPOdjObch1EixkJ0qN3g0/koSa+Q1c55+y+PNVHSDS+ncsUj6jS2DGqVjxVkY98aQ1TMmVpFblsu847c/yfk6Q2fH6SqFxiRGUjpshVpsqj3xcW2BR7rVdSdXquRMshRWLoFwnnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odNYNAac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E47C4AF07;
	Sun, 28 Jul 2024 00:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127708;
	bh=ZHPIC3z5mKcFU5quGPiAlq/c7cDr/avhdOWzlDzwzsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odNYNAac1uKgi4pbUHC1KVO8WckN++M2/mJXD7Ozq487kUZiJe9fEf9UThu4lILBz
	 zGW9+TpFLtQNaQZOdRmFUZf8jLu6/ffRtQd/N4w6QryWbnP40TKb4WVgLRGiJMqOp0
	 HeDKi/25w7ZaALyX6mztpknzYHjPNBmIpua6SdqNyYCpIg/hSwUamzs0dlyZfjOld2
	 HiFT26GFDmHihCNyE1j38hwySJfWHp1nXdixeuY/V8tRIOb3W3TkI9VntBkiDS4LXd
	 eVbO/kH5PxZMrrClPnm6zpeuqYFe90DyskcWOR/thKbqgp6XlMhIibPk8yNBgyPx52
	 UBiAiRBn5f1lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 8/9] rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation
Date: Sat, 27 Jul 2024 20:48:09 -0400
Message-ID: <20240728004812.1701139-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004812.1701139-1-sashal@kernel.org>
References: <20240728004812.1701139-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 55d4669ef1b76823083caecfab12a8bd2ccdcf64 ]

When rcu_barrier() calls rcu_rdp_cpu_online() and observes a CPU off
rnp->qsmaskinitnext, it means that all accesses from the offline CPU
preceding the CPUHP_TEARDOWN_CPU are visible to RCU barrier, including
callbacks expiration and counter updates.

However interrupts can still fire after stop_machine() re-enables
interrupts and before rcutree_report_cpu_dead(). The related accesses
happening between CPUHP_TEARDOWN_CPU and rnp->qsmaskinitnext clearing
are _NOT_ guaranteed to be seen by rcu_barrier() without proper
ordering, especially when callbacks are invoked there to the end, making
rcutree_migrate_callback() bypass barrier_lock.

The following theoretical race example can make rcu_barrier() hang:

CPU 0                                               CPU 1
-----                                               -----
//cpu_down()
smpboot_park_threads()
//ksoftirqd is parked now
<IRQ>
rcu_sched_clock_irq()
   invoke_rcu_core()
do_softirq()
   rcu_core()
      rcu_do_batch()
         // callback storm
         // rcu_do_batch() returns
         // before completing all
         // of them
   // do_softirq also returns early because of
   // timeout. It defers to ksoftirqd but
   // it's parked
</IRQ>
stop_machine()
   take_cpu_down()
                                                    rcu_barrier()
                                                        spin_lock(barrier_lock)
                                                        // observes rcu_segcblist_n_cbs(&rdp->cblist) != 0
<IRQ>
do_softirq()
   rcu_core()
      rcu_do_batch()
         //completes all pending callbacks
         //smp_mb() implied _after_ callback number dec
</IRQ>

rcutree_report_cpu_dead()
   rnp->qsmaskinitnext &= ~rdp->grpmask;

rcutree_migrate_callback()
   // no callback, early return without locking
   // barrier_lock
                                                        //observes !rcu_rdp_cpu_online(rdp)
                                                        rcu_barrier_entrain()
                                                           rcu_segcblist_entrain()
                                                              // Observe rcu_segcblist_n_cbs(rsclp) == 0
                                                              // because no barrier between reading
                                                              // rnp->qsmaskinitnext and rsclp->len
                                                              rcu_segcblist_add_len()
                                                                 smp_mb__before_atomic()
                                                                 // will now observe the 0 count and empty
                                                                 // list, but too late, we enqueue regardless
                                                                 WRITE_ONCE(rsclp->len, rsclp->len + v);
                                                        // ignored barrier callback
                                                        // rcu barrier stall...

This could be solved with a read memory barrier, enforcing the message
passing between rnp->qsmaskinitnext and rsclp->len, matching the full
memory barrier after rsclp->len addition in rcu_segcblist_add_len()
performed at the end of rcu_do_batch().

However the rcu_barrier() is complicated enough and probably doesn't
need too many more subtleties. CPU down is a slowpath and the
barrier_lock seldom contended. Solve the issue with unconditionally
locking the barrier_lock on rcutree_migrate_callbacks(). This makes sure
that either rcu_barrier() sees the empty queue or its entrained
callback will be migrated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8cf6a6fef7965..583cc29080764 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4595,11 +4595,15 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
-	if (rcu_rdp_is_offloaded(rdp) ||
-	    rcu_segcblist_empty(&rdp->cblist))
-		return;  /* No callbacks to migrate. */
+	if (rcu_rdp_is_offloaded(rdp))
+		return;
 
 	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
+	if (rcu_segcblist_empty(&rdp->cblist)) {
+		raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
+		return;  /* No callbacks to migrate. */
+	}
+
 	WARN_ON_ONCE(rcu_rdp_cpu_online(rdp));
 	rcu_barrier_entrain(rdp);
 	my_rdp = this_cpu_ptr(&rcu_data);
-- 
2.43.0


