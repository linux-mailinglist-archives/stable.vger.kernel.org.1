Return-Path: <stable+bounces-130401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD0BA80451
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1998719E2072
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6C269CE6;
	Tue,  8 Apr 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LrkwHJc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BB269CE8;
	Tue,  8 Apr 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113615; cv=none; b=JZxRLHczoQQlRnzpdDQDACm7/W3PV992BYhCzjVA9T9mT3Baa9bfDWmnO+nBI0AhbfDmVSh/koH84/UO2vbSlat1bhTtC3tYZ9jGljUm+Wn6Btyiy5I1KWo2D7E51BbO2u5IEjGtitZROoN0Btjg8M1ERNgCsX7w9c2IxPiwew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113615; c=relaxed/simple;
	bh=LjUQ0dFYMZb5mNnGsaakRgiuqN+wPRBQxek1J5IuqzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzBr989Wv2PnlC0rHtvGK7SiI35+8gyXTUYoL6LozkoJJDSEQbZlwoeaSUVwxQG2bGCHEZOtq2n0R4PehYjsCSzXn3rDfk8PMAUmaHCNJJy0q54yqBbh9E2vIBfKvSOLsCAAnE5LYiH94pXtTHdBmDHjTubE3UNeilK6a6nVXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LrkwHJc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BECC4CEE5;
	Tue,  8 Apr 2025 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113614;
	bh=LjUQ0dFYMZb5mNnGsaakRgiuqN+wPRBQxek1J5IuqzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrkwHJc7HeXgDBrG6uINyH/OdL+vTN2orogcHl83lcTihNwogpEAd5xkesoFs80fH
	 F9sskYISo3ivBoKEQ87YiWNbLkItAZb0ghLasdS4kPzj8a7jy1IrtzN5nsGEeu7z/U
	 +paA4rrAhX+LSJq02MhsVOh8cgDnhhLn1OVEMtNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Paul <seanpaul@chromium.org>,
	Arun Easi <aeasi@marvell.com>,
	Daniel Wagner <dwagner@suse.de>,
	Dmytro Maluka <dmaluka@chromium.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 224/268] tracing: Allow creating instances with specified system events
Date: Tue,  8 Apr 2025 12:50:35 +0200
Message-ID: <20250408104834.623514556@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit d23569979ca1cd139a42c410e0c7b9e6014c3b3a ]

A trace instance may only need to enable specific events. As the eventfs
directory of an instance currently creates all events which adds overhead,
allow internal instances to be created with just the events in systems
that they care about. This currently only deals with systems and not
individual events, but this should bring down the overhead of creating
instances for specific use cases quite bit.

The trace_array_get_by_name() now has another parameter "systems". This
parameter is a const string pointer of a comma/space separated list of
event systems that should be created by the trace_array. (Note if the
trace_array already exists, this parameter is ignored).

The list of systems is saved and if a module is loaded, its events will
not be added unless the system for those events also match the systems
string.

