Return-Path: <stable+bounces-43479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDF8C09C6
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054A21F22EA1
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCC13CF81;
	Thu,  9 May 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JIYrxp1V"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50D13CAB5
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221811; cv=none; b=MxujaKBR2Uef7opJRYL3EBhdtS+nJ8MktXJoXMqkcp3jEiSxkRMDAxRFxHT9vcoXNWqLayTN1pNkzJxCC8uOkKU+IPmNaF48DpOF34glvkjPLTlcmuHic36HAtnf8YsqND+yAf719ytIPEOa7QeMcfOxbgHzARKPogdPTo64OCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221811; c=relaxed/simple;
	bh=xid7qfZkhocWhIV51QFbrIZ0YWPScIcHCELBa8x9TyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5vG3TAFZNlCUoniH0w6jPlhXCQcnrpkvDZKjWh9uOvUT2FzL5dZfwQQNOt2OTag8WIx5NlGk1faFGUYlr4hKdNZVWWhFtxujT7zm4gsuc3ecPpU05rDg+KMcDuNt12wYkM2UMgnbVvHP60YGOo4PrICTxooA3gB1/2wrTl6quQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JIYrxp1V; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d52ZQa+RozZajQbVUzSWRy//6s3AwuaV3cm6mzuLjYQ=;
	b=JIYrxp1VY5tpxRC9Xl5Rz5faJgZwKP4hblLWFayG9Wf/y5R8WAWSrW7GwVd/Jjey99GnyZ
	NTXHmCa68QO++pa99KYHm7yFVyxj+n0+VDh8RnJ/AdDc48EjvuFn9pceAJ8sHz2+2t9DLE
	lDhMFpRH5iS3/khbSWcxCAiy2s6O5Cg=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 02/13] tracing: Add unified dynamic event framework
Date: Thu,  9 May 2024 10:29:20 +0800
Message-Id: <20240509022931.3513365-3-dongtai.guo@linux.dev>
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 5448d44c38557fc15d1c53b608a9c9f0e1ca8f86 upstream.

Add unified dynamic event framework for ftrace kprobes, uprobes
and synthetic events. Those dynamic events can be co-exist on
same file because those syntax doesn't overlap.

This introduces a framework part which provides a unified tracefs
interface and operations.

Link: http://lkml.kernel.org/r/154140852824.17322.12250362185969352095.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/Kconfig          |   3 +
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace.c          |   4 +
 kernel/trace/trace_dynevent.c | 210 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.h | 119 +++++++++++++++++++
 5 files changed, 337 insertions(+)
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e656d1e232da..7d7edc56eb5e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -518,6 +518,9 @@ config BPF_EVENTS
 	help
 	  This allows the user to attach BPF programs to kprobe events.
 
+config DYNAMIC_EVENTS
+	def_bool n
+
 config PROBE_EVENTS
 	def_bool n
 
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f81dadbc7c4a..9ff3c4fa91b6 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -78,6 +78,7 @@ endif
 ifeq ($(CONFIG_TRACING),y)
 obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
+obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e6b2d443bab9..bacdbeffcc05 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4665,6 +4665,10 @@ static const char readme_msg[] =
 	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
+#ifdef CONFIG_DYNAMIC_EVENTS
+	"  dynamic_events\t\t- Add/remove/show the generic dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #ifdef CONFIG_KPROBE_EVENTS
 	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
