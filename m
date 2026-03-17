Return-Path: <stable+bounces-226767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHr9HDWOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:24:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAB2AF7D9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 948213050CA2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FE26561A;
	Tue, 17 Mar 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh76FciQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEB21D5B0
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768115; cv=none; b=u34BlBdY3IlFsC7qE3TRxaOralMB2uZFPaNsbPAxN2hodjb7LZIN3Fkg9RSBD6Pm8lSCp6Nrau9iik4R6Hg6CpGdj7efm2JgF6H1B/5/bpoQdsmLRbqzVtN8RK6d3Gzo+jepxm59efLd6UFkKXpne+1GtKtlAuzC0rypMX5Ctq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768115; c=relaxed/simple;
	bh=KEepDmj13mgjR6mpMdfctSF7L/2p9WNhIY3oNAEYRXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTDne+oziEs0kNAAONpvSprTM8Fx3txhpUdazf1rN2waM44L/oKYghj1MZAlY9f4kWJuV7lP6yrWiI43sA4pnnYeIczilryBhjtrSU4/fdqiYB0ykmiGsv5aAxEHWwwO7LAgFrta8sgKTVNrK9Vy3xtORqvKMj2kkm6jVUAbzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh76FciQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B7C2BCB0;
	Tue, 17 Mar 2026 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768115;
	bh=KEepDmj13mgjR6mpMdfctSF7L/2p9WNhIY3oNAEYRXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jh76FciQi/ORB5A2T8sfspBTgDpa6/nyG3iOZ2mWOMc8/eYsxA03coZCaBv801rfF
	 paUuKy44Na5D3CUsTtF30XCG+4IRkHWfeX9T6o6QROmelG3cdYJOUmyLKWggk0Pxje
	 JTONJ1f9OeNkgbDOslzqmSbfjtFlAT0JXsXiKpdCbnHQ0C7+P9ANky9eFVgyBcMVpZ
	 vG57a5/mCAfXXzjdzGBgmSoMICgr+UlwbhFkMsa0HpX28lx3CA+hDJWO4UftaVB+Z1
	 BGufuzwHNWz6SkKZmJjW0h/4P20vFgOtEpfebWaNts0bobs6obuKxgTFFhnAMhpXTB
	 pFhURC1PCCaJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
Date: Tue, 17 Mar 2026 13:21:52 -0400
Message-ID: <20260317172152.239864-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317172152.239864-1-sashal@kernel.org>
References: <2026031736-mystify-skating-036b@gregkh>
 <20260317172152.239864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226767-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47EAB2AF7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 83236b2e43dba00bee5b82eb5758816b1a674f6a ]

scx_claim_exit() atomically sets exit_kind, which prevents scx_error() from
triggering further error handling. After claiming exit, the caller must kick
the helper kthread work which initiates bypass mode and teardown.

If the calling task gets preempted between claiming exit and kicking the
helper work, and the BPF scheduler fails to schedule it back (since error
handling is now disabled), the helper work is never queued, bypass mode
never activates, tasks stop being dispatched, and the system wedges.

Disable preemption across scx_claim_exit() and the subsequent work kicking
in all callers - scx_disable() and scx_vexit(). Add
lockdep_assert_preemption_disabled() to scx_claim_exit() to enforce the
requirement.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a10344f00411d..e565e622cd5ca 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4068,10 +4068,19 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_bypass(false);
 }
 
+/*
+ * Claim the exit on @sch. The caller must ensure that the helper kthread work
+ * is kicked before the current task can be preempted. Once exit_kind is
+ * claimed, scx_error() can no longer trigger, so if the current task gets
+ * preempted and the BPF scheduler fails to schedule it back, the helper work
+ * will never be kicked and the whole system can wedge.
+ */
 static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
 
+	lockdep_assert_preemption_disabled();
+
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
@@ -4094,6 +4103,7 @@ static void scx_disable(enum scx_exit_kind kind)
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
+		guard(preempt)();
 		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
@@ -4416,6 +4426,8 @@ static void scx_vexit(struct scx_sched *sch,
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
+	guard(preempt)();
+
 	if (!scx_claim_exit(sch, kind))
 		return;
 
-- 
2.51.0


