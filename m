Return-Path: <stable+bounces-214565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKoSEesLhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:30:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A416FF7A86
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0ACD304972B
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D237331A7B;
	Thu,  5 Feb 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0w0d1jl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C83314B6;
	Thu,  5 Feb 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326839; cv=none; b=KmKivKGd/gj+2zocveOSTtWP0cBEUU/o41GacsRB8AnvSNHwEQqbDxZ+2M5H/fPK0rg0r0wRi/obTKRA6Z8v5fi2yTB7zHHUznXAD8BYRZ7xNEyFNLuIjzHl5T3ePs51nnhESWbKx9rtckIyy0wY9k5V8HqVvfIbavZO+Vb/XW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326839; c=relaxed/simple;
	bh=xNQkaxGsTCbWDl52Vkp0iBpPK4UvLflBEiUVAMUzD6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ll2t2CkEhARQ2Q58gIRAVl7jVI2z9Brvhg0VbfanOXV2uxJIAqt3wbFj1bhrmcBrcpI1BlIdYnz3fT1ROn1ULqP6yoDhw8SzNfmdjYQQD0dJAVbMbWNXbm5rbUPYukHda5llBuXMb2Ij4IWz5ULro+EuuNQ0h9UrOQs5M/aO6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0w0d1jl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326840; x=1801862840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNQkaxGsTCbWDl52Vkp0iBpPK4UvLflBEiUVAMUzD6I=;
  b=J0w0d1jlribZsHS4vm8Rhx5cB2rGPoIoZysTrkRAPJNFuKi+7r2Gxmr6
   k4mMGo7Zqj5HrADfZuw97oUywVUmF5U2AFYWOFfi6brtTPycO6dmQg8Se
   N+6uwayoR3GWAUoK3mWGKyP/G1JRZe09XgULf3jyphwpaTzHlfdfV3cuo
   FhbSzELhotxSrAYQIFv12NDmpxhFdy1kBqBLmG9ibMqhJsT9ILOZSXYRn
   DBXm47OWUMX3kPbHcC/TN/HfpVKI6bvA9dVu7fnGTvQP6JQXe5/yPiYYV
   gEYR3pgJDwkAMeNDV1icKzIpEBVh+jeuEOXTZIqUNXcRg5bGKQFkrsfGJ
   g==;
X-CSE-ConnectionGUID: IC83O4KNT5K1WH8OkNZv4w==
X-CSE-MsgGUID: 7XD+8PV6TNmPaL24iOzsgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75386252"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="75386252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:27:19 -0800
X-CSE-ConnectionGUID: AM2sskbETVyFnCk4RIEMqg==
X-CSE-MsgGUID: BKWtdomuRgeoqSKv1gt/kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233617393"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 13:27:18 -0800
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
Subject: [PATCH 6.18 2/2] sched/topology: Fix sched domain build error for GNR, CWF in SNC-3 mode
Date: Thu,  5 Feb 2026 13:33:34 -0800
Message-Id: <741531fc98d3c3d364451113b26c4900a868348a.1768948644.git.tim.c.chen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214565-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,infradead.org:email]
X-Rspamd-Queue-Id: A416FF7A86
X-Rspamd-Action: no action

[ Upstream commit 4d6dd05d07d00bc3bd91183dab4d75caa8018db9 ]

It is possible for Granite Rapids (GNR) and Clearwater Forest
(CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
is enabled, each die will become a separate NUMA node in the package
with different distances between dies within the same package.

For example, on GNR, we see the following numa distances for a 2 socket
system with 3 dies per socket:

    package 1       package2
	----------------
	|               |
    ---------       ---------
    |   0   |       |   3   |
    ---------       ---------
	|               |
    ---------       ---------
    |   1   |       |   4   |
    ---------       ---------
	|               |
    ---------       ---------
    |   2   |       |   5   |
    ---------       ---------
	|               |
	----------------

node distances:
node     0    1    2    3    4    5
0:   	10   15   17   21   28   26
1:   	15   10   15   23   26   23
2:   	17   15   10   26   23   21
3:   	21   28   26   10   15   17
4:   	23   26   23   15   10   15
5:   	26   23   21   17   15   10

The node distances above led to 2 problems:

1. Asymmetric routes taken between nodes in different packages led to
asymmetric scheduler domain perspective depending on which node you
are on.  Current scheduler code failed to build domains properly with
asymmetric distances.

2. Multiple remote distances to respective tiles on remote package create
too many levels of domain hierarchies grouping different nodes between
remote packages.

For example, the above GNR topology lead to NUMA domains below:

Sched domains from the perspective of a CPU in node 0, where the number
in bracket represent node number.

NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3]
NUMA-level 3    [0,1,2,3] [5]
NUMA-level 4    [0,1,2,3,5] [4]

