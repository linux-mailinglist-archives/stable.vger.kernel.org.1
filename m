Return-Path: <stable+bounces-134125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87850A929B1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F3F8E4ABD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC225F997;
	Thu, 17 Apr 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCMdvcG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585325F98D;
	Thu, 17 Apr 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915172; cv=none; b=jZSlMal3ib9Q48CKKMIfovGnSMuvUt/S7zNvOVzr98ThiJopPb6neU0gUUNoHI3QvTnVRuIqG2BKksDO//GjOkPuOhMXbToX++5D76UPyPVaBXJ8+AYao6B0J+XU7383/s672w6tH7qgIdeTXigNqWLwUnxM8BWzYSt5ZjbjRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915172; c=relaxed/simple;
	bh=pgYmf2hntr6RuN1kNm1IRyVGHPmSohYS+5vexQ0RpEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFqyNfa0SWMawHserKVTD7k00n4HiRuhs2S7y/BF9A9XzZTx+mgfbXceVX/58XVmYbx92Tg6gsnk5/FepFjVYJcA3DJRZUiZZB6C608g0sTdQZdOPeO0vxlfjm5RuIFBFQJpzQTSfF24G91JmVSzkitJhEcHAQFMyzNgh+85qyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCMdvcG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45661C4CEE4;
	Thu, 17 Apr 2025 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915172;
	bh=pgYmf2hntr6RuN1kNm1IRyVGHPmSohYS+5vexQ0RpEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yCMdvcG2eb/uhRknDFKZ7JvsNyu/0zkhI+CsMG81T0bMK3phf1ECq5rAzlK9OmDDn
	 TKznljucteoGXD1lXriNrDT9ImoNa4d3fE/HVXvcs7mP4oG+Lhu775Tq1i5cWyIFU6
	 pphEjAyP1LJ1dfgPCnV+h1ylzgZsbTJ/k10I5gf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	James Clark <james.clark@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 042/393] perf/core: Add aux_pause, aux_resume, aux_start_paused
Date: Thu, 17 Apr 2025 19:47:31 +0200
Message-ID: <20250417175109.288063586@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 18d92bb57c39504d9da11c6ef604f58eb1d5a117 ]

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

Add ability for an event to "pause" or "resume" AUX area tracing.

Add aux_pause bit to perf_event_attr to indicate that, if the event
happens, the associated AUX area tracing should be paused. Ditto
aux_resume. Do not allow aux_pause and aux_resume to be set together.

Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
event that it should start in a "paused" state.

Add aux_paused to struct hw_perf_event for AUX area events to keep track of
the "paused" state. aux_paused is initialized to aux_start_paused.

Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
callbacks. Call as needed, during __perf_event_output(). Add
aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
handler. Pause/resume in NMI context will miss out if it coincides with
another pause/resume.

To use aux_pause or aux_resume, an event must be in a group with the AUX
area event as the group leader.

Example (requires Intel PT and tools patches also):

 $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.043 MB perf.data ]
 $ perf script --call-trace
 uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
 uname   30805 [000] 24001.058784424:  psb offs: 0
 uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785639: 0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20241022155920.17511-3-adrian.hunter@intel.com
