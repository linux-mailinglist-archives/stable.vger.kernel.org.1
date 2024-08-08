Return-Path: <stable+bounces-66047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690194BF88
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FEB2870F4
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962C18E752;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39818DF6E;
	Thu,  8 Aug 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=tJMxqTkUHaq1ouAUNU6klWyLTU33ZaX6Zp6syATFQswKNz06o/SYxY9IJPkKkPFQ359jQl/M2pj/B28EbQnQAIWb5Qwa3Vcz4tTcWdfYAwq3ic4JoEn2Z7c11n0p9FuCL7Sms+arCTtQKnts2yYRis4tCwhJMcIKmcpMotjB9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=ftPo2lTY7at9qELYpatcq4EPjW1lcsAIdZ/IvbUmBio=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tFirzvJ8DEeMzJNsBS/u+/gVswuWqF7qypF+nQJ8Umd97HJ0wd7G8REuKaPnf5UJYy/T9/v7sv6MqheQKF33iKpxbBXjUdZJq55OOf9baIcnFHdJJpf4k97fJP/7o3g14Wnq+kZSoItgclsSfk0w2yPf0IgQv+dftu859I4hD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4314C4AF0D;
	Thu,  8 Aug 2024 14:21:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc415-00000000BQ3-31Ju;
	Thu, 08 Aug 2024 10:21:23 -0400
Message-ID: <20240808142123.575263174@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 =?UTF-8?q?Ilkka=20Naulap=C3=A4=C3=A4?= <digirigawa@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al   Viro <viro@zeniv.linux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Mathias Krause <minipli@grsecurity.net>
Subject: [for-linus][PATCH 1/9] tracing: Have format file honor EVENT_FILE_FL_FREED
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When eventfs was introduced, special care had to be done to coordinate the
freeing of the file meta data with the files that are exposed to user
space. The file meta data would have a ref count that is set when the file
is created and would be decremented and freed after the last user that
opened the file closed it. When the file meta data was to be freed, it
would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
and any new references made (like new opens or reads) would fail as it is
marked freed. This allowed other meta data to be freed after this flag was
set (under the event_mutex).

All the files that were dynamically created in the events directory had a
pointer to the file meta data and would call event_release() when the last
reference to the user space file was closed. This would be the time that it
is safe to free the file meta data.

A shortcut was made for the "format" file. It's i_private would point to
the "call" entry directly and not point to the file's meta data. This is
because all format files are the same for the same "call", so it was
thought there was no reason to differentiate them.  The other files
maintain state (like the "enable", "trigger", etc). But this meant if the
file were to disappear, the "format" file would be unaware of it.

This caused a race that could be trigger via the user_events test (that
would create dynamic events and free them), and running a loop that would
read the user_events format files:

In one console run:

 # cd tools/testing/selftests/user_events
 # while true; do ./ftrace_test; done

And in another console run:

 # cd /sys/kernel/tracing/
 # while true; do cat events/user_events/__test_event/format; done 2>/dev/null

With KASAN memory checking, it would trigger a use-after-free bug report
(which was a real bug). This was because the format file was not checking
the file's meta data flag "EVENT_FILE_FL_FREED", so it would access the
event that the file meta data pointed to after the event was freed.

