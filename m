Return-Path: <stable+bounces-118616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1EA3F9C9
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A797519E0AAE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5E215053;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50668214A92;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153143; cv=none; b=Nlk6YbI0UsmhxDdemUL85zr0IziwEbKTb8ZyguJBzyWED8mA7eYNSwvrEaY0zOe20CFF2fIt9akf3k8tMhGjyXbohspjkieysgAw8fFudwlfSoePg3ykCLlDSqs+cOwRC1qo8jlU0Qwa9GfjGeRmBapPUexFVKk/RpOMIq+46Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153143; c=relaxed/simple;
	bh=gfvKqUGxKg/CSvEe34ixn+IucpV97z40xA3ev3jcZtw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O6rvPs24XKOsQCcTp3XOa05ujvClST+ObMw/lUumx74ZmU3A5W6ldxIF2YN2G8C7mBow6B2SIJ3bvcp5mKiGWL1cId2VR7v5tq0zn4ofzrCcL9NkhMZ4paCUEWi6ofRXm/HXRHxwp2hkgdY2Ie6CkaU63S8o/h2AC9F3BY0CuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6A7C4CEE9;
	Fri, 21 Feb 2025 15:52:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKe-00000006KT7-1P2l;
	Fri, 21 Feb 2025 10:52:52 -0500
Message-ID: <20250221155252.182535813@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Subject: [for-linus][PATCH 4/7] fprobe: Fix accounting of when to unregister from function graph
References: <20250221155210.755295517@goodmis.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250220202055.565129766@goodmis.org
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



