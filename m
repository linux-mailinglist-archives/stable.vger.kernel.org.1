Return-Path: <stable+bounces-263327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zLFqLWMcMGpXNwUAu9opvQ
	(envelope-from <stable+bounces-263327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:38:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E33687C4C
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:38:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HC3iCMNk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263327-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263327-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1F0F303F472
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F1406281;
	Mon, 15 Jun 2026 15:37:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EF406298
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537857; cv=none; b=QhVKY1I3AtK/+B7dWOXpmsuRtxRHaxTwAC9m8KNj1O0P2S90zPl9UAvEbgTzF2/HzSKZ0fv0aZUhMtvfuLJZIRJZS/uxcfYEMEEdR8XF8KqVPm7y+FoSjVOXh7ONnMarXOut4TwFeVLi28WWSlZpHKj+36HlqJ8f+K2nr0MWXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537857; c=relaxed/simple;
	bh=BCMUhtbdZZzKDDZa4idYCJZhFcNP/10olUtbiNPkVOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVk2ZypYFadpu/mmLzkb0L76+t2JXN/Qgy6E85CAvAlU4LLETMLIVn/5MLJj0JGATJA4ale3+h4IS5Ua6FhquqAeJ83QqDLajnB7XcrUS17wXRoLObUwBWU+Av7yXX1xH8Cbp4Kr85xpYjBK9D5GdGfpEduX/l+aqd1wuE93/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC3iCMNk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8270F1F00A3E;
	Mon, 15 Jun 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537856;
	bh=JD73ZmZn9/xEAKcgfr4nib3QjOwPG3zySjRTVt1eIWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HC3iCMNk4VEnr44930RZq/pgyjKDBjTh9/0NztqQTmTinIPUN8nJ5WlVBZiVtgCq2
	 7X5sCdUYKfDNk9BbbGgUAS0If4Nh/Dq2KYDSOqZoUQa2AZ+x6U793D9rJe3iD1Ujcx
	 cS4nu0c13a41hqF8dCBO++Jvgj6J5lKaIbpjkpxHyRkn2u3auey/f4HAXSMrQr78aO
	 BlucokxE9LXxBz82kkV119ao14ZERcjWjUmTeox8rM7zRd/j4ICicn72virzpk3+Zc
	 SxbGMf0wgucgfB6D+GsCgTKD0wwrhcD9e93NFgNFO05Y+Z2RsDKyPFL7em63fdJr5c
	 K0FLWZx+Z6uGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Matt Fleming <mfleming@cloudflare.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Date: Mon, 15 Jun 2026 11:37:32 -0400
Message-ID: <20260615153732.2213055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061552-lividly-railcar-9730@gregkh>
References: <2026061552-lividly-railcar-9730@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263327-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tj@kernel.org,m:mfleming@cloudflare.com,m:arighi@nvidia.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,cloudflare.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05E33687C4C

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 02e545c4297a26dbbc41df81b831e7f605bcd306 ]

A WARN fires when systemd's user manager writes "+cpu +memory +pids" to
its own subtree_control while a sched_ext scheduler is loaded:

  WARNING: at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
   scx_cgroup_move_task+0xa8/0xb0
   sched_move_task+0x134/0x290
   cpu_cgroup_attach+0x39/0x70
   cgroup_migrate_execute+0x37d/0x450
   cgroup_update_dfl_csses+0x1e3/0x270
   cgroup_subtree_control_write+0x3e7/0x440

scx_cgroup_can_attach() arms cgrp_moving_from only when a task's cpu
cgroup changes. It can still be NULL when scx_cgroup_move_task() runs,
through this sequence:

  Step                               Result
  ---------------------------------  ----------------------------------
  1. cpu enabled on cgroup G         cpu css = A
  2. cpu toggled off then on for G   A killed, B created (same cgroup)
  3. an exiting task keeps A alive   migration skips it, A now stale
  4. +memory migrates G              stale A vs current B pulls cpu in
  5. cpu attach runs for all tasks   hits a live, cpu-unchanged task
  6. scx_cgroup_move_task() on it    cgrp_moving_from NULL -> WARN

The mismatch is that scx_cgroup_can_attach() keys on cgroup identity
while migration drives the move on css identity, so a NULL cgrp_moving_from
here is a legitimate css-only migration, not a missing prep.

The call is already gated on cgrp_moving_from, so just drop the warning.
ops.cgroup_prep_move() and ops.cgroup_move() stay paired.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260601124156.2205704-1-mfleming@cloudflare.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 38157fc58c5cc0..cfdd0d4a78ca58 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3402,11 +3402,13 @@ void scx_cgroup_move_task(struct task_struct *p)
 		return;
 
 	/*
-	 * @p must have ops.cgroup_prep_move() called on it and thus
-	 * cgrp_moving_from set.
+	 * scx_cgroup_can_attach() sets cgrp_moving_from only when the task's
+	 * cgroup changes. Migration keys off css rather than cgroup identity,
+	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
+	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
+	 * keep prep_move and move paired.
 	 */
-	if (SCX_HAS_OP(sch, cgroup_move) &&
-	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
-- 
2.53.0


