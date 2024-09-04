Return-Path: <stable+bounces-73114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7D96CAEB
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 01:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB4DB212FD
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5818592C;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7126179958;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493406; cv=none; b=OtHwDFHRL58S1dIcVJleFLFKVY1BvzRrmhTk033Rt/wfraeV8Dov+/TjtYbqZr3+BGLiq5adeJGL8d1ffI5yB2wtm6BC+vJHGq1NGqU62bIGRZmhCBnW1q7n0DyWaE6DLxSvIFo8Gh63gcMjy4EbBh/2o+SuUZO5Jetr8Ut9Rt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493406; c=relaxed/simple;
	bh=z1Hmdig6/sKfwwjYdO9D6QFTtvoQAzQOiSHpFgUeDn8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bUmXP+Hv68rRFqargBL1yu5t9e5OkiKZv7uvhx7tcvCOJgD/NnRAO20RMyQo6DpKVfcAmjrR3GYiM9MUXPQaLajk76izzZb2/n3A1oPoQdXjMVkgRJHFg/g6qGeGZlHmpVUTWIdArLL4LBHzX9OZpA/97GGScrvPC8l2nRlH2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51857C4CEC3;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfo-00000005BoO-0GyU;
	Wed, 04 Sep 2024 19:44:28 -0400
Message-ID: <20240904234427.927438809@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: [for-linus][PATCH 3/6] tracing/timerlat: Only clear timer if a kthread exists
References: <20240904234411.443593140@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The timerlat tracer can use user space threads to check for osnoise and
timer latency. If the program using this is killed via a SIGTERM, the
threads are shutdown one at a time and another tracing instance can start
up resetting the threads before they are fully closed. That causes the
hrtimer assigned to the kthread to be shutdown and freed twice when the
dying thread finally closes the file descriptors, causing a use-after-free
bug.

Only cancel the hrtimer if the associated thread is still around.

Note, this is just a quick fix that can be backported to stable. A real
fix is to have a better synchronization between the shutdown of old
threads and the starting of new ones.

Link: https://lore.kernel.org/all/20240820130001.124768-1-tglozar@redhat.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20240903111642.35292e70@gandalf.local.home
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..400a72cd6ab5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -265,6 +265,8 @@ static inline void tlat_var_reset(void)
 	 */
 	for_each_cpu(cpu, cpu_online_mask) {
 		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+		if (tlat_var->kthread)
+			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
 }
@@ -2579,7 +2581,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
-	hrtimer_cancel(&tlat_var->timer);
+	if (tlat_var->kthread)
+		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
 	osn_var->sampling = 0;
-- 
2.43.0



