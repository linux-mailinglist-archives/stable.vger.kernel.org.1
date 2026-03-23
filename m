Return-Path: <stable+bounces-228254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGRpOApOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DE2F48F7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D35BA302AF21
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202B3B2FC2;
	Mon, 23 Mar 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bdf+KMf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540413B27F3;
	Mon, 23 Mar 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274593; cv=none; b=jp3Vf2bI8XxjIiBCkwyNxstsFwvFTR9lEcqGrrK7tdlvSHw0KPFC1Qfy9rSFvxTxKYAxV83Bh1+Zj+8GqFx8h/sdG59HzJOQF1B2L38NoDnDfTeVF479hQR08D7par3NSsRQGTHJrNy7BQFUKSt5kJXltKxLh3eMPkTmx8APd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274593; c=relaxed/simple;
	bh=XK0tSo+y1hAYpTtXCLAY0nysb4quFnY/7JufEEbQ+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3LAMzog/kA0AGZDRhYe9klxtBUMd2dN6xP88bYMrCueW1V8d8t2CN0RJNTwY0/WalwGIPB25kTJ+UCB1xsg+5T4R+YI37W0JYgphoVLYCcVnC93TOXCcw7+BwCQfsDlU8n7Qpphax5Sf4BH2Kwk1IUYlcd6FcpMO8w9c3ZCrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bdf+KMf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD90C4CEF7;
	Mon, 23 Mar 2026 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274593;
	bh=XK0tSo+y1hAYpTtXCLAY0nysb4quFnY/7JufEEbQ+E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bdf+KMf/WpRCaMk8KoJtvnFt+iocCrThF/qAh7/uKm5ZisiWPbV21ur1L5p9StXHb
	 +KlC/HJFiDKjIw3Pxb6rvipxYXduvOdmjunBmC/gUeDjm7CfkZBJJh3tQ0kwDKJyyS
	 2Oy2GjcGFv3OqaYX4UleoJ2OwWlJ5Ba/bDZsi+8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/212] sched_ext: Disable preemption between scx_claim_exit() and kicking helper work
Date: Mon, 23 Mar 2026 14:44:28 +0100
Message-ID: <20260323134505.258463567@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228254-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 312DE2F48F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4066,10 +4066,19 @@ done:
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
 
@@ -4092,6 +4101,7 @@ static void scx_disable(enum scx_exit_ki
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
+		guard(preempt)();
 		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
@@ -4414,6 +4424,8 @@ static void scx_vexit(struct scx_sched *
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
+	guard(preempt)();
+
 	if (!scx_claim_exit(sch, kind))
 		return;
 



