Return-Path: <stable+bounces-214561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KzJDt8KhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:25:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F03F79D6
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E29A3011C75
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45608330D5E;
	Thu,  5 Feb 2026 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj+UODwD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF0330B3B
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326749; cv=none; b=jVZCC8eVvR8eKXvqRi1T3poTAW1vHaLu9NxyidzUHbcgkoroD7aInXvjW0HxyYwToDu1IBviBziffqlGXjUedxIvN3x2ANYn24+pxVgr5NXTGULC5BfK5j6WA6EH/L6zSv0EN/zonOwdsy0lJjYqEOMY7PzCMD4RpsFtafaxehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326749; c=relaxed/simple;
	bh=7DeVgYsJMTNxyZtSxtHDEJD+67uU3KbN8L7Aw1Mn5qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjWAOaSc1rR6By6G2W2HrZVzcg06qlPAHd+jOkJ14cb7Q169sMjt9HdWhTdzP/pHsyW7UdkpDZ6JEDsdnA+bWsMMKIiT9aqpI4s3XuMBM3UaUBJoJkbA8YrYoVnnFg+X0CWwZEBsJlo1FNT42lJ5v7Q903sQvtk1VPPT3rgrc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hj+UODwD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326749; x=1801862749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DeVgYsJMTNxyZtSxtHDEJD+67uU3KbN8L7Aw1Mn5qg=;
  b=Hj+UODwDXaJJWoTvBqgveBsmxz/MOMY+M+WMLs0uMNx2tzQd0iAA+I0R
   Y0Bt/HYgeQ8Bts91oXcstNeZnuICkRZF1i39wION7gxdsUz5R/xh8iI9i
   RoUr4llEPkN2eMvDfvb4eYPAIoNDcgelKmJF+Tkq1wXd6nQD8VpgLnDMh
   TMTi6vpM5/fEo2rIgHWLVVp/eQ3IwEfZrzEN4n7XkUWoATJKA7DqtuR2Z
   MxwQLPm5nucBDxqA6+hdqALvqVaZGozPmB+oVJRMsppuc+WE0BtfsZctK
   3JOuI1SazK87IW4YyKUYznf68/Iw9TsSrQUPx2lO9xaNSioYF+lEdM+vE
   g==;
X-CSE-ConnectionGUID: dy4Jjj9JTTqGXIcGlkiHQw==
X-CSE-MsgGUID: aWRe46pkQYGfBi9zPW3ncQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71529161"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71529161"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:25:49 -0800
X-CSE-ConnectionGUID: YN8KrGNAT4mAYM1tbmfzjA==
X-CSE-MsgGUID: 55NPOd5xQ7urPq+EstpDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215175685"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2026 13:25:48 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	nathan@kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH 6.18 1/2] sched/fair: Skip sched_balance_running cmpxchg when balance is not due
Date: Thu,  5 Feb 2026 13:31:56 -0800
Message-Id: <1a6a130997912731445fce93a37b2bcbac58a24d.1770326432.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1770326432.git.tim.c.chen@linux.intel.com>
References: <cover.1770326432.git.tim.c.chen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214561-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.c.chen@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,intel.com:email,intel.com:dkim,infradead.org:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: A8F03F79D6
X-Rspamd-Action: no action

[Upstream commit 3324b2180c17b21c31c16966cc85ca41a7c93703]

The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
only one NUMA load balancing operation to run system-wide at a time.

Currently, each sched group leader directly under NUMA domain attempts
to acquire the global sched_balance_running flag via cmpxchg() before
checking whether load balancing is due or whether it is the designated
load balancer for that NUMA domain. On systems with a large number
of cores, this causes significant cache contention on the shared
sched_balance_running flag.

This patch reduces unnecessary cmpxchg() operations by first checking
that the balancer is the designated leader for a NUMA domain from
should_we_balance(), and the balance interval has expired before
trying to acquire sched_balance_running to load balance a NUMA
domain.

On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
running an OLTP workload, 7.8% of total CPU cycles were previously spent
in sched_balance_domain() contending on sched_balance_running before
this change.

         : 104              static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
         : 105              {
         : 106              return arch_cmpxchg(&v->counter, old, new);
    0.00 :   ffffffff81326e6c:       xor    %eax,%eax
    0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
    0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip)        # ffffffff836bb010 <sched_balance_running>
         : 110              sched_balance_domains():
         : 12234            if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
   99.39 :   ffffffff81326e7b:       test   %eax,%eax
    0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_balance_domains+0x209>
         : 12238            if (time_after_eq(jiffies, sd->last_balance + interval)) {
    0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax        # ffffffff828099c0 <jiffies_64>
    0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
    0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax

After applying this fix, sched_balance_domain() is gone from the profile
and there is a 5% throughput improvement.

[peterz: made it so that redo retains the 'lock' and split out the
         CPU_NEWLY_IDLE change to a separate patch]
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b752324270b..3bf1bfd31877 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11729,6 +11729,21 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
 	}
 }
 
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11754,6 +11769,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
+	bool need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
@@ -11765,6 +11781,14 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
+	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle != CPU_NEWLY_IDLE) {
+		int zero = 0;
+		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, &zero, 1))
+			goto out_balanced;
+
+		need_unlock = true;
+	}
+
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -12005,6 +12029,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
+	if (need_unlock)
+		atomic_set_release(&sched_balance_running, 0);
+
 	return ld_moved;
 }
 
@@ -12129,21 +12156,6 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
-/*
- * This flag serializes load-balancing passes over large domains
- * (above the NODE topology level) - only one load-balancing instance
- * may run at a time, to reduce overhead on very large systems with
- * lots of CPUs and large NUMA distances.
- *
- * - Note that load-balancing passes triggered while another one
- *   is executing are skipped and not re-tried.
- *
- * - Also note that this does not serialize rebalance_domains()
- *   execution, as non-SD_SERIALIZE domains will still be
- *   load-balanced in parallel.
- */
-static atomic_t sched_balance_running = ATOMIC_INIT(0);
-
 /*
  * Scale the max sched_balance_rq interval with the number of CPUs in the system.
  * This trades load-balance latency on larger machines for less cross talk.
@@ -12199,7 +12211,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
+	int need_decay = 0;
 	u64 max_cost = 0;
 
 	rcu_read_lock();
@@ -12223,13 +12235,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		}
 
 		interval = get_sd_balance_interval(sd, busy);
-
-		need_serialize = sd->flags & SD_SERIALIZE;
-		if (need_serialize) {
-			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
-				goto out;
-		}
-
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
@@ -12243,9 +12248,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
 		}
-		if (need_serialize)
-			atomic_set_release(&sched_balance_running, 0);
-out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
 			update_next_balance = 1;
-- 
2.32.0


