Return-Path: <stable+bounces-183717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCBBC9BEE
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4119E7EDD
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6DA1EDA0F;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdTILoK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0C1E51FB;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023461; cv=none; b=cZcZji73rBeMUacL4cjAJEyTlidw3rLxigb7feZgYGNZkLoTHMNWCzdnksamWWb1QIA+e//5N/9z7L94eTIOve9nq2DjnR8LdK4kciu1TTzyA7jqrSHoiEPzEX6eWypz2x/F9CoRIQLgOenkrygy5FM5hxdCtYwu8A9FfYgN6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023461; c=relaxed/simple;
	bh=tgJfcsY/z2eMnplyFIdM7m2mvJFamrw66o78/1eEZf0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fnMBRumOXcxGTsh2yz48rCYZ9n3kHL3Qd850xbeGo9OlCdrsUb8CmANF6x4h/UyTC+whrunRB9V5jdTC3XdbZdF+Db1PZSnAZPHrf6dOctiRK0gUGFx9m6MIRGpaaasem2aeNJgFHGGFufsultSR9k35S0ONvP1qNFanKUUgg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdTILoK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55EFC4CEE7;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023461;
	bh=tgJfcsY/z2eMnplyFIdM7m2mvJFamrw66o78/1eEZf0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gdTILoK6kJ3GlytrDWBi0Va5dnODVwT6oJtcGkv0RcO1Td28IN0W7j4h9J6iBGi4z
	 /9/RUa8apEtiKawWI/qc5Qw3boWVClamoKhKBWXIh+8Cw+0AD2qAXxFFzsbMnWPF38
	 ip2f79KTVLHthNk/yiNnZeY0xVrDj8ezsEWrpt9Sr9Bbvx8+xlu06pBt354K1IMYhD
	 FzGF+zs+oMywHJzWUdivDKCw4Ez7DvqqGouSSFhhbOJ5r7nnc6n4V8rtQ+TFHoGjQW
	 avhoXh/6RuaqyiZQi5EIt1hzVn1CvoJ/q5Tg23SEddWFKegItG13o914ww4xc9OpqV
	 p9/FEc6J0XO6g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVB-00000000BeS-1fN7;
	Thu, 09 Oct 2025 11:24:21 -0400
Message-ID: <20251009152421.249144319@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:24:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Luo Gengkun <luogengkun@huaweicloud.com>,
 Wattson CI <wattson-external@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Runping Lai <runpinglai@google.com>
Subject: [for-linus][PATCH 5/5] tracing: Have trace_marker use per-cpu data to read user space
References: <20251009152359.604267051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

It was reported that using __copy_from_user_inatomic() can actually
schedule. Which is bad when preemption is disabled. Even though there's
logic to check in_atomic() is set, but this is a nop when the kernel is
configured with PREEMPT_NONE. This is due to page faulting and the code
could schedule with preemption disabled.

Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@huaweicloud.com/

The solution was to change the __copy_from_user_inatomic() to
copy_from_user_nofault(). But then it was reported that this caused a
regression in Android. There's several applications writing into
trace_marker() in Android, but now instead of showing the expected data,
it is showing:

  tracing_mark_write: <faulted>

After reverting the conversion to copy_from_user_nofault(), Android was
able to get the data again.

Writes to the trace_marker is a way to efficiently and quickly enter data
into the Linux tracing buffer. It takes no locks and was designed to be as
non-intrusive as possible. This means it cannot allocate memory, and must
use pre-allocated data.

A method that is actively being worked on to have faultable system call
tracepoints read user space data is to allocate per CPU buffers, and use
them in the callback. The method uses a technique similar to seqcount.
That is something like this:

	preempt_disable();
	cpu = smp_processor_id();
	buffer = this_cpu_ptr(&pre_allocated_cpu_buffers, cpu);
	do {
		cnt = nr_context_switches_cpu(cpu);
		migrate_disable();
		preempt_enable();
		ret = copy_from_user(buffer, ptr, size);
		preempt_disable();
		migrate_enable();
	} while (!ret && cnt != nr_context_switches_cpu(cpu));

	if (!ret)
		ring_buffer_write(buffer);
	preempt_enable();

It's a little more involved than that, but the above is the basic logic.
The idea is to acquire the current CPU buffer, disable migration, and then
enable preemption. At this moment, it can safely use copy_from_user().
After reading the data from user space, it disables preemption again. It
then checks to see if there was any new scheduling on this CPU. If there
was, it must assume that the buffer was corrupted by another task. If
there wasn't, then the buffer is still valid as only tasks in preemptable
context can write to this buffer and only those that are running on the
CPU.

