Return-Path: <stable+bounces-81454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF4993511
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C821C22908
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA21D6DA9;
	Mon,  7 Oct 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlEwiAWv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1723139587
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322314; cv=none; b=NJKwz8U2H0TdmsU1rJNuo4lN5d8WjNTQ/As3gT7flOACoQG+msOs/qtZACRHegkvzw2dPf4P47YrqsvBzajSj2cp9TDgWn2pL+doC7xws0C0vbnVk5mvbhoIwnwsFSwkv/l32metrjafIm+1X5bTi5yMoUm/F8vIr7mhea0mfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322314; c=relaxed/simple;
	bh=0qBJTvT1KFKOLWxJ2fQk8HhEle7LYxrL8pX1WeKPstQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pep0y/rputDxwziHbs9BG0gt+E9GJUpLAuCtogU8weWJQRGgennc0HWmbr+c0UHksyPQgm4cBL1IgrlaywUninVMPAVMsYxe9rXr5tZ47EOinElTTeAWmuuCrBuLhio7m6MYKSburibJy3JZMBxoL06DHhpqWSlzLk5tou467UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlEwiAWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCFCC4CEC6;
	Mon,  7 Oct 2024 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322313;
	bh=0qBJTvT1KFKOLWxJ2fQk8HhEle7LYxrL8pX1WeKPstQ=;
	h=Subject:To:Cc:From:Date:From;
	b=VlEwiAWv8bFvvpfh2ZP79HjGgCTEezJV1t6ehLwIMKlPPKEQMMybOFznJGJoYHGuq
	 8Af4jdIrmFpN9hmBfof6c0HidMMRscRlnUiR6X8Hp0n5EagVOGi4cB+tf96EofygoA
	 iSN/zI2T2fDrKmcQeNDXxR2Evb6swLST/Dhk/7CM=
Subject: FAILED: patch "[PATCH] tracing/timerlat: Fix duplicated kthread creation due to CPU" failed to apply to 5.15-stable tree
To: liwei391@huawei.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:31:42 +0200
Message-ID: <2024100741-amplify-possum-3dcb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0bb0a5c12ecf36ad561542bbb95f96355e036a02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-amplify-possum-3dcb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0bb0a5c12ecf ("tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline")
177e1cc2f412 ("tracing/osnoise: Use a cpumask to know what threads are kthreads")
e88ed227f639 ("tracing/timerlat: Add user-space interface")
4998e7fda149 ("tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable")
30838fcd8107 ("tracing/osnoise: Add OSNOISE_WORKLOAD option")
b179d48b6aab ("tracing/osnoise: Add osnoise/options file")
dd990352f01e ("tracing/osnoise: Make osnoise_main to sleep for microseconds")
11e4e3523da9 ("trace/osnoise: make use of the helper function kthread_run_on_cpu()")
b14f4568d391 ("tracing/osnoise: Remove STACKTRACE ifdefs from inside functions")
ccb6754495ef ("tracing/osnoise: Remove TIMERLAT ifdefs from inside functions")
dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
15ca4bdb0327 ("tracing/osnoise: Split workload start from the tracer start")
21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0bb0a5c12ecf36ad561542bbb95f96355e036a02 Mon Sep 17 00:00:00 2001
From: Wei Li <liwei391@huawei.com>
Date: Tue, 24 Sep 2024 17:45:11 +0800
Subject: [PATCH] tracing/timerlat: Fix duplicated kthread creation due to CPU
 online/offline

osnoise_hotplug_workfn() is the asynchronous online callback for
"trace/osnoise:online". It may be congested when a CPU goes online and
offline repeatedly and is invoked for multiple times after a certain
online.

This will lead to kthread leak and timer corruption. Add a check
in start_kthread() to prevent this situation.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240924094515.3561410-2-liwei391@huawei.com
Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1439064f65d6..d1a539913a5f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2007,6 +2007,10 @@ static int start_kthread(unsigned int cpu)
 	void *main = osnoise_main;
 	char comm[24];
 
+	/* Do not start a new thread if it is already running */
+	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+		return 0;
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
@@ -2061,11 +2065,10 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	}
 
 	for_each_cpu(cpu, current_mask) {


