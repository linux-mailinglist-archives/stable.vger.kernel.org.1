Return-Path: <stable+bounces-105982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB89FB293
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C5918816B1
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920771A4AAA;
	Mon, 23 Dec 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHohaCNI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063617A597;
	Mon, 23 Dec 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970796; cv=none; b=MscfVvBYu5OEgjZp3SV4wKZVM3jVUAmcJgq/KcUL0WLX/Q8WDeLtgKWts8atx6J7ZVYKQN56+loMSdv7iZPFbT/f9jYdnS1rJ0rgOVSVzhPv9jRt7qS7b8zJQcPq7qIPgjLvWyYtOuGw3b1YbPzMNV9bvG8O0Msf2uttqL+UCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970796; c=relaxed/simple;
	bh=lqbCFcPji1zskPH4Fb0i82rIiOE3gZkzq+tI+dkJF5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+jSYWkDnjs+fk4z9mnwEUR8pE/bcAY1gr8LfRzwhH0fLwpQ2tRvHU2hJvnWo9W+WuRALKRWsqHtgwmk7zBDb4iCadFrV6QdsWtaq17pBspoUhFSsUJLrGRK/gBIx+TqDtd7TWYvKH4q/Iqc7oRw/4eJWE9ucRWvnmw8tLExb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHohaCNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D0CC4CED3;
	Mon, 23 Dec 2024 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970796;
	bh=lqbCFcPji1zskPH4Fb0i82rIiOE3gZkzq+tI+dkJF5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHohaCNI7zlcMUf+eHUYCDnyn7SSgd9h/QRWZ8rAFwKM3DJlGZ99cIOIzliIecNY3
	 NereaA0zZjOaQ2WnR23bCAe4vt1puuoFQbJPDUPvKoObnU07slj1SEdMPtOQwkMSsT
	 Z4oqjcDkjHOiKAOeggA6tEgmsQRfnSoufHstU/ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 64/83] tracing: Add "%s" check in test_event_printk()
Date: Mon, 23 Dec 2024 16:59:43 +0100
Message-ID: <20241223155356.105612221@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

commit 65a25d9f7ac02e0cf361356e834d1c71d36acca9 upstream.

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
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20241217024720.685917008@goodmis.org
Fixes: 5013f454a352c ("tracing: Add check of trace event print fmts for dereferencing pointers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events.c |  104 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 15 deletions(-)

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -242,19 +242,16 @@ int trace_event_get_offsets(struct trace
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
@@ -265,11 +262,26 @@ static bool test_field(const char *fmt,
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
@@ -315,6 +327,53 @@ static bool process_pointer(const char *
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
@@ -324,6 +383,7 @@ static bool process_pointer(const char *
 static void test_event_printk(struct trace_event_call *call)
 {
 	u64 dereference_flags = 0;
+	u64 string_flags = 0;
 	bool first = true;
 	const char *fmt;
 	int parens = 0;
@@ -414,8 +474,16 @@ static void test_event_printk(struct tra
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
@@ -462,7 +530,10 @@ static void test_event_printk(struct tra
 			}
 
 			if (dereference_flags & (1ULL << arg)) {
-				if (process_pointer(fmt + start_arg, e - start_arg, call))
+				if (string_flags & (1ULL << arg)) {
+					if (process_string(fmt + start_arg, e - start_arg, call))
+						dereference_flags &= ~(1ULL << arg);
+				} else if (process_pointer(fmt + start_arg, e - start_arg, call))
 					dereference_flags &= ~(1ULL << arg);
 			}
 
@@ -474,7 +545,10 @@ static void test_event_printk(struct tra
 	}
 
 	if (dereference_flags & (1ULL << arg)) {
-		if (process_pointer(fmt + start_arg, i - start_arg, call))
+		if (string_flags & (1ULL << arg)) {
+			if (process_string(fmt + start_arg, i - start_arg, call))
+				dereference_flags &= ~(1ULL << arg);
+		} else if (process_pointer(fmt + start_arg, i - start_arg, call))
 			dereference_flags &= ~(1ULL << arg);
 	}
 



