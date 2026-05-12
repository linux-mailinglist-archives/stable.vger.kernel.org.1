Return-Path: <stable+bounces-245716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TjnwMso3A2qK1wEAu9opvQ
	(envelope-from <stable+bounces-245716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:23:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D5522522
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C7E430AF0A7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C03B2D09;
	Tue, 12 May 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrnpBF61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C783B2D03
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595523; cv=none; b=cT4dFKobzP8+ktsaOmV+qrp5vsJERe8zMoW5y0vFLyW59xMUUBR+ymspwmeaKkc2byFSQi4e2jgeNaMgZrqHTLXJtc9T/XcLx8yig6xVTyN1cIfjQ5hojNX9Yl+LHLKpGaKAnxGLhdME3nlEXOIrjf8N2162Wa7yyXoBxjhN65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595523; c=relaxed/simple;
	bh=al4yRN1NQfOLzcSZVDl4n4kMIjFVFsUvx6MGJiM4weg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mE7yRPfvRiJ75hMAhmVpLjc9zd14mjwsutP8abk0CuNFBPxB75vnFXY1QYVUmDK2e6R61VgH+YmIBY/dvroHiNyB7vPdzDiJ+fYVGudEtbJ1vY6cPTuNSyMqXprewaahE7uOCgpWka8T545OYJ//dJ4LjLVQn3awSYskshqAW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrnpBF61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D2C2BCB0;
	Tue, 12 May 2026 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595523;
	bh=al4yRN1NQfOLzcSZVDl4n4kMIjFVFsUvx6MGJiM4weg=;
	h=Subject:To:Cc:From:Date:From;
	b=SrnpBF61JiiMZoM+ecSyIV3RmwmYWrY5StpMjpVRwRMRHkLMWFP1+KxjSREfD0aSi
	 gIHhv1umdsh5gy7HB4qUDQQpori1eRHuUyHGHrQA1Orjk4uZxFsjMyyQtJPvHnII4k
	 JQyNFhMXD2rrQ+D4FG2+nDK4RLxfSOSpM0aWb85g=
Subject: FAILED: patch "[PATCH] sched_ext: Pass held rq to SCX_CALL_OP() for" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:18:16 +0200
Message-ID: <2026051216-putdown-outage-4a65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B6D5522522
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245716-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,meta.com:email,gregkh:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4155fb489fa175ec74eedde7d02219cf2fe74303
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051216-putdown-outage-4a65@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


