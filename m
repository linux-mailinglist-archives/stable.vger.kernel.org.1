Return-Path: <stable+bounces-151724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48363AD06D5
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B0118949F7
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960728A1C7;
	Fri,  6 Jun 2025 16:42:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B1289E3A;
	Fri,  6 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228152; cv=none; b=YPb4VErHK13F6K+24wnhpct6exqNhxEfAejAzf68AVtmQZVV+hLaW5J+P+Evr+4VXxSLEvACLPRqEGTvzqiHStOq++X5JDP+v83084UeOw6OSpQ8CrUkBelMZ9/Y7FXohqS5rV4/EcJj0JmzAAINIAAAyPd45DTsS/23+t3lFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228152; c=relaxed/simple;
	bh=FSJ2NFCigh/zm/yHBe9thSEYQN2IqjgbWwmIYyf+kM8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k+dvSi/mCDzImfc9Cw53TK91/7lmlx6CI0TOLgusvFzSFX4zRdnCW2WkiTUivz32gYhrU4VWsA7LId7kxtT9cXt6wB946q8L1GYhEFiwNEDg042H+80W0i7QxixJTZ2WXxHd2Usc0SvPKeLhzkWD+DiIq5jZRvEdqFnGceK/2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B2C4CEED;
	Fri,  6 Jun 2025 16:42:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uNaAb-0000000FxAQ-1sqW;
	Fri, 06 Jun 2025 12:43:53 -0400
Message-ID: <20250606164353.303660896@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 06 Jun 2025 12:42:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "Ziegler, Andreas" <ziegler.andreas@siemens.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "Flot, Julien" <julien.flot@siemens.com>
Subject: [for-linus][PATCH 1/3] tracing: Fix regression of filter waiting a long time on RCU
 synchronization
References: <20250606164229.056794577@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When faultable trace events were added, a trace event may no longer use
normal RCU to synchronize but instead used synchronize_rcu_tasks_trace().
This synchronization takes a much longer time to synchronize.

The filter logic would free the filters by calling
tracepoint_synchronize_unregister() after it unhooked the filter strings
and before freeing them. With this function now calling
synchronize_rcu_tasks_trace() this increased the time to free a filter
tremendously. On a PREEMPT_RT system, it was even more noticeable.

 # time trace-cmd record -p function sleep 1
 [..]
 real	2m29.052s
 user	0m0.244s
 sys	0m20.136s

As trace-cmd would clear out all the filters before recording, it could
take up to 2 minutes to do a recording of "sleep 1".

To find out where the issues was:

 ~# trace-cmd sqlhist -e -n sched_stack  select start.prev_state as state, end.next_comm as comm, TIMESTAMP_DELTA_USECS as delta,  start.STACKTRACE as stack from sched_switch as start join sched_switch as end on start.prev_pid = end.next_pid

Which will produce the following commands (and -e will also execute them):

 echo 's:sched_stack s64 state; char comm[16]; u64 delta; unsigned long stack[];' >> /sys/kernel/tracing/dynamic_events
 echo 'hist:keys=prev_pid:__arg_18057_2=prev_state,__arg_18057_4=common_timestamp.usecs,__arg_18057_7=common_stacktrace' >> /sys/kernel/tracing/events/sched/sched_switch/trigger
 echo 'hist:keys=next_pid:__state_18057_1=$__arg_18057_2,__comm_18057_3=next_comm,__delta_18057_5=common_timestamp.usecs-$__arg_18057_4,__stack_18057_6=$__arg_18057_7:onmatch(sched.sched_switch).trace(sched_stack,$__state_18057_1,$__comm_18057_3,$__delta_18057_5,$__stack_18057_6)' >> /sys/kernel/tracing/events/sched/sched_switch/trigger

The above creates a synthetic event that creates a stack trace when a task
schedules out and records it with the time it scheduled back in. Basically
the time a task is off the CPU. It also records the state of the task when
it left the CPU (running, blocked, sleeping, etc). It also saves the comm
of the task as "comm" (needed for the next command).

~# echo 'hist:keys=state,stack.stacktrace:vals=delta:sort=state,delta if comm == "trace-cmd" &&  state & 3' > /sys/kernel/tracing/events/synthetic/sched_stack/trigger

