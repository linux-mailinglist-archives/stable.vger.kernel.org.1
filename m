Return-Path: <stable+bounces-250466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBo6AXcQDmrw5wUAu9opvQ
	(envelope-from <stable+bounces-250466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D3598C78
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876653513F94
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B60372B24;
	Wed, 20 May 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bXtsMkAE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BE31F9BE;
	Wed, 20 May 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295486; cv=none; b=TagITi2zGiL1BVzZZxnYt9hDCle7cjQBe1Jx9SgCzrNZJryREf60scbZxuKmKhWwuGalTw9miehZjNKwra4mAfH+QZXYRabHIheIlxY/CB/esvdvrHJVg1oJetC+qKWv0WiLBoMUptT4DaqgrbnVXwlGfYVHd+JrSQCmuBMENyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295486; c=relaxed/simple;
	bh=4fFzfiHArfM96zumpiV6z4+hUJ/5iXb/J99o4/4nDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjpSKxdnuKujgZyiMClBkq52cCL4Gs+ium4qtrmpcAeIo6PdKgCDNlMyw4++ArqJpuUMKSyQOli9VeCaniwuSxANNgxd83yYnj6aqGfVXlSa2Rj5B0puPWpxNTMGIeQf9gN26LIBCxzLu0UumookpupCpJaw1iRL4CE9EJGWGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bXtsMkAE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF21F000E9;
	Wed, 20 May 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295484;
	bh=T23de1evEVBYLJTtaRkyKa6VqcJTc730pOI6B/QUN4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXtsMkAEsBHd54ig7yqGmGFOlR/LtbojZcHNZHemSNMlHK3eDVAjXJrKhc2oJey0t
	 zpFdV4DqzyHs1wtn8/9VAR0UvZ2wxxuldKyFAHf7dEEWyi79uoHkesVvIpT7uUdeiU
	 bw6IiPVUKRBFcDLp8F+DwdKSxeVmRDJA0moRlu34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0438/1146] sched_ext: Fix ops.cgroup_move() invocation kf_mask and rq tracking
Date: Wed, 20 May 2026 18:11:28 +0200
Message-ID: <20260520162158.109443932@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250466-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3E6D3598C78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

[ Upstream commit b470e37c1fad72731be6f437e233cb6b16618f41 ]

sched_move_task() invokes ops.cgroup_move() inside task_rq_lock(tsk), so
@p's rq lock is held. The SCX_CALL_OP_TASK invocation mislabels this:

  - kf_mask = SCX_KF_UNLOCKED (== 0), claiming no lock is held.
  - rq = NULL, so update_locked_rq() doesn't run and scx_locked_rq()
    returns NULL.

Switch to SCX_KF_REST and pass task_rq(p), matching ops.set_cpumask()
from set_cpus_allowed_scx().

Three effects:

  - scx_bpf_task_cgroup() becomes callable (was rejected by
    scx_kf_allowed(__SCX_KF_RQ_LOCKED)). Safe; rq lock is held.

  - scx_bpf_dsq_move() is now rejected (was allowed via the unlocked
    branch). Calling it while holding an unrelated task's rq lock is
    risky; rejection is correct.

  - scx_bpf_select_cpu_*() previously took the unlocked branch in
    select_cpu_from_kfunc() and called task_rq_lock(p, &rf), which
    would deadlock against the already-held pi_lock. Now it takes the
    locked-rq branch and is rejected with -EPERM via the existing
    kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE) check. Latent
    deadlock fix.

No in-tree scheduler is known to call any of these from ops.cgroup_move().

v2: Add Fixes: tag (Andrea Righi).

Fixes: 18853ba782be ("sched_ext: Track currently locked rq")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 29ee463ec9bc4..3ac01ea9bfb1a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3406,7 +3406,7 @@ void scx_cgroup_move_task(struct task_struct *p)
 	 */
 	if (SCX_HAS_OP(sch, cgroup_move) &&
 	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(sch, SCX_KF_UNLOCKED, cgroup_move, NULL,
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
-- 
2.53.0




