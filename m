Return-Path: <stable+bounces-172677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB0B32CD4
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 03:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE923C01D0
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921414A4CC;
	Sun, 24 Aug 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS3R0N/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264391426C
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755998338; cv=none; b=YPUBYXNXOpaMGbKfy9vpSq27LfQIzQXAKey8KpzZ1zlObQleFIDgEt3NdIATtjlu+QjD7OlUbpfmLIjr6jt8SekROc9WYHWxt0svNx5+MVOG8I2DmCSkn0/gH4td2UzbHfFALG+u2ctkQqVTWtHx+/F3AdzIn7BMtu6mhLVdNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755998338; c=relaxed/simple;
	bh=GMF8iON5JKKHYgMjVKLliY1fFWK9/ErM49FV4ZBlNpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUsOkLwr8IRjpdCtFjwGomuhLVaz83zkU8AoYr/rBQy/+ww4oE9T1tbc1zI8l5WP2z+ekQXSjBxwdA+qHFM7UWsrBmPmOC2sXYzyE7b+GkShEllWlPzgioXJX9FSQMEnjwXlj/4MNNrFjTR27CXaiG4LnNQK+xS758k0UV8mD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS3R0N/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF70BC4CEE7;
	Sun, 24 Aug 2025 01:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755998337;
	bh=GMF8iON5JKKHYgMjVKLliY1fFWK9/ErM49FV4ZBlNpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oS3R0N/ShBu4hNIKypxuukpl0V5P1ExHlx7LGvstEsZsDgKzWurUs2Zm3W4S0Dwcs
	 hF6BqxBui+Z4uNe+Iqh41U9qq293JXlDB+tDg5gdj13mDnZSH2llRxaDimGNsUjUfQ
	 /w5XVLkTKmNxbBoa0XKDYXmARlJO/QEuzUIFLzTWDS8wchox5gd9wCvK5gCVxzMc5N
	 j8KLFwd9U79xqaQrGH5ids8SRNvQpz/eTOjORl97Gr0tzBgnDL0wT2iV31eHV33Mg9
	 IQqyMdjVJsOCztdYWthUcvrlPnXNy5KrajjpHidTIQnb1n/R9YOkY873cO7ry/dSDh
	 +9rn0ylEtvGGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tracing: Remove unneeded goto out logic
Date: Sat, 23 Aug 2025 21:18:54 -0400
Message-ID: <20250824011855.2574804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082330-tameness-senator-c4d5@gregkh>
References: <2025082330-tameness-senator-c4d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit c89504a703fb779052213add0e8ed642f4a4f1c8 ]

Several places in the trace.c file there's a goto out where the out is
simply a return. There's no reason to jump to the out label if it's not
doing any more logic but simply returning from the function.

Replace the goto outs with a return and remove the out labels.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250801203857.538726745@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 6a909ea83f22 ("tracing: Limit access to parser->buffer when trace_get_user failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 801def692f92..e6598a37e1e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1754,7 +1754,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		return ret;
 
 	read++;
 	cnt--;
@@ -1768,7 +1768,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				return ret;
 			read++;
 			cnt--;
 		}
@@ -1778,8 +1778,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1787,13 +1786,12 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
-		else {
-			ret = -EINVAL;
-			goto out;
-		}
+		else
+			return -EINVAL;
+
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			goto out;
+			return ret;
 		read++;
 		cnt--;
 	}
@@ -1808,15 +1806,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* Make sure the parsed string always terminates with '\0'. */
 		parser->buffer[parser->idx] = 0;
 	} else {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	*ppos += read;
-	ret = read;
-
-out:
-	return ret;
+	return read;
 }
 
 /* TODO add a seq_buf_to_buffer() */
@@ -2318,10 +2312,10 @@ int __init register_tracer(struct tracer *type)
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2333,8 +2327,7 @@ int __init register_tracer(struct tracer *type)
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8563,12 +8556,12 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
  out_reg:
 	ret = tracing_arm_snapshot(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 	if (ret < 0)
 		tracing_disarm_snapshot(tr);
- out:
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -10469,7 +10462,7 @@ __init static int tracer_alloc_buffers(void)
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -10582,7 +10575,6 @@ __init static int tracer_alloc_buffers(void)
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 
-- 
2.50.1


