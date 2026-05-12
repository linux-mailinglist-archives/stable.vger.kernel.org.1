Return-Path: <stable+bounces-245717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDDAGj0/A2rO2AEAu9opvQ
	(envelope-from <stable+bounces-245717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AF5230A0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5058F301E155
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909303B1ECD;
	Tue, 12 May 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JmgGC8Wp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435CE39E9CF
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595526; cv=none; b=SdSAwYrEt+MhmR6AOXXyn+WyrpvyQNZhv1bwHs44k/QoRysDCVuJiUuBIWUSgQfuhowLMBFBLrZfUxTQ6DqvmpCDMyP0OaIPPU+x8Xz+bG7i1QuS/wKETB17MWPiTKDqu40tvcaf0zOEo0TDTsiOdacxFipGG/8HX8yXI78LbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595526; c=relaxed/simple;
	bh=Dzo7Gl+NmHaAKr24punzjmrLRhI4/TDF7+yhl8h0AFc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HW0WuR4rU23YmYZNb2f4a72r76IS1hugKvKG6X7oi3Uglp/d6L1qjB69Ppc9hDwhOYpNTU6qgJARU6MKlkIfXfjx/HRlSlp+jGi8p0SEVEsa4GCGaC9dovCYEjf+W6BNqgu2AN7giLmn+Gk2/q2QRNRVCZLzXv4qRXm2H+2WE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JmgGC8Wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB0AC2BCFA;
	Tue, 12 May 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595525;
	bh=Dzo7Gl+NmHaAKr24punzjmrLRhI4/TDF7+yhl8h0AFc=;
	h=Subject:To:Cc:From:Date:From;
	b=JmgGC8WpUgxYcbPxo3en0vUzDTGZdtQ7iaLhEchu+vBuZjKzmSasc/7lFdsm7TI+w
	 icje0jrFMcAd2U5AvMWcHT9STIf9rSx4Xn7nlJuHmpqXrQpbC/8R6ThkXZoz3sMCBo
	 kSFuZ78KYBL8EtKamiK+EPy7QIPS41nqldLIlBqM=
Subject: FAILED: patch "[PATCH] sched_ext: Pass held rq to SCX_CALL_OP() for" failed to apply to 7.0-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:18:16 +0200
Message-ID: <2026051216-herbs-deranged-aad5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E2AF5230A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245717-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 4155fb489fa175ec74eedde7d02219cf2fe74303
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051216-herbs-deranged-aad5@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4155fb489fa175ec74eedde7d02219cf2fe74303 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Apr 2026 14:31:36 -1000
Subject: [PATCH] sched_ext: Pass held rq to SCX_CALL_OP() for
 core_sched_before

scx_prio_less() runs from core-sched's pick_next_task() path with rq
locked but invokes ops.core_sched_before() with NULL locked_rq, leaving
scx_locked_rq_state NULL. If the BPF callback calls a kfunc that
re-acquires rq based on scx_locked_rq() - e.g. scx_bpf_cpuperf_set(cpu)
- it re-acquires the already-held rq.

Pass task_rq(a).

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 73d629559d6d..ba977154273c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3198,7 +3198,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_bypassing(sch_a, task_cpu(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
-					      NULL,
+					      task_rq(a),
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
 	else


