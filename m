Return-Path: <stable+bounces-214564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLhAEMcLhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:29:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBCF7A68
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0C93040760
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0AC33122C;
	Thu,  5 Feb 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gf2+AAxu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A6331A41;
	Thu,  5 Feb 2026 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326838; cv=none; b=jw3gqifJVwCKA6uxiSpnAwsNCrygdgfhfhAsPsF/+AZUqWm1DtjY1G53vOAW0PDQT/0gXZ1D27czVQ7YKin0wn+FuwCHFH/xkOKbhrNBQuoVaXbEoU6LWh6P8MwpzLoQOQmZYY+RUxCNxAWiMMvPgEjTExU1duhU6zPgQ5Qe/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326838; c=relaxed/simple;
	bh=NWrTPZOFlr6x2yxpIgAuRviSFNZBnl3Tc4TgBPhPdiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7AdOvW3o2L4YNI9fBwU0Vf7iiSfYxnGGeHpIKaNPxdD2KQEJ0w/xAyz07DomaBJg50Ok1U06egLvV4hu4087ixBsiPzUTH99fXyGXCqRYmN/NjmrIJFBuCToQtrj7Fqu7zjCMOKlMwlH06Bqubc/cGcntAQAnoRIPzNoLn/GA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gf2+AAxu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326838; x=1801862838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWrTPZOFlr6x2yxpIgAuRviSFNZBnl3Tc4TgBPhPdiU=;
  b=gf2+AAxu45YMrvNlNC1BSOmyYfBMV8PkPI9zy+c1HjyrGDPg177/0gL2
   ObuWyLdgtH67P7SrTd6KYTrIAq9hX1BdC6E+raUaWvHI6rEJA67u/jmRR
   6GRWqqVqQK/xB+07Tk8jI55DjJF3K4EnhAhkvbahOb2LY8nZDno0FCuKu
   L22D8a2zij5n7Nu9uO8rBMZSyni1P8izBta8EvZNPXuwVYoVHErY3Tb6J
   FqbwGz+pzOlAOxMIXEWon20CY4RVyrHq7D0eZagG2GK+cPtj5S1D287II
   PaGwV+ZeI8MViJ2iYFSMU8MVx3jtxPphVoOKHnUPZV5oHEnwIuTVgHKaR
   A==;
X-CSE-ConnectionGUID: zVTiXZxeTM+LJsc+Eyag8g==
X-CSE-MsgGUID: KCsCjUeDQYqEPfYBi91sPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75386238"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="75386238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:27:18 -0800
X-CSE-ConnectionGUID: ImH2EQZIRTmi6Y/3kt8v1g==
X-CSE-MsgGUID: USDARmWSS0+BLRsggv2efw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233617382"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 13:27:17 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 6.18 1/2] sched: Create architecture specific sched domain distances
Date: Thu,  5 Feb 2026 13:33:33 -0800
Message-Id: <185f0a2768d139eae4fac27ab8862bc4868f11ae.1768948644.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1768948644.git.tim.c.chen@linux.intel.com>
References: <cover.1768948644.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214564-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2CBCF7A68
X-Rspamd-Action: no action

[ Upstream commit 06f2c90885e92992d1ce55d3f35b65b44d5ecc25 ]

Allow architecture specific sched domain NUMA distances that are
modified from actual NUMA node distances for the purpose of building
NUMA sched domains.

Keep actual NUMA distances separately if modified distances
are used for building sched domains. Such distances
are still needed as NUMA balancing benefits from finding the
NUMA nodes that are actually closer to a task numa_group.

Consolidate the recording of unique NUMA distances in an array to
sched_record_numa_dist() so the function can be reused to record NUMA
distances when the NUMA distance metric is changed.

No functional change and additional distance array
allocated if there're no arch specific NUMA distances
being defined.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/topology.c | 108 ++++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 444bdfdab731..711076aa4980 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1590,10 +1590,17 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 #ifdef CONFIG_NUMA
 enum numa_topology_type sched_numa_topology_type;
 
+/*
+ * sched_domains_numa_distance is derived from sched_numa_node_distance
+ * and provides a simplified view of NUMA distances used specifically
+ * for building NUMA scheduling domains.
+ */
 static int			sched_domains_numa_levels;
+static int			sched_numa_node_levels;
 
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
+static int			*sched_numa_node_distance;
 static struct cpumask		***sched_domains_numa_masks;
 #endif /* CONFIG_NUMA */
 
@@ -1845,10 +1852,10 @@ bool find_numa_distance(int distance)
 		return true;
 
 	rcu_read_lock();
-	distances = rcu_dereference(sched_domains_numa_distance);
+	distances = rcu_dereference(sched_numa_node_distance);
 	if (!distances)
 		goto unlock;