new file mode 100644
index 000000000000..f17a887abb66
--- /dev/null
+++ b/kernel/trace/trace_dynevent.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic dynamic event control interface
+ *
+ * Copyright (C) 2018 Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/tracefs.h>
+
+#include "trace.h"
+#include "trace_dynevent.h"
+
+static DEFINE_MUTEX(dyn_event_ops_mutex);
+static LIST_HEAD(dyn_event_ops_list);
+
+int dyn_event_register(struct dyn_event_operations *ops)
+{
+	if (!ops || !ops->create || !ops->show || !ops->is_busy ||
+	    !ops->free || !ops->match)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ops->list);
+	mutex_lock(&dyn_event_ops_mutex);
+	list_add_tail(&ops->list, &dyn_event_ops_list);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return 0;
+}
+
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
+{
+	struct dyn_event *pos, *n;
+	char *system = NULL, *event, *p;
+	int ret = -ENOENT;
+
+	if (argv[0][1] != ':')
+		return -EINVAL;
+
+	event = &argv[0][2];
+	p = strchr(event, '/');
+	if (p) {
+		system = event;
+		event = p + 1;
+		*p = '\0';
+	}
+	if (event[0] == '\0')
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event_safe(pos, n) {
+		if (type && type != pos->ops)
+			continue;
+		if (pos->ops->match(system, event, pos)) {
+			ret = pos->ops->free(pos);
+			break;
+		}
+	}
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int create_dyn_event(int argc, char **argv)
+{
+	struct dyn_event_operations *ops;
+	int ret;
+
+	if (argv[0][0] == '-')
+		return dyn_event_release(argc, argv, NULL);
+
+	mutex_lock(&dyn_event_ops_mutex);
+	list_for_each_entry(ops, &dyn_event_ops_list, list) {
+		ret = ops->create(argc, (const char **)argv);
+		if (!ret || ret != -ECANCELED)
+			break;
+	}
+	mutex_unlock(&dyn_event_ops_mutex);
+	if (ret == -ECANCELED)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* Protected by event_mutex */
+LIST_HEAD(dyn_event_list);
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&event_mutex);
+	return seq_list_start(&dyn_event_list, *pos);
+}
+
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &dyn_event_list, pos);
+}
+
+void dyn_event_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int dyn_event_seq_show(struct seq_file *m, void *v)
+{
+	struct dyn_event *ev = v;
+
+	if (ev && ev->ops)
+		return ev->ops->show(m, ev);
+
+	return 0;
+}
+
+static const struct seq_operations dyn_event_seq_op = {
+	.start	= dyn_event_seq_start,
+	.next	= dyn_event_seq_next,
+	.stop	= dyn_event_seq_stop,
+	.show	= dyn_event_seq_show
+};
+
+/*
+ * dyn_events_release_all - Release all specific events
+ * @type:	the dyn_event_operations * which filters releasing events
+ *
+ * This releases all events which ->ops matches @type. If @type is NULL,
+ * all events are released.
+ * Return -EBUSY if any of them are in use, and return other errors when
+ * it failed to free the given event. Except for -EBUSY, event releasing
+ * process will be aborted at that point and there may be some other
+ * releasable events on the list.
+ */
+int dyn_events_release_all(struct dyn_event_operations *type)
+{
+	struct dyn_event *ev, *tmp;
+	int ret = 0;
+
+	mutex_lock(&event_mutex);
+	for_each_dyn_event(ev) {
+		if (type && ev->ops != type)
+			continue;
+		if (ev->ops->is_busy(ev)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+	for_each_dyn_event_safe(ev, tmp) {
+		if (type && ev->ops != type)
+			continue;
+		ret = ev->ops->free(ev);
+		if (ret)
+			break;
+	}
+out:
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int dyn_event_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = dyn_events_release_all(NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &dyn_event_seq_op);
+}
+
+static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_dyn_event);
+}
+
+static const struct file_operations dynamic_events_ops = {
+	.owner          = THIS_MODULE,
+	.open           = dyn_event_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+	.write		= dyn_event_write,
+};
+
+/* Make a tracefs interface for controlling dynamic events */
+static __init int init_dynamic_event(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer))
+		return 0;
+
+	entry = tracefs_create_file("dynamic_events", 0644, d_tracer,
+				    NULL, &dynamic_events_ops);
+
+	/* Event list interface */
+	if (!entry)
+		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
+
+	return 0;
+}
+fs_initcall(init_dynamic_event);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
new file mode 100644
index 000000000000..8c334064e4d6
--- /dev/null
+++ b/kernel/trace/trace_dynevent.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common header file for generic dynamic events.
+ */
+
+#ifndef _TRACE_DYNEVENT_H
+#define _TRACE_DYNEVENT_H
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+
+#include "trace.h"
+
+struct dyn_event;
+
+/**
+ * struct dyn_event_operations - Methods for each type of dynamic events
+ *
+ * These methods must be set for each type, since there is no default method.
+ * Before using this for dyn_event_init(), it must be registered by
+ * dyn_event_register().
+ *
+ * @create: Parse and create event method. This is invoked when user passes
+ *  a event definition to dynamic_events interface. This must not destruct
+ *  the arguments and return -ECANCELED if given arguments doesn't match its
+ *  command prefix.
+ * @show: Showing method. This is invoked when user reads the event definitions
+ *  via dynamic_events interface.
+ * @is_busy: Check whether given event is busy so that it can not be deleted.
+ *  Return true if it is busy, otherwides false.
+ * @free: Delete the given event. Return 0 if success, otherwides error.
+ * @match: Check whether given event and system name match this event.
+ *  Return true if it matches, otherwides false.
+ *
+ * Except for @create, these methods are called under holding event_mutex.
+ */
+struct dyn_event_operations {
+	struct list_head	list;
+	int (*create)(int argc, const char *argv[]);
+	int (*show)(struct seq_file *m, struct dyn_event *ev);
+	bool (*is_busy)(struct dyn_event *ev);
+	int (*free)(struct dyn_event *ev);
+	bool (*match)(const char *system, const char *event,
+			struct dyn_event *ev);
+};
+
+/* Register new dyn_event type -- must be called at first */
+int dyn_event_register(struct dyn_event_operations *ops);
+
+/**
+ * struct dyn_event - Dynamic event list header
+ *
+ * The dyn_event structure encapsulates a list and a pointer to the operators
+ * for making a global list of dynamic events.
+ * User must includes this in each event structure, so that those events can
+ * be added/removed via dynamic_events interface.
+ */
+struct dyn_event {
+	struct list_head		list;
+	struct dyn_event_operations	*ops;
+};
+
+extern struct list_head dyn_event_list;
+
+static inline
+int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
+{
+	if (!ev || !ops)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&ev->list);
+	ev->ops = ops;
+	return 0;
+}
+
+static inline int dyn_event_add(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!ev || !ev->ops)
+		return -EINVAL;
+
+	list_add_tail(&ev->list, &dyn_event_list);
+	return 0;
+}
+
+static inline void dyn_event_remove(struct dyn_event *ev)
+{
+	lockdep_assert_held(&event_mutex);
+	list_del_init(&ev->list);
+}
+
+void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
+void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
+void dyn_event_seq_stop(struct seq_file *m, void *v);
+int dyn_events_release_all(struct dyn_event_operations *type);
+int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type);
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ *
+ * This is just a basement of for_each macro. Wrap this for
+ * each actual event structure with ops filtering.
+ */
+#define for_each_dyn_event(pos)	\
+	list_for_each_entry(pos, &dyn_event_list, list)
+
+/*
+ * for_each_dyn_event	-	iterate over the dyn_event list safely
+ * @pos:	the struct dyn_event * to use as a loop cursor
+ * @n:		the struct dyn_event * to use as temporary storage
+ */
+#define for_each_dyn_event_safe(pos, n)	\
+	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
+
+#endif
-- 
2.34.1


