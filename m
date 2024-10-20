Return-Path: <stable+bounces-86954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC09A534A
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D4A1C20EB7
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89412EBE7;
	Sun, 20 Oct 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n+odOK5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451212BB13
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416557; cv=none; b=OwNuAfOJPdFAx1Fpe7fCKsZg7f/G+mcB2LvVLlluJa/8hPzNut7F8Ex527cvTcuYtPXBMuxAf1JPOnBrTs6VBZNpHH/Fmt1WPzk9stnPctOSzo1Nv9ECxQwDfKaIg8SmlUUdgKTAfSGntekjoeh13o7UnL5fZQKocJtPUAgO8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416557; c=relaxed/simple;
	bh=HGapyhl68D8iG0vG6LZcK7vLeNtNmsSygh7AtfqYniI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G5B9Mb6q2drDJlIMZNh74TMxdhs3yqlfRkvsVDrKMabW11Z2L572CmcEHqIVp2A0KzZTH6VhrkZ5itVsdI2LTcMjXYAhS9NjIVfHHZ/ny7LEI9ICgo3ROgIOOh96itcEcWbhgpkxJ5atsM7kHkpKF6aDp+/AJMaQLnGY8Bs2ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n+odOK5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A05C4CEC6;
	Sun, 20 Oct 2024 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729416557;
	bh=HGapyhl68D8iG0vG6LZcK7vLeNtNmsSygh7AtfqYniI=;
	h=Subject:To:Cc:From:Date:From;
	b=n+odOK5weBrR6z3IDya/oNfcApkmqDYfISy0PkB85+bpbq7gxxWsYosSDMN9MtPF+
	 lI2VNKZsmtEvgJVzGTVtG0nVKGysSEXfCDBhbllHWcW4dueW9sn3wMZ2IvJ6aBTFWE
	 vxe//2HLOnEDZtGJKV1PKer+cuqCPHK2/FxpBzv0=
Subject: FAILED: patch "[PATCH] fgraph: Use CPU hotplug mechanism to initialize idle shadow" failed to apply to 4.19-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Oct 2024 11:29:01 +0200
Message-ID: <2024102001-badly-overvalue-6662@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2c02f7375e658ae93d57a31a66f91b62754ef8f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102001-badly-overvalue-6662@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


