Return-Path: <stable+bounces-225836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKyPHRU9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:37:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9662A8FB1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AE7C3037ED7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C735DA42;
	Tue, 17 Mar 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hokzbXJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D534DCD1
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747348; cv=none; b=K1VpqdWCNBlFPg7d2kX2ERgaWaklOjhexDvxQfAD9u21TzRjyb5qN1pPaE2zeGTfEvd9ydwxFxU+koipOBsX26i7BzBpcEV+2nm5HWClkDjSRxlfpBsChK639YmtSlsvOWxmX3Pk5SI7kwNdyXOotEyF/bt0yBHXLl+VcKM9SNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747348; c=relaxed/simple;
	bh=SpHs6nnSnsr/A9dK5CjiVMji7YHHb0+5Cl1mfYX5+EM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KUQI/hQZSKnZuvLRcp78A3e6mOkTpSAxm0x9jRJUDYjZdXhoCyQGWC5I3XMCB4K4JNq9nHcr/xtXFygGjDTAZO41hRA3+fFI6dIVPL1OeL2QFytuH5/q9/j0A/CzYwASpQfJE305UaC3d83vCo4/hC4xBe9c2nIh+tld9zf0SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hokzbXJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A4C19425;
	Tue, 17 Mar 2026 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747348;
	bh=SpHs6nnSnsr/A9dK5CjiVMji7YHHb0+5Cl1mfYX5+EM=;
	h=Subject:To:Cc:From:Date:From;
	b=hokzbXJ2VoNAVmxAezgOO2PQXzXob9NBcfr+vrEhADd/+QPS9BVwvG9UYzIP9COGT
	 g9KeAKK1eTP+j7Q1tdL4HyS6Hl4pAnCyRW6qByFMkF5fn2RnkpXgE2YUUiBJJ0TN1W
	 4xFIuFOiy/95bcQuhZMSFKtHxvGzNWLh7hd6hlvY=
Subject: FAILED: patch "[PATCH] sched_ext: Disable preemption between scx_claim_exit() and" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:35:37 +0100
Message-ID: <2026031737-imprecise-trodden-af5f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225836-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F9662A8FB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 83236b2e43dba00bee5b82eb5758816b1a674f6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031737-imprecise-trodden-af5f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


