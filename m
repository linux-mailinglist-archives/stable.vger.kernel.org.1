Return-Path: <stable+bounces-80743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3869904FB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8791F22F3B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3000215F4C;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C02139C8;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=fxhNu1IhYzk9U6sIV1D9SJtv4ckg943Zy+C0vLHhZaV1URXGdNuZPgAhGJCW9J3rp7hryyEGeJ6YrTUgGNm/5yCkFywtXNSWcpE7vKeywdogUJCu7xcc7DokY20fE9lGkT8yam1vyEU9mmFezkOqZ6eZE4uK56WNvvLZ9kXfulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=k8cXzyqbg2s7qf7ZrUuCUbyXUbR4GVpJT/q3XIstq7o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IYb+jgtXxee+Ht2sMm6Y+rA9kvClxk5aFIh5Rk9MszB2ZUrPQqOh/6U39zgUaivsj5lOhbDdoL2afcLjpie2raqvdjSmuWG9RtbacwxNdhLOdtiSpZR/LxG7nDuzSA/tHeeRuuvVc8yq1Oq+pO3i++av4XJACnaO7T5PVIZL14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8632DC4CECF;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005CA2-3vqH;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135723.800438615@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:57:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Wei Li <liwei391@huawei.com>
Subject: [for-linus][PATCH 5/8] tracing/timerlat: Fix duplicated kthread creation due to CPU
 online/offline
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wei Li <liwei391@huawei.com>

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
---
 kernel/trace/trace_osnoise.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.45.2



