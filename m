Return-Path: <stable+bounces-104416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421819F410B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3822C7A2C1A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B91442F6;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447021B960;
	Tue, 17 Dec 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403606; cv=none; b=pTUL6mnwRfR2JSqfIRwXVhYF+BoozfMWjk36a7PLVmbk32+moLKa8RQrPrWvdZHo837VYeU4ryfA5ripDGMGMOguBSQ6PDMc67JPhBUpMkGMDkzzSzC+BNnVvxDPSfaNM49FUjhX60+8aFshUNWTBxF/moah+fluJvxhnf1sN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403606; c=relaxed/simple;
	bh=laovlpAvLggj+yLL38XkkQXka8l0WJCbEAr6230mTYU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ORONQZ3jckLitKz2o2q/IGHLrE+FJ31wj3Is145YXg0FoH7iSeJE8A7y75oQRIah9p6kRoTYeyXmimkV51fUy44olC6t/S8s1udv5D7kSax78eXBD0CZoY+SAUwwCHtIjoxzPQR2P255aKV6GxrEvPRG9WSg8H9p4RmtZJktXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA055C4CED3;
	Tue, 17 Dec 2024 02:46:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNNcG-000000087W1-2n07;
	Mon, 16 Dec 2024 21:47:20 -0500
Message-ID: <20241217024720.521836792@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 16 Dec 2024 21:41:20 -0500
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
Subject: [PATCH 2/4] tracing: Add missing helper functions in event pointer dereference
 check
References: <20241217024118.587584221@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The process_pointer() helper function looks to see if various trace event
macros are used. These macros are for storing data in the event. This
makes it safe to dereference as the dereference will then point into the
event on the ring buffer where the content of the data stays with the
event itself.

A few helper functions were missing. Those were:

  __get_rel_dynamic_array()
  __get_dynamic_array_len()
  __get_rel_dynamic_array_len()
  __get_rel_sockaddr()

Also add a helper function find_print_string() to not need to use a middle
man variable to test if the string exists.

Cc: stable@vger.kernel.org
Fixes: 5013f454a352c ("tracing: Add check of trace event print fmts for dereferencing pointers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 14e160a5b905..df75c06bb23f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -274,6 +274,15 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 	return false;
 }
 
+/* Look for a string within an argument */
+static bool find_print_string(const char *arg, const char *str, const char *end)
+{
+	const char *r;
+
+	r = strstr(arg, str);
+	return r && r < end;
+}
+
 /* Return true if the argument pointer is safe */
 static bool process_pointer(const char *fmt, int len, struct trace_event_call *call)
 {
@@ -292,9 +301,17 @@ static bool process_pointer(const char *fmt, int len, struct trace_event_call *c
 		a = strchr(fmt, '&');
 		if ((a && (a < r)) || test_field(r, call))
 			return true;
-	} else if ((r = strstr(fmt, "__get_dynamic_array(")) && r < e) {
+	} else if (find_print_string(fmt, "__get_dynamic_array(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_rel_dynamic_array(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_dynamic_array_len(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_rel_dynamic_array_len(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_sockaddr(", e)) {
 		return true;
-	} else if ((r = strstr(fmt, "__get_sockaddr(")) && r < e) {
+	} else if (find_print_string(fmt, "__get_rel_sockaddr(", e)) {
 		return true;
 	}
 	return false;
-- 
2.45.2



