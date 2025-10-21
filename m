Return-Path: <stable+bounces-188419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096EBF83B8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8C18A64C4
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F124351FAF;
	Tue, 21 Oct 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpCCGdFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CC338903
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074550; cv=none; b=K16L4Bec9Ey8IFhVCNM5lssXN4udcydxPnmSl1/l01BIf+0vdl5XwqMhggn6zT4UfmY1B3ufwTdOfz/Ff4L1RshOzONDyJHQ6Q0b89hpNFDjdZjXkd/veNL0gfWUqQRYqXXnvTiJUGO9UQAlobi4LPIVHOihAqVyiHZQ3oWY44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074550; c=relaxed/simple;
	bh=DvGNiH3TJD0W9B7gLTEO1yaa+ECw6zmk7FNzi/nfemc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY4o5OrToz+iZRAkCZ3OfOniADzV6Fvj+A39FXzm2ytYouzqkUthTRwKoMMm3G5JMoYyODaNYf4to2/bpQwcC4Soi4wKq8ZVD8l9PrTz3j1Tqwb+SzDZfQQL3CcD79+COnuRZvA/u64iByj7RhUnhxiUdSKY4yiDEg36gpsx7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpCCGdFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124AFC116C6;
	Tue, 21 Oct 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074549;
	bh=DvGNiH3TJD0W9B7gLTEO1yaa+ECw6zmk7FNzi/nfemc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpCCGdFR50Sd62sHmvoVeb+MctdBbcu+dVGMHgHA4bz34uJ90tVGWbvqrPh2vmeBA
	 4GPzYmj3O0t+ERsFe19wjUCAs6knOzG/G8U0K4VaP48ZEHfK4RsPWzl+mRUzSFA74t
	 S27tj7FY3z8akfIf9Jp+xZQdqPlFmNIAsbKgRI5eqSXphIP48OhxorXWgviTLhNkhz
	 32NMBVJ/hqY10NdTbL3Z6nQzGj5/JWmB3PioojYd4Wu8Ophr4DGWc4WwvilahTqMUF
	 LLRVRaIQK++uAzSTx06h9RREePl7D52eb1DeXrqaIWPlLqaVD13w06xefXo+dQzYg+
	 XXrwH6EsyrKCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] PM: EM: Move CPU capacity check to em_adjust_new_capacity()
Date: Tue, 21 Oct 2025 15:22:24 -0400
Message-ID: <20251021192225.2899605-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021192225.2899605-1-sashal@kernel.org>
References: <2025101616-gigahertz-profane-b22c@gregkh>
 <20251021192225.2899605-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 3e3ba654d3097e0031f2add215b12ff81c23814e ]

Move the check of the CPU capacity currently stored in the energy model
against the arch_scale_cpu_capacity() value to em_adjust_new_capacity()
so it will be done regardless of where the latter is called from.

This will be useful when a new em_adjust_new_capacity() caller is added
subsequently.

While at it, move the pd local variable declaration in
em_check_capacity_update() into the loop in which it is used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://patch.msgid.link/7810787.EvYhyI6sBW@rjwysocki.net
Stable-dep-of: 1ebe8f7e7825 ("PM: EM: Fix late boot with holes in CPU topology")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/energy_model.c | 40 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index a035b030ff734..2ef0a7d9d8405 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -722,10 +722,24 @@ static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
  * Adjustment of CPU performance values after boot, when all CPUs capacites
  * are correctly calculated.
  */
-static void em_adjust_new_capacity(struct device *dev,
+static void em_adjust_new_capacity(unsigned int cpu, struct device *dev,
 				   struct em_perf_domain *pd)
 {
+	unsigned long cpu_capacity = arch_scale_cpu_capacity(cpu);
 	struct em_perf_table *em_table;
+	struct em_perf_state *table;
+	unsigned long em_max_perf;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+	em_max_perf = table[pd->nr_perf_states - 1].performance;
+	rcu_read_unlock();
+
+	if (em_max_perf == cpu_capacity)
+		return;
+
+	pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n", cpu,
+		 cpu_capacity, em_max_perf);
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -741,9 +755,6 @@ static void em_adjust_new_capacity(struct device *dev,
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	struct em_perf_state *table;
-	struct em_perf_domain *pd;
-	unsigned long cpu_capacity;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
@@ -754,7 +765,7 @@ static void em_check_capacity_update(void)
 	/* Check if CPUs capacity has changed than update EM */
 	for_each_possible_cpu(cpu) {
 		struct cpufreq_policy *policy;
-		unsigned long em_max_perf;
+		struct em_perf_domain *pd;
 		struct device *dev;
 
 		if (cpumask_test_cpu(cpu, cpu_done_mask))
@@ -777,24 +788,7 @@ static void em_check_capacity_update(void)
 		cpumask_or(cpu_done_mask, cpu_done_mask,
 			   em_span_cpus(pd));
 
-		cpu_capacity = arch_scale_cpu_capacity(cpu);
-
-		rcu_read_lock();
-		table = em_perf_state_from_pd(pd);
-		em_max_perf = table[pd->nr_perf_states - 1].performance;
-		rcu_read_unlock();
-
-		/*
-		 * Check if the CPU capacity has been adjusted during boot
-		 * and trigger the update for new performance values.
-		 */
-		if (em_max_perf == cpu_capacity)
-			continue;
-
-		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
-			 cpu, cpu_capacity, em_max_perf);
-
-		em_adjust_new_capacity(dev, pd);
+		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
 	free_cpumask_var(cpu_done_mask);
-- 
2.51.0