Link: https://lore.kernel.org/linux-trace-kernel/20231213093701.03fddec0@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Arun Easi   <aeasi@marvell.com>
Cc: Daniel Wagner <dwagner@suse.de>
Tested-by: Dmytro Maluka <dmaluka@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 0b4ffbe4888a ("tracing: Correct the refcount if the hist/hist_debug file fails to open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c       |  2 +-
 include/linux/trace.h               |  4 +--
 kernel/trace/trace.c                | 23 +++++++++++---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_boot.c           |  2 +-
 kernel/trace/trace_events.c         | 48 +++++++++++++++++++++++++++--
 samples/ftrace/sample-trace-array.c |  2 +-
 7 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 91d12198cc6c8..0a3a5af67f0ae 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2883,7 +2883,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 static void
 qla_trace_init(void)
 {
-	qla_trc_array = trace_array_get_by_name("qla2xxx");
+	qla_trc_array = trace_array_get_by_name("qla2xxx", NULL);
 	if (!qla_trc_array) {
 		ql_log(ql_log_fatal, NULL, 0x0001,
 		       "Unable to create qla2xxx trace instance, instance logging will be disabled.\n");
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 2a70a447184c9..fdcd76b7be83d 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -51,7 +51,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		       const char *fmt, ...);
 int trace_array_init_printk(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
-struct trace_array *trace_array_get_by_name(const char *name);
+struct trace_array *trace_array_get_by_name(const char *name, const char *systems);
 int trace_array_destroy(struct trace_array *tr);
 
 /* For osnoise tracer */
@@ -84,7 +84,7 @@ static inline int trace_array_init_printk(struct trace_array *tr)
 static inline void trace_array_put(struct trace_array *tr)
 {
 }
-static inline struct trace_array *trace_array_get_by_name(const char *name)
+static inline struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
 {
 	return NULL;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9d9af60b238e2..a41c99350a5bf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9417,7 +9417,8 @@ static int trace_array_create_dir(struct trace_array *tr)
 	return ret;
 }
 
-static struct trace_array *trace_array_create(const char *name)
+static struct trace_array *
+trace_array_create_systems(const char *name, const char *systems)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9437,6 +9438,12 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
+	if (systems) {
+		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
+		if (!tr->system_names)
+			goto out_free_tr;
+	}
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9480,12 +9487,18 @@ static struct trace_array *trace_array_create(const char *name)
 	free_trace_buffers(tr);
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
+	kfree_const(tr->system_names);
 	kfree(tr->name);
 	kfree(tr);
 
 	return ERR_PTR(ret);
 }
 
+static struct trace_array *trace_array_create(const char *name)
+{
+	return trace_array_create_systems(name, NULL);
+}
+
 static int instance_mkdir(const char *name)
 {
 	struct trace_array *tr;
@@ -9511,6 +9524,7 @@ static int instance_mkdir(const char *name)
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
  * @name: The name of the trace array to be looked up/created.
+ * @systems: A list of systems to create event directories for (NULL for all)
  *
  * Returns pointer to trace array with given name.
  * NULL, if it cannot be created.
@@ -9524,7 +9538,7 @@ static int instance_mkdir(const char *name)
  * trace_array_put() is called, user space can not delete it.
  *
  */
-struct trace_array *trace_array_get_by_name(const char *name)
+struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
 {
 	struct trace_array *tr;
 
@@ -9536,7 +9550,7 @@ struct trace_array *trace_array_get_by_name(const char *name)
 			goto out_unlock;
 	}
 
-	tr = trace_array_create(name);
+	tr = trace_array_create_systems(name, systems);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9583,6 +9597,7 @@ static int __remove_instance(struct trace_array *tr)
 
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
+	kfree_const(tr->system_names);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -10301,7 +10316,7 @@ __init static void enable_instances(void)
 		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
 			do_allocate_snapshot(tok);
 
-		tr = trace_array_get_by_name(tok);
+		tr = trace_array_get_by_name(tok, NULL);
 		if (!tr) {
 			pr_warn("Failed to create instance buffer %s\n", curr_str);
 			continue;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e45756f1ac2b1..db0d2641125e7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -377,6 +377,7 @@ struct trace_array {
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
+	const char		*system_names;
 	struct list_head	err_log;
 	struct dentry		*dir;
 	struct dentry		*options;
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 7ccc7a8e155b9..dbe29b4c6a7a0 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -633,7 +633,7 @@ trace_boot_init_instances(struct xbc_node *node)
 		if (!p || *p == '\0')
 			continue;
 
-		tr = trace_array_get_by_name(p);
+		tr = trace_array_get_by_name(p, NULL);
 		if (!tr) {
 			pr_err("Failed to get trace instance %s\n", p);
 			continue;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9d22745cdea5a..15041912c277d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3056,6 +3056,27 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 	up_write(&trace_event_sem);
 }
 
+static bool event_in_systems(struct trace_event_call *call,
+			     const char *systems)
+{
+	const char *system;
+	const char *p;
+
+	if (!systems)
+		return true;
+
+	system = call->class->system;
+	p = strstr(systems, system);
+	if (!p)
+		return false;
+
+	if (p != systems && !isspace(*(p - 1)) && *(p - 1) != ',')
+		return false;
+
+	p += strlen(system);
+	return !*p || isspace(*p) || *p == ',';
+}
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
@@ -3065,9 +3086,12 @@ trace_create_new_event(struct trace_event_call *call,
 	struct trace_event_file *file;
 	unsigned int first;
 
+	if (!event_in_systems(call, tr->system_names))
+		return NULL;
+
 	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
 	if (!file)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	pid_list = rcu_dereference_protected(tr->filtered_pids,
 					     lockdep_is_held(&event_mutex));
@@ -3132,8 +3156,17 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	struct trace_event_file *file;
 
 	file = trace_create_new_event(call, tr);
+	/*
+	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
+	 * allocation, or NULL if the event is not part of the tr->system_names.
+	 * When the event is not part of the tr->system_names, return zero, not
+	 * an error.
+	 */
 	if (!file)
-		return -ENOMEM;
+		return 0;
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
 	if (eventdir_initialized)
 		return event_create_dir(tr->event_dir, file);
@@ -3172,8 +3205,17 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	int ret;
 
 	file = trace_create_new_event(call, tr);
+	/*
+	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
+	 * allocation, or NULL if the event is not part of the tr->system_names.
+	 * When the event is not part of the tr->system_names, return zero, not
+	 * an error.
+	 */
 	if (!file)
-		return -ENOMEM;
+		return 0;
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
 	ret = event_define_fields(call);
 	if (ret)
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index 6aba02a31c96c..d0ee9001c7b37 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -105,7 +105,7 @@ static int __init sample_trace_array_init(void)
 	 * NOTE: This function increments the reference counter
 	 * associated with the trace array - "tr".
 	 */
-	tr = trace_array_get_by_name("sample-instance");
+	tr = trace_array_get_by_name("sample-instance", "sched,timer,kprobes");
 
 	if (!tr)
 		return -1;
-- 
2.39.5




