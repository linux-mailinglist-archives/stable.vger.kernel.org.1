Return-Path: <stable+bounces-171598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756BB2AAEC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A49587C13
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1B35A2B6;
	Mon, 18 Aug 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qr1Cd0gI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283335A297;
	Mon, 18 Aug 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526473; cv=none; b=t2S3LWqc8jgTORhlEfQiv9FXhiKu1TBFACk6Pqv7O7pNZdNGHT0MYlzSqze7L0PWOA/OSqzeyQRzHTzTje0KR2tRQXPr9L7sb4oWiHniQfSzRCJugHe6QDwo7WeJvREE359ps5mqLGPpACJP12PWyr0gv2/bfipQj8Ypg4VY74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526473; c=relaxed/simple;
	bh=PMNUS57VBm2lfRuD8lVeqmq0CXuIeUxVbSlNfoG7Jr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmugpSlR3GBrYN917L4/ZrrD09a8QIPfCR1AQ9nMacREHSa6xupNevxXWtYT9TPa0nRsr9xt9O0CojaIoHCcUp84KuETpThMzb1vdWIjd+4bLBPkU7lF2IGpp0UN1wcSh1IOBQTMvVA1zOAlhyAKkHwRHADADwnIqYy6CuQ2+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qr1Cd0gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFBBC4CEEB;
	Mon, 18 Aug 2025 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526473;
	bh=PMNUS57VBm2lfRuD8lVeqmq0CXuIeUxVbSlNfoG7Jr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qr1Cd0gIqSbccPMsu4LGfUec7gCX2uKfek7MBgxPSytL4CyXQSrQzUZhCuB9mFJR6
	 DGvo3Fq03Zb3G4wCDhbvb+EhEFFcpXaI4U+ONwqxEcPWRpRFpxyFeXfN1NmfMRxNbM
	 mL10lZFkpe0/b7whULYVlcHthXPIg+6Kc5oEsb08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH 6.16 566/570] rcu: Fix racy re-initialization of irq_work causing hangs
Date: Mon, 18 Aug 2025 14:49:13 +0200
Message-ID: <20250818124527.681084032@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit 61399e0c5410567ef60cb1cda34cca42903842e3 upstream.

RCU re-initializes the deferred QS irq work everytime before attempting
to queue it. However there are situations where the irq work is
attempted to be queued even though it is already queued. In that case
re-initializing messes-up with the irq work queue that is about to be
handled.

The chances for that to happen are higher when the architecture doesn't
support self-IPIs and irq work are then all lazy, such as with the
following sequence:

1) rcu_read_unlock() is called when IRQs are disabled and there is a
   grace period involving blocked tasks on the node. The irq work
   is then initialized and queued.

2) The related tasks are unblocked and the CPU quiescent state
   is reported. rdp->defer_qs_iw_pending is reset to DEFER_QS_IDLE,
   allowing the irq work to be requeued in the future (note the previous
   one hasn't fired yet).

3) A new grace period starts and the node has blocked tasks.

4) rcu_read_unlock() is called when IRQs are disabled again. The irq work
   is re-initialized (but it's queued! and its node is cleared) and
   requeued. Which means it's requeued to itself.

5) The irq work finally fires with the tick. But since it was requeued
   to itself, it loops and hangs.

Fix this with initializing the irq work only once before the CPU boots.

Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tree.c        |    2 ++
 kernel/rcu/tree.h        |    1 +
 kernel/rcu/tree_plugin.h |    8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4233,6 +4233,8 @@ int rcutree_prepare_cpu(unsigned int cpu
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	rcu_preempt_deferred_qs_init(rdp);
 	rcu_spawn_rnp_kthreads(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.n_online_cpus);
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -488,6 +488,7 @@ static int rcu_print_task_exp_stall(stru
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_sched_clock_irq(int user);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -699,8 +699,6 @@ static void rcu_read_unlock_special(stru
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				rdp->defer_qs_iw =
-					IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
@@ -840,6 +838,10 @@ dump_blkd_tasks(struct rcu_node *rnp, in
 	}
 }
 
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp)
+{
+	rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
+}
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
@@ -1039,6 +1041,8 @@ dump_blkd_tasks(struct rcu_node *rnp, in
 	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
 }
 
+static void rcu_preempt_deferred_qs_init(struct rcu_data *rdp) { }
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*



