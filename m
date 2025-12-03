Return-Path: <stable+bounces-198196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18927C9EDBD
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63DF4349E0A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315472F658F;
	Wed,  3 Dec 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y/TLmSUY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F892F616D
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761894; cv=none; b=TGp8of0wMBIhbe2hhGx0qhUc/wR1X710W1KAySFynhT/gdxadd0Ofi9JQ1SUmcf9keJaextzqalqx49iX87v/XxlP9z5WBv7hQXgbolptHiiUylHhtu7/JRc/VN9gFN4wU330Kn403n5hWXO/SEnzYg3gCA4cmP9bbg6OLdCbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761894; c=relaxed/simple;
	bh=ZG5mzj65CsSbn+sH8RL7YDJ3FtnnWDUbqNPW06zJwbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABmvMyljCMc9lL4Rm+YWnqiFrmJlzds0B+i+iIOeTn0xrGcjYwexxfqtgQhmvWOS+wM7uCGbREPqh59z2a4aVm3VxsOuBQFhVaEJ1aNPTchwnvuwufL0eS76lo0FfjtMD1ZCpTB3l09r7U4g4F2rDu2FGD6o5zsEcqOVNUgswKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y/TLmSUY; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29586626fbeso81420855ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761891; x=1765366691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaYvaRoI/zaMoFXpgyvVSoj5rbLS0T6qMiMhubQCjpU=;
        b=CZJeXbCfSr6XhYYhJik99D0MwFY0wiU0psOuRchGv3ofeh8fh1ahg3PdqxfAa3zJns
         LT8awkglAeeYKP0eQ1W5hKQE+VxtBx0bJZ5VwM6pV6jms0hUXdyeiKc4JTz/TGZDcsFr
         5v7UsoSg8dohKL0GUC2VWjVWJbbqxF+zffGrbSd2apTT6FZvOjZzplOHKr/kujLCuhxb
         OW5HOwmUKALwwSs5P2FNfULu9h0X1VHer7b8JqWookt0RC5Bc8PBX1EItDcPXGz8c3cd
         9i6nJF8FIMf0scISc5XtqX7v6UIbfEJpo7I076w6n61RlEclVLyrzK1T+cYKMngVe0N0
         YgWg==
X-Gm-Message-State: AOJu0YznPd9rVfAj68nPSbD74pR5YsGMZYo/KkFSCo0RsigXvp84dEUw
	b3XHbH1PJksjPLPO1kXwCmgVBzwQpogCmSFovXRC/NBqFF5l3YmIZwvlFfPICVoC/4m97DEmT3s
	iWlkt39vxkYVAsfNP0j9Cu30tvvsnGZljkagGTKL90THe46oaZX1Q/1gD/qr2IULbvJV/RHxwQk
	laV67rNqxjANkbJ64WY9CoAIA1LcJj3bSxu0JjV6Kwun8uMzRKHjfMPP6MbM1BZkla1h05APRe/
	our5cbidbg=
X-Gm-Gg: ASbGncsE8ytYdhRCfmVMGqvi3vKkgHGJ53jHpklMkEaDD2mge5vrsaj5SsmMzcSqi5a
	4iMIQHK83y3JVRrP7AsBuCpZii+SGDbOuQmPgGzDhPy6HwYy3vPdzL64e9wJjeHi81hG5u//IGr
	Ev2BbtHhb+Htqq01BUz2EpeFnmrrmNREi36nnmo83M98vI1J3mVYfpTXUf2Ztxx0VUtfaVNFr2P
	qg3Nk9P/UiQqus/5C+KDdJPjhQVWuUPFZuRqW6yDiDneW3O9LR9BXSiyxo5edyoSUHmE5AYvirl
	OaUToEkfO6YJSf0pG85D6mkxT4UkQjvBdmWOzb7P4wsDzp30Wb2prdPzJFCXpRy+CF6N3Z5zUwv
	/JbRPDm0f6tW5ysQzOQnpciKtBNZ5t1wt/GlpZ+Hl9rZw5NX3ySzVicbZrBX1g+WCM8exMWVIS5
	E6AFAKt1+hDqaiVDcD4jhEAEZTUwQ1Yw4RFN5b+5VY4w==
X-Google-Smtp-Source: AGHT+IH1EXukzUhEEXZDnT2sp1k86GB5zFhrVOHwjlhNs6V7mx+6GQNZAAIrm7zoBGhRxA3JV92KiFecf3KT
X-Received: by 2002:a17:902:c94b:b0:294:def6:5961 with SMTP id d9443c01a7336-29d683af981mr25423545ad.45.1764761891591;
        Wed, 03 Dec 2025 03:38:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce45105esm24103365ad.21.2025.12.03.03.38.11
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:38:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2955555f73dso76198975ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764761890; x=1765366690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaYvaRoI/zaMoFXpgyvVSoj5rbLS0T6qMiMhubQCjpU=;
        b=Y/TLmSUYMAuvWZUC6J+gS1vds8kBt6iLmn2c/WRXPCOfq+9SLfc36iQ23Z5TsHHGFW
         mnPLlB1ecVuQAQfWNw9CEUuPI44E/6PCYu4W2uosC28XaGafP63y4DrEUo9wPb8mQmwu
         hQPzdZpfLZ6OosAv41FHHlgn8sg+WCvQ5AFH8=
X-Received: by 2002:a05:7022:160a:b0:11b:9386:825d with SMTP id a92af1059eb24-11df0cebfdamr1730611c88.42.1764761889534;
        Wed, 03 Dec 2025 03:38:09 -0800 (PST)
X-Received: by 2002:a05:7022:160a:b0:11b:9386:825d with SMTP id a92af1059eb24-11df0cebfdamr1730570c88.42.1764761888840;
        Wed, 03 Dec 2025 03:38:08 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm83169465c88.6.2025.12.03.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:08 -0800 (PST)
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
Subject: [PATCH v6.12 4/4] sched/fair: Proportional newidle balance
Date: Wed,  3 Dec 2025 11:20:27 +0000
Message-Id: <20251203112027.1738141-5-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
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
[ Ajay: Modified to apply on v6.12 ]
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
index 4237daa5a..3cf27591f 100644
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
index 4b1953b6c..b1895b330 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -118,6 +118,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
@@ -8335,6 +8336,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
 
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae5da8f34..189681ab8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12217,11 +12217,27 @@ void update_max_interval(void)
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
@@ -12269,7 +12285,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay = update_newidle_cost(sd, 0);
+		need_decay = update_newidle_cost(sd, 0, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -12927,6 +12943,22 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
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
 
 			pulled_task = sched_balance_rq(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
@@ -12934,10 +12966,14 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
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
index 050d75030..da8ec0c23 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -122,3 +122,8 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
+
+/*
+ * Do newidle balancing proportional to its success rate using randomization.
+ */
+SCHED_FEAT(NI_RANDOM, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cf541c450..78b40c540 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1348,6 +1349,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
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
index 4bd825c24..bd8b2b301 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1632,6 +1632,12 @@ sd_init(struct sched_domain_topology_level *tl,
 
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


