Return-Path: <stable+bounces-90608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A19BE92F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D346F1F23336
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB31DFE27;
	Wed,  6 Nov 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2wICfar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD31D5AB5;
	Wed,  6 Nov 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896277; cv=none; b=Ic8eLUFOyafyYXZRXPveqhtbm3GQB70Xbnuv8h0fR+MUV878y66BpZTlPGFL1SgT9TN/2PG6spOewn85abVBHobYSUIQbfi/GMHb4gfYpCWahVuOUopR9Kul5Igg0ZnKmNc8XnovphApoFHivUeFFXUswMbD3iHOcIvYmhvXBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896277; c=relaxed/simple;
	bh=scyAAxIutKdOD848z/F4NJVFwvWMUhZ1oob255UkWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3Zr6UZxH4bSW/PS/PrrPXUgZT72dLCw9h9lizbm6ojnCa9wIrpoOusunlD6/qirbyM5uYQBmABSWlT0sRn9zTUD/NdYJeeUbIff+lKxSC2vPas7G8aj0jXjFhOF5c4VO6rptEMZqv5sjqx/y65RT6KiGDAIHSqT+5LHhTfMagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2wICfar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF077C4CECD;
	Wed,  6 Nov 2024 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896277;
	bh=scyAAxIutKdOD848z/F4NJVFwvWMUhZ1oob255UkWY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2wICfarRJM6sdQ4CStgby9LErRXBzK/VnS1UdT0kv9N4FcrgqesOWT+91wA1AcAR
	 jh3J8vBPE0S24kziFP0MTFL/+bxSmxYMM+rK9VFkQeP187m7KX42zQs9WEJj8lH74w
	 og7ZkrvKEvYfWnvCi5gZxUhoB9kZXQYGvK5f9SGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 148/245] cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
Date: Wed,  6 Nov 2024 13:03:21 +0100
Message-ID: <20241106120322.873173839@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 117932eea99b729ee5d12783601a4f7f5fd58a23 ]

A hung_task problem shown below was found:

INFO: task kworker/0:0:8 blocked for more than 327 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Workqueue: events cgroup_bpf_release
Call Trace:
 <TASK>
 __schedule+0x5a2/0x2050
 ? find_held_lock+0x33/0x100
 ? wq_worker_sleeping+0x9e/0xe0
 schedule+0x9f/0x180
 schedule_preempt_disabled+0x25/0x50
 __mutex_lock+0x512/0x740
 ? cgroup_bpf_release+0x1e/0x4d0
 ? cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? cgroup_bpf_release+0x1e/0x4d0
 ? mutex_lock_nested+0x2b/0x40
 ? __pfx_delay_tsc+0x10/0x10
 mutex_lock_nested+0x2b/0x40
 cgroup_bpf_release+0xcf/0x4d0
 ? process_scheduled_works+0x161/0x8a0
 ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
 ? process_scheduled_works+0x161/0x8a0
 process_scheduled_works+0x23a/0x8a0
 worker_thread+0x231/0x5b0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x14d/0x1c0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x59/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

This issue can be reproduced by the following pressuse test:
1. A large number of cpuset cgroups are deleted.
2. Set cpu on and off repeatly.
3. Set watchdog_thresh repeatly.
The scripts can be obtained at LINK mentioned above the signature.

The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
acquired in different tasks, which may lead to deadlock.
It can lead to a deadlock through the following steps:
1. A large number of cpusets are deleted asynchronously, which puts a
   large number of cgroup_bpf_release works into system_wq. The max_active
   of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
   cgroup_bpf_release works, and many cgroup_bpf_release works will be put
   into inactive queue. As illustrated in the diagram, there are 256 (in
   the acvtive queue) + n (in the inactive queue) works.
2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
   smp_call_on_cpu work into system_wq. However step 1 has already filled
   system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
   to wait until the works that were put into the inacvtive queue earlier
   have executed (n cgroup_bpf_release), so it will be blocked for a while.
3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
4. Cpusets that were deleted at step 1 put cgroup_release works into
   cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
   When cgroup_metux is acqured by work at css_killed_work_fn, it will
   call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
   However, cpuset_css_offline will be blocked for step 3.
5. At this moment, there are 256 works in active queue that are
   cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
   a result, all of them are blocked. Consequently, sscs.work can not be
   executed. Ultimately, this situation leads to four processes being
   blocked, forming a deadlock.

system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
...
2000+ cgroups deleted asyn
256 actives + n inactives
				__lockup_detector_reconfigure
				P(cpu_hotplug_lock.read)
				put sscs.work into system_wq
256 + n + 1(sscs.work)
sscs.work wait to be executed
				warting sscs.work finish
								percpu_down_write
								P(cpu_hotplug_lock.write)
								...blocking...
											css_killed_work_fn
											P(cgroup_mutex)
											cpuset_css_offline
											P(cpu_hotplug_lock.read)
											...blocking...
256 cgroup_bpf_release
mutex_lock(&cgroup_mutex);
..blocking...

To fix the problem, place cgroup_bpf_release works on a dedicated
workqueue which can break the loop and solve the problem. System wqs are
for misc things which shouldn't create a large number of concurrent work
items. If something is going to generate >WQ_DFL_ACTIVE(256) concurrent
work items, it should use its own dedicated workqueue.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Cc: stable@vger.kernel.org # v5.3+
Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a2395..479a2ea5d9af6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,23 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+/*
+ * cgroup bpf destruction makes heavy use of work items and there can be a lot
+ * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
+ * destruction work items don't end up filling up max_active of system_wq
+ * which may lead to deadlock.
+ */
+static struct workqueue_struct *cgroup_bpf_destroy_wq;
+
+static int __init cgroup_bpf_wq_init(void)
+{
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	if (!cgroup_bpf_destroy_wq)
+		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
+	return 0;
+}
+core_initcall(cgroup_bpf_wq_init);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -334,7 +351,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
-- 
2.43.0




