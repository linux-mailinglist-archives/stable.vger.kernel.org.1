Return-Path: <stable+bounces-130403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB7A80453
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E5319E33F6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B9B26981F;
	Tue,  8 Apr 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upkqHFl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DC269823;
	Tue,  8 Apr 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113620; cv=none; b=jljx6RmVKlr+6gvUWLwL52mv7oeEtbUD9VVhEvLLpua70nSVQXp2QbZ6JsVRw8rkY0KhMPpQtuthADhSPRSYykA05XvZ/q4fdTADbG+68ZdTo9TTPNdGAVIkyeBLDMLlWTJFH1Zh0JDCraLUvq8hAJPC/IsnDBXhPSOktb+jdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113620; c=relaxed/simple;
	bh=kNQilbdSLlZnJ/73cbcr6fmajA84b0L4bK8+J7o6fXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnB4caNzTgXmN4RgB3tEq4H04Aqkl8w9tp5BKmPbpSGdfiut+vplr66qtJjmYJZnVrzEVC03tCwsXDqzvmcUrSLWA/5v+9SaFDyDTyjkn81s5wzrYffYiDONvZf4uR8FVnASm+3XTtno3GbEJ3m+zIcolOtBR8WKX+jgadnTKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upkqHFl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED27AC4CEE5;
	Tue,  8 Apr 2025 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113620;
	bh=kNQilbdSLlZnJ/73cbcr6fmajA84b0L4bK8+J7o6fXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upkqHFl+s7u/n7tdEVCxJ/opd0eEP1rhKfZ1QpPxx2gQkidmFH56DJZYm3IOIFcxH
	 fwoTnxbfNNNjs9RwIL6zLA11f4GaX1jpdGqbC3n8+qRpu0MqAmGJOHHHSQ0Iu+hFwe
	 TdZ+ABVU/9BzVKnz0bnvIwKP29FJ/bGP7trL4zG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 226/268] tracing/hist: Add poll(POLLIN) support on hist file
Date: Tue,  8 Apr 2025 12:50:37 +0200
Message-ID: <20250408104834.681326102@linuxfoundation.org>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit 1bd13edbbed6e7e396f1aab92b224a4775218e68 ]

Add poll syscall support on the `hist` file. The Waiter will be waken
up when the histogram is updated with POLLIN.

Currently, there is no way to wait for a specific event in userspace.
So user needs to peek the `trace` periodicaly, or wait on `trace_pipe`.
But it is not a good idea to peek at the `trace` for an event that
randomly happens. And `trace_pipe` is not coming back until a page is
filled with events.

This allows a user to wait for a specific event on the `hist` file. User
can set a histogram trigger on the event which they want to monitor
and poll() on its `hist` file. Since this poll() returns POLLIN, the next
poll() will return soon unless a read() happens on that hist file.

NOTE: To read the hist file again, you must set the file offset to 0,
but just for monitoring the event, you may not need to read the
histogram.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/173527247756.464571.14236296701625509931.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 0b4ffbe4888a ("tracing: Correct the refcount if the hist/hist_debug file fails to open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h     | 14 +++++++
 kernel/trace/trace_events.c      | 14 +++++++
 kernel/trace/trace_events_hist.c | 70 ++++++++++++++++++++++++++++++--
 3 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index aa1bc41726620..fe95d13c5e4d8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -683,6 +683,20 @@ struct trace_event_file {
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
 
+#ifdef CONFIG_HIST_TRIGGERS
+extern struct irq_work hist_poll_work;
+extern wait_queue_head_t hist_poll_wq;
+
+static inline void hist_poll_wakeup(void)
+{
+	if (wq_has_sleeper(&hist_poll_wq))
+		irq_work_queue(&hist_poll_work);
+}
+
+#define hist_poll_wait(file, wait)	\
+	poll_wait(file, &hist_poll_wq, wait)
+#endif
+
 #define __TRACE_EVENT_FLAGS(name, value)				\
 	static int __init trace_init_flags_##name(void)			\
 	{								\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 15041912c277d..562efd6685726 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3077,6 +3077,20 @@ static bool event_in_systems(struct trace_event_call *call,
 	return !*p || isspace(*p) || *p == ',';
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+/*
+ * Wake up waiter on the hist_poll_wq from irq_work because the hist trigger
+ * may happen in any context.
+ */
+static void hist_poll_event_irq_work(struct irq_work *work)
+{
+	wake_up_all(&hist_poll_wq);
+}
+
+DEFINE_IRQ_WORK(hist_poll_work, hist_poll_event_irq_work);
+DECLARE_WAIT_QUEUE_HEAD(hist_poll_wq);
+#endif
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 755db2451fb2d..49b7811dec9f8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5322,6 +5322,8 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
 		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+
+	hist_poll_wakeup();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -5601,15 +5603,36 @@ static void hist_trigger_show(struct seq_file *m,
 		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
 }
 
+struct hist_file_data {
+	struct file *file;
+	u64 last_read;
+};
+
+static u64 get_hist_hit_count(struct trace_event_file *event_file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *data;
+	u64 ret = 0;
+
+	list_for_each_entry(data, &event_file->triggers, list) {
+		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = data->private_data;
+			ret += atomic64_read(&hist_data->map->hits);
+		}
+	}
+	return ret;
+}
+
 static int hist_show(struct seq_file *m, void *v)
 {
+	struct hist_file_data *hist_file = m->private;
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
 	int n = 0;
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_file(m->private);
+	event_file = event_file_file(hist_file->file);
 	if (unlikely(!event_file))
 		return -ENODEV;
 
@@ -5617,27 +5640,68 @@ static int hist_show(struct seq_file *m, void *v)
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
+	hist_file->last_read = get_hist_hit_count(event_file);
+
 	return 0;
 }
 
+static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct trace_event_file *event_file;
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+
+	guard(mutex)(&event_mutex);
+
+	event_file = event_file_data(file);
+	if (!event_file)
+		return EPOLLERR;
+
+	hist_poll_wait(file, wait);
+
+	if (hist_file->last_read != get_hist_hit_count(event_file))
+		return EPOLLIN | EPOLLRDNORM;
+
+	return 0;
+}
+
+static int event_hist_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct hist_file_data *hist_file = m->private;
+
+	kfree(hist_file);
+	return tracing_single_release_file_tr(inode, file);
+}
+
 static int event_hist_open(struct inode *inode, struct file *file)
 {
+	struct hist_file_data *hist_file;
 	int ret;
 
 	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	hist_file = kzalloc(sizeof(*hist_file), GFP_KERNEL);
+	if (!hist_file)
+		return -ENOMEM;
+	hist_file->file = file;
+
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_show, file);
+	ret = single_open(file, hist_show, hist_file);
+	if (ret)
+		kfree(hist_file);
+	return ret;
 }
 
 const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = tracing_single_release_file_tr,
+	.release = event_hist_release,
+	.poll = event_hist_poll,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
-- 
2.39.5