By using this method, where trace_marker open allocates the per CPU
buffers, trace_marker writes can access user space and even fault it in,
without having to allocate or take any locks of its own.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: Wattson CI <wattson-external@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20251008124510.6dba541a@gandalf.local.home
Fixes: 3d62ab32df065 ("tracing: Fix tracing_marker may trigger page fault during preempt_disable")
Reported-by: Runping Lai <runpinglai@google.com>
Tested-by: Runping Lai <runpinglai@google.com>
Closes: https://lore.kernel.org/linux-trace-kernel/20251007003417.3470979-2-runpinglai@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 268 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 220 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3c94fbaf002..0fd582651293 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4791,12 +4791,6 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
 	return single_release(inode, filp);
 }
 
-static int tracing_mark_open(struct inode *inode, struct file *filp)
-{
-	stream_open(inode, filp);
-	return tracing_open_generic_tr(inode, filp);
-}
-
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7163,7 +7157,7 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 
 #define TRACE_MARKER_MAX_SIZE		4096
 
-static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user *ubuf,
+static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 				      size_t cnt, unsigned long ip)
 {
 	struct ring_buffer_event *event;
@@ -7173,20 +7167,11 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	int meta_size;
 	ssize_t written;
 	size_t size;
-	int len;
-
-/* Used in tracing_mark_raw_write() as well */
-#define FAULTED_STR "<faulted>"
-#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
 
-	/* If less than "<faulted>", then make sure we can still add that */
-	if (cnt < FAULTED_SIZE)
-		size += FAULTED_SIZE - cnt;
-
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
@@ -7196,9 +7181,6 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 		 * make it smaller and try again.
 		 */
 		if (size > ring_buffer_max_event_size(buffer)) {
-			/* cnt < FAULTED size should never be bigger than max */
-			if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
-				return -EBADF;
 			cnt = ring_buffer_max_event_size(buffer) - meta_size;
 			/* The above should only happen once */
 			if (WARN_ON_ONCE(cnt + meta_size == size))
@@ -7212,14 +7194,8 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
-
-	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
-	if (len) {
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		cnt = FAULTED_SIZE;
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->buf, buf, cnt);
+	written = cnt;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
@@ -7243,6 +7219,169 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	return written;
 }
 
+struct trace_user_buf {
+	char		*buf;
+};
+
+struct trace_user_buf_info {
+	struct trace_user_buf __percpu	*tbuf;
+	int				ref;
+};
+
+
+static DEFINE_MUTEX(trace_user_buffer_mutex);
+static struct trace_user_buf_info *trace_user_buffer;
+
+static void trace_user_fault_buffer_free(struct trace_user_buf_info *tinfo)
+{
+	char *buf;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+		kfree(buf);
+	}
+	free_percpu(tinfo->tbuf);
+	kfree(tinfo);
+}
+
+static int trace_user_fault_buffer_enable(void)
+{
+	struct trace_user_buf_info *tinfo;
+	char *buf;
+	int cpu;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	if (trace_user_buffer) {
+		trace_user_buffer->ref++;
+		return 0;
+	}
+
+	tinfo = kmalloc(sizeof(*tinfo), GFP_KERNEL);
+	if (!tinfo)
+		return -ENOMEM;
+
+	tinfo->tbuf = alloc_percpu(struct trace_user_buf);
+	if (!tinfo->tbuf) {
+		kfree(tinfo);
+		return -ENOMEM;
+	}
+
+	tinfo->ref = 1;
+
+	/* Clear each buffer in case of error */
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = NULL;
+	}
+
+	for_each_possible_cpu(cpu) {
+		buf = kmalloc_node(TRACE_MARKER_MAX_SIZE, GFP_KERNEL,
+				   cpu_to_node(cpu));
+		if (!buf) {
+			trace_user_fault_buffer_free(tinfo);
+			return -ENOMEM;
+		}
+		per_cpu_ptr(tinfo->tbuf, cpu)->buf = buf;
+	}
+
+	trace_user_buffer = tinfo;
+
+	return 0;
+}
+
+static void trace_user_fault_buffer_disable(void)
+{
+	struct trace_user_buf_info *tinfo;
+
+	guard(mutex)(&trace_user_buffer_mutex);
+
+	tinfo = trace_user_buffer;
+
+	if (WARN_ON_ONCE(!tinfo))
+		return;
+
+	if (--tinfo->ref)
+		return;
+
+	trace_user_fault_buffer_free(tinfo);
+	trace_user_buffer = NULL;
+}
+
+/* Must be called with preemption disabled */
+static char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
+				   const char __user *ptr, size_t size,
+				   size_t *read_size)
+{
+	int cpu = smp_processor_id();
+	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+	unsigned int cnt;
+	int trys = 0;
+	int ret;
+
+	if (size > TRACE_MARKER_MAX_SIZE)
+		size = TRACE_MARKER_MAX_SIZE;
+	*read_size = 0;
+
+	/*
+	 * This acts similar to a seqcount. The per CPU context switches are
+	 * recorded, migration is disabled and preemption is enabled. The
+	 * read of the user space memory is copied into the per CPU buffer.
+	 * Preemption is disabled again, and if the per CPU context switches count
+	 * is still the same, it means the buffer has not been corrupted.
+	 * If the count is different, it is assumed the buffer is corrupted
+	 * and reading must be tried again.
+	 */
+
+	do {
+		/*
+		 * If for some reason, copy_from_user() always causes a context
+		 * switch, this would then cause an infinite loop.
+		 * If this task is preempted by another user space task, it
+		 * will cause this task to try again. But just in case something
+		 * changes where the copying from user space causes another task
+		 * to run, prevent this from going into an infinite loop.
+		 * 100 tries should be plenty.
+		 */
+		if (WARN_ONCE(trys++ > 100, "Error: Too many tries to read user space"))
+			return NULL;
+
+		/* Read the current CPU context switch counter */
+		cnt = nr_context_switches_cpu(cpu);
+
+		/*
+		 * Preemption is going to be enabled, but this task must
+		 * remain on this CPU.
+		 */
+		migrate_disable();
+
+		/*
+		 * Now preemption is being enabed and another task can come in
+		 * and use the same buffer and corrupt our data.
+		 */
+		preempt_enable_notrace();
+
+		ret = __copy_from_user(buffer, ptr, size);
+
+		preempt_disable_notrace();
+		migrate_enable();
+
+		/* if it faulted, no need to test if the buffer was corrupted */
+		if (ret)
+			return NULL;
+
+		/*
+		 * Preemption is disabled again, now check the per CPU context
+		 * switch counter. If it doesn't match, then another user space
+		 * process may have schedule in and corrupted our buffer. In that
+		 * case the copying must be retried.
+		 */
+	} while (nr_context_switches_cpu(cpu) != cnt);
+
+	*read_size = size;
+	return buffer;
+}
+
 static ssize_t
 tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7250,6 +7389,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
 	unsigned long ip;
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7263,6 +7404,16 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt > TRACE_MARKER_MAX_SIZE)
 		cnt = TRACE_MARKER_MAX_SIZE;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	if (cnt > size)
