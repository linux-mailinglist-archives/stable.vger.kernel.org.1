Return-Path: <stable+bounces-104417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D79F410F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB70168E97
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8482146599;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425B142E77;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403606; cv=none; b=Yv3YfC9Ii5oLzR4lJCAoH8rXB7nCLojPnpKe5QXUwD7+4YniaW5MwwgqsGh3QjzZi21KmAOi2/1e9066HJO22crL48hj48grdbNY4uzHTIFip2eag5HqN7UzLGiEUAb8hlkfJCqQsqkcJPnVB1qJnGwiirH1Fy6kbKXT2nnYOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403606; c=relaxed/simple;
	bh=g6nVI1S6GWbX8Cmw+znA5VwZuKHkgCB+UGFKsZbTobo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tBD7YnJfHaHe+kEBenJDKH0NBb+R36NtDrn7azS3BQ2O8c+lvpsocJTUa6X5UXt8Y1mVvJY3ZJfLuhVVq2CgH/McVK4YcQh4RVO6UmVezNveI9hazZMVd7i9XQxArpBf0no07MXRuZpQXiY4Y1xRx4lXkzfKN0GnQ9SdegBOrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E88EC4CEDE;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNNcG-000000087WV-3T1f;
	Mon, 16 Dec 2024 21:47:20 -0500
Message-ID: <20241217024720.685917008@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 16 Dec 2024 21:41:21 -0500
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
Subject: [PATCH 3/4] tracing: Add "%s" check in test_event_printk()
References: <20241217024118.587584221@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The test_event_printk() code makes sure that when a trace event is
registered, any dereferenced pointers in from the event's TP_printk() are
pointing to content in the ring buffer. But currently it does not handle
"%s", as there's cases where the string pointer saved in the ring buffer
points to a static string in the kernel that will never be freed. As that
is a valid case, the pointer needs to be checked at runtime.

Currently the runtime check is done via trace_check_vprintf(), but to not
have to replicate everything in vsnprintf() it does some logic with the
va_list that may not be reliable across architectures. In order to get rid
of that logic, more work in the test_event_printk() needs to be done. Some
of the strings can be validated at this time when it is obvious the string
is valid because the string will be saved in the ring buffer content.

Do all the validation of strings in the ring buffer at boot in
test_event_printk(), and make sure that the field of the strings that
point into the kernel are accessible. This will allow adding checks at
runtime that will validate the fields themselves and not rely on paring
the TP_printk() format at runtime.

Cc: stable@vger.kernel.org
Fixes: 5013f454a352c ("tracing: Add check of trace event print fmts for dereferencing pointers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 104 ++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index df75c06bb23f..521ad2fd1fe7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -244,19 +244,16 @@ int trace_event_get_offsets(struct trace_event_call *call)
 	return tail->offset + tail->size;
 }
 
