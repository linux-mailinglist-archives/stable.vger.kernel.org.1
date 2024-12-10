Return-Path: <stable+bounces-100377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF289EAC9A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53255294AB8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851F223318;
	Tue, 10 Dec 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fElInyS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87F78F47
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823546; cv=none; b=hxCRDfWhBy+y6vW4xHg3BPIueuh0yUQvNrVXADmQ6OhCgBvKjlzq7Z7uibl7ruq8FC15sPv2VVGHK/Tzgnu7gt6CyFhlOobyJD/JOW6x5ReQw8OfNWW4MYxiRs+oBi2JLhENVX1jh1mym2qZ73WkUiTVSAy97KPQdVR/FocfuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823546; c=relaxed/simple;
	bh=52nl554tA/+UMTN7H/Z4Ex2b2YaZNLJxVom3hc6CQto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=THrxE1igMQjrtVFrpJpBVHhBAgEPQLyuT6VM/B65h7phTTTPnSYCD8CNJyzFbnkNUISRDKCeO8CrXEj8LOlOX8POcXECMvg7ERAXhI1rarwBvtDnJiIfU8ZG2y7KzWIHKif18rbCHaxt/b25FcNMBQ1SVdq3vFlprNBru6ImDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fElInyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F315C4CED6;
	Tue, 10 Dec 2024 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823546;
	bh=52nl554tA/+UMTN7H/Z4Ex2b2YaZNLJxVom3hc6CQto=;
	h=Subject:To:Cc:From:Date:From;
	b=1fElInySjAU3VhrFJB4XBQ2o9qV8BplHsfpIy2XJeU8/LnCX0CYtIZqv7uVl0SK0c
	 knegqxRH4E5JnbhjAF7nKvz8dyh4x3DEuq2Y7Pr99wiej8K8goL4bdkYj5tRbIoigo
	 fixFoA5DHd392v7uV1rUONPZjtSi9X8h84Jo2T6I=
Subject: FAILED: patch "[PATCH] sched/numa: fix memory leak due to the overwritten" failed to apply to 6.6-stable tree
To: ahuang12@lenovo.com,akpm@linux-foundation.org,bsegall@google.com,dietmar.eggemann@arm.com,juri.lelli@redhat.com,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,raghavendra.kt@amd.com,rostedt@goodmis.org,stable@vger.kernel.org,sunjw10@lenovo.com,vbabka@suse.cz,vincent.guittot@linaro.org,vschneid@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:37:50 +0100
Message-ID: <2024121049-manhandle-nintendo-724e@gregkh>
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
git cherry-pick -x 5f1b64e9a9b7ee9cfd32c6b2fab796e29bfed075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121049-manhandle-nintendo-724e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f1b64e9a9b7ee9cfd32c6b2fab796e29bfed075 Mon Sep 17 00:00:00 2001
From: Adrian Huang <ahuang12@lenovo.com>
Date: Wed, 13 Nov 2024 18:21:46 +0800
Subject: [PATCH] sched/numa: fix memory leak due to the overwritten
 vma->numab_state

[Problem Description]
When running the hackbench program of LTP, the following memory leak is
reported by kmemleak.

  # /opt/ltp/testcases/bin/hackbench 20 thread 1000
  Running with 20*40 (== 800) tasks.

  # dmesg | grep kmemleak
  ...
  kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
  kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xffff888cd8ca2c40 (size 64):
    comm "hackbench", pid 17142, jiffies 4299780315
    hex dump (first 32 bytes):
      ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc bff18fd4):
      [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
      [<ffffffff8113f715>] task_numa_work+0x725/0xa00
      [<ffffffff8110f878>] task_work_run+0x58/0x90
      [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
      [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
      [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...

This issue can be consistently reproduced on three different servers:
  * a 448-core server
  * a 256-core server
  * a 192-core server

[Root Cause]
Since multiple threads are created by the hackbench program (along with
the command argument 'thread'), a shared vma might be accessed by two or
more cores simultaneously. When two or more cores observe that
vma->numab_state is NULL at the same time, vma->numab_state will be
overwritten.

Although current code ensures that only one thread scans the VMAs in a
single 'numa_scan_period', there might be a chance for another thread
to enter in the next 'numa_scan_period' while we have not gotten till
numab_state allocation [1].

Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
cannot the reproduce the issue. It is verified with 200+ test runs.

[Solution]
Use the cmpxchg atomic operation to ensure that only one thread executes
the vma->numab_state assignment.

[1] https://lore.kernel.org/lkml/1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com/

Link: https://lkml.kernel.org/r/20241113102146.2384-1-ahuang12@lenovo.com
Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reported-by: Jiwei Sun <sunjw10@lenovo.com>
Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..a59ae2e23daf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3399,11 +3399,17 @@ static void task_numa_work(struct callback_head *work)
 
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
-			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
-				GFP_KERNEL);
-			if (!vma->numab_state)
+			struct vma_numab_state *ptr;
+
+			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+			if (!ptr)
 				continue;
 
+			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
+				kfree(ptr);
+				continue;
+			}
+
 			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
 
 			vma->numab_state->next_scan = now +


