Return-Path: <stable+bounces-255962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFeKAxupGGrclwgAu9opvQ
	(envelope-from <stable+bounces-255962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:44:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F95F96B6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93293185262
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5E52F1FEC;
	Thu, 28 May 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="opbH9FH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F233987F;
	Thu, 28 May 2026 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000367; cv=none; b=EiqPuc+cHjx5ouQEM/YhaGaXh0bcCC4ATKwwmV4v2Mq7wDo7GkQG7UId5DcojFLLzr6b9WVw0gfAUKSAYY89HxfyhGjECG7XrfzPy2HQwyfPBjHR6uH8xCb8KsmwaozXPNLmpwYE8YJihTzAcnnnnyvpvSlgJxr86hBcxaKtqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000367; c=relaxed/simple;
	bh=XNJx3QDv4p6lxkTWVQjTF4/ZgD+CV4joTfenuaEX1cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur+1e8InU68vzPnJ3d8io+0Mqe+HEilN92q6XUHavjAKWxwY09wMjq1yYPABi0+IwIWaIKKzDECVU+Wz+6aWDoCD+hDG4RVFQKUX0XYH097ADzjHmgc7YwPrvF1xtE6lI1+OKmhl2uuZl0W0CEJ4zKcA2LGmQGubXFo/ZKU1DeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=opbH9FH6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E841F000E9;
	Thu, 28 May 2026 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000366;
	bh=81Ke31HSxU+PM0tgtwkDaDt3qCKgilkmiOUY1OY7bo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opbH9FH6vMtk9wyiK1T2to31S78UpTFaurau1YIsMQFYnUt/LnBqf3EI4Sl0vTiv3
	 SFDDA6yU1F59vIQSLsJO2s7y87zOgF8Bz094F985tWvmxLFHdtsj9VHVXX2E3Wh5j6
	 tRphYCtfc9HCM44CTz69BMt8h7dakrHanKGSqohg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 020/272] sched/deadline: Stop dl_server before CPU goes offline
Date: Thu, 28 May 2026 21:46:34 +0200
Message-ID: <20260528194629.949050676@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255962-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 892F95F96B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra (Intel) <peterz@infradead.org>

[ Upstream commit ee6e44dfe6e50b4a5df853d933a96bdff5309e6e ]

IBM CI tool reported kernel warning[1] when running a CPU removal
operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"

WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
Call Trace:
[c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
[c0000000002b7cb8] dl_server_timer+0x168/0x2a0
[c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
[c00000000034f624] hrtimer_interrupt+0x124/0x300
[c00000000002a230] timer_interrupt+0x140/0x320

Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")

This happens since:
- dl_server hrtimer gets enqueued close to cpu offline, when
  kthread_park enqueues a fair task.
- CPU goes offline and drmgr removes it from cpu_present_mask.
- hrtimer fires and warning is hit.

Fix it by stopping the dl_server before CPU is marked dead.

[1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
[2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr

[sshegde: wrote the changelog and tested it]
Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     | 2 ++
 kernel/sched/deadline.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b238c9c71c67..1b1ddd24cb227 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8319,10 +8319,12 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
 	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
 		WARN(true, "Dying CPU not properly vacated!");
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
+	dl_server_stop(&rq->fair_server);
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a6c699e43111d..cb8eff0ebd228 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1848,6 +1848,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime || dl_se->dl_server_active)
 		return;
 
+	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
+		return;
+
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
-- 
2.53.0