-/*
- * Check if the referenced field is an array and return true,
- * as arrays are OK to dereference.
- */
-static bool test_field(const char *fmt, struct trace_event_call *call)
+
+static struct trace_event_fields *find_event_field(const char *fmt,
+						   struct trace_event_call *call)
 {
 	struct trace_event_fields *field = call->class->fields_array;
-	const char *array_descriptor;
 	const char *p = fmt;
 	int len;
 
 	if (!(len = str_has_prefix(fmt, "REC->")))
-		return false;
+		return NULL;
 	fmt += len;
 	for (p = fmt; *p; p++) {
 		if (!isalnum(*p) && *p != '_')
@@ -267,11 +264,26 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 	for (; field->type; field++) {
 		if (strncmp(field->name, fmt, len) || field->name[len])
 			continue;
-		array_descriptor = strchr(field->type, '[');
-		/* This is an array and is OK to dereference. */
-		return array_descriptor != NULL;
+
+		return field;
 	}
-	return false;
+	return NULL;
+}
+
+/*
+ * Check if the referenced field is an array and return true,
+ * as arrays are OK to dereference.
+ */
+static bool test_field(const char *fmt, struct trace_event_call *call)
+{
+	struct trace_event_fields *field;
+
+	field = find_event_field(fmt, call);
+	if (!field)
+		return false;
+
+	/* This is an array and is OK to dereference. */
+	return strchr(field->type, '[') != NULL;
 }
 
 /* Look for a string within an argument */
@@ -317,6 +329,53 @@ static bool process_pointer(const char *fmt, int len, struct trace_event_call *c
 	return false;
 }
 
+/* Return true if the string is safe */
+static bool process_string(const char *fmt, int len, struct trace_event_call *call)
+{
+	const char *r, *e, *s;
+
+	e = fmt + len;
+
+	/*
+	 * There are several helper functions that return strings.
+	 * If the argument contains a function, then assume its field is valid.
+	 * It is considered that the argument has a function if it has:
+	 *   alphanumeric or '_' before a parenthesis.
+	 */
+	s = fmt;
+	do {
+		r = strstr(s, "(");
+		if (!r || r >= e)
+			break;
+		for (int i = 1; r - i >= s; i++) {
+			char ch = *(r - i);
+			if (isspace(ch))
+				continue;
+			if (isalnum(ch) || ch == '_')
+				return true;
+			/* Anything else, this isn't a function */
+			break;
+		}
+		/* A function could be wrapped in parethesis, try the next one */
+		s = r + 1;
+	} while (s < e);
+
+	/*
+	 * If there's any strings in the argument consider this arg OK as it
+	 * could be: REC->field ? "foo" : "bar" and we don't want to get into
+	 * verifying that logic here.
+	 */
+	if (find_print_string(fmt, "\"", e))
+		return true;
+
+	/* Dereferenced strings are also valid like any other pointer */
+	if (process_pointer(fmt, len, call))
+		return true;
+
+	/* Make sure the field is found, and consider it OK for now if it is */
+	return find_event_field(fmt, call) != NULL;
+}
+
 /*
  * Examine the print fmt of the event looking for unsafe dereference
  * pointers using %p* that could be recorded in the trace event and
@@ -326,6 +385,7 @@ static bool process_pointer(const char *fmt, int len, struct trace_event_call *c
 static void test_event_printk(struct trace_event_call *call)
 {
 	u64 dereference_flags = 0;
+	u64 string_flags = 0;
 	bool first = true;
 	const char *fmt;
 	int parens = 0;
@@ -416,8 +476,16 @@ static void test_event_printk(struct trace_event_call *call)
 						star = true;
 						continue;
 					}
-					if ((fmt[i + j] == 's') && star)
-						arg++;
+					if ((fmt[i + j] == 's')) {
+						if (star)
+							arg++;
+						if (WARN_ONCE(arg == 63,
+							      "Too many args for event: %s",
+							      trace_event_name(call)))
+							return;
+						dereference_flags |= 1ULL << arg;
+						string_flags |= 1ULL << arg;
+					}
 					break;
 				}
 				break;
@@ -464,7 +532,10 @@ static void test_event_printk(struct trace_event_call *call)
 			}
 
 			if (dereference_flags & (1ULL << arg)) {
-				if (process_pointer(fmt + start_arg, e - start_arg, call))
+				if (string_flags & (1ULL << arg)) {
+					if (process_string(fmt + start_arg, e - start_arg, call))
+						dereference_flags &= ~(1ULL << arg);
+				} else if (process_pointer(fmt + start_arg, e - start_arg, call))
 					dereference_flags &= ~(1ULL << arg);
 			}
 
@@ -476,7 +547,10 @@ static void test_event_printk(struct trace_event_call *call)
 	}
 
 	if (dereference_flags & (1ULL << arg)) {
-		if (process_pointer(fmt + start_arg, i - start_arg, call))
+		if (string_flags & (1ULL << arg)) {
+			if (process_string(fmt + start_arg, i - start_arg, call))
+				dereference_flags &= ~(1ULL << arg);
+		} else if (process_pointer(fmt + start_arg, i - start_arg, call))
 			dereference_flags &= ~(1ULL << arg);
 	}
 
-- 
2.45.2



