Return-Path: <stable+bounces-219190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6+7YGg6CnmmGVwQAu9opvQ
	(envelope-from <stable+bounces-219190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:01:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0805C191AE8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 524D13013DD5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDB028D8DF;
	Wed, 25 Feb 2026 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcwhM5tL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57A749C;
	Wed, 25 Feb 2026 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995657; cv=none; b=TDAfWKVeTSrSAGNGtRraCSRyuWpoAtI+vjaJIyKJGkOV48Xzzlk/UO++TStwk1Cb5NL4B36a3L9M1/v5Pbv5sxwo1W7iF2Qyu/CR3FmNA4zYD9uE+gL15gW/q9UsEJ6u8nU6BYZ3nI/e+cDwTfXtEw58GO3OfzzCB/HUJUun1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995657; c=relaxed/simple;
	bh=LEg/kvL4+PWzwZZr3vvN0r75U42G46ZWLV2HAR0tIBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYLVSVzdL63oBSqQxK3cGAqY7mOiwXq4kyvSWweIZSbnGa+cy3eMFEYr6cPYtQCANCD1aXsQVSBtjpkF3qs7EfAxjpabSZfHNBzGwXvrd+hGYlGOmfQgNq1OFiIA2XQtCrfs6Q+3NtzNAyG4S3HQoSwQrfXd0By3uthD2SBc+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcwhM5tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0033EC116D0;
	Wed, 25 Feb 2026 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995657;
	bh=LEg/kvL4+PWzwZZr3vvN0r75U42G46ZWLV2HAR0tIBY=;
	h=From:To:Cc:Subject:Date:From;
	b=hcwhM5tL0T8hzCiINRBnOAupJWtIlnwh7wZ4XBqEFyccvCy/TrfG8PXpOnGBKqQyA
	 Cy5UWLrW1/rihugCRyxlGYVIYibRUae3+c7S302T/aWhioSS1BZjRsaiDUvzhok5aM
	 ALYQfwXZ2BCpGLa9Fc8JEcUeSaA+iAoqGnDqrKt85C3VszqiySHvHdaXcFAvneE4qk
	 6YP12xOzrVaE77Ohya8n7vFG0IEI1QnG/sl156o46QsW2dQtWt12iiXdYqB7o6orOm
	 WwP3rft8BUqs1tTg/5cZL2o9Lel4EC8iHzP6NqzXON3TZ8BO8jOWyY5yW4lnZ919tp
	 lhbjOkd8hBGKQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.0-fixes] sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
Date: Tue, 24 Feb 2026 19:00:55 -1000
Message-ID: <20260225050055.1069822-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219190-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0805C191AE8
X-Rspamd-Action: no action

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

Fixes: a69040ed57f5 ("sched_ext: Simplify breather mechanism with scx_aborting flag")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c18e81e8ef51..9280381f8923 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4423,10 +4423,19 @@ static void scx_disable_workfn(struct kthread_work *work)
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
 
@@ -4449,6 +4458,7 @@ static void scx_disable(enum scx_exit_kind kind)
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
+		guard(preempt)();
 		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
@@ -4771,6 +4781,8 @@ static bool scx_vexit(struct scx_sched *sch,
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
+	guard(preempt)();
+
 	if (!scx_claim_exit(sch, kind))
 		return false;
 
-- 
2.53.0


