Return-Path: <stable+bounces-116817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F85A3A7A1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91DD189061A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5D271294;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DE270EDE;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907064; cv=none; b=isbJVp0r9byJD2LIMwRnxd6gaJsGDpUCoXCgJ5URROMCrgfvJ+geVHneXUJDubh4ODTAIuaJzJR0cq+w/QLh6cPazwX2i3o+cdgdKHhjlByhaG0NYeY9Jb+nU9R6UyFkLV4fHCw1YcVW7+Eu5pM3CBocFYRy5oXFzZLvYe1EbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907064; c=relaxed/simple;
	bh=M7fCrUMkcJFL3ZqgFUjk+rKtBC8bW07j+zFJYfrD5jo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rzDd//8qFG7K4X0NTmADo28HLV3IbsxlLiXmAantCiTDKgqbwL4VdMAK9Ea1aIh0W3fiixo0zoV+k35vQ59DCwAyYacvKDO2xusF2y+EYm2PZ8/YJETZkXhkJUmAY88GYxOWWbjOR35OfS5c0BnYh6frmUTrycYjyxk9uCC0SFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FCDC4CEEE;
	Tue, 18 Feb 2025 19:31:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTJW-00000004A0N-3Dpy;
	Tue, 18 Feb 2025 14:31:26 -0500
Message-ID: <20250218193126.619197190@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:30:36 -0500
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
Subject: [PATCH 3/5] fprobe: Fix accounting of when to unregister from function graph
References: <20250218193033.338823920@goodmis.org>
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
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 2560b312ad57..90241091ca61 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -681,6 +681,8 @@ int unregister_fprobe(struct fprobe *fp)
 
 	if (count)
 		fprobe_graph_remove_ips(addrs, count);
+	else
+		fprobe_graph_active--;
 
 	kfree_rcu(hlist_array, rcu);
 	fp->hlist_array = NULL;
-- 
2.47.2



