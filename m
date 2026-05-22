Return-Path: <stable+bounces-253851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YESQOc3BEGoSdQYAu9opvQ
	(envelope-from <stable+bounces-253851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:51:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1A5BA37C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34F01300A7CD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8537CD35;
	Fri, 22 May 2026 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVne7wMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB83624D7
	for <stable@vger.kernel.org>; Fri, 22 May 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483081; cv=none; b=iiFS81gdjvgh61USAqOn2pbNcnLLy12afGFz8fWvmkcNm7Wdvwr2w1fSnKVlsT3OiMbCk2Ik3rFKb2QrdqRn5p0EaiZs8Nk870s9bMInfk4HW5EM91YGls/hUGwn6tFizCnCpbpxxxdGTRTlNtU4BHe8EZJh0TSdrlbytq3rmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483081; c=relaxed/simple;
	bh=OVmhk5pLP7LMkx7s+EKVqZDLM8GTJjw/mRwqJJKA9B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAcjfMTxgqZleHCeb/nyrjUx5+ej2nLEEX1Aq3gcfzm4bOUl5ieOudU5Z26RLRGCIi8kbKz3fFbyXez0pny9YeBNj86g2CodkOKMaQU8CltF5UWNm+duXW82Xg6oKX4G+XKOItreQyuyeMvEzMULMRYLIpzFHfZ+vyzVl2ZOBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVne7wMr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FFA1F000E9;
	Fri, 22 May 2026 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779483080;
	bh=67jdM6V+7WUFZtSDCoYSYPHfbRGuzmbWBpNsvjrn6Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVne7wMrpTfF+g5O1P09O1MJU3vNldpkE1KkfiOT/ZIQkeM45VH0EIoa/Rl/qttj1
	 7uyHHaIMY0lnAPm4HLNeZCiUeoyjgMP01/8O9MyldlBVLlKqtr5iIGBNpKdEefYLNl
	 JxQnFL/SkBgx1/NAH21F+SeL1hev/GnND8vBR+0ZIcSjW3pZ050J8FzXUdEeQ40Kiq
	 RcfuW16i4ij/le3ew5MYczS/vrj0JVkSe11TRyX2eF+Hq7l1eBhpNDgm8P9F9h0QB8
	 KOX9dSg6zV0Q6ZIrNPc3ikfnecWghFwNbeWjNK45n2cKnaEgvATYkT2m5wGZCjLiy/
	 pXr2GmaWCJHEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cgroup/cpuset: Reset DL migration state on can_attach() failure
Date: Fri, 22 May 2026 16:51:17 -0400
Message-ID: <20260522205117.4065831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051952-bunkbed-preschool-73aa@gregkh>
References: <2026051952-bunkbed-preschool-73aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253851-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huaweicloud.com:email]
X-Rspamd-Queue-Id: 64F1A5BA37C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

[ Upstream commit 4a39eda5fdd867fc39f3c039714dd432cee00268 ]

cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
state in the destination cpuset while walking the taskset.

If a later task_can_attach() or security_task_setscheduler() check
fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
and does not call cpuset_cancel_attach() for it. The partially
accumulated state is then left behind and can be consumed by a later
attach, corrupting cpuset DL task accounting and pending DL bandwidth
accounting.

Reset the pending DL migration state from the common error exit when
ret is non-zero. Successful can_attach() keeps the state for
cpuset_attach() or cpuset_cancel_attach().

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Reviewed-by: Waiman Long <longman@redhat.com>
[ omitted upstream context line `cs->dl_bw_cpu = cpu;` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ecc5ebbcf9917..7e294d59bd1a3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2579,16 +2579,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
 
 		if (unlikely(cpu >= nr_cpu_ids)) {
-			reset_migrate_dl_data(cs);
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 
 		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret) {
-			reset_migrate_dl_data(cs);
+		if (ret)
 			goto out_unlock;
-		}
 	}
 
 out_success:
@@ -3401,7 +3398,10 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	 * changes which zero cpus/mems_allowed.
 	 */
 	cs->attach_in_progress++;
+
 out_unlock:
+	if (ret)
+		reset_migrate_dl_data(cs);
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.53.0


