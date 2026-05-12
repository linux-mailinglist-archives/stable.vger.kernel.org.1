Return-Path: <stable+bounces-245480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IxsDhAmA2qL1AEAu9opvQ
	(envelope-from <stable+bounces-245480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93943520C37
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9231631BF46B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77144390603;
	Tue, 12 May 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4/EIxMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9983A719C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589764; cv=none; b=THF4PWlqTFXLLLCbBKCF4pC1jONX3l1o2s4KM7fYxFuaOsGt4omd3nY5JDPlc+kC72Ddvn33X65p9Ynu5PFpzM/k6j11MMOgSTK2XDZy8rAhoK+aShiBGkfMXyW8E25188l34EQsyeavjsowsqlK3zdy6X0v6/gN9J+7KG5LkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589764; c=relaxed/simple;
	bh=GNGLmEl9QcWNAQu0JVrUXMkETeZ/iawEee5rhP6zIAQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tEwkoJKLu31lnzvCWGL5n+bOwYh2FTs9mxVhXHnY5ZHQqL4oopQLLTaOGAmxIrz8TwU/gZOhKLUrMvdtbVx2jzU0AKmYsdplljnaiKmD+YjCuR/2P0Epd+x/xvV4JRcUA7crtNu8Nobrq6O1wYw/Lrgml6UNVVSICPdpaEZnRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4/EIxMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B57C2BCB0;
	Tue, 12 May 2026 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589763;
	bh=GNGLmEl9QcWNAQu0JVrUXMkETeZ/iawEee5rhP6zIAQ=;
	h=Subject:To:Cc:From:Date:From;
	b=e4/EIxMp1dCBVbp2sQ8lBKfiGK2a9go6DEQWG+oczvk8QpJLHJAbqVZyBwTfUJiSf
	 TCQz2D04gfVnP1w5PnuHSx3BIcCXPdNmesc6IuZfgKb3S6+amefQVW8AWyA8hONnKk
	 Bb8DtwHZHX4S8kxO27Br9fNM4v4hogJpKodBT9lY=
Subject: FAILED: patch "[PATCH] sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:38:19 +0200
Message-ID: <2026051219-oval-unbalance-97f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93943520C37
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245480-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 80afd4c84bc8f5e80145ce35279f5ce53f6043db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051219-oval-unbalance-97f6@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80afd4c84bc8f5e80145ce35279f5ce53f6043db Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Apr 2026 14:31:35 -1000
Subject: [PATCH] sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup
 setters

scx_group_set_{weight,idle,bandwidth}() cache scx_root before acquiring
scx_cgroup_ops_rwsem, so the pointer can be stale by the time the op runs.
If the loaded scheduler is disabled and freed (via RCU work) and another is
enabled between the naked load and the rwsem acquire, the reader sees
scx_cgroup_enabled=true (the new scheduler's) but dereferences the freed one
- UAF on SCX_HAS_OP(sch, ...) / SCX_CALL_OP(sch, ...).

scx_cgroup_enabled is toggled only under scx_cgroup_ops_rwsem write
(scx_cgroup_{init,exit}), so reading scx_root inside the rwsem read section
correlates @sch with the enabled snapshot.

Fixes: a5bd6ba30b33 ("sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations")
Cc: stable@vger.kernel.org # v6.18+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dd0539ab9ba8..f6d22636a4de 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4343,9 +4343,10 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
@@ -4358,9 +4359,10 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
@@ -4374,9 +4376,10 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 void scx_group_set_bandwidth(struct task_group *tg,
 			     u64 period_us, u64 quota_us, u64 burst_us)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
 	    (tg->scx.bw_period_us != period_us ||


