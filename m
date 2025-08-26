Return-Path: <stable+bounces-174268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF493B3622E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5209318873D0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAA343214;
	Tue, 26 Aug 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcUzqroH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F64334717;
	Tue, 26 Aug 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213938; cv=none; b=V56AYDbtNeXJzLG8UnheKx2FA0qr98i7zuIjh5W6WVxlXvongQUuw16yh26A3ZeQYcUW520OWoQPYOwD8/dR6XGlm3/ugKbHzd+KDRhkKQRk5uZu5Yz8rDwwSwSA3kTYQY4zduaF2Z5HiIOaBaVzRUy9uPiFlMNiUZdMkUQecrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213938; c=relaxed/simple;
	bh=IVO7FDucWQnwehwniRFxlpuBNA8WxeNBTO2H8pCfi+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHSUt7Q5smOH0XtNTzqpPQ0UkA27V9DfGyPi+dq5ImGmuxzkqDKqSQzBrn8/yuNfPNOkffqcMUcVRCrYoDwyr9DW7QJ/VmLJ3bzqssFCuzL7cATnwRSKQrGyqdoWjLdBrEmdftd+RTlq/dQuQsPBMwi5YuOOdZwrZioGmur+9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcUzqroH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEE7C2BCAF;
	Tue, 26 Aug 2025 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213938;
	bh=IVO7FDucWQnwehwniRFxlpuBNA8WxeNBTO2H8pCfi+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcUzqroHmfNm8z1SHiel2rMv9dBlmEJHAmLWcQQbs5eoVooRAwd/N47na8Q3UfMeu
	 e/tdYZRNAKjtkeWFHJ0znc1sSsNM4D0CwrRt31H61nMmGhZhoVi08GlpIJ4c8A6cTz
	 BYJ4rjSF6EmOGamAW8b3K8ocbUf4K+BLC0u+ezH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 536/587] tracing: Remove unneeded goto out logic
Date: Tue, 26 Aug 2025 13:11:25 +0200
Message-ID: <20250826111006.643878912@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |   37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1661,7 +1661,7 @@ int trace_get_user(struct trace_parser *
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		return ret;
 
 	read++;
 	cnt--;
@@ -1675,7 +1675,7 @@ int trace_get_user(struct trace_parser *
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				return ret;
 			read++;
 			cnt--;
 		}
@@ -1685,8 +1685,7 @@ int trace_get_user(struct trace_parser *
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1694,13 +1693,12 @@ int trace_get_user(struct trace_parser *
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
@@ -1715,15 +1713,11 @@ int trace_get_user(struct trace_parser *
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
@@ -2211,10 +2205,10 @@ int __init register_tracer(struct tracer
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2226,8 +2220,7 @@ int __init register_tracer(struct tracer
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8734,11 +8727,10 @@ ftrace_trace_snapshot_callback(struct tr
  out_reg:
 	ret = tracing_alloc_snapshot_instance(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 
- out:
 	return ret < 0 ? ret : 0;
 }
 
@@ -10344,7 +10336,7 @@ __init static int tracer_alloc_buffers(v
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -10455,7 +10447,6 @@ out_free_cpumask:
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 



