Return-Path: <stable+bounces-2502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93217F8475
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D261C27B85
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F05364C4;
	Fri, 24 Nov 2023 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbTdiJiT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E08339BE;
	Fri, 24 Nov 2023 19:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB582C433C8;
	Fri, 24 Nov 2023 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854042;
	bh=xVSDRouZwHAWlsNkujTWyNg8MVeuuqdqhnWnMraPb0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbTdiJiTTILhj+e2A4ZeFgh8nHlwv6bqz/z5V4N2zLwP0POuCMkj8Hae+TIlMXMi0
	 t/QU/YD0VjIjPYl1d1fBIG35nnJfwzcbK5iNmisOIww7dlyH4g7qDWpNuoanbP9fNR
	 W2RQ3TFOBp3WPp0T/YWzjtyL7xlldoGpfqOtYD0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.4 133/159] tracing: Have trace_event_file have ref counters
Date: Fri, 24 Nov 2023 17:55:50 +0000
Message-ID: <20231124171947.348654241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 upstream.

The following can crash the kernel:

 # cd /sys/kernel/tracing
 # echo 'p:sched schedule' > kprobe_events
 # exec 5>>events/kprobes/sched/enable
 # > kprobe_events
 # exec 5>&-

The above commands:

 1. Change directory to the tracefs directory
 2. Create a kprobe event (doesn't matter what one)
 3. Open bash file descriptor 5 on the enable file of the kprobe event
 4. Delete the kprobe event (removes the files too)
 5. Close the bash file descriptor 5

The above causes a crash!

 BUG: kernel NULL pointer dereference, address: 0000000000000028
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 6 PID: 877 Comm: bash Not tainted 6.5.0-rc4-test-00008-g2c6b6b1029d4-dirty #186
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:tracing_release_file_tr+0xc/0x50

What happens here is that the kprobe event creates a trace_event_file
"file" descriptor that represents the file in tracefs to the event. It
maintains state of the event (is it enabled for the given instance?).
Opening the "enable" file gets a reference to the event "file" descriptor
via the open file descriptor. When the kprobe event is deleted, the file is
also deleted from the tracefs system which also frees the event "file"
descriptor.

But as the tracefs file is still opened by user space, it will not be
totally removed until the final dput() is called on it. But this is not
true with the event "file" descriptor that is already freed. If the user
does a write to or simply closes the file descriptor it will reference the
event "file" descriptor that was just freed, causing a use-after-free bug.

To solve this, add a ref count to the event "file" descriptor as well as a
new flag called "FREED". The "file" will not be freed until the last
reference is released. But the FREE flag will be set when the event is
removed to prevent any more modifications to that event from happening,
even if there's still a reference to the event "file" descriptor.

Link: https://lore.kernel.org/linux-trace-kernel/20231031000031.1e705592@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20231031122453.7a48b923@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: f5ca233e2e66d ("tracing: Increase trace array ref count on enable and filter files")
Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
Tested-by: Beau Belgrave <beaub@linux.microsoft.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/trace_events.h       |    4 +++
 kernel/trace/trace.c               |   15 ++++++++++++++
 kernel/trace/trace.h               |    3 ++
 kernel/trace/trace_events.c        |   39 ++++++++++++++++++++++++-------------
 kernel/trace/trace_events_filter.c |    3 ++
 5 files changed, 51 insertions(+), 13 deletions(-)

--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -341,6 +341,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 /*
@@ -357,6 +358,7 @@ enum {
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -370,6 +372,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -398,6 +401,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4257,6 +4257,20 @@ int tracing_open_file_tr(struct inode *i
 	if (ret)
 		return ret;
 
+	mutex_lock(&event_mutex);
+
+	/* Fail if the file is marked for removal */
+	if (file->flags & EVENT_FILE_FL_FREED) {
+		trace_array_put(file->tr);
+		ret = -ENODEV;
+	} else {
+		event_file_get(file);
+	}
+
+	mutex_unlock(&event_mutex);
+	if (ret)
+		return ret;
+
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -4267,6 +4281,7 @@ int tracing_release_file_tr(struct inode
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1696,6 +1696,9 @@ extern int register_event_command(struct
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -698,21 +698,33 @@ static void remove_subsystem(struct trac
 	}
 }
 
+void event_file_get(struct trace_event_file *file)
+{
+	atomic_inc(&file->ref);
+}
+
+void event_file_put(struct trace_event_file *file)
+{
+	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			kmem_cache_free(file_cachep, file);
+		return;
+	}
+
+	if (atomic_dec_and_test(&file->ref)) {
+		/* Count should only go to zero when it is freed */
+		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
+			return;
+		kmem_cache_free(file_cachep, file);
+	}
+}
+
 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	struct dentry *dir = file->dir;
-	struct dentry *child;
-
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
 
+	if (dir)
 		tracefs_remove_recursive(dir);
-	}
 
 	list_del(&file->list);
 	remove_subsystem(file->system);
@@ -1033,7 +1045,7 @@ event_enable_read(struct file *filp, cha
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1071,7 +1083,7 @@ event_enable_write(struct file *filp, co
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file))
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED)))
 			ret = ftrace_event_enable_disable(file, val);
 		mutex_unlock(&event_mutex);
 		break;
@@ -1340,7 +1352,7 @@ event_filter_read(struct file *filp, cha
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2264,6 +2276,7 @@ trace_create_new_event(struct trace_even
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1800,6 +1800,9 @@ int apply_event_filter(struct trace_even
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);



