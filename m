Return-Path: <stable+bounces-104122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0409F10F0
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F48163E01
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419A1E25F8;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5C1E25E1;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103598; cv=none; b=N4lnOCGpz/Jyx0WB64ml+HuwEGo8RAPvx0cJrELxl7j/EPfWBN4ssszn6Wjm9asIXzAO3pw24n1ntkpikfDxhn4u0NZrAWBKRi1lBKdPcTb1hDOVZJpO0jedBBnu/SfWbk1XiYleDQi+cdh9oEJ+yGso1XELN6gjC8I8joFTUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103598; c=relaxed/simple;
	bh=hbXcFDcsPeKieMQYD3MUdlFFN9d9AAy2f0U+uADjD2E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KW0s/mLU0eZnCqffFqdD38LkZWDZFbgzcabr71g06I50Sh4XG9S5D8rdUkrxh7SHKvp47FOUC6ucEwKyLymdnApGhHBCiDQ9/uVK0mhSdBLbmwfUwad5e6ATx3cYw6gqK88sCbUs5OJygCej+gOtmvnHJfn6kk+CIyWqjTO2t1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615A3C4CEE1;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tM7ZI-00000005PGg-146l;
	Fri, 13 Dec 2024 10:27:04 -0500
Message-ID: <20241213152704.105004386@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Dec 2024 10:26:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/3] tracing: Fix trace output when pointer hash is disabled
References: <20241213152647.904822987@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The "%p" in the trace output is by default hashes the pointer. An option
was added to disable the hashing as reading trace output is a privileged
operation (just like reading kallsyms). When hashing is disabled, the
iter->fmt temp buffer is used to add "x" to "%p" into "%px" before sending
to the svnprintf() functions.

The problem with using iter->fmt, is that the trace_check_vprintf() that
makes sure that trace events "%pX" pointers are not dereferencing freed
addresses (and prints a warning if it does) also uses the iter->fmt to
save to and use to print out for the trace file. When the hash_ptr option
is disabled, the "%px" version is added to the iter->fmt buffer, and that
then is passed to the trace_check_vprintf() function that then uses the
iter->fmt as a temp buffer. Obviously this caused bad results.

This was noticed when backporting the persistent ring buffer to 5.10 and
added this code without the option being disabled by default, so it failed
one of the selftests because the sched_wakeup was missing the "comm"
field:

     cat-907     [006] dN.4.   249.722403: sched_wakeup: comm= pid=74 prio=120 target_cpu=006

Instead of showing:

  <idle>-0       [004] dNs6.    49.076464: sched_wakeup: comm=sshd-session pid=896 prio=120 target_cpu=0040

