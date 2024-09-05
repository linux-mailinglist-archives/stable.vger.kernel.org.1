Return-Path: <stable+bounces-73669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17C96E48F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF731F2473B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7231A38DC;
	Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D958165F0E;
	Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570209; cv=none; b=kSlbyksr8gcRTGCTCl5OE1UmV3kixHthUNtZ6gfYD/9QLUGLgEul1PO1AMS8Ut/nQXhvfqUo80TBRtT6wgk1WAaj5o3seW+x3MKDEYga8gAOgABu9Poq9hGWoW6rj2oZpzIw3KVUSJWeneI1NMU4eSj0TvCjsCOmmsDbbBpy9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570209; c=relaxed/simple;
	bh=Y42E3MV/iaZOC/fZ+DHnliL/0n2bPZwko8Rr7rWfCkQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GaadTnxoxqjdC7PoBrIbAYr1rEDXa1SjPwZw7wO4N0m16GcQBbl+6pKS7Se5Smmmw07aJ9xmHS4A2eoYde/Ho8/r+ic5LEF+/OE6YBtN3gn2cPazjHmo44wE87Qi6TZvGMPUk1scy0b72uaclhLRoEzkktr3bf9nG2MJdnaam+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495BDC4CEC4;
	Thu,  5 Sep 2024 21:03:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1smJea-00000005KpW-30XW;
	Thu, 05 Sep 2024 17:04:32 -0400
Message-ID: <20240905210432.578892618@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 05 Sep 2024 17:04:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [for-linus][PATCH 2/2] tracing/timerlat: Add interface_lock around clearing of kthread in
 stop_kthread()
References: <20240905210412.128465542@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The timerlat interface will get and put the task that is part of the
"kthread" field of the osn_var to keep it around until all references are
released. But here's a race in the "stop_kthread()" code that will call
put_task_struct() on the kthread if it is not a kernel thread. This can
race with the releasing of the references to that task struct and the
put_task_struct() can be called twice when it should have been called just
once.

Take the interface_lock() in stop_kthread() to synchronize this change.
But to do so, the function stop_per_cpu_kthreads() needs to change the
loop from for_each_online_cpu() to for_each_possible_cpu() and remove the
cpu_read_lock(), as the interface_lock can not be taken while the cpu
locks are held. The only side effect of this change is that it may do some
extra work, as the per_cpu variables of the offline CPUs would not be set
anyway, and would simply be skipped in the loop.

Remove unneeded "return;" in stop_kthread().

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20240905113359.2b934242@gandalf.local.home
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 48e5014dd4ab..bbe47781617e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,8 +1953,12 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	mutex_lock(&interface_lock);
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
 	if (kthread) {
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+		mutex_unlock(&interface_lock);
+
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1967,8 +1971,8 @@ static void stop_kthread(unsigned int cpu)
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
 			put_task_struct(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	} else {
+		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1976,7 +1980,6 @@ static void stop_kthread(unsigned int cpu)
 			 */
 			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
 			barrier();
-			return;
 		}
 	}
 }
@@ -1991,12 +1994,8 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	cpus_read_lock();
-
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		stop_kthread(cpu);
-
-	cpus_read_unlock();
 }
 
 /*
-- 
2.43.0



