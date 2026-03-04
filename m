Return-Path: <stable+bounces-223145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ECwHAuuqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:11:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5920208569
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D686031BF866
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0073DEAE1;
	Wed,  4 Mar 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfNYn5+F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A73DBD5E;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661781; cv=none; b=Uo77GZ51lUQXKq6HT/Y2013rG8gAuOWkEJEuWYsLQA3euonRfnnk1Gyv9yrvypHRbg3zbbKqrQbhtCH7FQGqj6q78NvApfq95iPhCUG9xAytoPYH1RH5L8zFbEzV1BdX31Ep4BxBiYvTzz77FdJueq/vdkjSkQ9THOobxZIJgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661781; c=relaxed/simple;
	bh=gUJnyYHpzbwPTZcyWxg+pe/cJjIBUydOkRcpy8tcmTU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qiCOJ+SL0x70KpKbHBKhI6K9kLod6f1rOgG1yNNUTDzmGIwP22KhTCC0sDtXzW+VY+WVfkMHpKRRAf1eAYMd0f3hlQCgA+IxJyxm2GRBBv9XaNO2E9KuD5AghYllLFP7s+N707fPNTN3tEtEwAWEXYO+GEJhALhf1yzjsZ6tdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfNYn5+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF262C2BC9E;
	Wed,  4 Mar 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661780;
	bh=gUJnyYHpzbwPTZcyWxg+pe/cJjIBUydOkRcpy8tcmTU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=KfNYn5+FlxQYmUzR9mL3JflNEG9qvvqIKFgDIiO4KRHBTys3M+G/4xo+TQj6g15VL
	 kJMNUDA4UcR4vAzkKpu/i1nVOnbowAIs3/tb1wM5Kf6uX4c/NFTpMBq51wndina8Mh
	 bYGYYJ0LJAP991v68LyJ6FxS3hQPcKouHET9hmynY5ZRj48QbswA14mfpbpOATXMsp
	 PpWSOddtI0m/H3FC1DLWDk0nx5VqZu2QdwN8Mx8fZT/MDgdytcS0+SedupFT3nCkw5
	 O7Ew7pOGpncHRCWUWvQjQiT+uhVd9xSYGbmF2BI9JKZHQHc0MmSoCmsOz0MrqV4CjQ
	 pM7Gmpbl7fVeQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vxuJe-00000003CSj-0c1C;
	Wed, 04 Mar 2026 17:03:38 -0500
Message-ID: <20260304220338.020708336@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 04 Mar 2026 17:03:24 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 5/6] tracing: Disable preemption in the tracepoint callbacks handling
 filtered pids
References: <20260304220319.218314827@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: D5920208569
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223145-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,efficios.com:email,goodmis.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Filtering PIDs for events triggered the following during selftests:

[37] event tracing - restricts events based on pid notrace filtering
[  155.874095]
[  155.874869] =============================
[  155.876037] WARNING: suspicious RCU usage
[  155.877287] 7.0.0-rc1-00004-g8cd473a19bc7 #7 Not tainted
[  155.879263] -----------------------------
[  155.882839] kernel/trace/trace_events.c:1057 suspicious rcu_dereference_check() usage!
[  155.889281]
[  155.889281] other info that might help us debug this:
[  155.889281]
[  155.894519]
[  155.894519] rcu_scheduler_active = 2, debug_locks = 1
[  155.898068] no locks held by ftracetest/4364.
[  155.900524]
[  155.900524] stack backtrace:
[  155.902645] CPU: 1 UID: 0 PID: 4364 Comm: ftracetest Not tainted 7.0.0-rc1-00004-g8cd473a19bc7 #7 PREEMPT(lazy)
[  155.902648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  155.902651] Call Trace:
[  155.902655]  <TASK>
[  155.902659]  dump_stack_lvl+0x67/0x90
[  155.902665]  lockdep_rcu_suspicious+0x154/0x1a0
[  155.902672]  event_filter_pid_sched_process_fork+0x9a/0xd0
[  155.902678]  kernel_clone+0x367/0x3a0
[  155.902689]  __x64_sys_clone+0x116/0x140
[  155.902696]  do_syscall_64+0x158/0x460
[  155.902700]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902702]  ? trace_irq_disable+0x1d/0xc0
[  155.902709]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  155.902711] RIP: 0033:0x4697c3
[  155.902716] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  155.902718] RSP: 002b:00007ffc41150428 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  155.902721] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004697c3
[  155.902722] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  155.902724] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000003fccf990
[  155.902725] R10: 000000003fccd690 R11: 0000000000000246 R12: 0000000000000001
[  155.902726] R13: 000000003fce8103 R14: 0000000000000001 R15: 0000000000000000
[  155.902733]  </TASK>
[  155.902747]

The tracepoint callbacks recently were changed to allow preemption. The
event PID filtering callbacks that were attached to the fork and exit
tracepoints expected preemption disabled in order to access the RCU
protected PID lists.

Add a guard(preempt)() to protect the references to the PID list.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260303215738.6ab275af@fedora
Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Link: https://patch.msgid.link/20260303131706.96057f61a48a34c43ce1e396@kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9c7f26cbe171..b7343fdfd7b0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1039,6 +1039,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 
@@ -1054,6 +1055,7 @@ event_filter_pid_sched_process_fork(void *data,
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
+	guard(preempt)();
 	pid_list = rcu_dereference_sched(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, self, task);
 
-- 
2.51.0