+		cnt = size;
+
 	/* The selftests expect this function to be the IP address */
 	ip = _THIS_IP_;
 
@@ -7270,32 +7421,27 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+			written = write_marker_to_buffer(tr, buf, cnt, ip);
 			if (written < 0)
 				break;
 		}
 	} else {
-		written = write_marker_to_buffer(tr, ubuf, cnt, ip);
+		written = write_marker_to_buffer(tr, buf, cnt, ip);
 	}
 
 	return written;
 }
 
 static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
-					  const char __user *ubuf, size_t cnt)
+					  const char *buf, size_t cnt)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
 	ssize_t written;
-	int size;
-	int len;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
 
 	size = sizeof(*entry) + cnt;
-	if (cnt < FAULT_SIZE_ID)
-		size += FAULT_SIZE_ID - cnt;
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7309,14 +7455,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-
-	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
-	if (len) {
-		entry->id = -1;
-		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-		written = -EFAULT;
-	} else
-		written = cnt;
+	memcpy(&entry->id, buf, cnt);
+	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
 
@@ -7329,8 +7469,8 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	ssize_t written = -ENODEV;
-
-#define FAULT_SIZE_ID (FAULTED_SIZE + sizeof(int))
+	size_t size;
+	char *buf;
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -7342,6 +7482,17 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
+	/* Must have preemption disabled while having access to the buffer */
+	guard(preempt_notrace)();
+
+	buf = trace_user_fault_read(trace_user_buffer, ubuf, cnt, &size);
+	if (!buf)
+		return -EFAULT;
+
+	/* raw write is all or nothing */
+	if (cnt > size)
+		return -EINVAL;
+
 	/* The global trace_marker_raw can go to multiple instances */
 	if (tr == &global_trace) {
 		guard(rcu)();
@@ -7357,6 +7508,27 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = trace_user_fault_buffer_enable();
+	if (ret < 0)
+		return ret;
+
+	stream_open(inode, filp);
+	ret = tracing_open_generic_tr(inode, filp);
+	if (ret < 0)
+		trace_user_fault_buffer_disable();
+	return ret;
+}
+
+static int tracing_mark_release(struct inode *inode, struct file *file)
+{
+	trace_user_fault_buffer_disable();
+	return tracing_release_generic_tr(inode, file);
+}
+
 static int tracing_clock_show(struct seq_file *m, void *v)
 {
 	struct trace_array *tr = m->private;
@@ -7764,13 +7936,13 @@ static const struct file_operations tracing_free_buffer_fops = {
 static const struct file_operations tracing_mark_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
 	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.release	= tracing_release_generic_tr,
+	.release	= tracing_mark_release,
 };
 
 static const struct file_operations trace_clock_fops = {
-- 
2.51.0



