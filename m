Return-Path: <stable+bounces-172744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B2B33043
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698787A2702
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECD274FD3;
	Sun, 24 Aug 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQQC7TQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75A393DE3
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043927; cv=none; b=qjL21v/GvBXypmlxiSXSwDNSItYrZpXkMUpe5VYGO0XN9+LSkzQnSnZFcunSs3NCx74Og+Fz+9ZSAfTrMLSleFssOg6xgdPZber4XQgh56gXWJUZdisLR7ls8QpaLJk69gOjhyiC8FGMNq5jDS8ewHZoTcI+wqSyKCCkXZeXyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043927; c=relaxed/simple;
	bh=lYTKWYA5A1MLrPwLpbbsU6+3pdeUvinCpei47oE05gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOYa7z6hDqrG0rHJXaVFy+0qagBCSCGRumSKlCtmtthQekJ7Zot+PCr2x2Kk+9cWUOrnvkWl3IoVruXRzgf6XY63IIlhgaVyypTnZ9b4Xpmw8fF0zgcGuQnkRUb0r0BbdPwBSH1Xn5rK6MAVzh0DDDy9eg3pRwo7jHIioKHn/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQQC7TQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D3C4CEEB;
	Sun, 24 Aug 2025 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043925;
	bh=lYTKWYA5A1MLrPwLpbbsU6+3pdeUvinCpei47oE05gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQQC7TQog5zfOP4iaMyC6Kgym9uPzfd99n0c9yrBAe1MSg4UNnWjuCF+GvWxiTqFq
	 HCE+0c7z7YmqzjZNqNcsP62OaMeFWLWDqtcGiCHLWQXCzrz1dgvUMruUELHVmaP3jl
	 ai/hHBcUQAk3C44YwofSi/T+o4lNnw5xd6CgpR5sUEE0E/rQShfdH4Gr1PCIw3dGBK
	 sacmBhmtDdl9Xg/0MOz/It6dcfWiGTaC/aLpEuJ4MqsewxduB62AMGtgKnshGuhN2n
	 S7m2n5rwu5ddrwG/jZr4fJqOwO1i+Tzkj/5IyFTD/wtdDC00UUV/YHHKszpc1v8v/S
	 jhM5N/gt7Kghg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] tracing: Remove unneeded goto out logic
Date: Sun, 24 Aug 2025 09:58:42 -0400
Message-ID: <20250824135843.2924564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082331-pushing-surrender-b647@gregkh>
References: <2025082331-pushing-surrender-b647@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35b9f08a9a37..44f3d6e3d1d8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1605,7 +1605,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		return ret;
 
 	read++;
 	cnt--;
@@ -1619,7 +1619,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				return ret;
 			read++;
 			cnt--;
 		}
@@ -1629,8 +1629,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1638,13 +1637,12 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
@@ -1659,15 +1657,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
@@ -2136,10 +2130,10 @@ int __init register_tracer(struct tracer *type)
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2151,8 +2145,7 @@ int __init register_tracer(struct tracer *type)
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8711,11 +8704,10 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
  out_reg:
 	ret = tracing_alloc_snapshot_instance(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 
- out:
 	return ret < 0 ? ret : 0;
 }
 
@@ -10231,7 +10223,7 @@ __init static int tracer_alloc_buffers(void)
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -10344,7 +10336,6 @@ __init static int tracer_alloc_buffers(void)
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 
-- 
2.50.1


