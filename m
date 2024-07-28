Return-Path: <stable+bounces-61995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D265A93E1C9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6DFB218DC
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850165D8F0;
	Sun, 28 Jul 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsRQxU8/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD665914C;
	Sun, 28 Jul 2024 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127689; cv=none; b=QVLo4aDpuZq9hJVxMyFrXwfptY0bj9VaXUj6VojItTQ54LuFXbfmIVt2r8UfTfRwfUAXNgjtGEiGEMYkLMxF+9JEL8U9kUZYD5JVFsigtVDWLYnMmjD05C2Nh/UzZ2hXvNHWcSnruyy2sIomgqhcMh0hVCyXJIGDAWruRlozPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127689; c=relaxed/simple;
	bh=60xfGF4gtOnUuozlTRSU0le0zz/v+ho5Qw6BTOGPUOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyYhw0d21fniLR+0jHPUkQ7ZC8j8RyC2HFfQOdOxPiQBSYbciDKOMdsxPb8CEq4Nbb9uBXmpGaQJBBWNQZAozdeiVO9Iq5gU4LtcG8H94HOQBQ+eRBjFUAuXjvqf2l5ZVRbond8LjRLfWvqnd1k7JN+7tglKczOE7RZdei79bFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsRQxU8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F3BC32781;
	Sun, 28 Jul 2024 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127688;
	bh=60xfGF4gtOnUuozlTRSU0le0zz/v+ho5Qw6BTOGPUOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsRQxU8/UlA6F43c0fVJf0wkMGpk4P//zY56xFPDJrSmemfeqsBlGGnUWKxHpZAwf
	 HbXnJZLGdD7TosDlNi7rtsyS2kc0NGUCU0Q+eE7y73tnlFS9Sfst0jHBeEhjPjzJIY
	 mRMA2Eh1Q0XKwEwdDyQfsSbIEkpo+7Z1SZsKUXEgqEU4L35/XoEBzdwqHVOofVMXlE
	 Tbq7jk8nFK21Ny7egj2NzserMKV3JVMS57HB2LtlHZbmiSFjUWLPtFcfm3Wi/fGoLn
	 ccNZeyoubraaCJSv1bnfBsNS2zenbHEASVbCgUy4xLXcm4QRo16m4YxcLu6iUph2JX
	 PwMqN7IxD3UGw==
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
Subject: [PATCH AUTOSEL 6.10 15/16] rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation
Date: Sat, 27 Jul 2024 20:47:32 -0400
Message-ID: <20240728004739.1698541-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 28c7031711a3f..63fb007beeaf5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5110,11 +5110,15 @@ void rcutree_migrate_callbacks(int cpu)
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