-	for (i = 0; i < sched_domains_numa_levels; i++) {
+	for (i = 0; i < sched_numa_node_levels; i++) {
 		if (distances[i] == distance) {
 			found = true;
 			break;
@@ -1924,14 +1931,34 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
-void sched_init_numa(int offline_node)
+/*
+ * An architecture could modify its NUMA distance, to change
+ * grouping of NUMA nodes and number of NUMA levels when creating
+ * NUMA level sched domains.
+ *
+ * A NUMA level is created for each unique
+ * arch_sched_node_distance.
+ */
+static int numa_node_dist(int i, int j)
 {
-	struct sched_domain_topology_level *tl;
-	unsigned long *distance_map;
+	return node_distance(i, j);
+}
+
+int arch_sched_node_distance(int from, int to)
+			     __weak __alias(numa_node_dist);
+
+static bool modified_sched_node_distance(void)
+{
+	return numa_node_dist != arch_sched_node_distance;
+}
+
+static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
+				  int **dist, int *levels)
+{
+	unsigned long *distance_map __free(bitmap) = NULL;
 	int nr_levels = 0;
 	int i, j;
 	int *distances;
-	struct cpumask ***masks;
 
 	/*
 	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
@@ -1939,17 +1966,16 @@ void sched_init_numa(int offline_node)
 	 */
 	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
 	if (!distance_map)
-		return;
+		return -ENOMEM;
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for_each_cpu_node_but(i, offline_node) {
 		for_each_cpu_node_but(j, offline_node) {
-			int distance = node_distance(i, j);
+			int distance = n_dist(i, j);
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
-				bitmap_free(distance_map);
-				return;
+				return -EINVAL;
 			}
 
 			bitmap_set(distance_map, distance, 1);
@@ -1962,18 +1988,46 @@ void sched_init_numa(int offline_node)
 	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
 
 	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!distances) {
-		bitmap_free(distance_map);
-		return;
-	}
+	if (!distances)
+		return -ENOMEM;
 
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
 		distances[i] = j;
 	}
-	rcu_assign_pointer(sched_domains_numa_distance, distances);
+	*dist = distances;
+	*levels = nr_levels;
+
+	return 0;
+}
+
+void sched_init_numa(int offline_node)
+{
+	struct sched_domain_topology_level *tl;
+	int nr_levels, nr_node_levels;
+	int i, j;
+	int *distances, *domain_distances;
+	struct cpumask ***masks;
 
-	bitmap_free(distance_map);
+	/* Record the NUMA distances from SLIT table */
+	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
+				   &nr_node_levels))
+		return;
+
+	/* Record modified NUMA distances for building sched domains */
+	if (modified_sched_node_distance()) {
+		if (sched_record_numa_dist(offline_node, arch_sched_node_distance,
+					   &domain_distances, &nr_levels)) {
+			kfree(distances);
+			return;
+		}
+	} else {
+		domain_distances = distances;
+		nr_levels = nr_node_levels;
+	}
+	rcu_assign_pointer(sched_numa_node_distance, distances);
+	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
+	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
 
 	/*
 	 * 'nr_levels' contains the number of unique distances
@@ -1991,6 +2045,8 @@ void sched_init_numa(int offline_node)
 	 *
 	 * We reset it to 'nr_levels' at the end of this function.
 	 */
+	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
+
 	sched_domains_numa_levels = 0;
 
 	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
@@ -2016,10 +2072,13 @@ void sched_init_numa(int offline_node)
 			masks[i][j] = mask;
 
 			for_each_cpu_node_but(k, offline_node) {
-				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
+				if (sched_debug() &&
+				    (arch_sched_node_distance(j, k) !=
+				     arch_sched_node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				if (arch_sched_node_distance(j, k) >
+				    sched_domains_numa_distance[i])
 					continue;
 
 				cpumask_or(mask, mask, cpumask_of_node(k));
@@ -2059,7 +2118,6 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
 
 	init_numa_topology_type(offline_node);
 }
@@ -2067,14 +2125,18 @@ void sched_init_numa(int offline_node)
 
 static void sched_reset_numa(void)
 {
-	int nr_levels, *distances;
+	int nr_levels, *distances, *dom_distances = NULL;
 	struct cpumask ***masks;
 
 	nr_levels = sched_domains_numa_levels;
+	sched_numa_node_levels = 0;
 	sched_domains_numa_levels = 0;
 	sched_max_numa_distance = 0;
 	sched_numa_topology_type = NUMA_DIRECT;
-	distances = sched_domains_numa_distance;
+	distances = sched_numa_node_distance;
+	if (sched_numa_node_distance != sched_domains_numa_distance)
+		dom_distances = sched_domains_numa_distance;
+	rcu_assign_pointer(sched_numa_node_distance, NULL);
 	rcu_assign_pointer(sched_domains_numa_distance, NULL);
 	masks = sched_domains_numa_masks;
 	rcu_assign_pointer(sched_domains_numa_masks, NULL);
@@ -2083,6 +2145,7 @@ static void sched_reset_numa(void)
 
 		synchronize_rcu();
 		kfree(distances);
+		kfree(dom_distances);
 		for (i = 0; i < nr_levels && masks; i++) {
 			if (!masks[i])
 				continue;
@@ -2129,7 +2192,8 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 				continue;
 
 			/* Set ourselves in the remote node's masks */
-			if (node_distance(j, node) <= sched_domains_numa_distance[i])
+			if (arch_sched_node_distance(j, node) <=
+			    sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
 	}
-- 
2.32.0


