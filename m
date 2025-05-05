Return-Path: <stable+bounces-140006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38078AAA3B5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1659F3BF8F3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471F2F5FA8;
	Mon,  5 May 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow1MgtfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A909284B52;
	Mon,  5 May 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483893; cv=none; b=EbL9OAWfLHqqRtji9l/w4/92dll8lFi0WENFlwCXNfxhGkP25Gu1pW/q2dPt1tWuS4vv6GFlNpxD14gnd7uTK8jTVXjTUhHDy/q4htW62WXiJwkL6ceMMBDH+ENVzfaKvi1QtXUF/VQxhvqXxv2cfFdg/Wls4GpTtfz8aaW2FbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483893; c=relaxed/simple;
	bh=Z7eYYngvAmhpp/wijbOeUMrD3MIS7r0t5AhztlBnb7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yojl1p/Y3zrZIM2hsTSUwitsKRTqPezryp4IJoJ/qmcci7X2d2SqPEbtoTmkF8z8tdjNdSrss+y9kCAy3RhUlkHi53nGzs0DyK+ZI4ZPd0CVLuTJhio5jnNXpvG+MzxEBpYQBL6Ey+s+P4Rq5TXdkdMBUFBlxd2a88yX6tNeUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow1MgtfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C78C4CEED;
	Mon,  5 May 2025 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483893;
	bh=Z7eYYngvAmhpp/wijbOeUMrD3MIS7r0t5AhztlBnb7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow1MgtfKkkf0aBKnPTTtNbQZ4fR0QJHeANIpFWnN5ykWq3hdnL10RT7NNCY0Pe7Qn
	 6QMYzGIwmGBbweBHJQS2CLbpOpJIzjqFj9jGI+YhZfD6un+SdPzhZlvkOWQnnPjTOm
	 zgmLodO19wHucm1EFIaUxRPI0iylBBRh16GCmd86vS2X1/Yvx6eaiZSqR67DeNuqgw
	 jxVclSMwvR80CWmoex1tTp7fClE9/PxDu6v0Smg7Nq3Ds617KiZUhsgJpVWdMZgsq2
	 GBzr0z74RXxotgiVYFfhCMj7ndNmFDMFG+GqHaC3tNiLMEaPZHn3aoYUFjIPPHaW9X
	 DXqgx3dNYw3DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 259/642] rcu: Fix get_state_synchronize_rcu_full() GP-start detection
Date: Mon,  5 May 2025 18:07:55 -0400
Message-Id: <20250505221419.2672473-259-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 85aad7cc417877054c65bd490dc037b087ef21b4 ]

The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
functions use the root rcu_node structure's ->gp_seq field to detect
the beginnings and ends of grace periods, respectively.  This choice is
necessary for the poll_state_synchronize_rcu_full() function because
(give or take counter wrap), the following sequence is guaranteed not
to trigger:

	get_state_synchronize_rcu_full(&rgos);
	synchronize_rcu();
	WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));

The RCU callbacks that awaken synchronize_rcu() instances are
guaranteed not to be invoked before the root rcu_node structure's
->gp_seq field is updated to indicate the end of the grace period.
However, these callbacks might start being invoked immediately
thereafter, in particular, before rcu_state.gp_seq has been updated.
Therefore, poll_state_synchronize_rcu_full() must refer to the
root rcu_node structure's ->gp_seq field.  Because this field is
updated under this structure's ->lock, any code following a call to
poll_state_synchronize_rcu_full() will be fully ordered after the
full grace-period computation, as is required by RCU's memory-ordering
semantics.

By symmetry, the get_state_synchronize_rcu_full() function should also
use this same root rcu_node structure's ->gp_seq field.  But it turns out
that symmetry is profoundly (though extremely infrequently) destructive
in this case.  To see this, consider the following sequence of events:

1.	CPU 0 starts a new grace period, and updates rcu_state.gp_seq
	accordingly.

2.	As its first step of grace-period initialization, CPU 0 examines
	the current CPU hotplug state and decides that it need not wait
	for CPU 1, which is currently offline.

3.	CPU 1 comes online, and updates its state.  But this does not
	affect the current grace period, but rather the one after that.
	After all, CPU 1 was offline when the current grace period
	started, so all pre-existing RCU readers on CPU 1 must have
	completed or been preempted before it last went offline.
	The current grace period therefore has nothing it needs to wait
	for on CPU 1.

4.	CPU 1 switches to an rcutorture kthread which is running
	rcutorture's rcu_torture_reader() function, which starts a new
	RCU reader.

5.	CPU 2 is running rcutorture's rcu_torture_writer() function
	and collects a new polled grace-period "cookie" using
	get_state_synchronize_rcu_full().  Because the newly started
	grace period has not completed initialization, the root rcu_node
	structure's ->gp_seq field has not yet been updated to indicate
	that this new grace period has already started.

	This cookie is therefore set up for the end of the current grace
	period (rather than the end of the following grace period).

6.	CPU 0 finishes grace-period initialization.

7.	If CPU 1’s rcutorture reader is preempted, it will be added to
	the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
	set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
	will not be updated.  Thus, this grace period will not wait on
	it.  Which is only fair, given that the CPU did not come online
	until after the grace period officially started.

8.	CPUs 0 and 2 then detect the new grace period and then report
	a quiescent state to the RCU core.

9.	Because CPU 1 was offline at the start of the current grace
	period, CPUs 0 and 2 are the only CPUs that this grace period
	needs to wait on.  So the grace period ends and post-grace-period
	cleanup starts.  In particular, the root rcu_node structure's
	->gp_seq field is updated to indicate that this grace period
	has now ended.

