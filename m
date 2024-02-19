Return-Path: <stable+bounces-20597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797F85A896
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D81C234EE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C53B1B2;
	Mon, 19 Feb 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmphYveL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D33D98E
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359493; cv=none; b=Y4VFUMHUM7DBiyoZwear1GaLPzdNGJ2eklU7lUKggtxCYTV8O7GRh1Sk4O6RZzO55JOxrAckIBQYRTHujgFj+tTgMNtbJFyEE4bHVEI9oqor6yyud3TQbLUHL+0HihNPUQArJLCRcxN16XN9fS5V7Uci1TXyci/uEaCBGh02Py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359493; c=relaxed/simple;
	bh=piXqkKgR4xNX5PqPCzTKBsNhPgcwUPX1FaC22rAenVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RI+L+jWTBOhb9ixDreXKv4QT4lTDSqnNaZ0W7ehkjzZvc5+F0DYIJpduppOYr6YudekWC4/0RZV9RW39tUQ/Fapkj1mQXX7ayX+QRxiecSJlVzjjpP9kbypoYy5Ei+jf62gGZZQKACe6a5N0h5yHvdt1IpEeNYGSqM3ZHYqlWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmphYveL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B10C433F1;
	Mon, 19 Feb 2024 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359492;
	bh=piXqkKgR4xNX5PqPCzTKBsNhPgcwUPX1FaC22rAenVo=;
	h=Subject:To:Cc:From:Date:From;
	b=rmphYveLgb6A9eBBgdqkQMk9Y4M52/4q9djK8o+c1SCCXcZZW2otI7KPe9obcCkSf
	 oDmZdBwpFOHfjklwA1kMxhV56biPshubbYtH1nlmItaH/WTX6dqAGLSAdSETwFZ4Qs
	 dyL7cgVauwS/rDiIgDx4VTJeDlrXrfkv+m1wFyP0=
Subject: FAILED: patch "[PATCH] tracing: Fix wasted memory in saved_cmdlines logic" failed to apply to 4.19-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,meted@linux.ibm.com,mhiramat@kernel.org,svens@linux.ibm.com,vdonnefort@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:18:09 +0100
Message-ID: <2024021909-compacted-account-af9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 44dc5c41b5b1267d4dd037d26afc0c4d3a568acb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021909-compacted-account-af9d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
c0a581d7126c ("tracing: Disable interrupt or preemption before acquiring arch_spinlock_t")
a35873a0993b ("tracing: Add conditional snapshot")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44dc5c41b5b1267d4dd037d26afc0c4d3a568acb Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Fri, 9 Feb 2024 06:36:22 -0500
Subject: [PATCH] tracing: Fix wasted memory in saved_cmdlines logic

While looking at improving the saved_cmdlines cache I found a huge amount
of wasted memory that should be used for the cmdlines.

The tracing data saves pids during the trace. At sched switch, if a trace
occurred, it will save the comm of the task that did the trace. This is
saved in a "cache" that maps pids to comms and exposed to user space via
the /sys/kernel/tracing/saved_cmdlines file. Currently it only caches by
default 128 comms.

The structure that uses this creates an array to store the pids using
PID_MAX_DEFAULT (which is usually set to 32768). This causes the structure
to be of the size of 131104 bytes on 64 bit machines.

In hex: 131104 = 0x20020, and since the kernel allocates generic memory in
powers of two, the kernel would allocate 0x40000 or 262144 bytes to store
this structure. That leaves 131040 bytes of wasted space.

Worse, the structure points to an allocated array to store the comm names,
which is 16 bytes times the amount of names to save (currently 128), which
is 2048 bytes. Instead of allocating a separate array, make the structure
end with a variable length string and use the extra space for that.

This is similar to a recommendation that Linus had made about eventfs_inode names:

  https://lore.kernel.org/all/20240130190355.11486-5-torvalds@linux-foundation.org/

Instead of allocating a separate string array to hold the saved comms,
have the structure end with: char saved_cmdlines[]; and round up to the
next power of two over sizeof(struct saved_cmdline_buffers) + num_cmdlines * TASK_COMM_LEN
It will use this extra space for the saved_cmdline portion.

Now, instead of saving only 128 comms by default, by using this wasted
space at the end of the structure it can save over 8000 comms and even
saves space by removing the need for allocating the other array.

Link: https://lore.kernel.org/linux-trace-kernel/20240209063622.1f7b6d5f@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>
Fixes: 939c7a4f04fcd ("tracing: Introduce saved_cmdlines_size file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..9ff8a439d674 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2320,7 +2320,7 @@ struct saved_cmdlines_buffer {
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	char *saved_cmdlines;
+	char saved_cmdlines[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
@@ -2334,47 +2334,58 @@ static inline void set_cmdline(int idx, const char *cmdline)
 	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
-static int allocate_cmdlines_buffer(unsigned int val,
-				    struct saved_cmdlines_buffer *s)
+static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 {
+	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+
+	kfree(s->map_cmdline_to_pid);
+	free_pages((unsigned long)s, order);
+}
+
+static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
+{
+	struct saved_cmdlines_buffer *s;
+	struct page *page;
+	int orig_size, size;
+	int order;
+
+	/* Figure out how much is needed to hold the given number of cmdlines */
+	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	order = get_order(orig_size);
+	size = 1 << (order + PAGE_SHIFT);
+	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return NULL;
+
+	s = page_address(page);
+	memset(s, 0, sizeof(*s));
+
+	/* Round up to actual allocation */
+	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	s->cmdline_num = val;
+
 	s->map_cmdline_to_pid = kmalloc_array(val,
 					      sizeof(*s->map_cmdline_to_pid),
 					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid)
-		return -ENOMEM;
-
-	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
-	if (!s->saved_cmdlines) {
-		kfree(s->map_cmdline_to_pid);
-		return -ENOMEM;
+	if (!s->map_cmdline_to_pid) {
+		free_saved_cmdlines_buffer(s);
+		return NULL;
 	}
 
 	s->cmdline_idx = 0;
-	s->cmdline_num = val;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
 	       val * sizeof(*s->map_cmdline_to_pid));
 
-	return 0;
+	return s;
 }
 
 static int trace_create_savedcmd(void)
 {
-	int ret;
+	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
 
-	savedcmd = kmalloc(sizeof(*savedcmd), GFP_KERNEL);
-	if (!savedcmd)
-		return -ENOMEM;
-
-	ret = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT, savedcmd);
-	if (ret < 0) {
-		kfree(savedcmd);
-		savedcmd = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
+	return savedcmd ? 0 : -ENOMEM;
 }
 
 int is_tracing_stopped(void)
@@ -6056,26 +6067,14 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-{
-	kfree(s->saved_cmdlines);
-	kfree(s->map_cmdline_to_pid);
-	kfree(s);
-}
-
 static int tracing_resize_saved_cmdlines(unsigned int val)
 {
 	struct saved_cmdlines_buffer *s, *savedcmd_temp;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = allocate_cmdlines_buffer(val);
 	if (!s)
 		return -ENOMEM;
 
-	if (allocate_cmdlines_buffer(val, s) < 0) {
-		kfree(s);
-		return -ENOMEM;
-	}
-
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;


