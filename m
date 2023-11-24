Return-Path: <stable+bounces-802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77E7F7C9F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CC5B20E2F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20139FD9;
	Fri, 24 Nov 2023 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXcuj47M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE339FF3;
	Fri, 24 Nov 2023 18:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF2DC433CA;
	Fri, 24 Nov 2023 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849813;
	bh=nnMk4f6cdHa1W9i8HJEF5L0H8NjJcxhN848QPi2KgzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXcuj47MCb3WceprBlKWaWpReStY+y0VOzJ4vYQIrdNJhov/YTWxApnhbi9imLLLy
	 ukxBjoi2WH8tKuDxmvpL8rxH4X8RkaMDZTwAFmkfVmPMUykpIg3vZ/7AheT5S7+STP
	 zkxRqeiWkg24/RqY4VxuXnckVRhF57SBhMUj+bP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Paul McKenney <paulmck@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 6.6 331/530] rcu/tree: Defer setting of jiffies during stall reset
Date: Fri, 24 Nov 2023 17:48:17 +0000
Message-ID: <20231124172038.095114350@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit b96e7a5fa0ba9cda32888e04f8f4bac42d49a7f8 upstream.

There are instances where rcu_cpu_stall_reset() is called when jiffies
did not get a chance to update for a long time. Before jiffies is
updated, the CPU stall detector can go off triggering false-positives
where a just-started grace period appears to be ages old. In the past,
we disabled stall detection in rcu_cpu_stall_reset() however this got
changed [1]. This is resulting in false-positives in KGDB usecase [2].

Fix this by deferring the update of jiffies to the third run of the FQS
loop. This is more robust, as, even if rcu_cpu_stall_reset() is called
just before jiffies is read, we would end up pushing out the jiffies
read by 3 more FQS loops. Meanwhile the CPU stall detection will be
delayed and we will not get any false positives.

[1] https://lore.kernel.org/all/20210521155624.174524-2-senozhatsky@chromium.org/
[2] https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/

Tested with rcutorture.cpu_stall option as well to verify stall behavior
with/without patch.

Tested-by: Huacai Chen <chenhuacai@loongson.cn>
Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Closes: https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/
Suggested-by: Paul  McKenney <paulmck@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: a80be428fbc1 ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tree.c       |   12 ++++++++++++
 kernel/rcu/tree.h       |    4 ++++
 kernel/rcu/tree_stall.h |   20 ++++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1556,10 +1556,22 @@ static bool rcu_gp_fqs_check_wake(int *g
  */
 static void rcu_gp_fqs(bool first_time)
 {
+	int nr_fqs = READ_ONCE(rcu_state.nr_fqs_jiffies_stall);
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
+
+	WARN_ON_ONCE(nr_fqs > 3);
+	/* Only countdown nr_fqs for stall purposes if jiffies moves. */
+	if (nr_fqs) {
+		if (nr_fqs == 1) {
+			WRITE_ONCE(rcu_state.jiffies_stall,
+				   jiffies + rcu_jiffies_till_stall_check());
+		}
+		WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, --nr_fqs);
+	}
+
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,6 +386,10 @@ struct rcu_state {
 						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
+	int nr_fqs_jiffies_stall;		/* Number of fqs loops after
+						 * which read jiffies and set
+						 * jiffies_stall. Stall
+						 * warnings disabled if !0. */
 	unsigned long jiffies_resched;		/* Time at which to resched */
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -149,12 +149,17 @@ static void panic_on_rcu_stall(void)
 /**
  * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
+ * To perform the reset request from the caller, disable stall detection until
+ * 3 fqs loops have passed. This is required to ensure a fresh jiffies is
+ * loaded.  It should be safe to do from the fqs loop as enough timer
+ * interrupts and context switches should have passed.
+ *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + rcu_jiffies_till_stall_check());
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
+	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -170,6 +175,7 @@ static void record_gp_stall_check_time(v
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
 	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 0);
 	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
@@ -725,6 +731,16 @@ static void check_cpu_stall(struct rcu_d
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
+
+	/*
+	 * Check if it was requested (via rcu_cpu_stall_reset()) that the FQS
+	 * loop has to set jiffies to ensure a non-stale jiffies value. This
+	 * is required to have good jiffies value after coming out of long
+	 * breaks of jiffies updates. Not doing so can cause false positives.
+	 */
+	if (READ_ONCE(rcu_state.nr_fqs_jiffies_stall) > 0)
+		return;
+
 	j = jiffies;
 
 	/*