10.	CPU 2 continues running rcu_torture_writer() and sees that,
	from the viewpoint of the root rcu_node structure consulted by
	the poll_state_synchronize_rcu_full() function, the grace period
	has ended.  It therefore updates state accordingly.

11.	CPU 1 is still running the same RCU reader, which notices this
	update and thus complains about the too-short grace period.

The fix is for the get_state_synchronize_rcu_full() function to use
rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq field.
With this change in place, if step 5's cookie indicates that the grace
period has not yet started, then any prior code executed by CPU 2 must
have happened before CPU 1 came online.  This will in turn prevent CPU
1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
thus preventing CPU 1 from being subjected to a too-short grace period.

This commit therefore makes this change.  Note that there is no change to
the poll_state_synchronize_rcu_full() function, which as noted above,
must continue to use the root rcu_node structure's ->gp_seq field.
This is of course an asymmetry between these two functions, but is an
asymmetry that is absolutely required for correct operation.  It is a
common human tendency to greatly value symmetry, and sometimes symmetry
is a wonderful thing.  Other times, symmetry results in poor performance.
But in this case, symmetry is just plain wrong.

Nevertheless, the asymmetry does require an additional adjustment.
It is possible for get_state_synchronize_rcu_full() to see a given
grace period as having started, but for an immediately following
poll_state_synchronize_rcu_full() to see it as having not yet started.
Given the current rcu_seq_done_exact() implementation, this will
result in a false-positive indication that the grace period is done
from poll_state_synchronize_rcu_full().  This is dealt with by making
rcu_seq_done_exact() reach back three grace periods rather than just
two of them.

However, simply changing get_state_synchronize_rcu_full() function to
use rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq
field results in a theoretical bug in kernels booted with
rcutree.rcu_normal_wake_from_gp=1 due to the following sequence of
events:

o	The rcu_gp_init() function invokes rcu_seq_start() to officially
	start a new grace period.

o	A new RCU reader begins, referencing X from some RCU-protected
	list.  The new grace period is not obligated to wait for this
	reader.

o	An updater removes X, then calls synchronize_rcu(), which queues
	a wait element.

o	The grace period ends, awakening the updater, which frees X
	while the reader is still referencing it.

The reason that this is theoretical is that although the grace period
has officially started, none of the CPUs are officially aware of this,
and thus will have to assume that the RCU reader pre-dated the start of
the grace period. Detailed explanation can be found at [2] and [3].

Except for kernels built with CONFIG_PROVE_RCU=y, which use the polled
grace-period APIs, which can and do complain bitterly when this sequence
of events occurs.  Not only that, there might be some future RCU
grace-period mechanism that pulls this sequence of events from theory
into practice.  This commit therefore also pulls the call to
rcu_sr_normal_gp_init() to precede that to rcu_seq_start().

Although this fixes commit 91a967fd6934 ("rcu: Add full-sized polling
for get_completed*() and poll_state*()"), it is not clear that it is
worth backporting this commit.  First, it took me many weeks to convince
rcutorture to reproduce this more frequently than once per year.
Second, this cannot be reproduced at all without frequent CPU-hotplug
operations, as in waiting all of 50 milliseconds from the end of the
previous operation until starting the next one.  Third, the TREE03.boot
settings cause multi-millisecond delays during RCU grace-period
initialization, which greatly increase the probability of the above
sequence of events.  (Don't do this in production workloads!) Fourth,
the TREE03 rcutorture scenario was modified to use four-CPU guest OSes,
to have a single-rcu_node combining tree, no testing of RCU priority
boosting, and no random preemption, and these modifications were
necessary to reproduce this issue in a reasonable timeframe. Fifth,
extremely heavy use of get_state_synchronize_rcu_full() and/or
poll_state_synchronize_rcu_full() is required to reproduce this, and as
of v6.12, only kfree_rcu() uses it, and even then not particularly
heavily.

[boqun: Apply the fix [1], and add the comment before the moved
rcu_sr_normal_gp_init(). Additional links are added for explanation.]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/rcu/d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop/ [1]
Link: https://lore.kernel.org/rcu/20250303001507.GA3994772@joelnvbox/ [2]
Link: https://lore.kernel.org/rcu/Z8bcUsZ9IpRi1QoP@pc636/ [3]
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcu.h  |  2 +-
 kernel/rcu/tree.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d59..f87c9d6d36fcb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed141..b7bf9db9bb461 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1801,10 +1801,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
+	/*
+	 * A new wait segment must be started before gp_seq advanced, so
+	 * that previous gp waiters won't observe the new gp_seq.
+	 */
+	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	start_new_poll = rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
@@ -3357,14 +3361,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-	struct rcu_node *rnp = rcu_get_root();
-
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
 	 * before the loads from ->gp_seq and ->expedited_sequence.
 	 */
 	smp_mb();  /* ^^^ */
-	rgosp->rgos_norm = rcu_seq_snap(&rnp->gp_seq);
+
+	// Yes, rcu_state.gp_seq, not rnp_root->gp_seq, the latter's use
+	// in poll_state_synchronize_rcu_full() notwithstanding.  Use of
+	// the latter here would result in too-short grace periods due to
+	// interactions with newly onlined CPUs.
+	rgosp->rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
 	rgosp->rgos_exp = rcu_seq_snap(&rcu_state.expedited_sequence);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
-- 
2.39.5


