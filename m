Return-Path: <stable+bounces-80744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B459904FA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9024A283602
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E485A215F50;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCE2141D0;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=fAN+vIYdtUeS6XADzU3tarSemeFBtv/B74ASjp+zy2SSUb8gbWMKQUDV6eceITl+wWuSAlq95P/ojat1rcH3n1tMlcZBUySV1+jKJ3LJ5D9u8DjoZcWlh8hPJ83vEzzkdYNPwfY8qV7dEN00W4GRtDgdU7wH4oTGF5+rdsRaDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=Vlvy5l4fmOohbA20KkO/nfnBsMBTpT7pZhN5CpbYE9U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EumchhNVOl6QUuwzGveG39Ydxwhd5ao/bh1Y+1nU7VWxz4g+P7blxzJ8XYLB3oAEY2MlFQs32XzQppTUIzy1qmrWm3AJILq+R43BB2zUKVQsciCVh6Ol1WdQ2S0eTzV52xuVFcF/XZuEFBnF6HGuhkMfAes8k0QtdsUVuavHCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5710C4CED9;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio8-00000005CAW-0PsF;
	Fri, 04 Oct 2024 09:57:24 -0400
Message-ID: <20241004135723.958450678@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:57:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Wei Li <liwei391@huawei.com>
Subject: [for-linus][PATCH 6/8] tracing/timerlat: Drop interface_lock in stop_kthread()
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wei Li <liwei391@huawei.com>

stop_kthread() is the offline callback for "trace/osnoise:online", since
commit 5bfbcd1ee57b ("tracing/timerlat: Add interface_lock around clearing
of kthread in stop_kthread()"), the following ABBA deadlock scenario is
introduced:

T1                            | T2 [BP]               | T3 [AP]
osnoise_hotplug_workfn()      | work_for_cpu_fn()     | cpuhp_thread_fun()
                              |   _cpu_down()         |   osnoise_cpu_die()
  mutex_lock(&interface_lock) |                       |     stop_kthread()
                              |     cpus_write_lock() |       mutex_lock(&interface_lock)
  cpus_read_lock()            |     cpuhp_kick_ap()   |

As the interface_lock here in just for protecting the "kthread" field of
the osn_var, use xchg() instead to fix this issue. Also use
for_each_online_cpu() back in stop_per_cpu_kthreads() as it can take
cpu_read_lock() again.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240924094515.3561410-3-liwei391@huawei.com
Fixes: 5bfbcd1ee57b ("tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()")
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index d1a539913a5f..e22567174dd3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,12 +1953,8 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	mutex_lock(&interface_lock);
-	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 	if (kthread) {
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
-		mutex_unlock(&interface_lock);
-
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1972,7 +1968,6 @@ static void stop_kthread(unsigned int cpu)
 			put_task_struct(kthread);
 		}
 	} else {
-		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1994,8 +1989,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	cpus_read_lock();
+
+	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
+
+	cpus_read_unlock();
 }
 
 /*
-- 
2.45.2



