Return-Path: <stable+bounces-198206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E5C9EE0E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DE83A458A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1E2F5A34;
	Wed,  3 Dec 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZjuHlBfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A82F6563
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762217; cv=none; b=nSSh7CyX6e7Fsf14nQW9i7bV/e9yJ9IkZ8aVk98qC1Nq40TyhfmRX5quUKx2nXOmbnGvPE6Snz4I9SoFtOvUgitcwZNm91/d3+pGDYlBcpVEbN+Ng6iu69mnvMFG2ZRoL2l1JSbuiIPudH1GB8FXem9+5kQI4ccCc41JO3Nazcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762217; c=relaxed/simple;
	bh=UtdFMJwZBJWJFUXRVW5pS9k5RKZ7sSfvPSP4YuwCcxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdBpPucB+ddYlyVruM5TW4J6VEjYGMYW8NpVfFG/3yU+0MK6k38tUrSbOaqLfpk9NWRMfpse0b+MpGUUgCy1iKE1c+avVY0hA/xpGlugvxerMXkeIrTkBkqrxVxnbQ/TELqust6luBwTkm3CFEq8wULRqYtBo8ZdDuNI5X3tYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZjuHlBfM; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-299d40b0845so107198645ad.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762215; x=1765367015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12d1g/kfvy76Un8DYq1Egc2YQIXGsJ6Y11du/XcNKeo=;
        b=OdQ2nmPbHN5HfZODgfUS+VerRjsBm4n4Ix4uLlHjDVircf1Fh7aaVsULTfNivKyYNZ
         GquhIlAGbVjSr67DwpQ6+8sJ2zOLR6y0wk/LYtZdzGvyhr37mXAXYaIpMk6/1kZxtvCN
         wx56pGAZc1eisKQTNqm1zBfDxnp4b9fUwhH+uXIqqfhtbKo+3yZoPIPgn2m7M7nDjUX7
         eF24wMyHp1ZIjnE1wk38GrRHsZz5V5rMMOUvcR0qecLY3xDbL/48uQgBGWbsav9hTcez
         Eg/2n5KhCJJF+p5uoEaTd+enCusgGpt0WBZsEMojblMk9IjAzz4xMw2Mj8yEOnrdVuJO
         Cymw==
X-Gm-Message-State: AOJu0YwC0D248YAW5x0l30kn9k3KbZeZns4nyGFsir8b9dUyfnkj8vRT
	LA0AKI3U/YbbBpSwOC7gKoC8HzAcAI0rhrrqJV+8IX93yPoAVrMjeTd7N9SAAWlp9lvhjxtCsz6
	6Cyl/adgi/2KkefB80mkZOG2AnLCGm82fcAeTBp5TK0t26j6RK8Z4XUMNl4MLW7W95mRj4nRcVF
	qpase1Ct/DEWk0T11P238K3kb9qoCzgzHlLyeD+0y8L5Bjmbbx7/Me2fvgcu9FsYPvPOixG/PEc
	CRYhILrSxg=
X-Gm-Gg: ASbGncu0PCJF9x7IVTD/+tjtoUwAS02QJCY3RtqfSq6nng8pGmsXNZuuWaNvBaPyrsO
	wcqtN8cXvzSKUl/YfABdLKGrd5nh21UZM1UaUs2Yt2GXZ174JaJIlfBoME037oqNSXM5Kq9cgVt
	sAGM3XS949ulc0Lg1MB/DQNEEKND+sLB7bQuz6PfQSsPwjwCUXwj36Vzb+3faF1tfTHpTc3RPL9
	5dw9cWNTryoltSv2kL7rC1bWjW+mDVQHfaudmOJ+oBQboYsOxxv33eU0FjwwklhkCVaVcI/gOUS
	ZsmgVgzv3Ezyj4uvV1hi1z0XbzN+SGnmxzW/TbU54aE8B+lAIlQNPKPzWxHjz8/yy/M3EeojL3X
	SWpoOrBErWRzlapousbUgDb4H2C6mipRri96OV2UqtW3E3+q94RF3UJpxEbviThBSdjdOaeF/2n
	Ff8igbsQZhUn2r3oAVBbrBw6hraYtwf3s/PLFxw0a1pMna
X-Google-Smtp-Source: AGHT+IFF2v9nqbmNFhSOeNihgav40KkiscvN6dPNlFu2DhhYbRSAatmIerr2KNFY1a8B/7um/ge/snXnFnbK
X-Received: by 2002:a17:902:ce91:b0:295:7f1d:b034 with SMTP id d9443c01a7336-29d683128efmr28038165ad.4.1764762214740;
        Wed, 03 Dec 2025 03:43:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce41b327sm24118975ad.6.2025.12.03.03.43.34
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:43:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b225760181so798762585a.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762213; x=1765367013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12d1g/kfvy76Un8DYq1Egc2YQIXGsJ6Y11du/XcNKeo=;
        b=ZjuHlBfMImMVIr3c5kHc3R0ugrEbwThQdtqqYJvFbVi/W+Ag2NmwGUPmiQGChnmmru
         F6bi6P+119vSL8KixZGbQVf9C2iAfjxBKYaKiPJfWBS4MxH0FJRpWD1DCzY2r66Yxs2S
         PfoHLtZJoVG+y7sGNPt2P9JYh6pogdQOmRKlY=
