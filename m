Return-Path: <stable+bounces-104415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533B9F410A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B6F18904D5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847F13F42A;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490F18035;
	Tue, 17 Dec 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403606; cv=none; b=K9KpCV8BdBy5evLDCKyLtzmA9DO15kQVC65vBzmqgGwv0WAZ/4pqScYXSdWilKwEU7jqNSqpK+suhd6I6eG/cpf9W8h02HizS5U7SxDRlsm9c8O/AMOtFMiJ+ig8IsaMvUOKXH/MRF+SUN9yJabWMGl90Rca+s4462y0O7VY3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403606; c=relaxed/simple;
	bh=OyU1FNQYFda3q1ZApYV9F4W8wK01VXp83Vev22+RFcQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KXNVQh930NSCJlhJ5KvxZuOEJgBnp5PFQwltXVyCmWBCrCi7rybnUHWYj/cJA06+wRySy5Pb/lH1dCs9KkI5y1onryY7m3X5Yrk8aA/oqhb1f/MkrfZ/KhWlGM7Kugmcbyz5sBI33bNUAUgJBnmShznFs/gFWPJt+Eb8a7TUPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5836C4CED7;
	Tue, 17 Dec 2024 02:46:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNNcG-000000087VK-26Gk;
	Mon, 16 Dec 2024 21:47:20 -0500
Message-ID: <20241217024720.362271189@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 16 Dec 2024 21:41:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 1/4] tracing: Fix test_event_printk() to process entire print argument
References: <20241217024118.587584221@goodmis.org>
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



