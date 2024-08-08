Return-Path: <stable+bounces-66052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5B94BF91
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D40288BE9
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D018F2C3;
	Thu,  8 Aug 2024 14:21:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9418EFE1;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=uVfNRpXxCW5cM+MyNPswDTKYjzrcQMVWXDjUM+yGl6Cu+fY5XjT/qo2xNDX95KBlg3erGdDZMOPZM9HubUtue0TN8t3cwPHDo5/5hTOJFTBeZalOp+COW1tMl2tz/7BIQPiE3vuStKzSL4L7qM9fej/s81wNJhc7V2Me390TmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=UnOX5YQMGjLWkWbAK1IRlmM/ZvH8x7rVFb1Rl9qWXzc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GYqxMxEcC5hLnftYtbNPlrrFD5BnIVNB/Jzatcvlzh1W98yA7qhUINnBXFmW0GuKbQpd8f1XhP+MIH9eWEXB00t/BSj0bnzrP02/gyykGeFJxpIX5idpcJ8ktafBtd1tsv427VsDark+y1BMmtJPjYoXKPT9UAUxFkReSMwpCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D75C4AF19;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc416-00000000BSU-2BaL;
	Thu, 08 Aug 2024 10:21:24 -0400
Message-ID: <20240808142124.382913771@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 6/9] function_graph: Fix the ret_stack used by ftrace_graph_ret_addr()
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Pavlu <petr.pavlu@suse.com>

When ftrace_graph_ret_addr() is invoked to convert a found stack return
address to its original value, the function can end up producing the
following crash:

[   95.442712] BUG: kernel NULL pointer dereference, address: 0000000000000028
[   95.442720] #PF: supervisor read access in kernel mode
[   95.442724] #PF: error_code(0x0000) - not-present page
[   95.442727] PGD 0 P4D 0-
[   95.442731] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   95.442736] CPU: 1 UID: 0 PID: 2214 Comm: insmod Kdump: loaded Tainted: G           OE K    6.11.0-rc1-default #1 67c62a3b3720562f7e7db5f11c1fdb40b7a2857c
[   95.442747] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
[   95.442750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   95.442754] RIP: 0010:ftrace_graph_ret_addr+0x42/0xc0
[   95.442766] Code: [...]
[   95.442773] RSP: 0018:ffff979b80ff7718 EFLAGS: 00010006
[   95.442776] RAX: ffffffff8ca99b10 RBX: ffff979b80ff7760 RCX: ffff979b80167dc0
[   95.442780] RDX: ffffffff8ca99b10 RSI: ffff979b80ff7790 RDI: 0000000000000005
[   95.442783] RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
[   95.442786] R10: 0000000000000005 R11: 0000000000000000 R12: ffffffff8e9491e0
[   95.442790] R13: ffffffff8d6f70f0 R14: ffff979b80167da8 R15: ffff979b80167dc8
[   95.442793] FS:  00007fbf83895740(0000) GS:ffff8a0afdd00000(0000) knlGS:0000000000000000
[   95.442797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.442800] CR2: 0000000000000028 CR3: 0000000005070002 CR4: 0000000000370ef0
[   95.442806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   95.442809] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   95.442816] Call Trace:
[   95.442823]  <TASK>
[   95.442896]  unwind_next_frame+0x20d/0x830
[   95.442905]  arch_stack_walk_reliable+0x94/0xe0
[   95.442917]  stack_trace_save_tsk_reliable+0x7d/0xe0
[   95.442922]  klp_check_and_switch_task+0x55/0x1a0
[   95.442931]  task_call_func+0xd3/0xe0
[   95.442938]  klp_try_switch_task.part.5+0x37/0x150
[   95.442942]  klp_try_complete_transition+0x79/0x2d0
[   95.442947]  klp_enable_patch+0x4db/0x890
[   95.442960]  do_one_initcall+0x41/0x2e0
[   95.442968]  do_init_module+0x60/0x220
[   95.442975]  load_module+0x1ebf/0x1fb0
[   95.443004]  init_module_from_file+0x88/0xc0
[   95.443010]  idempotent_init_module+0x190/0x240
[   95.443015]  __x64_sys_finit_module+0x5b/0xc0
[   95.443019]  do_syscall_64+0x74/0x160
[   95.443232]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   95.443236] RIP: 0033:0x7fbf82f2c709
[   95.443241] Code: [...]
[   95.443247] RSP: 002b:00007fffd5ea3b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   95.443253] RAX: ffffffffffffffda RBX: 000056359c48e750 RCX: 00007fbf82f2c709
[   95.443257] RDX: 0000000000000000 RSI: 000056356ed4efc5 RDI: 0000000000000003
[   95.443260] RBP: 000056356ed4efc5 R08: 0000000000000000 R09: 00007fffd5ea3c10
[   95.443263] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[   95.443267] R13: 000056359c48e6f0 R14: 0000000000000000 R15: 0000000000000000
[   95.443272]  </TASK>
[   95.443274] Modules linked in: [...]
[   95.443385] Unloaded tainted modules: intel_uncore_frequency(E):1 isst_if_common(E):1 skx_edac(E):1
[   95.443414] CR2: 0000000000000028

The bug can be reproduced with kselftests:

 cd linux/tools/testing/selftests
 make TARGETS='ftrace livepatch'
 (cd ftrace; ./ftracetest test.d/ftrace/fgraph-filter.tc)
 (cd livepatch; ./test-livepatch.sh)

The problem is that ftrace_graph_ret_addr() is supposed to operate on the
ret_stack of a selected task but wrongly accesses the ret_stack of the
current task. Specifically, the above NULL dereference occurs when
task->curr_ret_stack is non-zero, but current->ret_stack is NULL.

Correct ftrace_graph_ret_addr() to work with the right ret_stack.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/20240803131211.17255-1-petr.pavlu@suse.com
Fixes: 7aa1eaef9f42 ("function_graph: Allow multiple users to attach to function graph")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index fc205ad167a9..d1d5ea2d0a1b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -902,7 +902,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 	i = *idx ? : task->curr_ret_stack;
 	while (i > 0) {
-		ret_stack = get_ret_stack(current, i, &i);
+		ret_stack = get_ret_stack(task, i, &i);
 		if (!ret_stack)
 			break;
 		/*
-- 
2.43.0



