Return-Path: <stable+bounces-43485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E88C09CD
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F21C217FE
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A513CAB3;
	Thu,  9 May 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nICWxWJw"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344713C835
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221829; cv=none; b=TM13LH7blbcFEZkucqoYdrczNyRlMt/gkZfnVAQc374mqn9LatUXvgGVdfVh4x8bi4/P5aDlDlMg/o1cGF/QbSxEhf/WLa7GmW5IQri9njpISg1jCbINOE6NVvtuJnyrZbwAjzhPpVLwu3u+HlvefSUcA6v417C/4EfxC+mmNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221829; c=relaxed/simple;
	bh=JZyiwzrF1stdT31y4lFUurtMv4iAaQSD2fJl1LNxfGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6/EJGya+AuBrpsqoH2LYS5pqn6CXF2bkfN5+k/sb7Hhb75dCUnhhZJvuz2eGL+jHkdtBnp8MT5ch/yqgftogQLv55Z+mN9RHrPJ6TQaG5HUzmbHUSHhXYe3fqOprRs42vYQaEAJRaq0ilRPgcybvDT2pg5bKWtK8Ts8+9E97wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nICWxWJw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lenp54jzWOAMLuhcFI1vHOXGYvaqSf6g80skuelXPYw=;
	b=nICWxWJw5cp3kUQh4frchpBTyUUR9WRI5em367npgU/aYFAE5fPcXOQFAv8k73ONPAWu91
	J8grqPaxpvwobCuz8OfHzJX7Bm60p82tcFfAEknUzE4r4wYcmiFpGCX8vCzloQC7GadhPO
	+MZzwxLB3MvoS30+NIt9Oe8nKPb+fmI=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 08/13] tracing: Use str_has_prefix() instead of using fixed sizes
Date: Thu,  9 May 2024 10:29:26 +0800
Message-Id: <20240509022931.3513365-9-dongtai.guo@linux.dev>
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit b6b2735514bcd70ad1556a33892a636b20ece671 upstream.

There are several instances of strncmp(str, "const", 123), where 123 is the
strlen of the const string to check if "const" is the prefix of str. But
this can be error prone. Use str_has_prefix() instead.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events.c      | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/trace_probe.c       | 2 +-
 kernel/trace/trace_stack.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d409b6e2aa43..559f2ad02a41 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4470,7 +4470,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	cmp = strstrip(option);
 
-	if (strncmp(cmp, "no", 2) == 0) {
+	if (str_has_prefix(cmp, "no")) {
 		neg = 1;
 		cmp += 2;
 	}
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 949eac9362a6..a982cbfcb9f1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1249,7 +1249,7 @@ static int f_show(struct seq_file *m, void *v)
 	 */
 	array_descriptor = strchr(field->type, '[');
 
-	if (!strncmp(field->type, "__data_loc", 10))
+	if (str_has_prefix(field->type, "__data_loc"))
 		array_descriptor = NULL;
 
 	if (!array_descriptor)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1441c3934cbf..95f5e328a98b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -484,7 +484,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
 
 static bool synth_field_signed(char *type)
 {
-	if (strncmp(type, "u", 1) == 0)
+	if (str_has_prefix(type, "u"))
 		return false;
 	if (strcmp(type, "gfp_t") == 0)
 		return false;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d85ee1778b99..6efd38b5843c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -342,7 +342,7 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 			f->fn = t->fetch[FETCH_MTD_retval];
 		else
 			ret = -EINVAL;
-	} else if (strncmp(arg, "stack", 5) == 0) {
+	} else if (str_has_prefix(arg, "stack")) {
 		if (arg[5] == '\0') {
 			if (strcmp(t->name, DEFAULT_FETCH_TYPE_STR))
 				return -EINVAL;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 40337094085c..9a4e24d5b8c0 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -453,7 +453,7 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
 {
-	if (strncmp(str, "_filter=", 8) == 0)
+	if (str_has_prefix(str, "_filter="))
 		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
-- 
2.34.1


