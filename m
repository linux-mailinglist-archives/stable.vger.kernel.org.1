Return-Path: <stable+bounces-43658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449608C426E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD36B286F21
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E1154443;
	Mon, 13 May 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jk3mhffE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CD153564
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607942; cv=none; b=JY81Mtr9PXr5i8VS/0ZMOei3+bVHCU1CTZqrG/rEorzGwbMwTlrWerfhhWQiN0rUAFPjMnd17PAjacDJGBrUvEQEPWUZKv06VE0Cx6Czavo5M8Qp9P7GQ2c69HD59qm89crO97lneVFs7lUi7XHsqAo/iZTVdgAa0UywMsaNDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607942; c=relaxed/simple;
	bh=VOtSL8S4/6XqUGko0rzn9nZLe26NX+UurEuPv19/2hQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ayrS1s0ad0wCcyDZkyz7ymzrDaZCO0GgnU+MbU+IhtcZo4wQDuuBXnInP4rOvHTWfb9v+JBxdn+u/gZhCgfdUEM1x4MQ0+y6eI0U4gcTnIOYp4e7fwkDn/tLHD3tGfOMV5I1ePwN62RIJFclLh5D8YuPZ25jU4BcY3uSsfhNEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jk3mhffE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD62CC4DDE3;
	Mon, 13 May 2024 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607942;
	bh=VOtSL8S4/6XqUGko0rzn9nZLe26NX+UurEuPv19/2hQ=;
	h=Subject:To:Cc:From:Date:From;
	b=jk3mhffE39orUm1639no/c4QAvGYkApOrROT4nmLe5xihi8uD4G10P0ARjKBUf9xZ
	 9OzbgMep8STcQ5F2xi+i4eJ5+ff+AxTf1O+Fy39qJ6cJLUHc5Z742ly+DtChGAeSUL
	 saDCfUcWpiCLu0lgwn1P5h6uL4n1YWGcwj7xGlqc=
Subject: FAILED: patch "[PATCH] workqueue: Fix divide error in wq_update_node_max_active()" failed to apply to 6.6-stable tree
To: jiangshan.ljs@antgroup.com,samsun1006219@gmail.com,tj@kernel.org,xrivendell7@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:45:31 +0200
Message-ID: <2024051331-lasso-junkie-d098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 91f098704c25106d88706fc9f8bcfce01fdb97df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051331-lasso-junkie-d098@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

91f098704c25 ("workqueue: Fix divide error in wq_update_node_max_active()")
5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
91ccc6e7233b ("workqueue: Introduce struct wq_node_nr_active")
9f66cff212bb ("workqueue: RCU protect wq->dfl_pwq and implement accessors for it")
c5404d4e6df6 ("workqueue: Make wq_adjust_max_active() round-robin pwqs while activating")
1c270b79ce0b ("workqueue: Move nr_active handling into helpers")
4c6380305d21 ("workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()")
afa87ce85379 ("workqueue: Factor out pwq_is_empty()")
a045a272d887 ("workqueue: Move pwq->max_active to wq->max_active")
31c89007285d ("workqueue.c: Increase workqueue name length")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91f098704c25106d88706fc9f8bcfce01fdb97df Mon Sep 17 00:00:00 2001
From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Date: Wed, 24 Apr 2024 21:51:54 +0800
Subject: [PATCH] workqueue: Fix divide error in wq_update_node_max_active()

Yue Sun and xingwei lee reported a divide error bug in
wq_update_node_max_active():

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 6.9.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:wq_update_node_max_active+0x369/0x6b0 kernel/workqueue.c:1605
Code: 24 bf 00 00 00 80 44 89 fe e8 83 27 33 00 41 83 fc ff 75 0d 41
81 ff 00 00 00 80 0f 84 68 01 00 00 e8 fb 22 33 00 44 89 f8 99 <41> f7
fc 89 c5 89 c7 44 89 ee e8 a8 24 33 00 89 ef 8b 5c 24 04 89
RSP: 0018:ffffc9000018fbb0 EFLAGS: 00010293
RAX: 00000000000000ff RBX: 0000000000000001 RCX: ffff888100ada500
RDX: 0000000000000000 RSI: 00000000000000ff RDI: 0000000080000000
RBP: 0000000000000001 R08: ffffffff815b1fcd R09: 1ffff1100364ad72
R10: dffffc0000000000 R11: ffffed100364ad73 R12: 0000000000000000
R13: 0000000000000100 R14: 0000000000000000 R15: 00000000000000ff
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb8c06ca6f8 CR3: 000000010d6c6000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 workqueue_offline_cpu+0x56f/0x600 kernel/workqueue.c:6525
 cpuhp_invoke_callback+0x4e1/0x870 kernel/cpu.c:194
 cpuhp_thread_fun+0x411/0x7d0 kernel/cpu.c:1092
 smpboot_thread_fn+0x544/0xa10 kernel/smpboot.c:164
 kthread+0x2ed/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

After analysis, it happens when all of the CPUs in a workqueue's affinity
get offine.

The problem can be easily reproduced by:

 # echo 8 > /sys/devices/virtual/workqueue/<any-wq-name>/cpumask
 # echo 0 > /sys/devices/system/cpu/cpu3/online

Use the default max_actives for nodes when all of the CPUs in the
workqueue's affinity get offline to fix the problem.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Link: https://lore.kernel.org/lkml/CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com/
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Cc: stable@vger.kernel.org
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5f536c63a48d..d2dbe099286b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1598,6 +1598,15 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 	if (off_cpu >= 0)
 		total_cpus--;
 
+	/* If all CPUs of the wq get offline, use the default values */
+	if (unlikely(!total_cpus)) {
+		for_each_node(node)
+			wq_node_nr_active(wq, node)->max = min_active;
+
+		wq_node_nr_active(wq, NUMA_NO_NODE)->max = max_active;
+		return;
+	}
+
 	for_each_node(node) {
 		int node_cpus;
 


