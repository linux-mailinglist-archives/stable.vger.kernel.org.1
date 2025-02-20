Return-Path: <stable+bounces-118514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FBA3E5B8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F8017C5C3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152C26463D;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80F26461F;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082828; cv=none; b=tr4oySuCYVJvO6djh1c3dG3RPda7vsfgM5mngsLKgDqTOmQ853RlXSZ9h6Qq71HD80cucdAcTeLvBT38lHpjCn1jIXToqM1mLEcTz6Ebmj/lSM4U3Fo13xiCCdGtMyPzo25jYNvdLWcq+5Bf5v3Ky8BPNZ5s01a08Tm+3nU2eO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082828; c=relaxed/simple;
	bh=pg0iNqHKlmSRSuqmH65Td4ieQjUxR+1Ri/ERlqUl3a0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KN0hbJTIFLT+jHcqiZ02LsGE+yuYniE4gsWbkJpJuub9iDxexqix03Ed77Dw9xV1VbcqQ5p7o2N1+W2CLel7mlPRTJT06/xfW6f9Tq7W9A2vQC0vIKCJF18ddbgvKsGm6DCZdjs3HN3bPmlgjAQt3xnvdhDp5IvbELHhzWVT8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F007C4CEE3;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlD2V-00000005fYH-2zep;
	Thu, 20 Feb 2025 15:20:55 -0500
Message-ID: <20250220202055.565129766@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 15:20:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 4/5] fprobe: Fix accounting of when to unregister from function graph
References: <20250220202009.689253424@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When adding a new fprobe, it will update the function hash to the
functions the fprobe is attached to and register with function graph to
have it call the registered functions. The fprobe_graph_active variable
keeps track of the number of fprobes that are using function graph.

If two fprobes attach to the same function, it increments the
fprobe_graph_active for each of them. But when they are removed, the first
fprobe to be removed will see that the function it is attached to is also
used by another fprobe and it will not remove that function from
function_graph. The logic will skip decrementing the fprobe_graph_active
variable.

This causes the fprobe_graph_active variable to not go to zero when all
fprobes are removed, and in doing so it does not unregister from
function graph. As the fgraph ops hash will now be empty, and an empty
filter hash means all functions are enabled, this triggers function graph
to add a callback to the fprobe infrastructure for every function!

 # echo "f:myevent1 kernel_clone" >> /sys/kernel/tracing/dynamic_events
 # echo "f:myevent2 kernel_clone%return" >> /sys/kernel/tracing/dynamic_events
 # cat /sys/kernel/tracing/enabled_functions
kernel_clone (1)           	tramp: 0xffffffffc0024000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60

 # > /sys/kernel/tracing/dynamic_events
 # cat /sys/kernel/tracing/enabled_functions
trace_initcall_start_cb (1)             tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
run_init_process (1)            tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
try_to_run_init_process (1)             tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
x86_pmu_show_pmu_cap (1)                tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
cleanup_rapl_pmus (1)                   tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
uncore_free_pcibus_map (1)              tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
uncore_types_exit (1)                   tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
uncore_pci_exit.part.0 (1)              tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
kvm_shutdown (1)                tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
vmx_dump_msrs (1)               tramp: 0xffffffffc0026000 (function_trace_call+0x0/0x170) ->function_trace_call+0x0/0x170
[..]

 # cat /sys/kernel/tracing/enabled_functions | wc -l
54702

If a fprobe is being removed and all its functions are also traced by
other fprobes, still decrement the fprobe_graph_active counter.

Cc: stable@vger.kernel.org
Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
Closes: https://lore.kernel.org/all/20250217114918.10397-A-hca@linux.ibm.com/
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fprobe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 62e8f7d56602..33082c4e8154 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -407,7 +407,8 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 	if (!fprobe_graph_active)
 		unregister_ftrace_graph(&fprobe_graph_ops);
 
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
+	if (num)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
 static int symbols_cmp(const void *a, const void *b)
@@ -677,8 +678,7 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
-	if (count)
-		fprobe_graph_remove_ips(addrs, count);
+	fprobe_graph_remove_ips(addrs, count);
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.47.2



