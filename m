Return-Path: <stable+bounces-168970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A705B2377D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746C7188D7EF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D72D47F4;
	Tue, 12 Aug 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5MtMhrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB227781E;
	Tue, 12 Aug 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025942; cv=none; b=vEy4S9L6oUqDOT0dwa2UtSNoUPETf8cbogfYtnEN4xMMyJnU9hXxkzz5xdqXtwX2zzoWXXyYoOZVlvPOBE6oOg1tttI8OC4ea7sM0Y94Yt8pfvoN922F4CNo3092iOvzObTK+yH0hLl4xtLckvxuXt6F8qGu4D9LYFpXb77ljsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025942; c=relaxed/simple;
	bh=ojJTAalpvEqDIPNKya+2wPnJGeK0vOMYhgcMpANK+pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcXkYPpOb0Zx7wq1YIidXMzefrTQR2YbE0xjuV9OLxlAuMols0LFilXVA+MXrrtS+dO9LsyLHAGEvsHw18gvF1S9U4ynw2M1Imew4sodbaB3MupL9RZQNsKybbzmhWoDTcUkSFcWbcvtWF/KCxS+snJsJ1MwGyy8gRDg9rWp5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5MtMhrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FED2C4CEF0;
	Tue, 12 Aug 2025 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025942;
	bh=ojJTAalpvEqDIPNKya+2wPnJGeK0vOMYhgcMpANK+pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5MtMhrjRmEFyMNDjr0LLE5GHiVQyqfwq1OBqN8JAhXOwhi4WslwtTGWsa8/Rck5A
	 W8gJzpBIF3Lcmtak6aKz9feCY2iYqCooc5heqGwPL9odkUerK/gAXKjr2mMVkk1ar6
	 gkJCNqQ4gC3QzgqY3eAKVp33/ULxnEiPOIfy/Xx8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 157/480] sched/deadline: Initialize dl_servers after SMP
Date: Tue, 12 Aug 2025 19:46:05 +0200
Message-ID: <20250812174403.995964601@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit 9f239df55546ee1d28f0976130136ffd1cad0fd7 ]

dl-servers are currently initialized too early at boot when CPUs are not
fully up (only boot CPU is). This results in miscalculation of per
runqueue DEADLINE variables like extra_bw (which needs a stable CPU
count).

Move initialization of dl-servers later on after SMP has been
initialized and CPUs are all online, so that CPU count is stable and
DEADLINE variables can be computed correctly.

Fixes: d741f297bceaf ("sched/fair: Fair server interface")
Reported-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-2-juri.lelli@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     |  2 ++
 kernel/sched/deadline.c | 48 +++++++++++++++++++++++++----------------
 kernel/sched/sched.h    |  1 +
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d5f51e2f761..333743f143aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8501,6 +8501,8 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
+	sched_init_dl_servers();
+
 	sched_smp_initialized = true;
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 094134c9b135..ef5b5c045769 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -824,6 +824,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
+	update_rq_clock(rq);
+
 	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
 
@@ -1652,23 +1654,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
-	/*
-	 * XXX: the apply do not work fine at the init phase for the
-	 * fair server because things are not yet set. We need to improve
-	 * this before getting generic.
-	 */
-	if (!dl_server(dl_se)) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
-
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
-	}
-
-	if (!dl_se->dl_runtime || dl_se->dl_server_active)
+	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
 	dl_se->dl_server_active = 1;
@@ -1679,7 +1665,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
-	if (!dl_se->dl_runtime)
+	if (!dl_server(dl_se) || !dl_server_active(dl_se))
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
@@ -1712,6 +1698,32 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick_task = pick_task;
 }
 
+void sched_init_dl_servers(void)
+{
+	int cpu;
+	struct rq *rq;
+	struct sched_dl_entity *dl_se;
+
+	for_each_online_cpu(cpu) {
+		u64 runtime =  50 * NSEC_PER_MSEC;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		rq = cpu_rq(cpu);
+
+		guard(rq_lock_irq)(rq);
+
+		dl_se = &rq->fair_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+	}
+}
+
 void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
 {
 	u64 new_bw = dl_se->dl_bw;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d6f82833f652..063f29a228ad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -384,6 +384,7 @@ extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
+extern void sched_init_dl_servers(void);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.39.5