X-Received: by 2002:a05:620a:31a2:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b5e5830538mr253365785a.37.1764762213529;
        Wed, 03 Dec 2025 03:43:33 -0800 (PST)
X-Received: by 2002:a05:620a:31a2:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b5e5830538mr253358885a.37.1764762212814;
        Wed, 03 Dec 2025 03:43:32 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1284727985a.33.2025.12.03.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:32 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Chris Mason <clm@meta.com>
Subject: [PATCH v6.1 4/4] sched/fair: Proportional newidle balance
Date: Wed,  3 Dec 2025 11:25:52 +0000
Message-Id: <20251203112552.1738424-5-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
References: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Peter Zijlstra <peterz@infradead.org>

commit 33cf66d88306663d16e4759e9d24766b0aaa2e17 upstream.

Add a randomized algorithm that runs newidle balancing proportional to
its success rate.

This improves schbench significantly:

 6.18-rc4:			2.22 Mrps/s
 6.18-rc4+revert:		2.04 Mrps/s
 6.18-rc4+revert+random:	2.18 Mrps/S

Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:

 6.17:			-6%
 6.17+revert:		 0%
 6.17+revert+random:	-1%

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://lkml.kernel.org/r/6825c50d-7fa7-45d8-9b81-c6e7e25738e2@meta.com
Link: https://patch.msgid.link/20251107161739.770122091@infradead.org
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 include/linux/sched/topology.h |  3 +++
 kernel/sched/core.c            |  3 +++
 kernel/sched/fair.c            | 44 ++++++++++++++++++++++++++++++----
 kernel/sched/features.h        |  5 ++++
 kernel/sched/sched.h           |  7 ++++++
 kernel/sched/topology.c        |  6 +++++
 6 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc4..caeceec3e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -106,6 +106,9 @@ struct sched_domain {
 	unsigned int nr_balance_failed; /* initialise to 0 */
 
 	/* idle_balance() stats */
+	unsigned int newidle_call;
+	unsigned int newidle_success;
+	unsigned int newidle_ratio;
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b01fdceb..09ffe1b96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -112,6 +112,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
@@ -9632,6 +9633,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
 
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f296e2af..9f7c9083e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10935,11 +10935,27 @@ void update_max_interval(void)
 	max_load_balance_interval = HZ*num_online_cpus()/10;
 }
 
-static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+static inline void update_newidle_stats(struct sched_domain *sd, unsigned int success)
+{
+	sd->newidle_call++;
+	sd->newidle_success += success;
+
+	if (sd->newidle_call >= 1024) {
+		sd->newidle_ratio = sd->newidle_success;
+		sd->newidle_call /= 2;
+		sd->newidle_success /= 2;
+	}
+}
+
+static inline bool
+update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
 {
 	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
 	unsigned long now = jiffies;
 
+	if (cost)
+		update_newidle_stats(sd, success);
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
@@ -10987,7 +11003,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay = update_newidle_cost(sd, 0);
+		need_decay = update_newidle_cost(sd, 0, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -11621,6 +11637,22 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 			break;
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			unsigned int weight = 1;
+
+			if (sched_feat(NI_RANDOM)) {
+				/*
+				 * Throw a 1k sided dice; and only run
+				 * newidle_balance according to the success
+				 * rate.
+				 */
+				u32 d1k = sched_rng() % 1024;
+				weight = 1 + sd->newidle_ratio;
+				if (d1k > weight) {
+					update_newidle_stats(sd, 0);
+					continue;
+				}
+				weight = (1024 + weight/2) / weight;
+			}
 
 			pulled_task = load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
@@ -11628,10 +11660,14 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Track max cost of a domain to make sure to not delay the
+			 * next wakeup on the CPU.
+			 */
+			update_newidle_cost(sd, domain_cost, weight * !!pulled_task);
 		}
 
 		/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76..0115183ee 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -99,5 +99,10 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
 
+/*
+ * Do newidle balancing proportional to its success rate using randomization.
+ */
+SCHED_FEAT(NI_RANDOM, true)
+
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 95afded0b..6f66a9b1a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1190,6 +1191,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
 }
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU(struct rnd_state, sched_rnd_state);
+
+static inline u32 sched_rng(void)
+{
+	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
+}
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d404b5d2d..9d6ec8311 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1584,6 +1584,12 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
+
+		/* 50% success rate */
+		.newidle_call		= 512,
+		.newidle_success	= 256,
+		.newidle_ratio		= 512,
+
 		.max_newidle_lb_cost	= 0,
 		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,
-- 
2.40.4


