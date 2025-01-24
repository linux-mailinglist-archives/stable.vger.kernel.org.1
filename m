Return-Path: <stable+bounces-110421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A0A1BD51
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 21:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C08F3AF2AF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408D224B1C;
	Fri, 24 Jan 2025 20:22:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575218A93E;
	Fri, 24 Jan 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750155; cv=none; b=ZkoEsyjZYiVhWKMgaui/UBbvT+1lblB/manNSPTzKZ8fCIjH3oxz8OYiD3y8QUQqLUY58lS8k02oXfvYhhNodsARu+U66rLLKP0umETliGIn3oSlbqPxfAJYLtLUhiWKnMM/RHaE7/BrUMEnbhkuvhjkCmwUqjTJig/IuJe+lwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750155; c=relaxed/simple;
	bh=USudLkJyOglvzS1xWfP+3m7/nofTgJFo848UJmbULOA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ApFEckMPpFU+4t0aTk0yurWWYnl3/21mkKTbb+CG83tIy2xqojRjrL7yFY/5eAmDiMl4jqbFzgDTEFdGSk+mkIAgnigdyEf7r04ryQPMjDyYihRRkL7hqHNj6VCmx2t0SL+XWSpialddo7/W3jlf0vfW/HoZrUtePIG0hVkdG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121D8C4CEE1;
	Fri, 24 Jan 2025 20:22:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbQCU-00000001Hvr-1I5a;
	Fri, 24 Jan 2025 15:22:46 -0500
Message-ID: <20250124202246.162357801@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 15:22:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 1/2] rv: Reset per-task monitors also for idle tasks
References: <20250124202212.573818998@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

RV per-task monitors are implemented through a monitor structure
available for each task_struct. This structure is reset every time the
monitor is (re-)started, to avoid inconsistencies if the monitor was
activated previously.
To do so, we reset the monitor on all threads using the macro
for_each_process_thread. However, this macro excludes the idle tasks on
each CPU. Idle tasks could be considered tasks on their own right and it
should be up to the model whether to ignore them or not.

Reset monitors also on the idle tasks for each present CPU whenever we
reset all per-task monitors.

Cc: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250115151547.605750-2-gmonaco@redhat.com
Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/rv/da_monitor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9705b2a98e49..510c88bfabd4 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,6 +14,7 @@
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/bug.h>
+#include <linux/sched.h>
 
 #ifdef CONFIG_RV_REACTORS
 
@@ -324,10 +325,13 @@ static inline struct da_monitor *da_get_monitor_##name(struct task_struct *tsk)
 static void da_monitor_reset_all_##name(void)							\
 {												\
 	struct task_struct *g, *p;								\
+	int cpu;										\
 												\
 	read_lock(&tasklist_lock);								\
 	for_each_process_thread(g, p)								\
 		da_monitor_reset_##name(da_get_monitor_##name(p));				\
+	for_each_present_cpu(cpu)								\
+		da_monitor_reset_##name(da_get_monitor_##name(idle_task(cpu)));			\
 	read_unlock(&tasklist_lock);								\
 }												\
 												\
-- 
2.45.2



