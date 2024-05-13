Return-Path: <stable+bounces-43657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD38C426D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9511F20C27
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268915444E;
	Mon, 13 May 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SiE4nhvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170215444A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607933; cv=none; b=lmH8/gTf+600De1HXDIKNHYPUMLUce2CTxrHUnWd9R+TQrLNqflbmXTGrC0tfqz29Go4U+jkbNdLQpCmuqlTqYGqoLwmEDmtHCYbig59x93ryj6HpSv9SN3i9CFhydqFV9y93doFX1E3hfiinadfPceNIVIiT2Ky9xcVI0YarNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607933; c=relaxed/simple;
	bh=7bVSSTbOIG8jrldqJ/2XWJ24MalQP8wtlS6jEVcy6qk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m6/JMed5o6Lu5AsGgJuFFbvxjby2EQ/Y8gaqQlZ7sABqLbEtrJcCdDgzmpiDZCAiQLsfKOShkoBRkK4/5ZRj0ZlqRYTZqdUgaho72zSceKR8PpNDPrllBy0Dr5JAZdybDC+k/V0e8zavyAaT4tEqaN/xKRw/4ghywNmB6YENaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SiE4nhvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A10C32781;
	Mon, 13 May 2024 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607933;
	bh=7bVSSTbOIG8jrldqJ/2XWJ24MalQP8wtlS6jEVcy6qk=;
	h=Subject:To:Cc:From:Date:From;
	b=SiE4nhvyyH9KvCJHxwr1ir2vy71kOoioKsm8GS0TCQTWCZZFF82YmDp3AeAexhUJj
	 56C8sZkP0JVd59qoPGzFHX6crDs07eKpRqh1N+C+D/4GWb8ZUjsyq3ipB7S1dAgmZw
	 y6wMt7t19thd4CJIvubaN/o+oVsoiJbW6oj75LjE=
Subject: FAILED: patch "[PATCH] workqueue: Fix divide error in wq_update_node_max_active()" failed to apply to 6.8-stable tree
To: jiangshan.ljs@antgroup.com,samsun1006219@gmail.com,tj@kernel.org,xrivendell7@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:45:29 +0200
Message-ID: <2024051329-golf-handwoven-298c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 91f098704c25106d88706fc9f8bcfce01fdb97df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051329-golf-handwoven-298c@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

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
 