Sched domains from the perspective of a CPU in node 4
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,2]
NUMA-level 3    [0,2,3,4,5] [1]

Scheduler group peers for load balancing from the perspective of CPU 0
and 4 are different.  Improper task could be chosen for load balancing
between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
in 0 or 2 that are in same package as node 1 first.  But instead tasks
in the remote package node 3, 4, 5 could be chosen with an equal chance
and could lead to excessive remote package migrations and imbalance of
load between packages.  We should not group partial remote nodes and
local nodes together.
Simplify the remote distances for CWF and GNR for the purpose of
sched domains building, which maintains symmetry and leads to a more
reasonable load balance hierarchy.

The sched domains from the perspective of a CPU in node 0 NUMA-level 1
is now
NUMA-level 1    [0,1] [2]
NUMA-level 2    [0,1,2] [3,4,5]

The sched domains from the perspective of a CPU in node 4 NUMA-level 1
is now
NUMA-level 1    [4] [3,5]
NUMA-level 2    [3,4,5] [0,1,2]

We have the same balancing perspective from node 0 or node 4.  Loads are
now balanced equally between packages.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
---
 arch/x86/kernel/smpboot.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289abece23..5709c9cab195 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -515,6 +515,76 @@ static void __init build_sched_topology(void)
 	set_sched_topology(topology);
 }
 
+#ifdef CONFIG_NUMA
+static int sched_avg_remote_distance;
+static int avg_remote_numa_distance(void)
+{
+	int i, j;
+	int distance, nr_remote, total_distance;
+
+	if (sched_avg_remote_distance > 0)
+		return sched_avg_remote_distance;
+
+	nr_remote = 0;
+	total_distance = 0;
+	for_each_node_state(i, N_CPU) {
+		for_each_node_state(j, N_CPU) {
+			distance = node_distance(i, j);
+
+			if (distance >= REMOTE_DISTANCE) {
+				nr_remote++;
+				total_distance += distance;
+			}
+		}
+	}
+	if (nr_remote)
+		sched_avg_remote_distance = total_distance / nr_remote;
+	else
+		sched_avg_remote_distance = REMOTE_DISTANCE;
+
+	return sched_avg_remote_distance;
+}
+
+int arch_sched_node_distance(int from, int to)
+{
+	int d = node_distance(from, to);
+
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_ATOM_DARKMONT_X:
+
+		if (!x86_has_numa_in_package || topology_max_packages() == 1 ||
+		    d < REMOTE_DISTANCE)
+			return d;
+
+		/*
+		 * With SNC enabled, there could be too many levels of remote
+		 * NUMA node distances, creating NUMA domain levels
+		 * including local nodes and partial remote nodes.
+		 *
+		 * Trim finer distance tuning for NUMA nodes in remote package
+		 * for the purpose of building sched domains. Group NUMA nodes
+		 * in the remote package in the same sched group.
+		 * Simplify NUMA domains and avoid extra NUMA levels including
+		 * different remote NUMA nodes and local nodes.
+		 *
+		 * GNR and CWF don't expect systems with more than 2 packages
+		 * and more than 2 hops between packages. Single average remote
+		 * distance won't be appropriate if there are more than 2
+		 * packages as average distance to different remote packages
+		 * could be different.
+		 */
+		WARN_ONCE(topology_max_packages() > 2,
+			  "sched: Expect only up to 2 packages for GNR or CWF, "
+			  "but saw %d packages when building sched domains.",
+			  topology_max_packages());
+
+		d = avg_remote_numa_distance();
+	}
+	return d;
+}
+#endif /* CONFIG_NUMA */
+
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = __max_threads_per_core > 1;
-- 
2.32.0