To fix this, change trace_check_vprintf() to modify the iter->fmt instead
of copying to it. If the fmt passed in is not the iter->fmt, first copy
the entire fmt string to iter->fmt and then iterate the iter->fmt. When
the format needs to be processed, perform the following like actions:

  save_ch = p[i];
  p[i] = '\0';
  trace_seq_printf(&iter->seq, p, str);
  p[i] = save_ch;

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241212105426.113f2be3@batman.local.home
Fixes: efbbdaa22bb78 ("tracing: Show real address for trace event arguments")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 90 +++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..b44b1cdaa20e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3711,8 +3711,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 {
 	long text_delta = 0;
 	long data_delta = 0;
-	const char *p = fmt;
 	const char *str;
+	char save_ch;
+	char *buf = NULL;
+	char *p;
 	bool good;
 	int i, j;
 
@@ -3720,7 +3722,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		return;
 
 	if (static_branch_unlikely(&trace_no_verify))
-		goto print;
+		goto print_fmt;
 
 	/*
 	 * When the kernel is booted with the tp_printk command line
@@ -3735,8 +3737,21 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 
 	/* Don't bother checking when doing a ftrace_dump() */
 	if (iter->fmt == static_fmt_buf)
-		goto print;
+		goto print_fmt;
 
+	if (fmt != iter->fmt) {
+		int len = strlen(fmt);
+		while (iter->fmt_size < len + 1) {
+			/*
+			 * If we can't expand the copy buffer,
+			 * just print it.
+			 */
+			if (!trace_iter_expand_format(iter))
+				goto print_fmt;
+		}
+		strscpy(iter->fmt, fmt, iter->fmt_size);
+	}
+	p = iter->fmt;
 	while (*p) {
 		bool star = false;
 		int len = 0;
@@ -3748,14 +3763,6 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 * as well as %p[sS] if delta is non-zero
 		 */
 		for (i = 0; p[i]; i++) {
-			if (i + 1 >= iter->fmt_size) {
-				/*
-				 * If we can't expand the copy buffer,
-				 * just print it.
-				 */
-				if (!trace_iter_expand_format(iter))
-					goto print;
-			}
 
 			if (p[i] == '\\' && p[i+1]) {
 				i++;
@@ -3788,10 +3795,11 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (!p[i])
 			break;
 
-		/* Copy up to the %s, and print that */
-		strncpy(iter->fmt, p, i);
-		iter->fmt[i] = '\0';
-		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
+		/* Print up to the %s */
+		save_ch = p[i];
+		p[i] = '\0';
+		trace_seq_vprintf(&iter->seq, p, ap);
+		p[i] = save_ch;
 
 		/* Add delta to %pS pointers */
 		if (p[i+1] == 'p') {
@@ -3837,6 +3845,8 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			good = trace_safe_str(iter, str, star, len);
 		}
 
+		p += i;
+
 		/*
 		 * If you hit this warning, it is likely that the
 		 * trace event in question used %s on a string that
@@ -3849,41 +3859,51 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (WARN_ONCE(!good, "fmt: '%s' current_buffer: '%s'",
 			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
+#define TEMP_BUFSIZ 1024
+
+			if (!buf) {
+				char *buf = kmalloc(TEMP_BUFSIZ, GFP_KERNEL);
+				if (!buf) {
+					/* Need buffer to read address */
+					trace_seq_printf(&iter->seq, "(0x%px)[UNSAFE-MEMORY]", str);
+					p += j + 1;
+					goto print;
+				}
+			}
+			if (len >= TEMP_BUFSIZ)
+				len = TEMP_BUFSIZ - 1;
 
 			/* Try to safely read the string */
 			if (star) {
-				if (len + 1 > iter->fmt_size)
-					len = iter->fmt_size - 1;
-				if (len < 0)
-					len = 0;
-				ret = copy_from_kernel_nofault(iter->fmt, str, len);
-				iter->fmt[len] = 0;
-				star = false;
+				ret = copy_from_kernel_nofault(buf, str, len);
+				buf[len] = 0;
 			} else {
-				ret = strncpy_from_kernel_nofault(iter->fmt, str,
-								  iter->fmt_size);
+				ret = strncpy_from_kernel_nofault(buf, str, TEMP_BUFSIZ);
 			}
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", str);
 			else
-				trace_seq_printf(&iter->seq, "(0x%px:%s)",
-						 str, iter->fmt);
-			str = "[UNSAFE-MEMORY]";
-			strcpy(iter->fmt, "%s");
+				trace_seq_printf(&iter->seq, "(0x%px:%s)", str, buf);
+			trace_seq_puts(&iter->seq, "[UNSAFE-MEMORY]");
 		} else {
-			strncpy(iter->fmt, p + i, j + 1);
-			iter->fmt[j+1] = '\0';
+			save_ch = p[j + 1];
+			p[j + 1] = '\0';
+			if (star)
+				trace_seq_printf(&iter->seq, p, len, str);
+			else
+				trace_seq_printf(&iter->seq, p, str);
+			p[j + 1] = save_ch;
 		}
-		if (star)
-			trace_seq_printf(&iter->seq, iter->fmt, len, str);
-		else
-			trace_seq_printf(&iter->seq, iter->fmt, str);
 
-		p += i + j + 1;
+		p += j + 1;
 	}
  print:
 	if (*p)
 		trace_seq_vprintf(&iter->seq, p, ap);
+	kfree(buf);
+	return;
+ print_fmt:
+	trace_seq_vprintf(&iter->seq, fmt, ap);
 }
 
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
-- 
2.45.2



