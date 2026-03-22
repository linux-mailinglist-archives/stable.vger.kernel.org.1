Return-Path: <stable+bounces-227808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHDBN3xdv2ku3gMAu9opvQ
	(envelope-from <stable+bounces-227808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:09:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4082E80C5
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634ED300EFAD
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390E37DEAD;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1JFfRde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698A37106D;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774148974; cv=none; b=r5TZZJu5UQ9k1AhFYqfwiQVb37BGDXei3aQ5KxFGwBbFhs91r8DwRANpV+hKm/AVJGI8lKXLPyl3C6Yri0FZXfvvjFNqwSch37N/Z3oDMVw0J/T3/UVp/m+PBNMBBRV9vLqS9dl73KYA6x5cMixSfMgJ1JlkKcKlB81qkfCnv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774148974; c=relaxed/simple;
	bh=8Uh/2C2chpwUjdNna2gkJd6YPMWhIiCHZHB2dwFsr64=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DawPGAPqyKdy3kF4sWR6+zV1JtgjnGYLIh/+VeeHeslvWdha8A+4OMWAYOYLxYA09Q9jrBk5NXX+Zh6uDtb9MZTm1+FmMkAfOrjuLDUl9ncIPMSDLW0IVxNr+Xlm5Ufntdcd/ppeOJyj3HH8hcRCq0QgEGmfTT5RyjpBl8VdRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1JFfRde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B2BC2BCB4;
	Sun, 22 Mar 2026 03:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774148973;
	bh=8Uh/2C2chpwUjdNna2gkJd6YPMWhIiCHZHB2dwFsr64=;
	h=Date:From:To:Cc:Subject:References:From;
	b=t1JFfRde5MmXavnxWQsfvd0KCUteupz0nTfbJOYGVCHgqZdNk8MxdYU/q8M7vVLsG
	 ibtH6KCeLFlCenMAvCy7tDqjEEIL6xrX334mXemNIf7yhr7/kchdIYkU2D61cWcjz7
	 yDt8t8mDS9FzfOBA0Cz9LIfg8CA7/Mdf/egAZsIuIhaVjWgJoC7VNt70gXdJio4Aj8
	 o5TAT7GRrmmtzo8O4Kaw4KTpsSxPOWXHS7PgKF06RJHWmIAt/wDGEWeFz8sAlylPGs
	 dOUjZJE1Sk0mAdVLfWxAF9m0LTRSPK1KV/81IayE+SjUXK1ezrH4x0+jbKowu+u20o
	 c9Jly58edVJPg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w49Cc-0000000B7jn-1T1A;
	Sat, 21 Mar 2026 23:10:10 -0400
Message-ID: <20260322031010.191529722@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 21 Mar 2026 23:09:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/5] tracing: Fix failure to read user space from system call trace events
References: <20260322030954.198361547@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227808-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4082E80C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steven Rostedt <rostedt@goodmis.org>

The system call trace events call trace_user_fault_read() to read the user
space part of some system calls. This is done by grabbing a per-cpu
buffer, disabling migration, enabling preemption, calling
copy_from_user(), disabling preemption, enabling migration and checking if
the task was preempted while preemption was enabled. If it was, the buffer
is considered corrupted and it tries again.

There's a safety mechanism that will fail out of this loop if it fails 100
times (with a warning). That warning message was triggered in some
pi_futex stress tests. Enabling the sched_switch trace event and
traceoff_on_warning, showed the problem:

 pi_mutex_hammer-1375    [006] d..21   138.981648: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981651: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981656: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981659: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981664: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981667: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981671: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981675: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981679: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981682: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981687: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981690: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981695: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981698: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981703: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981706: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981711: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981714: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981719: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981722: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981727: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981730: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95
 pi_mutex_hammer-1375    [006] d..21   138.981735: sched_switch: prev_comm=pi_mutex_hammer prev_pid=1375 prev_prio=95 prev_state=R+ ==> next_comm=migration/6 next_pid=47 next_prio=0
     migration/6-47      [006] d..2.   138.981738: sched_switch: prev_comm=migration/6 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=pi_mutex_hammer next_pid=1375 next_prio=95

What happened was the task 1375 was flagged to be migrated. When
preemption was enabled, the migration thread woke up to migrate that task,
but failed because migration for that task was disabled. This caused the
loop to fail to exit because the task scheduled out while trying to read
user space.

Every time the task enabled preemption the migration thread would schedule
in, try to migrate the task, fail and let the task continue. But because
the loop would only enable preemption with migration disabled, it would
always fail because each time it enabled preemption to read user space,
the migration thread would try to migrate it.

To solve this, when the loop fails to read user space without being
scheduled out, enabled and disable preemption with migration enabled. This
will allow the migration task to successfully migrate the task and the
next loop should succeed to read user space without being scheduled out.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260316130734.1858a998@gandalf.local.home
Fixes: 64cf7d058a005 ("tracing: Have trace_marker use per-cpu data to read user space")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebd996f8710e..bb4a62f4b953 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6783,6 +6783,23 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 	 */
 
 	do {
+		/*
+		 * It is possible that something is trying to migrate this
+		 * task. What happens then, is when preemption is enabled,
+		 * the migration thread will preempt this task, try to
+		 * migrate it, fail, then let it run again. That will
+		 * cause this to loop again and never succeed.
+		 * On failures, enabled and disable preemption with
+		 * migration enabled, to allow the migration thread to
+		 * migrate this task.
+		 */
+		if (trys) {
+			preempt_enable_notrace();
+			preempt_disable_notrace();
+			cpu = smp_processor_id();
+			buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		}
+
 		/*
 		 * If for some reason, copy_from_user() always causes a context
 		 * switch, this would then cause an infinite loop.
-- 
2.51.0



