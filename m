Return-Path: <stable+bounces-226404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CbSLIOKuWkjJwIAu9opvQ
	(envelope-from <stable+bounces-226404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521B2AF021
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C61E4317EAF4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597E3F0778;
	Tue, 17 Mar 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVP6NHpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD03BFE59;
	Tue, 17 Mar 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766557; cv=none; b=dfLCmzajNv9Uj6qRfoTiAqbUJSgYqaC+TI7tRzamCaQnC0GILw4i4IRJG6HK6TWUTJpfVTbtyi6u/yCEc/ExjsyGNPR+/kLdBpA/FZhVjOVD4yBdO7eFPwjExbnOD1uB7nbEfsFAVm2u6J7LNoPwEo044kXEIAgojEJ9x1FjlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766557; c=relaxed/simple;
	bh=MswuxkEAtulPlz0YOODhc43aDu4Q3Y5YW/DONji+ZAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUgMTupg8eJtbK9SjFYZ7xHUKAv9lPlYx3yZdX3yxMslcI1UHtxXI48lcn3xYko+MqcYusIYPy4qLvICuHZ/xIcV+xSUkCrPh8KaGii9WSpHc7flrMj/XL2KwjB8TPQ5WMHC2lGupXPkgMcAYaOpw2ecGr0FnGEmuium4j1mCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVP6NHpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211ADC4CEF7;
	Tue, 17 Mar 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766557;
	bh=MswuxkEAtulPlz0YOODhc43aDu4Q3Y5YW/DONji+ZAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVP6NHpCJfNuo3tltb4K8B3wzfzdueSHLXqaDK8sXznnH/ohtEoebEAGVB8AnRBXf
	 7j9/++wAFy23ZVR8JBxbQAser4sTfe53dnLu5GhMYNBoWvMpn8KcutHX+uOeBZe7dj
	 qPgGG7zT35paZtAc3PEnvL/RnhRhUtEH9HZivAhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.19 239/378] sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
Date: Tue, 17 Mar 2026 17:33:16 +0100
Message-ID: <20260317163015.807328123@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226404-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4521B2AF021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 83236b2e43dba00bee5b82eb5758816b1a674f6a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4390,10 +4390,19 @@ done:
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
 
@@ -4416,6 +4425,7 @@ static void scx_disable(enum scx_exit_ki
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
+		guard(preempt)();
 		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
@@ -4738,6 +4748,8 @@ static bool scx_vexit(struct scx_sched *
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
+	guard(preempt)();
+
 	if (!scx_claim_exit(sch, kind))
 		return false;
 



