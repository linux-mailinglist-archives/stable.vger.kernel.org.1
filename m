Return-Path: <stable+bounces-86950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDA9A5347
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81582281D18
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071E12EBE7;
	Sun, 20 Oct 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vSbFNHuA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACE2BB13
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416542; cv=none; b=nW3zagAF3NclL5zJ2G1oF91TyHcqfHPPFv+kkZw021peeRNnYmfptrP3qptm0msNmBmpg0YW9CNhDhWT8k5KQBSy4ynMjwZUEa5ao2s/5Xjfpouv1Uo7xK/6LnIcwSlb+YY81nA47VgYd8EDW3Mi4B6GguoJYx5AJmbSpoaqVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416542; c=relaxed/simple;
	bh=0Hn6B1y/VAfWKZvl3RVbYV8JqvFw89s2HOAfKZVm11I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ieI01umdsn6eahylK9o/3nnkUXtWeVGm39EYNj5waz9JaY6L3NwcayUzlyVdcq2yRqgUp+WFPOoIC64Y/lOoRNAVBlGMW2sPPq/hflj2hOPp4uFY04IGQQKa9GS19UYvarWKCpFr4Mbc+cPLJYLoMsZoXX0pMndoqpJwZHHW2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vSbFNHuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBFBC4CEC6;
	Sun, 20 Oct 2024 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416542;
	bh=0Hn6B1y/VAfWKZvl3RVbYV8JqvFw89s2HOAfKZVm11I=;
	h=Subject:To:Cc:From:Date:From;
	b=vSbFNHuAYILkgoQ+umGV7BB7DzwHDspLwwavwiCQFOBysX8Oh/9x4Cgei0z4i166K
	 s2ZCwdYaCCG1VxPO37hBEDUy5FuEo60ehK4mk5Wfei+DdHFO6kWrLwqOb8iJMuatHm
	 go4C0ArZvZVUyT87QWrUMzIi1J4EVVJyrQxrazXc=
Subject: FAILED: patch "[PATCH] fgraph: Use CPU hotplug mechanism to initialize idle shadow" failed to apply to 6.1-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:28:55 +0200
Message-ID: <2024102055-nugget-delicious-edfe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2c02f7375e658ae93d57a31a66f91b62754ef8f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102055-nugget-delicious-edfe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c02f7375e658ae93d57a31a66f91b62754ef8f1 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 18 Oct 2024 21:43:00 -0400
Subject: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle shadow
 stacks

The function graph infrastructure allocates a shadow stack for every task
when enabled. This includes the idle tasks. The first time the function
graph is invoked, the shadow stacks are created and never freed until the
task exits. This includes the idle tasks.

Only the idle tasks that were for online CPUs had their shadow stacks
created when function graph tracing started. If function graph tracing is
enabled and a CPU comes online, the idle task representing that CPU will
not have its shadow stack created, and all function graph tracing for that
idle task will be silently dropped.

Instead, use the CPU hotplug mechanism to allocate the idle shadow stacks.
This will include idle tasks for CPUs that come online during tracing.

This issue can be reproduced by:

 # cd /sys/kernel/tracing
 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # echo 0 > set_ftrace_pid
 # echo function_graph > current_tracer
 # echo 1 > options/funcgraph-proc
 # echo 1 > /sys/devices/system/cpu/cpu1
 # grep '<idle>' per_cpu/cpu1/trace | head

Before, nothing would show up.

After:
 1)    <idle>-0    |   0.811 us    |                        __enqueue_entity();
 1)    <idle>-0    |   5.626 us    |                      } /* enqueue_entity */
 1)    <idle>-0    |               |                      dl_server_update_idle_time() {
 1)    <idle>-0    |               |                        dl_scaled_delta_exec() {
 1)    <idle>-0    |   0.450 us    |                          arch_scale_cpu_capacity();
 1)    <idle>-0    |   1.242 us    |                        }
 1)    <idle>-0    |   1.908 us    |                      }
 1)    <idle>-0    |               |                      dl_server_start() {
 1)    <idle>-0    |               |                        enqueue_dl_entity() {
 1)    <idle>-0    |               |                          task_contending() {

Note, if tracing stops and restarts, the old way would then initialize
the onlined CPUs.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20241018214300.6df82178@rorschach
Fixes: 868baf07b1a25 ("ftrace: Fix memory leak with function graph and cpu hotplug")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..43f4e3f57438 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1160,19 +1160,13 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret, cpu;
+	int ret;
 
 	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
 
-	/* The cpu_boot init_task->ret_stack will never be freed */
-	for_each_online_cpu(cpu) {
-		if (!idle_task(cpu)->ret_stack)
-			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
-	}
-
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
@@ -1242,14 +1236,34 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	fgraph_direct_gops = &fgraph_stub;
 }
 
+/* The cpu_boot init_task->ret_stack will never be freed */
+static int fgraph_cpu_init(unsigned int cpu)
+{
+	if (!idle_task(cpu)->ret_stack)
+		ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	return 0;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	static bool fgraph_initialized;
 	int command = 0;
 	int ret = 0;
 	int i = -1;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!fgraph_initialized) {
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+					fgraph_cpu_init, NULL);
+		if (ret < 0) {
+			pr_warn("fgraph: Error to init cpu hotplug support\n");
+			return ret;
+		}
+		fgraph_initialized = true;
+		ret = 0;
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)