The above creates a histogram with buckets per state, per stack, and the
value of the total time it was off the CPU for that stack trace. It filters
on tasks with "comm == trace-cmd" and only the sleeping and blocked states
(1 - sleeping, 2 - blocked).

~# trace-cmd record -p function sleep 1

~# cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -18
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_tasks_generic+0x151/0x230
         apply_subsystem_event_filter+0xa2b/0x1300
         subsystem_filter_write+0x67/0xc0
         vfs_write+0x1e2/0xeb0
         ksys_write+0xff/0x1d0
         do_syscall_64+0x7b/0x420
         entry_SYSCALL_64_after_hwframe+0x76/0x7e
} hitcount:        237  delta:   99756288  <<--------------- Delta is 99 seconds!

Totals:
    Hits: 525
    Entries: 21
    Dropped: 0

This shows that this particular trace waited for 99 seconds on
synchronize_rcu_tasks() in apply_subsystem_event_filter().

In fact, there's a lot of places in the filter code that spends a lot of
time waiting for synchronize_rcu_tasks_trace() in order to free the
filters.

Add helper functions that will use call_rcu*() variants to asynchronously
free the filters. This brings the timings back to normal:

 # time trace-cmd record -p function sleep 1
 [..]
 real	0m14.681s
 user	0m0.335s
 sys	0m28.616s

And the histogram also shows this:

~# cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -21
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_normal+0x3db/0x5c0
         tracing_reset_online_cpus+0x8f/0x1e0
         tracing_open+0x335/0x440
         do_dentry_open+0x4c6/0x17a0
         vfs_open+0x82/0x360
         path_openat+0x1a36/0x2990
         do_filp_open+0x1c5/0x420
         do_sys_openat2+0xed/0x180
         __x64_sys_openat+0x108/0x1d0
         do_syscall_64+0x7b/0x420
} hitcount:          2  delta:      77044

Totals:
    Hits: 55
    Entries: 28
    Dropped: 0

Where the total waiting time of synchronize_rcu_tasks_trace() is 77
milliseconds.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>
Cc: "Ziegler, Andreas" <ziegler.andreas@siemens.com>
Cc: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Link: https://lore.kernel.org/20250605161701.35f7989a@gandalf.local.home
Reported-by: "Flot, Julien" <julien.flot@siemens.com>
Tested-by: Julien Flot <julien.flot@siemens.com>
Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
Closes: https://lore.kernel.org/all/240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 164 ++++++++++++++++++++++-------
 1 file changed, 127 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2048560264bb..3ff782d6b522 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1335,6 +1335,74 @@ static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
 	}
 }
 
+struct filter_list {
+	struct list_head	list;
+	struct event_filter	*filter;
+};
+
+struct filter_head {
+	struct list_head	list;
+	struct rcu_head		rcu;
+};
+
+
+static void free_filter_list(struct rcu_head *rhp)
+{
+	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
+	struct filter_list *filter_item, *tmp;
+
+	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
+		__free_filter(filter_item->filter);
+		list_del(&filter_item->list);
+		kfree(filter_item);
+	}
+	kfree(filter_list);
+}
+
+static void free_filter_list_tasks(struct rcu_head *rhp)
+{
+	call_rcu(rhp, free_filter_list);
+}
+
+/*
+ * The tracepoint_synchronize_unregister() is a double rcu call.
+ * It calls synchronize_rcu_tasks_trace() followed by synchronize_rcu().
+ * Instead of waiting for it, simply call these via the call_rcu*()
+ * variants.
+ */
+static void delay_free_filter(struct filter_head *head)
+{
+	call_rcu_tasks_trace(&head->rcu, free_filter_list_tasks);
+}
+
+static void try_delay_free_filter(struct event_filter *filter)
+{
+	struct filter_head *head;
+	struct filter_list *item;
+
+	head = kmalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		goto free_now;
+
+	INIT_LIST_HEAD(&head->list);
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item) {
+		kfree(head);
+		goto free_now;
+	}
+
+	item->filter = filter;
+	list_add_tail(&item->list, &head->list);
+	delay_free_filter(head);
+	return;
+
+ free_now:
+	/* Make sure the filter is not being used */
+	tracepoint_synchronize_unregister();
+	__free_filter(filter);
+}
+
 static inline void __free_subsystem_filter(struct trace_event_file *file)
 {
 	__free_filter(file->filter);
@@ -1342,15 +1410,53 @@ static inline void __free_subsystem_filter(struct trace_event_file *file)
 }
 
 static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
