Return-Path: <stable+bounces-246937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEAbHEarBGoxMwIAu9opvQ
	(envelope-from <stable+bounces-246937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0B53763C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 878393083C40
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FBC254B18;
	Wed, 13 May 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsigsY4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18A34753F
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690005; cv=none; b=Hx6MiLi9XCbShRnNoQUr33d34F+oaJVwl/NbCdSOrnYcVd1ZEbd63N+MzjbtYWSFPmH8SouXgN8FFBBu2QWbycxs46HZof3Vlycv7rfscZamoK+DNdW3DIXYIlJ1vJxkGVnaMEsxRj9YrSh0Eads+dYALJeAUlJ5CYH7TPGzU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690005; c=relaxed/simple;
	bh=ijc5DuPkrdefG6UblgzlgfN78R4DsNkJbWJnnF0AsCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFc/EwG3NRwYb2d0UFn+alFyIpXM4WqSCRf3uEwq0wHWg+fzb3wjYwIcxZmJZGxia1GYwarGjtPUFMGyWrGNErQ6ykDCS8G9H8w3ENhdKFqpoONCQqW9PDIlMkLYOlwbbCuSjFPFbPZQIfJmWiD3+8jVmct2PkgghfdFibUKGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsigsY4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABFC19425;
	Wed, 13 May 2026 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690004;
	bh=ijc5DuPkrdefG6UblgzlgfN78R4DsNkJbWJnnF0AsCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsigsY4tZ8SmpAocyhj0xX+aylqx4B9uW0j9IWG1iXsBVSw1cAd/yORgDYboYRQkH
	 6+eyBCF0UZxQkTnx920eSzYr60WyNQSoSLUcTwjUpXg6wmI8dFVTktwWCooDEpCbDx
	 dUd1nD0vpEHCOTuyKKs+fEksf8/8xkeV77+P+MgFg3YHsoe30jxFdvGkpWx8oq6NAx
	 Gfuw8NQ3I4oz1+m/xqScUjK4zQGmQhZv+CrrYKUfcjUsDNVuXWrHqsB8xSepZDwfwm
	 K3+FOhNVUjj55BMs2U4zhiM8TL8pAUHAP0uwkhgAmt1qVn8WGqHiJmDwmMQMOFBjva
	 S2ZHqWIZmLS/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: zhidao su <suzhidao@xiaomi.com>,
	zhidao su <soolaugust@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] sched/ext: Implement cgroup_set_idle() callback
Date: Wed, 13 May 2026 12:33:21 -0400
Message-ID: <20260513163322.3807202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051219-oval-unbalance-97f6@gregkh>
References: <2026051219-oval-unbalance-97f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70B0B53763C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xiaomi.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246937-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Action: no action

From: zhidao su <suzhidao@xiaomi.com>

[ Upstream commit 347ed2d566dabb06c7970fff01129c4f59995ed6 ]

Implement the missing cgroup_set_idle() callback that was marked as a
TODO. This allows BPF schedulers to be notified when a cgroup's idle
state changes, enabling them to adjust their scheduling behavior
accordingly.

The implementation follows the same pattern as other cgroup callbacks
like cgroup_set_weight() and cgroup_set_bandwidth(). It checks if the
BPF scheduler has implemented the callback and invokes it with the
appropriate parameters.

Fixes a spelling error in the cgroup_set_bandwidth() documentation.

tj: s/scx_cgroup_rwsem/scx_cgroup_ops_rwsem/ to fix build breakage.

Signed-off-by: zhidao su <soolaugust@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 80afd4c84bc8 ("sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext.c          | 16 +++++++++++++++-
 kernel/sched/ext_internal.h | 13 ++++++++++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d82b7a9b0658b..9848aeab27864 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -228,6 +228,7 @@ struct scx_task_group {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+	bool			idle;
 #endif
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ee031ba877d9c..423098966a291 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3118,6 +3118,7 @@ void scx_tg_init(struct task_group *tg)
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
+	tg->scx.idle = false;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -3266,7 +3267,18 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	/* TODO: Implement ops->cgroup_set_idle() */
+	struct scx_sched *sch = scx_root;
+
+	percpu_down_read(&scx_cgroup_ops_rwsem);
+
+	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
+			    tg_cgrp(tg), idle);
+
+	/* Update the task group's idle state */
+	tg->scx.idle = idle;
+
+	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 
 void scx_group_set_bandwidth(struct task_group *tg,
@@ -5126,6 +5138,7 @@ static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *fro
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
+static void sched_ext_ops__cgroup_set_idle(struct cgroup *cgrp, bool idle) {}
 #endif
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
@@ -5164,6 +5177,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
+	.cgroup_set_idle	= sched_ext_ops__cgroup_set_idle,
 #endif
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 8039a750490f8..5b2dd105fa92a 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -697,12 +697,23 @@ struct sched_ext_ops {
 	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
 	 * interpreted in the same fashion and specifies how much @cgrp can
 	 * burst temporarily. The specific control mechanism and thus the
-	 * interpretation of @period_us and burstiness is upto to the BPF
+	 * interpretation of @period_us and burstiness is up to the BPF
 	 * scheduler.
 	 */
 	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
 				     u64 period_us, u64 quota_us, u64 burst_us);
 
+	/**
+	 * @cgroup_set_idle: A cgroup's idle state is being changed
+	 * @cgrp: cgroup whose idle state is being updated
+	 * @idle: whether the cgroup is entering or exiting idle state
+	 *
+	 * Update @cgrp's idle state to @idle. This callback is invoked when
+	 * a cgroup transitions between idle and non-idle states, allowing the
+	 * BPF scheduler to adjust its behavior accordingly.
+	 */
+	void (*cgroup_set_idle)(struct cgroup *cgrp, bool idle);
+
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
 	/*
-- 
2.53.0


