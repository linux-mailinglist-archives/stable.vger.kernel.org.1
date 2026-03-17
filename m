Return-Path: <stable+bounces-225835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K0hMg89uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:37:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454602A8FAA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B63230305C0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE1357A20;
	Tue, 17 Mar 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9cKuDjS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346A34A3A2
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747339; cv=none; b=bVnTRv6B+1EAwLh9xRaUEDtMRftQHmIxydgLjFKjL8UO+mB+igS67RCSnt+5JVExNJPL5/48F3l7SOoLo8DlhPtZm+1eG8RZtg8+nyRD6h40AT/5yLvtR5tu7vZ7bz+P0jXqxWMPLJj9bQpFmO0fB5jLuJ3t7dZDarFSc8Gm5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747339; c=relaxed/simple;
	bh=p9igKvbfKqXnB5vPq9WjVHWuzkCGhnjW9yu+hiVlJJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LoAU4E5FmujLwh1BspjgKAxOjLWuECCh6vuHeBE/9jSxHqp5OxvAzBeKjLqQK3mEa5Fy6gnfpvZL2SXMY8ZMGoWa8iR/gl71DNk1CSZEv904gyQBoT6ldeQu22M9dmiVwwWs4+OiNrhfTmJXE2zktePQjINyiuzeYq+NNHyG1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9cKuDjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFE7C4CEF7;
	Tue, 17 Mar 2026 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747339;
	bh=p9igKvbfKqXnB5vPq9WjVHWuzkCGhnjW9yu+hiVlJJg=;
	h=Subject:To:Cc:From:Date:From;
	b=c9cKuDjSbyWBYlmYdxLu7XulUwFyzvVgwerpTdWtLEf/et0eoyhF3hmKpcmYzEfOv
	 /qgG5NrjjvQ87gQVK/8p+GbDtIfd9Wg7IbPNRFrdo3BoZFKtnncd04tVAj8BbdlT1R
	 OnOoFgG/LjkWhAwqxH9RB/YZvtoQ+maL257M8cvw=
Subject: FAILED: patch "[PATCH] sched_ext: Disable preemption between scx_claim_exit() and" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:35:36 +0100
Message-ID: <2026031736-mystify-skating-036b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225835-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 454602A8FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 83236b2e43dba00bee5b82eb5758816b1a674f6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031736-mystify-skating-036b@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83236b2e43dba00bee5b82eb5758816b1a674f6a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 24 Feb 2026 21:39:58 -1000
Subject: [PATCH] sched_ext: Disable preemption between scx_claim_exit() and
 kicking helper work

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
 