-					  struct trace_array *tr)
+					  struct trace_array *tr,
+					  struct event_filter *filter)
 {
 	struct trace_event_file *file;
+	struct filter_head *head;
+	struct filter_list *item;
+
+	head = kmalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		goto free_now;
+
+	INIT_LIST_HEAD(&head->list);
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item) {
+		kfree(head);
+		goto free_now;
+	}
+
+	item->filter = filter;
+	list_add_tail(&item->list, &head->list);
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir)
 			continue;
-		__free_subsystem_filter(file);
+		item = kmalloc(sizeof(*item), GFP_KERNEL);
+		if (!item)
+			goto free_now;
+		item->filter = file->filter;
+		list_add_tail(&item->list, &head->list);
+		file->filter = NULL;
+	}
+
+	delay_free_filter(head);
+	return;
+ free_now:
+	tracepoint_synchronize_unregister();
+
+	if (head)
+		free_filter_list(&head->rcu);
+
+	list_for_each_entry(file, &tr->events, list) {
+		if (file->system != dir || !file->filter)
+			continue;
+		__free_filter(file->filter);
 	}
+	__free_filter(filter);
 }
 
 int filter_assign_type(const char *type)
@@ -2131,11 +2237,6 @@ static inline void event_clear_filter(struct trace_event_file *file)
 	RCU_INIT_POINTER(file->filter, NULL);
 }
 
-struct filter_list {
-	struct list_head	list;
-	struct event_filter	*filter;
-};
-
 static int process_system_preds(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
 				struct filter_parse_error *pe,
@@ -2144,11 +2245,16 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct trace_event_file *file;
 	struct filter_list *filter_item;
 	struct event_filter *filter = NULL;
-	struct filter_list *tmp;
-	LIST_HEAD(filter_list);
+	struct filter_head *filter_list;
 	bool fail = true;
 	int err;
 
+	filter_list = kmalloc(sizeof(*filter_list), GFP_KERNEL);
+	if (!filter_list)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&filter_list->list);
+
 	list_for_each_entry(file, &tr->events, list) {
 
 		if (file->system != dir)
@@ -2175,7 +2281,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter_item)
 			goto fail_mem;
 
-		list_add_tail(&filter_item->list, &filter_list);
+		list_add_tail(&filter_item->list, &filter_list->list);
 		/*
 		 * Regardless of if this returned an error, we still
 		 * replace the filter for the call.
@@ -2195,31 +2301,22 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	 * Do a synchronize_rcu() and to ensure all calls are
 	 * done with them before we free them.
 	 */
-	tracepoint_synchronize_unregister();
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		__free_filter(filter_item->filter);
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+	delay_free_filter(filter_list);
 	return 0;
  fail:
 	/* No call succeeded */
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+	free_filter_list(&filter_list->rcu);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
 	__free_filter(filter);
+
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
-		tracepoint_synchronize_unregister();
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		__free_filter(filter_item->filter);
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+		delay_free_filter(filter_list);
+	else
+		free_filter_list(&filter_list->rcu);
+
 	return -ENOMEM;
 }
 
@@ -2361,9 +2458,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		event_clear_filter(file);
 
-		/* Make sure the filter is not being used */
-		tracepoint_synchronize_unregister();
-		__free_filter(filter);
+		try_delay_free_filter(filter);
 
 		return 0;
 	}
@@ -2387,11 +2482,8 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		event_set_filter(file, filter);
 
-		if (tmp) {
-			/* Make sure the call is done with the filter */
-			tracepoint_synchronize_unregister();
-			__free_filter(tmp);
-		}
+		if (tmp)
+			try_delay_free_filter(tmp);
 	}
 
 	return err;
@@ -2417,9 +2509,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		filter = system->filter;
 		system->filter = NULL;
 		/* Ensure all filters are no longer used */
-		tracepoint_synchronize_unregister();
-		filter_free_subsystem_filters(dir, tr);
-		__free_filter(filter);
+		filter_free_subsystem_filters(dir, tr, filter);
 		return 0;
 	}
 
-- 
2.47.2



