Return-Path: <stable+bounces-66488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522594EC48
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221EA1F228DF
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB41366;
	Mon, 12 Aug 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFiFsmd9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17163715E
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464183; cv=none; b=lEMMmplQGZtZaSJP84JIsA2bRGB4rFnseGCA8RxkDZycMMCW5fVvMmpAzng6fzYbMbgp85UvAUWEwMqJaHO3xZBkDVY55wOSYcJCNL8c7MLDWPv/O3kqejfbbzxbEI+/G8bvpLTUcE94OQJfE3YZs94b5/G4xUMBnkjQ2pt2ivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464183; c=relaxed/simple;
	bh=mAaiikFGsolNzxBllKSFXl8y2Vr159tPgMKffsQMYdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7QFiPkKBML8ZseLxZ5QLPn6DTrcVlU/ljqz9RKl5jfnCcTL3VnyjKmt+Og2FXZO4M610psi8dhF7b5c9fESBIg8FsqvixT9iCDwh3aLCNIttad72TpZEp3MYsIipZw0i/0RvA3cmWsA910pRjo8fGchA7lgB/Bs0oE7wITZN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFiFsmd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E7C4AF0D;
	Mon, 12 Aug 2024 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464182;
	bh=mAaiikFGsolNzxBllKSFXl8y2Vr159tPgMKffsQMYdM=;
	h=Subject:To:Cc:From:Date:From;
	b=eFiFsmd9TyU2BFTocb/ulP8i8vBA6y4H5CL8+Ifz7sb7tYXPoMiPy5zHyPNq+4l8p
	 X/klzC6NYj0YyPMxl0bWX4P0AVfwNk3FyrUNP6B4MJmVUWpVS7lmyCHAqYfs3/SyL3
	 g4wq0mXj99YMoXUt0kg9OkWbBcC/If9svL5XLBdA=
Subject: FAILED: patch "[PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,ajay.kaher@broadcom.com,alexey.makhalov@broadcom.com,beaub@linux.microsoft.com,dan.carpenter@linaro.org,digirigawa@gmail.com,florian.fainelli@broadcom.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,minipli@grsecurity.net,torvalds@linux-foundation.org,vasavi.sirnapalli@broadcom.com,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:02:58 +0200
Message-ID: <2024081258-amusement-designing-88e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b1560408692cd0ab0370cfbe9deb03ce97ab3f6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081258-amusement-designing-88e9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

b1560408692c ("tracing: Have format file honor EVENT_FILE_FL_FREED")
bb32500fb9b7 ("tracing: Have trace_event_file have ref counters")
5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
a1f157c7a3bb ("tracing: Expand all ring buffers individually")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1560408692cd0ab0370cfbe9deb03ce97ab3f6d Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 30 Jul 2024 11:06:57 -0400
Subject: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