Stable-dep-of: 56799bc03565 ("perf: Fix hang while freeing sigtrap event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h      | 28 ++++++++++++
 include/uapi/linux/perf_event.h | 11 ++++-
 kernel/events/core.c            | 75 +++++++++++++++++++++++++++++++--
 kernel/events/internal.h        |  1 +
 4 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 347901525a46a..19551d664bce2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -170,6 +170,12 @@ struct hw_perf_event {
 		};
 		struct { /* aux / Intel-PT */
 			u64		aux_config;
+			/*
+			 * For AUX area events, aux_paused cannot be a state
+			 * flag because it can be updated asynchronously to
+			 * state.
+			 */
+			unsigned int	aux_paused;
 		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
@@ -294,6 +300,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_AUX_PAUSE			0x0200
 
 /**
  * pmu::scope
@@ -384,6 +391,8 @@ struct pmu {
 #define PERF_EF_START	0x01		/* start the counter when adding    */
 #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
 #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
+#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
+#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
@@ -423,6 +432,18 @@ struct pmu {
 	 *
 	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
+	 *
+	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
+	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
+	 * PERF_EF_RESUME.
+	 *
+	 * ->start() with PERF_EF_RESUME will start as simply as possible but
+	 * only if the counter is not otherwise stopped. Will not overlap
+	 * another ->start() with PERF_EF_RESUME nor ->stop() with
+	 * PERF_EF_PAUSE.
+	 *
+	 * Notably, PERF_EF_PAUSE/PERF_EF_RESUME *can* be concurrent with other
+	 * ->stop()/->start() invocations, just not itself.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
 	void (*stop)			(struct perf_event *event, int flags);
@@ -1685,6 +1706,13 @@ static inline bool has_aux(struct perf_event *event)
 	return event->pmu->setup_aux;
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_sample_size ||
+	       event->attr.aux_pause ||
+	       event->attr.aux_resume;
+}
+
 static inline bool is_write_backward(struct perf_event *event)
 {
 	return !!event->attr.write_backward;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf801..0524d541d4e3d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b5ccf52bb71ba..bee6f88d0556b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2146,7 +2146,7 @@ static void perf_put_aux_event(struct perf_event *event)
 
 static bool perf_need_aux_event(struct perf_event *event)
 {
-	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+	return event->attr.aux_output || has_aux_action(event);
 }
 
 static int perf_get_aux_event(struct perf_event *event,
@@ -2171,6 +2171,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	    !perf_aux_output_match(event, group_leader))
 		return 0;
 
+	if ((event->attr.aux_pause || event->attr.aux_resume) &&
+	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
+		return 0;
+
 	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
@@ -8029,6 +8033,49 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void __perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	if (pause) {
+		if (!event->hw.aux_paused) {
+			event->hw.aux_paused = 1;
+			event->pmu->stop(event, PERF_EF_PAUSE);
+		}
+	} else {
+		if (event->hw.aux_paused) {
+			event->hw.aux_paused = 0;
+			event->pmu->start(event, PERF_EF_RESUME);
+		}
+	}
+}
+
+static void perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	struct perf_buffer *rb;
+
+	if (WARN_ON_ONCE(!event))
+		return;
+
+	rb = ring_buffer_get(event);
+	if (!rb)
+		return;
+
+	scoped_guard (irqsave) {
+		/*
+		 * Guard against self-recursion here. Another event could trip
+		 * this same from NMI context.
+		 */
+		if (READ_ONCE(rb->aux_in_pause_resume))
+			break;
+
+		WRITE_ONCE(rb->aux_in_pause_resume, 1);
+		barrier();
+		__perf_event_aux_pause(event, pause);
+		barrier();
+		WRITE_ONCE(rb->aux_in_pause_resume, 0);
+	}
+	ring_buffer_put(rb);
+}
+
 static __always_inline int
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
@@ -9832,9 +9879,12 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
-		return ret;
+		goto out;
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
@@ -9896,6 +9946,9 @@ static int __perf_event_overflow(struct perf_event *event,
 		event->pending_wakeup = 1;
 		irq_work_queue(&event->pending_irq);
 	}
+out:
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
 
 	return ret;
 }
@@ -12312,11 +12365,25 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (event->attr.aux_output &&
-	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
+	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
+	     event->attr.aux_pause || event->attr.aux_resume)) {
 		err = -EOPNOTSUPP;
 		goto err_pmu;
 	}
 
+	if (event->attr.aux_pause && event->attr.aux_resume) {
+		err = -EINVAL;
+		goto err_pmu;
+	}
+
+	if (event->attr.aux_start_paused) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
+			err = -EOPNOTSUPP;
+			goto err_pmu;
+		}
+		event->hw.aux_paused = 1;
+	}
+
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
@@ -13112,7 +13179,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
 	 */
-	if (attr->aux_output)
+	if (attr->aux_output || attr->aux_action)
 		return ERR_PTR(-EINVAL);
 
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index e072d995d670f..249288d82b8dc 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -52,6 +52,7 @@ struct perf_buffer {
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
 	int				aux_in_sampling;
+	int				aux_in_pause_resume;
 	void				**aux_pages;
 	void				*aux_priv;
 
-- 
2.39.5




