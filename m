Return-Path: <stable+bounces-218939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE0NFPBUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E418FE59
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6BB930D85D1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313327F4CA;
	Wed, 25 Feb 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIxKGUdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7C27D782;
	Wed, 25 Feb 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983837; cv=none; b=OQlVyAIYzel3FM35UVcPRxT0X5yRRuFKG7aL8nfLuOSmH1WL0Q0j7355Mbg01/6f6VIopvR42uS33xBwwA1vXAW91iPblkrVsRROkjujElSSf4AXfa1OfWwpcCI6hylWYn+4vSdwykPkNfqdyzKP1Af7jNJED0wLETFmxsv8BnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983837; c=relaxed/simple;
	bh=sPQMVlvH736PJtHxhNp+rAhRCzdpm2whf2vcBsXoPhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkgCvPmnD7J5ckb2j0FkUWxfw4wv3ynifk2lpGI892dPr7CkJW62XVQl2hEtBKDisWtAfKDrdMLTliFan8HiLQecTSEp0TC7Y7yojO6yBmCqkirXdJdJR9l0ruFWOc86Ek3HmbDBiQDcNAEjsK8JLxi/rohfjrhbMXkhRsBu6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIxKGUdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F7C19424;
	Wed, 25 Feb 2026 01:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983837;
	bh=sPQMVlvH736PJtHxhNp+rAhRCzdpm2whf2vcBsXoPhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIxKGUdkSvcfors30j9YpGyVY2e5jqWFT91ZBckkSGncHHBtH2vAyRq6AWZ4FadMk
	 P7oJdHAwKPzhUkr8Kjc4pNd40Gf+aubaj+amZcPi676SNpGjT7lHygRWo99N51l6n7
	 FvAW5zLsWC/TXgvjZWFcLGRNsN2rGM+Qgxdbs7Oo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chen Jinghuang <chenjinghuang2@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 116/641] sched/rt: Skip currently executing CPU in rto_next_cpu()
Date: Tue, 24 Feb 2026 17:17:22 -0800
Message-ID: <20260225012351.942296011@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218939-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,huawei.com:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,goodmis.org:email]
X-Rspamd-Queue-Id: DF5E418FE59
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Jinghuang <chenjinghuang2@huawei.com>

[ Upstream commit 94894c9c477e53bcea052e075c53f89df3d2a33e ]

CPU0 becomes overloaded when hosting a CPU-bound RT task, a non-CPU-bound
RT task, and a CFS task stuck in kernel space. When other CPUs switch from
RT to non-RT tasks, RT load balancing (LB) is triggered; with
HAVE_RT_PUSH_IPI enabled, they send IPIs to CPU0 to drive the execution
of rto_push_irq_work_func. During push_rt_task on CPU0,
if next_task->prio < rq->donor->prio, resched_curr() sets NEED_RESCHED
and after the push operation completes, CPU0 calls rto_next_cpu().
Since only CPU0 is overloaded in this scenario, rto_next_cpu() should
ideally return -1 (no further IPI needed).

However, multiple CPUs invoking tell_cpu_to_push() during LB increments
rd->rto_loop_next. Even when rd->rto_cpu is set to -1, the mismatch between
rd->rto_loop and rd->rto_loop_next forces rto_next_cpu() to restart its
search from -1. With CPU0 remaining overloaded (satisfying rt_nr_migratory
&& rt_nr_total > 1), it gets reselected, causing CPU0 to queue irq_work to
itself and send self-IPIs repeatedly. As long as CPU0 stays overloaded and
other CPUs run pull_rt_tasks(), it falls into an infinite self-IPI loop,
which triggers a CPU hardlockup due to continuous self-interrupts.

The trigging scenario is as follows:

         cpu0                      cpu1                    cpu2
                                pull_rt_task
                              tell_cpu_to_push
                 <------------irq_work_queue_on
rto_push_irq_work_func
       push_rt_task
    resched_curr(rq)                                   pull_rt_task
    rto_next_cpu                                     tell_cpu_to_push
                      <-------------------------- atomic_inc(rto_loop_next)
rd->rto_loop != next
     rto_next_cpu
   irq_work_queue_on
rto_push_irq_work_func

Fix redundant self-IPI by filtering the initiating CPU in rto_next_cpu().
This solution has been verified to effectively eliminate spurious self-IPIs
and prevent CPU hardlockup scenarios.

Fixes: 4bdced5c9a29 ("sched/rt: Simplify the IPI based RT balancing logic")
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Jinghuang <chenjinghuang2@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://patch.msgid.link/20260122012533.673768-1-chenjinghuang2@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/rt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fb07dcfc60a24..d4d994fb8999a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2100,6 +2100,7 @@ static void push_rt_tasks(struct rq *rq)
  */
 static int rto_next_cpu(struct root_domain *rd)
 {
+	int this_cpu = smp_processor_id();
 	int next;
 	int cpu;
 
@@ -2123,6 +2124,10 @@ static int rto_next_cpu(struct root_domain *rd)
 
 		rd->rto_cpu = cpu;
 
+		/* Do not send IPI to self */
+		if (cpu == this_cpu)
+			continue;
+
 		if (cpu < nr_cpu_ids)
 			return cpu;
 
-- 
2.51.0




