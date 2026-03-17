Return-Path: <stable+bounces-226929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBX5AJDouWntPQIAu9opvQ
	(envelope-from <stable+bounces-226929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:49:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 089CC2B4764
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D395F3004606
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BBB3A4F44;
	Tue, 17 Mar 2026 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3SGl89X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47C2868A7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791369; cv=none; b=lzlANOUVMwAR8grsZKHJHTpwzlniAMKJ6jfKIY2CXhXeUyLcsZiNV8JCHFeGUjsF5Y7vMLpCayfpoemYO0+nznM+IUc81rTCHZ95gOE7S+W1Ce6R3shM5LfPK1yNo3H0z5ZroJty5OFDFgv13B0gjKBdJAeJkBZh/tW7F+H6Csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791369; c=relaxed/simple;
	bh=B5zX/btelmPrPxeLmOad9yHj3k9hJHtToQC7+6gjHfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzPAf61HZHtSRZbIzBIs96mumPGmajFakpM7SPIdGgb/AxlPKEdPL1iMVeX84kN6n6+e4AAsZ1vCRf9gsn8TTuJOAai3I+8FORVjcPiSCcSjM0IJHJS8oBu1JEDM4FJ1L5sbjXUnq0o3HRn2C7y/PR5jDmsuj4moYa+dfEdBbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3SGl89X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F8CC4CEF7;
	Tue, 17 Mar 2026 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773791369;
	bh=B5zX/btelmPrPxeLmOad9yHj3k9hJHtToQC7+6gjHfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3SGl89XBTGboeDNB+o9mYiheiU41H3SK5xZcW2OIs5AS09+x/9jliKpVO+qWhx1z
	 YWGlUSwhhHqnq7N2zYkAR/VlADk9vEDvt/rIjQsmTXh3RFVtS0A4nwa4IQzlbuvQno
	 Z7Je2zLB17lahfl9XCNk/2tOhO5ZXtEcoKeMewXw+JqT/LrxIJ72NcOsTvzPA/doGg
	 +k44NbiHUkHEBshQ+Q2CL9Zxpw9TiSVlSjov5CqOc8/yUN0fzk1K19gTghqKHcFBXV
	 ed16dHZgX6o//XPldoWR1jVVtwfqsG49FLfSG7olYg/lGyJGlWDFutNBQvHAJNtTKe
	 kdLQBasWMHduw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
Date: Tue, 17 Mar 2026 19:49:26 -0400
Message-ID: <20260317234926.369009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031737-imprecise-trodden-af5f@gregkh>
References: <2026031737-imprecise-trodden-af5f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226929-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 089CC2B4764
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
[ adapted per-scheduler struct (sch->exit_kind, scx_disable, scx_vexit) to global variables (scx_exit_kind, scx_ops_disable, scx_ops_exit_kind) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e79f39c7bcf6..29750b3c63ebe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4775,14 +4775,29 @@ static void schedule_scx_ops_disable_work(void)
 		kthread_queue_work(helper, &scx_ops_disable_work);
 }
 
-static void scx_ops_disable(enum scx_exit_kind kind)
+/*
+ * Claim the exit. The caller must ensure that the helper kthread work
+ * is kicked before the current task can be preempted. Once exit_kind is
+ * claimed, scx_error() can no longer trigger, so if the current task gets
+ * preempted and the BPF scheduler fails to schedule it back, the helper work
+ * will never be kicked and the whole system can wedge.
+ */
+static bool scx_claim_exit(enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
 
+	lockdep_assert_preemption_disabled();
+
+	return atomic_try_cmpxchg(&scx_exit_kind, &none, kind);
+}
+
+static void scx_ops_disable(enum scx_exit_kind kind)
+{
 	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
 		kind = SCX_EXIT_ERROR;
 
-	atomic_try_cmpxchg(&scx_exit_kind, &none, kind);
+	guard(preempt)();
+	scx_claim_exit(kind);
 
 	schedule_scx_ops_disable_work();
 }
@@ -5082,10 +5097,11 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     const char *fmt, ...)
 {
 	struct scx_exit_info *ei = scx_exit_info;
-	int none = SCX_EXIT_NONE;
 	va_list args;
 
-	if (!atomic_try_cmpxchg(&scx_exit_kind, &none, kind))
+	guard(preempt)();
+
+	if (!scx_claim_exit(kind))
 		return;
 
 	ei->exit_code = exit_code;
-- 
2.51.0


