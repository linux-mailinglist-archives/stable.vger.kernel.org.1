Return-Path: <stable+bounces-226766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB9wIGeTuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8172B01B6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B38A30624C1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD773176FD;
	Tue, 17 Mar 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKDNM+2l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458A2D73B8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768114; cv=none; b=g8TwRvV6FZAItHdOEl3jSINaV6O/OvRTTq3KWLAuiBPalvruv5GV8W5GlQio4TUwq6G170VpjnX4UMqxR/hsFw1k+3dOr9SkxZe4kTFc7asN/X75bZQa9q+h2v3j6yfnAS/v2nxCOYfh95OdLJDXepLWIFYwsm/2Yaikrn18fSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768114; c=relaxed/simple;
	bh=jCCM4tW2YQfvY57eumB6RF4aKmABUH84OqsIEJt7r9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnqOfZCz6TX3kukNKP00blaM4ZQZyT9HAPVrbEJ0FjnRn5SuYcZ/n9CkqXA9HdakY6j+vUi1SaQt7FvL+pzpTZ2Ux0wBBFhZP29uK/HNrzUZa0r/AiPGK2d+tH6izbExrKSRw2iPok0q/BIhL9/bfMq/G/6qJN6MIGyUzWpHREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKDNM+2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A541C4CEF7;
	Tue, 17 Mar 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768114;
	bh=jCCM4tW2YQfvY57eumB6RF4aKmABUH84OqsIEJt7r9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKDNM+2lu+3Iz/Y1Ke+F8Dgxfco5EapuLu7iS17U4b6PBvV6RMJahvROfzQCLpDqY
	 It3QrsdnUN7ueng8ZJ5U8vKNSwG2S+gaP/Jr2QqjH6ntEtIZEveqJ0coYryTv9LsjN
	 M+cX6W10pSvH1a35MTcMtiBCCGY0JaCsOvCu8LdlS2jVNlLNkDRenN+DMB6gISsaxd
	 Y/HimUwRB03HEhvGXkmSOZRCjgxJfR3vOBoZPgykW1NBYan+S3hXLc251PJm43h/Z5
	 itRG/4hqhYu2dxxybLJ6PdMquvtlib1CRjM5tAUTlGqjvo60MMOFqOkBS/XK9JUebJ
	 a2JnKWLocx1tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] sched_ext: Simplify breather mechanism with scx_aborting flag
Date: Tue, 17 Mar 2026 13:21:51 -0400
Message-ID: <20260317172152.239864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031736-mystify-skating-036b@gregkh>
References: <2026031736-mystify-skating-036b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,etsalapatis.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226766-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,etsalapatis.com:email]
X-Rspamd-Queue-Id: 9B8172B01B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit a69040ed57f50156e5452474d25c79b9e62075d0 ]

The breather mechanism was introduced in 62dcbab8b0ef ("sched_ext: Avoid
live-locking bypass mode switching") and e32c260195e6 ("sched_ext: Enable the
ops breather and eject BPF scheduler on softlockup") to prevent live-locks by
injecting delays when CPUs are trapped in dispatch paths.

Currently, it uses scx_breather_depth (atomic_t) and scx_in_softlockup
(unsigned long) with separate increment/decrement and cleanup operations. The
breather is only activated when aborting, so tie it directly to the exit
mechanism. Replace both variables with scx_aborting flag set when exit is
claimed and cleared after bypass is enabled. Introduce scx_claim_exit() to
consolidate exit_kind claiming and breather enablement. This eliminates
scx_clear_softlockup() and simplifies scx_softlockup() and scx_bypass().

The breather mechanism will be replaced by a different abort mechanism in a
future patch. This simplification prepares for that change.

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 83236b2e43db ("sched_ext: Disable preemption between scx_claim_exit() and kicking helper work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 54 +++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2ff7034841c7c..a10344f00411d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -33,9 +33,8 @@ static DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
-static unsigned long scx_in_softlockup;
-static atomic_t scx_breather_depth = ATOMIC_INIT(0);
 static int scx_bypass_depth;
+static bool scx_aborting;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -1792,7 +1791,7 @@ static void scx_breather(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (likely(!atomic_read(&scx_breather_depth)))
+	if (likely(!READ_ONCE(scx_aborting)))
 		return;
 
 	raw_spin_rq_unlock(rq);
@@ -1801,9 +1800,9 @@ static void scx_breather(struct rq *rq)
 
 	do {
 		int cnt = 1024;
-		while (atomic_read(&scx_breather_depth) && --cnt)
+		while (READ_ONCE(scx_aborting) && --cnt)
 			cpu_relax();
-	} while (atomic_read(&scx_breather_depth) &&
+	} while (READ_ONCE(scx_aborting) &&
 		 time_before64(ktime_get_ns(), until));
 
 	raw_spin_rq_lock(rq);
@@ -3720,30 +3719,14 @@ void scx_softlockup(u32 dur_s)
 		goto out_unlock;
 	}
 
-	/* allow only one instance, cleared at the end of scx_bypass() */
-	if (test_and_set_bit(0, &scx_in_softlockup))
-		goto out_unlock;
-
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
 			smp_processor_id(), dur_s, scx_root->ops.name);
 
-	/*
-	 * Some CPUs may be trapped in the dispatch paths. Enable breather
-	 * immediately; otherwise, we might even be able to get to scx_bypass().
-	 */
-	atomic_inc(&scx_breather_depth);
-
 	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
 out_unlock:
 	rcu_read_unlock();
 }
 
-static void scx_clear_softlockup(void)
-{
-	if (test_and_clear_bit(0, &scx_in_softlockup))
-		atomic_dec(&scx_breather_depth);
-}
-
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
@@ -3804,8 +3787,6 @@ static void scx_bypass(bool bypass)
 				      ktime_get_ns() - bypass_timestamp);
 	}
 
-	atomic_inc(&scx_breather_depth);
-
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_rq_bypassing()
@@ -3862,10 +3843,8 @@ static void scx_bypass(bool bypass)
 		raw_spin_rq_unlock(rq);
 	}
 
-	atomic_dec(&scx_breather_depth);
 unlock:
 	raw_spin_unlock_irqrestore(&bypass_lock, flags);
-	scx_clear_softlockup();
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
@@ -3960,6 +3939,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
+	WRITE_ONCE(scx_aborting, false);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
 	case SCX_DISABLING:
@@ -4088,9 +4068,24 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_bypass(false);
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
+
+	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+		return false;
+
+	/*
+	 * Some CPUs may be trapped in the dispatch paths. Enable breather
+	 * immediately; otherwise, we might not even be able to get to
+	 * scx_bypass().
+	 */
+	WRITE_ONCE(scx_aborting, true);
+	return true;
+}
+
+static void scx_disable(enum scx_exit_kind kind)
+{
 	struct scx_sched *sch;
 
 	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
@@ -4099,7 +4094,7 @@ static void scx_disable(enum scx_exit_kind kind)
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
-		atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
+		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
 	rcu_read_unlock();
@@ -4420,9 +4415,8 @@ static void scx_vexit(struct scx_sched *sch,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
-	int none = SCX_EXIT_NONE;
 
-	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+	if (!scx_claim_exit(sch, kind))
 		return;
 
 	ei->exit_code = exit_code;
@@ -4637,6 +4631,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
 	WARN_ON_ONCE(scx_root);
+	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
+		WRITE_ONCE(scx_aborting, false);
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
-- 
2.51.0


