Return-Path: <stable+bounces-81453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79792993510
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389D8281716
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F2139587;
	Mon,  7 Oct 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oecTQCA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCE17740
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322304; cv=none; b=Ph40cqGAMGgk3yhwUqVEkrNwt5sZmtuB5c262eyJI43/YdRlf4VfeglxVrdNugQd++TTjm9ZPNOUuswFvEXTDDNpr5Vk2Yg+Vu67kclkuzWvffJL9Zw9KH7gWBNfURKF3BxmzDMIjYrzPY2Nu8FG4rnJuZ6oP3neU54dEAtGm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322304; c=relaxed/simple;
	bh=OP2imvaz6xibDXZyen9WGt+p0QUyOie0K9VPVHxEASA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j6RNPTtF2lM/cIptD2mlSlmL1JqQBDdc3Nmo0CN7hr5kRsKDB+a1YrS/5UetbmGGM2aP5oHnh36Tx7D5xY2saNu7LkEpqSuqtH0kby+8PFuuXIfJUx6GRG0tRwQN1ShWUPwxiS7fAlW2pphcD8SaPFCDIvxKu0y2UOellrzNMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oecTQCA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A57C4CEC6;
	Mon,  7 Oct 2024 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322304;
	bh=OP2imvaz6xibDXZyen9WGt+p0QUyOie0K9VPVHxEASA=;
	h=Subject:To:Cc:From:Date:From;
	b=oecTQCA5GE9WdC20yDfXqjUY+w7D4bqXBZpEH4I78Fh6k4vW1V1wydZiV6/d/mEs+
	 eujksgo4a29+Qj3SjamYfkz1unRfGPTkfq8Vr58x4lTLOivoIdzojiZeFfi1XXHMff
	 /0FptZ4O2xsaQ0GNRckUFbrfszXNap2GSbVe1grU=
Subject: FAILED: patch "[PATCH] tracing/timerlat: Fix duplicated kthread creation due to CPU" failed to apply to 6.1-stable tree
To: liwei391@huawei.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:31:41 +0200
Message-ID: <2024100741-afoot-canal-db89@gregkh>
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
git cherry-pick -x 0bb0a5c12ecf36ad561542bbb95f96355e036a02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-afoot-canal-db89@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0bb0a5c12ecf ("tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline")
177e1cc2f412 ("tracing/osnoise: Use a cpumask to know what threads are kthreads")
e88ed227f639 ("tracing/timerlat: Add user-space interface")
4998e7fda149 ("tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable")
30838fcd8107 ("tracing/osnoise: Add OSNOISE_WORKLOAD option")
b179d48b6aab ("tracing/osnoise: Add osnoise/options file")

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


