Return-Path: <stable+bounces-249785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7ECDMOJzDWrSxgUAu9opvQ
	(envelope-from <stable+bounces-249785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32D589F8C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBFCB310C659
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072C3BADB6;
	Wed, 20 May 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2iEvvHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3P64RFxP"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332913BAD9C;
	Wed, 20 May 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266042; cv=none; b=r0gl3I2YukF/r6lb2QntU3qtjn8uQLTMWjXk3WJWdt8V9T4SNg8WySzYEthG9FU7uSoKSMJyN+ZiiXPU96eHbezjEbnQG6fJOkRRYMIkNMGtDtChzmgnuxs+z35db4meC1pET51ijN4nxmmjtdoQSje8+jcH1XsHbpU9DK93Yhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266042; c=relaxed/simple;
	bh=n24lq8I4Tj6r+9b0Eie//R4FmP7tXjhAddS5NdwHsIY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qpLtyG3PJYeMQcdI5p7yN0++gIpbTKiT1+uNjpAOD/BBassNnnPk4Wfztwg9WzlTMcFlgYjb8fVdt35L4mbMEozPp5gQ2hk31CW7LUFRu/+BIdRYGFZDAA3nHEdr8vSYXlqE+M0YKAKTP3+Bi9ceCJznl96V0CCRlvg3OW3neLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2iEvvHD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3P64RFxP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 May 2026 08:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEyHSLydSXBgoJytFAgglxdQ6AI7xczA0pyTghR0DnY=;
	b=x2iEvvHD0EdyqTedvs+8D6kSZfm7+FXAfguMA9Dts8wpuUuIdenY2MXTMjDfUBtf54+LOl
	yqySbiscAzQqSo5i1kMerkwaSvhDOaIvz7bgvGpLGiDDBTTnsMZvSZ55OzEMuzccIRLQbF
	WeeD4vjKr0TJ3HmKa8iwcJXMuxsN8T+HkUuBurt/2ZKN2BwIETDlQrwMriH/ciZh3rvVYP
	t6IVr7nnb2olluSw6MM3iaifVTXtSBdyZdZyw6r1oD2l/4ABXGJFm6r2m0kUVW8WRkd/VO
	/G4Kce9TA8fdY4eHm9ooxdG6CElSwtdXFIYLiZcY1cuzYogRefbKJdFprEulzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEyHSLydSXBgoJytFAgglxdQ6AI7xczA0pyTghR0DnY=;
	b=3P64RFxPquA4M0vfLvDgweaCxc0VO1QU+pB6+emNDl3zkfTNH10EGR9hNPFbOeWDr6ThvA
	tAEgcowrktgQo1BQ==
From: "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Have RT_PUSH_IPI be default off for non
 PREEMPT_RT
Cc: Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260515103740.25ccbed8@gandalf.local.home>
References: <20260515103740.25ccbed8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177926603830.711.2887528860384008788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249785-lists,stable=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3A32D589F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dd29c017aed628076e915fe4cdfb5392fd4c5cab
Gitweb:        https://git.kernel.org/tip/dd29c017aed628076e915fe4cdfb5392fd4=
c5cab
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Fri, 15 May 2026 10:37:40 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2026 12:17:39 +02:00

sched/rt: Have RT_PUSH_IPI be default off for non PREEMPT_RT

RT migration is done aggressively. When a CPU schedules out a high
priority RT task for a lower priority task, it will look to see if there's
any RT tasks that are waiting to run on another CPU that is of higher
priority than the task this CPU is about to run. If it finds one, it will
pull that task over to the CPU and allow it to run there instead.

Normally, this pulling is done by looking at the RT overloaded mask (rto)
which contains all the CPUs in the scheduler domain with RT tasks that are
waiting to run due to a higher priority RT task currently running on their
CPU. The CPU that is about to schedule a lower priority task will grab the
rq lock of the overloaded CPU and move the RT task from that CPU's runqueue
to the local one and schedule the higher priority RT task.

This caused issues when a lot of CPUs would schedule a lower priority task
at the same time. They would all try to grab the same runqueue lock of
the CPU with the overloaded RT tasks. Only the first CPU that got in will
get that task. All the others would wait until they got the runqueue lock
and see there's nothing to pull and do nothing. On systems with lots of
CPUs, this caused a large latency (up to 500us) which is beyond what
PREEMPT_RT is to allow.

The solution to that was to create an RT_PUSH_IPI logic. When any CPU
wanted to pull a task, instead of grabbing the runqueue lock of the
overloaded CPU, it would start by sending an IPI to the overloaded CPU,
and that IPI handler would have the CPU with the waiting RT task do a push
instead. Then that handler would send an IPI to the next CPU with
overloaded RT tasks, and so on. Note, after the first CPU starts this
process, if another CPU wanted to do a pull, it would see that the process
has already begun and would only increment a counter to have the IPIs
continue again.

The RT_PUSH_IPI solved the latency problem with PREEMPT_RT but could cause
a new issue with non PREEMPT_RT. Namely, softirqs run in a threaded
context on PREEMPT_RT but they can run in an interrupt context in non-RT.

If an IPI lands on a CPU that has just woken up multiple RT tasks and the
current CPU is running a non RT or a low priority RT task, instead of
doing a push, it would simply do a schedule on that CPU. But if a softirq
was also executing on this CPU, the schedule would need to wait until the
softirq finished. Until then, the CPU would still be considered overloaded
as there are RT tasks still waiting to run on it.

A live lock occurred on a workload that was doing heavy networking traffic
on a large machine where the softirqs would run 500us out of 750us. And it
would also be waking up RT tasks, causing the RT pull logic to be
constantly executed.

When a softirq triggered on a CPU with RT tasks queued but not running
yet, and the other CPUs would see this CPU as being overloaded, they would
send an IPI over to it. The CPU would notice that the waiting RT tasks are
of higher priority than the currently running task and simply schedule
that CPU instead. But because the softirq was executing, before it could
schedule, it would receive another IPI to do the same. The amount of IPIs
would slow down the currently running softirq so much that before it could
return back to task context, it would execute another softirq never
allowing the CPU to schedule. This live locked that CPU.

As RT_PUSH_IPI was created to help PREEMPT_RT, make it default off if
PREEMPT_RT is not enabled.

Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration ins=
tead of pulling")
Closes: https://lore.kernel.org/all/20260506235716.2530720-1-tj@kernel.org/
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260515103740.25ccbed8@gandalf.local.home
---
 kernel/sched/features.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 84c4fe3..8f0dee8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -110,8 +110,16 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
  * rq lock and possibly create a large contention, sending an
  * IPI to that CPU and let that CPU push the RT task to where
  * it should go may be a better scenario.
+ *
+ * This is best for PREEMPT_RT, but for non-RT it can cause issues
+ * when preemption is disabled for long periods of time. Have
+ * it only default enabled for PREEMPT_RT.
  */
+# ifdef CONFIG_PREEMPT_RT
 SCHED_FEAT(RT_PUSH_IPI, true)
+# else
+SCHED_FEAT(RT_PUSH_IPI, false)
+# endif
 #endif
=20
 SCHED_FEAT(RT_RUNTIME_SHARE, false)