After inspection, there are other locations that were found to not check
the EVENT_FILE_FL_FREED flag when accessing the trace_event_file. Add a
new helper function: event_file_file() that will make sure that the
event_mutex is held, and will return NULL if the trace_event_file has the
EVENT_FILE_FL_FREED flag set. Have the first reference of the struct file
pointer use event_file_file() and check for NULL. Later uses can still use
the event_file_data() helper function if the event_mutex is still held and
was not released since the event_file_file() call.

Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers   <mathieu.desnoyers@efficios.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Ilkka Naulapää    <digirigawa@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al   Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter   <dan.carpenter@linaro.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Florian Fainelli  <florian.fainelli@broadcom.com>
Cc: Alexey Makhalov    <alexey.makhalov@broadcom.com>
Cc: Vasavi Sirnapalli    <vasavi.sirnapalli@broadcom.com>
Link: https://lore.kernel.org/20240730110657.3b69d3c1@gandalf.local.home
Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
Reported-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                | 23 ++++++++++++++++++++
 kernel/trace/trace_events.c         | 33 +++++++++++++++++------------
 kernel/trace/trace_events_hist.c    |  4 ++--
 kernel/trace/trace_events_inject.c  |  2 +-
 kernel/trace/trace_events_trigger.c |  6 +++---
 5 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8783bebd0562..bd3e3069300e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1634,6 +1634,29 @@ static inline void *event_file_data(struct file *filp)
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
+/*
+ * When the trace_event_file is the filp->i_private pointer,
+ * it must be taken under the event_mutex lock, and then checked
+ * if the EVENT_FILE_FL_FREED flag is set. If it is, then the
+ * data pointed to by the trace_event_file can not be trusted.
+ *
+ * Use the event_file_file() to access the trace_event_file from
+ * the filp the first time under the event_mutex and check for
+ * NULL. If it is needed to be retrieved again and the event_mutex
+ * is still held, then the event_file_data() can be used and it
+ * is guaranteed to be valid.
+ */
+static inline struct trace_event_file *event_file_file(struct file *filp)
+{
+	struct trace_event_file *file;
+
+	lockdep_assert_held(&event_mutex);
+	file = READ_ONCE(file_inode(filp)->i_private);
+	if (!file || file->flags & EVENT_FILE_FL_FREED)
+		return NULL;
+	return file;
+}
+
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..f08fbaf8cad6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1386,12 +1386,12 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	char buf[4] = "0";
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (likely(file))
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file || flags & EVENT_FILE_FL_FREED)
+	if (!file)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1424,8 +1424,8 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	case 1:
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
-		file = event_file_data(filp);
-		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED))) {
+		file = event_file_file(filp);
+		if (likely(file)) {
 			ret = tracing_update_buffers(file->tr);
 			if (ret < 0) {
 				mutex_unlock(&event_mutex);
@@ -1540,7 +1540,8 @@ enum {
 
 static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct list_head *common_head = &ftrace_common_fields;
 	struct list_head *head = trace_get_fields(call);
 	struct list_head *node = v;
@@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 
 static int f_show(struct seq_file *m, void *v)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct ftrace_event_field *field;
 	const char *array_descriptor;
 
@@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_file(m->private);
+	if (!file)
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)
@@ -1706,8 +1710,8 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 	trace_seq_init(s);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file && !(file->flags & EVENT_FILE_FL_FREED))
+	file = event_file_file(filp);
+	if (file)
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -1736,9 +1740,13 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return PTR_ERR(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file)
-		err = apply_event_filter(file, buf);
+	file = event_file_file(filp);
+	if (file) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			err = -ENODEV;
+		else
+			err = apply_event_filter(file, buf);
+	}
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
@@ -2485,7 +2493,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (strcmp(name, "format") == 0) {
 		*mode = TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
-		*data = call;
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..5f9119eb7c67 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5601,7 +5601,7 @@ static int hist_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -5880,7 +5880,7 @@ static int hist_debug_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 8650562bdaa9..a8f076809db4 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -299,7 +299,7 @@ event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (file) {
 		call = file->event_call;
 		size = parse_entry(buf, call, &entry);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4bec043c8690..a5e3d6acf1e1 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -159,7 +159,7 @@ static void *trigger_start(struct seq_file *m, loff_t *pos)
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file))
 		return ERR_PTR(-ENODEV);
 
@@ -213,7 +213,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&event_mutex);
 
-	if (unlikely(!event_file_data(file))) {
+	if (unlikely(!event_file_file(file))) {
 		mutex_unlock(&event_mutex);
 		return -ENODEV;
 	}
@@ -293,7 +293,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (unlikely(!event_file)) {
 		mutex_unlock(&event_mutex);
 		kfree(buf);
-- 
2.43.0



