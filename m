Return-Path: <stable+bounces-105097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420D9F5C65
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF48416D92D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB423D3B3;
	Wed, 18 Dec 2024 01:49:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D93595C;
	Wed, 18 Dec 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486564; cv=none; b=ZQU/bsRpx9y1ZxlpbESCVw06UvUZyassB7OkUXH9DU0esqLFAmEOcv4d/bFbhBWLxJmFBksnZJAv+B7O0sUqGACm2kaZljBC4KzYNxPDcXbzF0YmwyC9cwjak4Hfr7pMUlBnKqh4avZeQslbOdd6Mad7uSllgtyUmWmuO/gv/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486564; c=relaxed/simple;
	bh=CqMXOoJbutcBRANGdyC71WCBKAm1g4ejEx8/isPV0xI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pCnHjiVTHoGx3CQqnGchtc8XD2vdws12Pp/VVN8EJUf60LpOcIUHY+GVDGg2W562k18KXIdyo7n4TIdSzg9NBUzWpaWCl+oWK0AIaSFBpz7F/445K5d+FEHDWK/V09VwOopgZ3qlUfDe4asTmFeYclyUigQYw5Qz+avlNJtqlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D841EC4CEDD;
	Wed, 18 Dec 2024 01:49:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNjCK-00000008v3A-3nEm;
	Tue, 17 Dec 2024 20:50:00 -0500
Message-ID: <20241218015000.757611267@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 20:38:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 1/4] tracing: Fix test_event_printk() to process entire print argument
References: <20241218013828.733621977@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The test_event_printk() analyzes print formats of trace events looking for
cases where it may dereference a pointer that is not in the ring buffer
which can possibly be a bug when the trace event is read from the ring
buffer and the content of that pointer no longer exists.

The function needs to accurately go from one print format argument to the
next. It handles quotes and parenthesis that may be included in an
argument. When it finds the start of the next argument, it uses a simple
"c = strstr(fmt + i, ',')" to find the end of that argument!

In order to include "%s" dereferencing, it needs to process the entire
content of the print format argument and not just the content of the first
',' it finds. As there may be content like:

 ({ const char *saved_ptr = trace_seq_buffer_ptr(p); static const char
   *access_str[] = { "---", "--x", "w--", "w-x", "-u-", "-ux", "wu-", "wux"
   }; union kvm_mmu_page_role role; role.word = REC->role;
   trace_seq_printf(p, "sp gen %u gfn %llx l%u %u-byte q%u%s %s%s" " %snxe
   %sad root %u %s%c", REC->mmu_valid_gen, REC->gfn, role.level,
   role.has_4_byte_gpte ? 4 : 8, role.quadrant, role.direct ? " direct" : "",
   access_str[role.access], role.invalid ? " invalid" : "", role.efer_nx ? ""
   : "!", role.ad_disabled ? "!" : "", REC->root_count, REC->unsync ?
   "unsync" : "sync", 0); saved_ptr; })

Which is an example of a full argument of an existing event. As the code
already handles finding the next print format argument, process the
argument at the end of it and not the start of it. This way it has both
the start of the argument as well as the end of it.

Add a helper function "process_pointer()" that will do the processing during
the loop as well as at the end. It also makes the code cleaner and easier
to read.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20241217024720.362271189@goodmis.org
Fixes: 5013f454a352c ("tracing: Add check of trace event print fmts for dereferencing pointers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 82 ++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 77e68efbd43e..14e160a5b905 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -265,8 +265,7 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 	len = p - fmt;
 
 	for (; field->type; field++) {
-		if (strncmp(field->name, fmt, len) ||
-		    field->name[len])
+		if (strncmp(field->name, fmt, len) || field->name[len])
 			continue;
 		array_descriptor = strchr(field->type, '[');
 		/* This is an array and is OK to dereference. */
@@ -275,6 +274,32 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 	return false;
 }
 
+/* Return true if the argument pointer is safe */
+static bool process_pointer(const char *fmt, int len, struct trace_event_call *call)
+{
+	const char *r, *e, *a;
+
+	e = fmt + len;
+
+	/* Find the REC-> in the argument */
+	r = strstr(fmt, "REC->");
+	if (r && r < e) {
+		/*
+		 * Addresses of events on the buffer, or an array on the buffer is
+		 * OK to dereference. There's ways to fool this, but
+		 * this is to catch common mistakes, not malicious code.
+		 */
+		a = strchr(fmt, '&');
+		if ((a && (a < r)) || test_field(r, call))
+			return true;
+	} else if ((r = strstr(fmt, "__get_dynamic_array(")) && r < e) {
+		return true;
+	} else if ((r = strstr(fmt, "__get_sockaddr(")) && r < e) {
+		return true;
+	}
+	return false;
+}
+
 /*
  * Examine the print fmt of the event looking for unsafe dereference
  * pointers using %p* that could be recorded in the trace event and
@@ -285,12 +310,12 @@ static void test_event_printk(struct trace_event_call *call)
 {
 	u64 dereference_flags = 0;
 	bool first = true;
-	const char *fmt, *c, *r, *a;
+	const char *fmt;
 	int parens = 0;
 	char in_quote = 0;
 	int start_arg = 0;
 	int arg = 0;
-	int i;
+	int i, e;
 
 	fmt = call->print_fmt;
 
@@ -403,42 +428,41 @@ static void test_event_printk(struct trace_event_call *call)
 		case ',':
 			if (in_quote || parens)
 				continue;
+			e = i;
 			i++;
 			while (isspace(fmt[i]))
 				i++;
-			start_arg = i;
-			if (!(dereference_flags & (1ULL << arg)))
-				goto next_arg;
 
-			/* Find the REC-> in the argument */
-			c = strchr(fmt + i, ',');
-			r = strstr(fmt + i, "REC->");
-			if (r && (!c || r < c)) {
-				/*
-				 * Addresses of events on the buffer,
-				 * or an array on the buffer is
-				 * OK to dereference.
-				 * There's ways to fool this, but
-				 * this is to catch common mistakes,
-				 * not malicious code.
-				 */
-				a = strchr(fmt + i, '&');
-				if ((a && (a < r)) || test_field(r, call))
+			/*
+			 * If start_arg is zero, then this is the start of the
+			 * first argument. The processing of the argument happens
+			 * when the end of the argument is found, as it needs to
+			 * handle paranthesis and such.
+			 */
+			if (!start_arg) {
+				start_arg = i;
+				/* Balance out the i++ in the for loop */
+				i--;
+				continue;
+			}
+
+			if (dereference_flags & (1ULL << arg)) {
+				if (process_pointer(fmt + start_arg, e - start_arg, call))
 					dereference_flags &= ~(1ULL << arg);
-			} else if ((r = strstr(fmt + i, "__get_dynamic_array(")) &&
-				   (!c || r < c)) {
-				dereference_flags &= ~(1ULL << arg);
-			} else if ((r = strstr(fmt + i, "__get_sockaddr(")) &&
-				   (!c || r < c)) {
-				dereference_flags &= ~(1ULL << arg);
 			}
 
-		next_arg:
-			i--;
+			start_arg = i;
 			arg++;
+			/* Balance out the i++ in the for loop */
+			i--;
 		}
 	}
 
+	if (dereference_flags & (1ULL << arg)) {
+		if (process_pointer(fmt + start_arg, i - start_arg, call))
+			dereference_flags &= ~(1ULL << arg);
+	}
+
 	/*
 	 * If you triggered the below warning, the trace event reported
 	 * uses an unsafe dereference pointer %p*. As the data stored
-- 
2.45.2



