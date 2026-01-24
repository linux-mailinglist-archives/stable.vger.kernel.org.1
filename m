Return-Path: <stable+bounces-211448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExcNPyOdGmw7AAAu9opvQ
	(envelope-from <stable+bounces-211448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:21:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2B7D10C
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4EF3009B25
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286571C5D57;
	Sat, 24 Jan 2026 09:20:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296EE55C
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246458; cv=none; b=YSNs/61ky4xTVK9dEGVLxkb9zt1ZWCdtnhUbyvN7ho6VjZRlIQpdnIqvRoC4J2lMeH48WIXILcme89Hq3AZbPlHf6CxEP8egL4x5FIJdOrAGWwPaoZhDxqUuLA4NxDtNoVb/R5KeLjOvOEZxTWDFRZOmugJ1vasirNt4EL3SnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246458; c=relaxed/simple;
	bh=5xeiIQAIfX5gSevzRoLN7EgA/VNh14wdtI/7n7inqHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DM5NmP+Rv6cizaHT0Labigf1/kJZU+ZcicXKgtWH/0Hz+qWLlZTGXalx3reB6cI9JzbSNNCxNxrMx70kDyfC4gx842gxRzeYCtmyfiDPltLRASHKMjkpH6IKjqGbrqWMoKanXyTelbccY/Ml9DRHe0aPOdZrE6NMQNtG2Cricjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F39D1476;
	Sat, 24 Jan 2026 01:20:49 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.81.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2676F3F73F;
	Sat, 24 Jan 2026 01:20:53 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev
Subject: [PATCH 1/2] sched_ext: Don't kick CPUs running higher classes
Date: Sat, 24 Jan 2026 09:20:42 +0000
Message-Id: <20260124092043.349976-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260124092043.349976-1-christian.loehle@arm.com>
References: <20260124092043.349976-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211448-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F2B7D10C
X-Rspamd-Action: no action

From: Tejun Heo <tj@kernel.org>

commit a9c1fbbd6dadbaa38c157a07d5d11005460b86b9 upstream.

When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
higher class task. sched_ext has no control over such CPUs. A sched_ext
scheduler couldn't have expected to get access to the CPU after kicking it
anyway. Skip kicking when the target CPU is running a higher class.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 31eda2a56920..3d53b2232937 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5164,18 +5164,23 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	const struct sched_class *cur_class;
 	bool should_wait = false;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
+	cur_class = rq->curr->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
-	 * forward progress. Allow kicking self regardless of online state.
+	 * forward progress. Allow kicking self regardless of online state. If
+	 * @cpu is running a higher class task, we have no control over @cpu.
+	 * Skip kicking.
 	 */
-	if (cpu_online(cpu) || cpu == cpu_of(this_rq)) {
+	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
-			if (rq->curr->sched_class == &ext_sched_class)
+			if (cur_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
-- 
2.34.1


