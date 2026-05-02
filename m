Return-Path: <stable+bounces-242625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJZ3ER6J9mkUWAIAu9opvQ
	(envelope-from <stable+bounces-242625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7164B3A6F
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC3373008506
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D8305968;
	Sat,  2 May 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niqoVllm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FE30E858
	for <stable@vger.kernel.org>; Sat,  2 May 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764633; cv=none; b=j0un4CrDaq0TCnvfWTQfa5B0SF8vXwnsKZT3PkbvbWFOea1o4dW1Ei1Gy77BFgnm87Wgvu7IaZDMDOpx1q5WsyVp0SkulOrDbDGkWzEqVDlsb+Zt8BMohf/7XSRl6Min7J8nEoafwQX0qtV2p3TYgqe5XAToCIRo8jKwM8iz8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764633; c=relaxed/simple;
	bh=xUf+0LdeY20mGqxOuC717Vm4z5lXPodDpViV5wtnQ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACBedcXZ1+zhh47hidG7QGQvBR7Z97tYwVM3OVV1fw6vVs9p7j1AVzw80NXLrcZWtLEhyjEPCQFp/QD+Zxn8WOnAXVmuJe4NE6aM1fA2v5QSG/sd9V53j7h1FvRUN4BDGpqqIeoeqjaxwI1SK7IUoNXwZlDhJgqzhckHFxByhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niqoVllm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549EDC19425;
	Sat,  2 May 2026 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777764632;
	bh=xUf+0LdeY20mGqxOuC717Vm4z5lXPodDpViV5wtnQ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niqoVllmIT40/WqTnYsL2zWzUaOLA/vXzU3fDq1pWry7W7xAQp6DJtlNbKmgU6UVr
	 vvgw/fMUxwIn/os5Dzx0FhHPvJ8aoJ7JEiuyqFE6m1z0nQ9dPbBHlBlvYawIw9xLN7
	 N9SEL850wcfpaEvdIn70dg9yVXDENsAsP8ylcOvM0kWMzelULn6BXpjZTU9koCfo8c
	 v5glXqYSAe6BwcAF5UHBESC72cEHsUAAVFBPAJTcbXTLbVdygktocpBZiaLMZ8uP7r
	 38kaytrJMXrmd+s9/Nm4KYLhWWiV4VPmdOUExha5XmZbmna4g1ylsJaiM6RBg9Y+D4
	 FAe8v+zL2sCuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] sched: Use u64 for bandwidth ratio calculations
Date: Sat,  2 May 2026 19:30:19 -0400
Message-ID: <20260502233019.915219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050159-quadrant-kilogram-1f30@gregkh>
References: <2026050159-quadrant-kilogram-1f30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD7164B3A6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242625-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]

From: Joseph Salisbury <joseph.salisbury@oracle.com>

[ Upstream commit c6e80201e057dfb7253385e60bf541121bf5dc33 ]

to_ratio() computes BW_SHIFT-scaled bandwidth ratios from u64 period and
runtime values, but it returns unsigned long.  tg_rt_schedulable() also
stores the current group limit and the accumulated child sum in unsigned
long.

On 32-bit builds, large bandwidth ratios can be truncated and the RT
group sum can wrap when enough siblings are present.  That can let an
overcommitted RT hierarchy pass the schedulability check, and it also
narrows the helper result for other callers.

Return u64 from to_ratio() and use u64 for the RT group totals so
bandwidth ratios are preserved and compared at full width on both 32-bit
and 64-bit builds.

Fixes: b40b2e8eb521 ("sched: rt: multi level group constraints")
Assisted-by: Codex:GPT-5
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260403210014.2713404-1-joseph.salisbury@oracle.com
[ dropped `extern` keyword from `to_ratio()` declaration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/rt.c    | 2 +-
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4a9797e9effd..d558e43aedcf2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4823,7 +4823,7 @@ void sched_post_fork(struct task_struct *p)
 	uclamp_post_fork(p);
 }
 
-unsigned long to_ratio(u64 period, u64 runtime)
+u64 to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
 		return BW_UNIT;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0b420a65b31dc..46d2250b72359 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2776,7 +2776,7 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 {
 	struct rt_schedulable_data *d = data;
 	struct task_group *child;
-	unsigned long total, sum = 0;
+	u64 total, sum = 0;
 	u64 period, runtime;
 
 	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e1913e253221b..65ff0254659ac 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2463,7 +2463,7 @@ extern void init_dl_entity(struct sched_dl_entity *dl_se);
 #define RATIO_SHIFT		8
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
-unsigned long to_ratio(u64 period, u64 runtime);
+u64 to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
-- 
2.53.0


