Return-Path: <stable+bounces-224133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDnWIxj/r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:23:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B524A8B8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81DA9323FB74
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B22BF3E2;
	Tue, 10 Mar 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAWUvPg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE2352C4F;
	Tue, 10 Mar 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141266; cv=none; b=aLjjRBUZHtsD8egKSglkM/t7hoBE++doJUQd4hg3Cn27HXvQ+oxV9eDj5UnptVpBAPM0zQ4GAu7MNxsLqJfoGEps5wuXtz83r6t/y4/x+al+XZPsGMQBtdx1yWjKKINk5da12jnXx4MBXENL62E0W/KMt9L+eujadOAG2Ak5v/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141266; c=relaxed/simple;
	bh=7fpypRrBPEoCTaITpgUhHcZJ02L8ZrMA5aL66HvtaxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBMGqZFjF5ZxEuOcbC7zt/5nlXscSVe9PTv78qaZdZXiVs29asFODGsJOmqBPOpZpJxl9nBAS5Dj81lf0CF0zwhoWof7ecxlavWt2IXccylL2Ob6JdqOkM+Z++lv3rs3ypvLfb+b1Wnrqn/nSHlHe9yhYYC3DzeiiavF2uNP06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAWUvPg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBE0C2BCB0;
	Tue, 10 Mar 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141266;
	bh=7fpypRrBPEoCTaITpgUhHcZJ02L8ZrMA5aL66HvtaxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAWUvPg2t7Pr26prn3uzLuDXPGlEhtxSPHlt2UTfxJphfmU/Y1B0+Grenf9F/kgzl
	 zVrku82vwuZQdDCzmHT8JoC569CbFsV4lziOsuxcr138MlW7kixHkCwHBBGz+T/JaN
	 /rZcLellmq8lAoEng85yr5tmmKUrPeP+mZQCKVGRQ7YA/uSbzUlfyHZG+PVKBKCyzg
	 tIRC3/MiCv9Zg0gHXYOAwdlhuEc3gIKpuiKpi4M/JqDLuEhDp/Ymdgvke2FW7XAh+X
	 CxEwPfDLwbbVgCSnkZ8kLa/4k2zXBoDBVuXxyqyrIlRf908O43Xtu9nIqo5J8yCs3j
	 AGDPJAYzELMfw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 268/311] x86/topo: Replace x86_has_numa_in_package
Date: Tue, 10 Mar 2026 07:05:15 -0400
Message-ID: <af6f2eae612ce2e1b07bdd7c29e515f229f84c76.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E0B524A8B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224133-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,amd.com:email,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 717b64d58cff6fb97f97be07e382ed7641167a56 ]

.. with the brand spanking new topology_num_nodes_per_package().

Having the topology setup determine this value during MADT/SRAT parsing before
SMP bringup avoids having to detect this situation when building the SMP
topology masks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Link: https://patch.msgid.link/20260303110100.123701837@infradead.org
Stable-dep-of: 528d89a4707e ("x86/topo: Fix SNC topology mess")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5cd6950ab672a..db3e481cdbb2e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -468,13 +468,6 @@ static int x86_cluster_flags(void)
 }
 #endif
 
-/*
- * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
- * Sub-NUMA Clustering have this.
- */
-static bool x86_has_numa_in_package;
-
 static struct sched_domain_topology_level x86_topology[] = {
 	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
@@ -496,7 +489,7 @@ static void __init build_sched_topology(void)
 	 * PKG domain since the NUMA domains will auto-magically create the
 	 * right spanning domains based on the SLIT.
 	 */
-	if (x86_has_numa_in_package) {
+	if (topology_num_nodes_per_package() > 1) {
 		unsigned int pkgdom = ARRAY_SIZE(x86_topology) - 2;
 
 		memset(&x86_topology[pkgdom], 0, sizeof(x86_topology[pkgdom]));
@@ -550,7 +543,7 @@ int arch_sched_node_distance(int from, int to)
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_ATOM_DARKMONT_X:
 
-		if (!x86_has_numa_in_package || topology_max_packages() == 1 ||
+		if (topology_max_packages() == 1 || topology_num_nodes_per_package() == 1 ||
 		    d < REMOTE_DISTANCE)
 			return d;
 
@@ -606,7 +599,7 @@ void set_cpu_sibling_map(int cpu)
 		o = &cpu_data(i);
 
 		if (match_pkg(c, o) && !topology_same_node(c, o))
-			x86_has_numa_in_package = true;
+			WARN_ON_ONCE(topology_num_nodes_per_package() == 1);
 
 		if ((i == cpu) || (has_smt && match_smt(c, o)))
 			link_mask(topology_sibling_cpumask, cpu, i);
-- 
2.51.0


