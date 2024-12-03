Return-Path: <stable+bounces-96681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1689E2112
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744681665E0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AE1F7584;
	Tue,  3 Dec 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w6afqiPU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6333FE;
	Tue,  3 Dec 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238284; cv=none; b=cui+TCWIOSLu+dXHPfj7Ce7LUKHAs4Vidznl8PvJbUVX7R4QZdVBzyLNeRIQhBksHMnezUxP03GY8bRhWhVBCNDH/vBKfVaov6vpKExtNy/m8k7VZ+DHjMPjOIEixCfPvO1NacdZTOYN74yAwc8qV4ZVF2KvizbJWLmXoyd2d5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238284; c=relaxed/simple;
	bh=E5tcVZ7NW0rr/t+oDv86GOOGm6g6zlI46PTePiEqOs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgDGz9634RDMMzEQz8YiZZPnahCoJ8c4CIcikWm829tJPESehaob1KAGuy9JRYLabdU2+aQrErIr4iGfrHPiprorroi+Gc3wSUGneYkE0AvWvHCawLlEdNMtXYMCJ75cySTLsuK9SvtOIbTIIeTDZkAdUlyQmUUw6WpbIoyOXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6afqiPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988F6C4CECF;
	Tue,  3 Dec 2024 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238284;
	bh=E5tcVZ7NW0rr/t+oDv86GOOGm6g6zlI46PTePiEqOs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w6afqiPUFBCBBcHBBKj6/iyQeLotqyODea2EGJvK8gdtycsXrfbWi1YSVo/NrCkng
	 JBw6Z5/0fVDqBNMTXh+APaAOa7bOK5SUvWsPoL9QEMTH1Hb1qvPxL92Cn5dtmbEw3r
	 +GaB1OHbx8AAT5epCru4hkCt8F9/Xu+1HZlOK71g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 225/817] drm/v3d: Appease lockdep while updating GPU stats
Date: Tue,  3 Dec 2024 15:36:37 +0100
Message-ID: <20241203144004.531420403@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit 06c3c406850e5495bb56ccf624d0c9477e1ba901 ]

Lockdep thinks our seqcount_t usage is unsafe because the update path can
be both from irq and worker context:

 [ ] ================================
 [ ] WARNING: inconsistent lock state
 [ ] 6.10.3-v8-16k-numa #159 Tainted: G        WC
 [ ] --------------------------------
 [ ] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
 [ ] swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 [ ] ffff80003d7c08d0 (&v3d_priv->stats[i].lock){?.+.}-{0:0}, at: v3d_irq+0xc8/0x660 [v3d]
 [ ] {HARDIRQ-ON-W} state was registered at:
 [ ]   lock_acquire+0x1f8/0x328
 [ ]   v3d_job_start_stats.isra.0+0xd8/0x218 [v3d]
 [ ]   v3d_bin_job_run+0x23c/0x388 [v3d]
 [ ]   drm_sched_run_job_work+0x520/0x6d0 [gpu_sched]
 [ ]   process_one_work+0x62c/0xb48
 [ ]   worker_thread+0x468/0x5b0
 [ ]   kthread+0x1c4/0x1e0
 [ ]   ret_from_fork+0x10/0x20
 [ ] irq event stamp: 337094
 [ ] hardirqs last  enabled at (337093): [<ffffc0008144ce7c>] default_idle_call+0x11c/0x140
 [ ] hardirqs last disabled at (337094): [<ffffc0008144a354>] el1_interrupt+0x24/0x58
 [ ] softirqs last  enabled at (337082): [<ffffc00080061d90>] handle_softirqs+0x4e0/0x538
 [ ] softirqs last disabled at (337073): [<ffffc00080010364>] __do_softirq+0x1c/0x28
 [ ]
                other info that might help us debug this:
 [ ]  Possible unsafe locking scenario:

 [ ]        CPU0
 [ ]        ----
 [ ]   lock(&v3d_priv->stats[i].lock);
 [ ]   <Interrupt>
 [ ]     lock(&v3d_priv->stats[i].lock);
 [ ]
                *** DEADLOCK ***

 [ ] no locks held by swapper/0/0.
 [ ]
               stack backtrace:
 [ ] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        WC         6.10.3-v8-16k-numa #159
 [ ] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
 [ ] Call trace:
 [ ]  dump_backtrace+0x170/0x1b8
 [ ]  show_stack+0x20/0x38
 [ ]  dump_stack_lvl+0xb4/0xd0
 [ ]  dump_stack+0x18/0x28
 [ ]  print_usage_bug+0x3cc/0x3f0
 [ ]  mark_lock+0x4d0/0x968
 [ ]  __lock_acquire+0x784/0x18c8
 [ ]  lock_acquire+0x1f8/0x328
 [ ]  v3d_job_update_stats+0xec/0x2e0 [v3d]
 [ ]  v3d_irq+0xc8/0x660 [v3d]
 [ ]  __handle_irq_event_percpu+0x1f8/0x488
 [ ]  handle_irq_event+0x88/0x128
 [ ]  handle_fasteoi_irq+0x298/0x408
 [ ]  generic_handle_domain_irq+0x50/0x78

But it is a false positive because all the queue-stats pairs have their
own lock and jobs are also one at a time.

Nevertheless we can appease lockdep by disabling local interrupts to make
it see lock usage is consistent.

Cc: Maíra Canal <mcanal@igalia.com>
Fixes: 6abe93b621ab ("drm/v3d: Fix race-condition between sysfs/fdinfo and interrupt handler")
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240813102505.80512-2-tursulin@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 46 +++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index ad1e6236ff6ff..255bd9100c78a 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -133,8 +133,31 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
 	struct v3d_stats *global_stats = &v3d->queue[queue].stats;
 	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
-
-	preempt_disable();
+	unsigned long flags;
+
+	/*
+	 * We only need to disable local interrupts to appease lockdep who
+	 * otherwise would think v3d_job_start_stats vs v3d_stats_update has an
+	 * unsafe in-irq vs no-irq-off usage problem. This is a false positive
+	 * because all the locks are per queue and stats type, and all jobs are
+	 * completely one at a time serialised. More specifically:
+	 *
+	 * 1. Locks for GPU queues are updated from interrupt handlers under a
+	 *    spin lock and started here with preemption disabled.
+	 *
+	 * 2. Locks for CPU queues are updated from the worker with preemption
+	 *    disabled and equally started here with preemption disabled.
+	 *
+	 * Therefore both are consistent.
+	 *
+	 * 3. Because next job can only be queued after the previous one has
+	 *    been signaled, and locks are per queue, there is also no scope for
+	 *    the start part to race with the update part.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		local_irq_save(flags);
+	else
+		preempt_disable();
 
 	write_seqcount_begin(&local_stats->lock);
 	local_stats->start_ns = now;
@@ -144,7 +167,10 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
 	global_stats->start_ns = now;
 	write_seqcount_end(&global_stats->lock);
 
-	preempt_enable();
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		local_irq_restore(flags);
+	else
+		preempt_enable();
 }
 
 static void
@@ -165,11 +191,21 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
 	struct v3d_stats *global_stats = &v3d->queue[queue].stats;
 	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
+	unsigned long flags;
+
+	/* See comment in v3d_job_start_stats() */
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		local_irq_save(flags);
+	else
+		preempt_disable();
 
-	preempt_disable();
 	v3d_stats_update(local_stats, now);
 	v3d_stats_update(global_stats, now);
-	preempt_enable();
+
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		local_irq_restore(flags);
+	else
+		preempt_enable();
 }
 
 static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
-- 
2.43.0




