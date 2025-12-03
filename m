Return-Path: <stable+bounces-198201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400AC9EDDB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0483A6794
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84B2F5335;
	Wed,  3 Dec 2025 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PQfQtqB5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1C2F60CC
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762025; cv=none; b=iQbb5miEpsb0YA/Q6uv0XBIfht1eO7yPni1LK6HfrY4ubCMGlxXAVM7v95xCcnDs/Qy/m9LXNBp0qZZijafdiFTIaSCoqevQWHPcynOkIoY9ftUYQt0jzIkDzLoUlvTEg/RrOyTNslSeo3rTJVUi/xLwO4STTGW3zrJ3GxW/Gn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762025; c=relaxed/simple;
	bh=02Yp53TuowJehhoJcF+Iw5981qDC8pXTcvwqF/knsI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTSgVjCxaTGs5D535ejNzSFGiEXGKA0wBf2uYKpz3u/k2KEAWrzwuf2D182x5+qSGMhDwNX4RcWvP+vlDBwVJQKf1Amw0olclLHld3I9QPGOHw+P7ZWiINP631K8sRJud3WkX3MHMrjYULe1JqPKkF7VwTXHU9xe1zJD7KOS06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PQfQtqB5; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-297d4ac44fbso4953275ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762023; x=1765366823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/SKWEA8ISmyxBr9KByGjrpmJhdyEvH8fSbpB6G/k0w=;
        b=KgNeeM5qC5LvEjyDPrVXPdz68ugpU1S/HyEtnCH/ogpLuRcGYj4MAgfxYiZlieAIto
         Ny9B9cZnUiORDUmvhEtw+cnuBD2KDqIYG2KhCSG0m+9sbcuZZUX6ZfJAMJPwCPR543F5
         JCy3KlhlnPQ+M1taVN1ZeCQB8Ljpn/OEmXmEoBgTSEWk5A3Xes2yUlxzGz8oFL/dbapB
         hyUJC4bDhND0P7XhDgkQKoBRRWqPnG6nH1jpO6SnecZyXNbYdtJCQBxGL1NUppxAM6ne
         xfg0q8x2uWIw2iQKbmVrtdSiXei3rF/ohEE7W76gOD1cTSyRZJ7F6uy8QXVWnRqjMnlt
         1FIw==
X-Gm-Message-State: AOJu0Ywdj9wI5cGbsK9w1VqscOM9VmLDCQaJ/ArHLug0epy56Z12BNof
	nUnCORVEtRTHDZZvkwS3JZCKtntjeOkbvqQSStngfyIsLQ9twAJ9OueeE9EAn8f2H9WAIcATuej
	EWpbr027tMnKMpFoZcajcH+rJnkAZgr12KSrgbXI72Rp7bkhr/TQ4B4214PycU19zUWHFWBm8R7
	2TSk5M+rpwQpruI7HCVFwkHAKNXmHN2JqEbIMuSeZxCpQRjfZWn0Tbs6SThimdV8AHp5DcPomuT
	gY7p5C3LC8=
X-Gm-Gg: ASbGncumXnU3ckLitVxqqbesekHIkc6xoCL13u/SmUxazMP+oAhjHGmrZfwry78xiew
	FOT7T2uadZAGNfw4O52uN7lX8S7WanwWzGsR+EKebuv34c0nduBheicW1UeXrA0Wxa82nE5EEEQ
	vGWb9buoJEkJjYo6AdDZHNztzJRWJ88t2HxpSuGTniJIvHCBPRuCEcTcidK0RkQXc0QoU9vP42V
	/dN0G+LFw20BL5iGjON5SQ0b2iKZpRMfPcBAs4yTsKOcnz1EW2P7W1LT8Gu1fTCn9dHlodk6isz
	6xzqlwNvwJN9H5KNe4t6J2MJ+C+QjB/6A1hhvEEGuJlZWaZ1ID8cBu5mQLtbFKaWY6C/8Q7Uyve
	FjAw+SyxovTijqa8O68ygbxpxHShO+Q/CaKxE1s4Uup+FLkMxz6cJbq7IdXREKuySzBlScQWRNh
	Gzp/TKqX6eYmeUgwIXrHKUEy/PRhj1tNzvVspfBFGSQjP6
X-Google-Smtp-Source: AGHT+IG73LW/SICRWCZ9hMv6Orcz7HpbQRpIlBNWbXWL8780v8o7DYNjCgQXoWQRGW+IadyAIZkkbiSswA3M
X-Received: by 2002:a17:903:1a8f:b0:297:e897:6f6d with SMTP id d9443c01a7336-29d5a4ad68bmr65100205ad.9.1764762022641;
        Wed, 03 Dec 2025 03:40:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bceb0d2a1sm25162085ad.55.2025.12.03.03.40.22
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:40:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2a45fea6efbso1048381eec.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762021; x=1765366821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/SKWEA8ISmyxBr9KByGjrpmJhdyEvH8fSbpB6G/k0w=;
        b=PQfQtqB5M3kK8u318NO1Q8A2ZhMCieTbmATYvgwbDKFtzolSkhl9h+9QaEa3RYbcAv
         nOYuvybn1LfYVQ2m/8Fr6Mk8KdgtYUyf0Nit0ZWveoNO8rV33Sju7Em9x1fsA51WBHxq
         UNJ/t4WzBb9TYCGiOoA7WCqCvW/IHoxYvTqYY=
X-Received: by 2002:a05:693c:2b10:b0:2ab:9990:79a9 with SMTP id 5a478bee46e88-2ab99908053mr504407eec.17.1764762020891;
        Wed, 03 Dec 2025 03:40:20 -0800 (PST)
X-Received: by 2002:a05:693c:2b10:b0:2ab:9990:79a9 with SMTP id 5a478bee46e88-2ab99908053mr504383eec.17.1764762020180;
        Wed, 03 Dec 2025 03:40:20 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm63324781eec.5.2025.12.03.03.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:40:19 -0800 (PST)
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
Subject: [PATCH v6.6 4/4] sched/fair: Proportional newidle balance
Date: Wed,  3 Dec 2025 11:22:55 +0000
Message-Id: <20251203112255.1738272-5-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112255.1738272-1-ajay.kaher@broadcom.com>
References: <20251203112255.1738272-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Peter Zijlstra (Intel) <peterz@infradead.org>

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
[ Ajay: Modified to apply on v6.6 ]
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
index 9671b7234..197039bab 100644
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
index 1b5e4389f..c4a9797e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
@@ -9872,6 +9873,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
 
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f93a6a12e..a10df85e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11704,11 +11704,27 @@ void update_max_interval(void)
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
@@ -11756,7 +11772,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay = update_newidle_cost(sd, 0);
+		need_decay = update_newidle_cost(sd, 0, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -12394,6 +12410,22 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
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
@@ -12401,10 +12433,14 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
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
index f77016823..48b104ab5 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -88,4 +88,9 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
 
+/*
+ * Do newidle balancing proportional to its success rate using randomization.
+ */
+SCHED_FEAT(NI_RANDOM, true)
+
 SCHED_FEAT(HZ_BW, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64634314a..e1913e253 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1205,6 +1206,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
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
index b87426b74..9fa77e7a6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1600,6 +1600,12 @@ sd_init(struct sched_domain_topology_level *tl,
 
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


