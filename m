Return-Path: <stable+bounces-4898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BC807EA1
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A5EB211DF
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D30186B;
	Thu,  7 Dec 2023 02:37:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022181869
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 02:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C03C433AD;
	Thu,  7 Dec 2023 02:37:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rB4HM-00000001aPB-1r1j;
	Wed, 06 Dec 2023 21:38:20 -0500
Message-ID: <20231207023820.217771011@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 06 Dec 2023 21:37:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 6/8] tracing: Fix a possible race when disabling buffered events
References: <20231207023752.712829638@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Pavlu <petr.pavlu@suse.com>

Function trace_buffered_event_disable() is responsible for freeing pages
backing buffered events and this process can run concurrently with
trace_event_buffer_lock_reserve().

The following race is currently possible:

* Function trace_buffered_event_disable() is called on CPU 0. It
  increments trace_buffered_event_cnt on each CPU and waits via
  synchronize_rcu() for each user of trace_buffered_event to complete.

* After synchronize_rcu() is finished, function
  trace_buffered_event_disable() has the exclusive access to
  trace_buffered_event. All counters trace_buffered_event_cnt are at 1
  and all pointers trace_buffered_event are still valid.

* At this point, on a different CPU 1, the execution reaches
  trace_event_buffer_lock_reserve(). The function calls
  preempt_disable_notrace() and only now enters an RCU read-side
  critical section. The function proceeds and reads a still valid
  pointer from trace_buffered_event[CPU1] into the local variable
  "entry". However, it doesn't yet read trace_buffered_event_cnt[CPU1]
  which happens later.

* Function trace_buffered_event_disable() continues. It frees
  trace_buffered_event[CPU1] and decrements
  trace_buffered_event_cnt[CPU1] back to 0.

* Function trace_event_buffer_lock_reserve() continues. It reads and
  increments trace_buffered_event_cnt[CPU1] from 0 to 1. This makes it
  believe that it can use the "entry" that it already obtained but the
  pointer is now invalid and any access results in a use-after-free.

Fix the problem by making a second synchronize_rcu() call after all
trace_buffered_event values are set to NULL. This waits on all potential
users in trace_event_buffer_lock_reserve() that still read a previous
pointer from trace_buffered_event.

Link: https://lore.kernel.org/all/20231127151248.7232-2-petr.pavlu@suse.com/
Link: https://lkml.kernel.org/r/20231205161736.19663-4-petr.pavlu@suse.com

Cc: stable@vger.kernel.org
Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ef72354f61ce..fbcd3bafb93e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2791,13 +2791,17 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	/* Do the work on each cpu */
+	/* For each CPU, relinquish the buffer */
 	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
 			 true);
 }
-- 
2.42.0



