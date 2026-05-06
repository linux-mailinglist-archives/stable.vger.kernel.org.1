Return-Path: <stable+bounces-244468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJn0BGHV+2klFQAAu9opvQ
	(envelope-from <stable+bounces-244468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 01:57:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BA4E1A18
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 01:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A55D301944A
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 23:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771C36493E;
	Wed,  6 May 2026 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZuKhRao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915623183C;
	Wed,  6 May 2026 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111838; cv=none; b=Vdwa4L6bpw+QIP/6LPbmCUKLBKOl7PUiyPhdm1mcyx/Rr6HoSDppTh0QJiSgqGKLLQOKa/zmeRdVJviBykPGUTuvRtSHwmYXdDQb2IhqCLjxMEQMF9PyWrFI+znCCk8Ou4S3f75ImAHBk+UVbQH53uHvxkm/z9/bp/jf1df4mDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111838; c=relaxed/simple;
	bh=pnrxCZK0CdDAyCGbPQDjFHy4Z1SaLmMaisNGMLupLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJDcATw5iiCLlgIh0dj5zweuwyAWt4BOzTP9edCjq+MSjg76PqPmJX7UMnlADa0B+k8/2I5b1s2tto53sPAh2TCBjuVHuwsBxCFA9/hzJVR09YVk+TlHr6Q5sSrDaFifglyt3XCNQBG3qF0f9x9QVnAGuDOOhdgnVbgob6uJDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZuKhRao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7262C2BCB0;
	Wed,  6 May 2026 23:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778111837;
	bh=pnrxCZK0CdDAyCGbPQDjFHy4Z1SaLmMaisNGMLupLVA=;
	h=From:To:Cc:Subject:Date:From;
	b=HZuKhRaoR2/CxIW4cIh/zyiRaKCC7RjLS/u4MPcaB90N2INPf2cVZzSYn65Dba2QP
	 jA8MgXVC/c/wfyHs3FfRSm1UVnAoLUgNwGwv87SIeShP1Xt2IQMwQ/PQk+j0e9S85k
	 cBSeZeUwU07907hBoJEUxlHWp41cOZWscWZAAcvMKg0ri/vJNd/wlaEfD5vS1SmX1E
	 p8nG221poe6LghQvj9isfsqk1X2fvySDWdVCgr4B96q4eBVtY8td0qSLBokJ5zO4mE
	 tZc6X5pHDk8zM2mcXC9lumugsv9wTmHwOOWDBqdqASsWyDu5jmHHuZv8urEv5FBd8E
	 B9Lf7o9fOsfaw==
From: Tejun Heo <tj@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Date: Wed,  6 May 2026 13:57:16 -1000
Message-ID: <20260506235716.2530720-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 834BA4E1A18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244468-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

push_rt_task() picks the highest pushable RT task next_task. If it
outranks rq->donor, the existing path calls resched_curr() and
returns 0, trusting local schedule() to pick next_task soon.

The RT_PUSH_IPI relay caller (rto_push_irq_work_func()) cannot rely
on that. When this CPU has a steady supply of softirq work (e.g.,
incoming packets), the next push IPI arrives before schedule() can
run. Other CPUs keep seeing this CPU as overloaded and keep sending
IPIs, this CPU keeps taking the same bail, and the loop repeats
until soft lockup.

Seen in production on hosts with sustained NET_RX softirq load:
the loop ran millions of iterations before tripping the soft-lockup
watchdog.

Skip the prio bail when called via the IPI relay (pull=true) so
push_rt_task() migrates next_task to another CPU. Verified with a
synthetic reproducer.

Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")
Cc: Kyle McMartin <jkkm@meta.com>
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
This looks minimal to me, but happy for suggestions. Thanks.

 kernel/sched/rt.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1968,8 +1968,14 @@ retry:
 	 * It's possible that the next_task slipped in of
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
+	 *
+	 * This doesn't work for the IPI relay caller (pull). When this CPU
+	 * has a steady supply of softirq work (e.g., incoming packets), the
+	 * next push IPI arrives before schedule() can run. Other CPUs keep
+	 * seeing it as overloaded and keep sending IPIs, this CPU keeps
+	 * taking the same bail, and the loop repeats until soft lockup.
 	 */
-	if (unlikely(next_task->prio < rq->donor->prio)) {
+	if (unlikely(next_task->prio < rq->donor->prio) && !pull) {
 		resched_curr(rq);
 		return 0;
 	}

