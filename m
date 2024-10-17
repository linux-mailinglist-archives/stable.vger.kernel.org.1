Return-Path: <stable+bounces-86557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364489A1A20
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A21C2267C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3E15EFA1;
	Thu, 17 Oct 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pI9G2cdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDB15B12F;
	Thu, 17 Oct 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142434; cv=none; b=X5cgopQd4Eg2t7eG48MDwFoHPIGsf9ODMI02oUqqAvA8embGIY3LA6y+U/rge7jJqh/yIxzNqtGnOTE2PZ0emLqk8Gjjj1Mo1Z40Ao/pxO4aKMDAfcsSSB1jcxyZoiSi8ePe4OxhRozJdXwcViizF53jHEpN6Nkko/lrUY5Il3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142434; c=relaxed/simple;
	bh=n4izxsdCqjqWcvDJ5ZCj3ultS7uzhfdnEfgNyYzLHZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwjSDr2gr0N5NjOl5/PEVIS3/jcl6NlvxnnPtxTHaJikLsnioVlASGGnadJjqY67DdDuB7NQ/PbGHdSvoqvkpVTpDwVizEzM6qM4vmSKQyrU81l+ge86y2Z1kql/uMG9qPZen62UTb3qpl2Pr9UNf/0VA3qP+ogn24sh5fltDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pI9G2cdi; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729142434; x=1760678434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjgaYnv9bouACl+8S6HJYWGpatyfYcFMbgYWvbg4/as=;
  b=pI9G2cdiUYKZ+fNmtudGjYL5kku9QCMAED77lC+aQW9bgbAf4QHiWMky
   g+B+a9mu8EmUqdHjl3d8DcKvTsYRcTaOZPdglJnI/qrDMtmUd8WCVxjw0
   Uzu5SHVuJos7Oup9pB+iWVOOZRkhTyEibVfo+/KBBtICEKkaJWJz+Cgy6
   4=;
X-IronPort-AV: E=Sophos;i="6.11,210,1725321600"; 
   d="scan'208";a="435749412"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:20:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23927]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 8057a66f-0bcb-466b-beba-e80bf4a06cb7; Thu, 17 Oct 2024 05:20:30 +0000 (UTC)
X-Farcaster-Flow-ID: 8057a66f-0bcb-466b-beba-e80bf4a06cb7
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:30 +0000
Received: from 88665a51a6b2.amazon.com (10.106.178.54) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:28 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Geoff Blake
	<blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Cristian Prundeanu <cpru@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] [tip: sched/core] sched: Move PLACE_LAG and RUN_TO_PARITY to sysctl
Date: Thu, 17 Oct 2024 00:20:00 -0500
Message-ID: <20241017052000.99200-3-cpru@amazon.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017052000.99200-1-cpru@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

These two scheduler features have a high impact on performance for some
database workloads. Move them to sysctl as they are likely to be modified
and persisted across reboots.

Cc: <stable@vger.kernel.org> # 6.6.x
Fixes: 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Signed-off-by: Cristian Prundeanu <cpru@amazon.com>
---
 include/linux/sched/sysctl.h |  8 ++++++++
 kernel/sched/core.c          | 13 +++++++++++++
 kernel/sched/fair.c          |  5 +++--
 kernel/sched/features.h      | 10 ----------
 kernel/sysctl.c              | 20 ++++++++++++++++++++
 5 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5a64582b086b..0258fba3896a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -29,4 +29,12 @@ extern int sysctl_numa_balancing_mode;
 #define sysctl_numa_balancing_mode	0
 #endif
 
+#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_SYSCTL)
+extern unsigned int sysctl_sched_place_lag_enabled;
+extern unsigned int sysctl_sched_run_to_parity_enabled;
+#else
+#define sysctl_sched_place_lag_enabled 0
+#define sysctl_sched_run_to_parity_enabled 0
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..c6bd1bda8c7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -134,6 +134,19 @@ const_debug unsigned int sysctl_sched_features =
 	0;
 #undef SCHED_FEAT
 
+#ifdef CONFIG_SYSCTL
+/*
+ * Using the avg_vruntime, do the right thing and preserve lag across
+ * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
+ */
+__read_mostly unsigned int sysctl_sched_place_lag_enabled = 0;
+/*
+ * Inhibit (wakeup) preemption until the current task has either matched the
+ * 0-lag point or until is has exhausted it's slice.
+ */
+__read_mostly unsigned int sysctl_sched_run_to_parity_enabled = 0;
+#endif
+
 /*
  * Print a warning if need_resched is set for the given duration (if
  * LATENCY_WARN is enabled).
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a621210c9c1..c58b76233f59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -925,7 +925,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * Once selected, run a task until it either becomes non-eligible or
 	 * until it gets a new slice. See the HACK in set_next_entity().
 	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (sysctl_sched_run_to_parity_enabled &&
+	    curr && curr->vlag == curr->deadline)
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -5280,7 +5281,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
+	if (sysctl_sched_place_lag_enabled && cfs_rq->nr_running && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 8a5ca80665b3..b39a9dde0b54 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,10 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/*
- * Using the avg_vruntime, do the right thing and preserve lag across
- * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
- */
-SCHED_FEAT(PLACE_LAG, false)
 /*
  * Give new tasks half a slice to ease into the competition.
  */
@@ -13,11 +8,6 @@ SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
  * Preserve relative virtual deadline on 'migration'.
  */
 SCHED_FEAT(PLACE_REL_DEADLINE, true)
-/*
- * Inhibit (wakeup) preemption until the current task has either matched the
- * 0-lag point or until is has exhausted it's slice.
- */
-SCHED_FEAT(RUN_TO_PARITY, false)
 /*
  * Allow wakeup of tasks with a shorter slice to cancel RUN_TO_PARITY for
  * current.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..f435b741654a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2029,6 +2029,26 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
+#ifdef CONFIG_SCHED_DEBUG
+	{
+		.procname	= "sched_place_lag_enabled",
+		.data		= &sysctl_sched_place_lag_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "sched_run_to_parity_enabled",
+		.data		= &sysctl_sched_run_to_parity_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
 };
 
 static struct ctl_table vm_table[] = {
-- 
2.40.1


