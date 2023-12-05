Return-Path: <stable+bounces-4773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2880612F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 22:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4926A1F21281
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B86FCF5;
	Tue,  5 Dec 2023 21:59:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B12C6FCEE;
	Tue,  5 Dec 2023 21:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F15C433C8;
	Tue,  5 Dec 2023 21:59:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rAdSc-00000000POm-43z1;
	Tue, 05 Dec 2023 17:00:10 -0500
Message-ID: <20231205220010.748996423@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Dec 2023 16:52:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: Stop current tracer when resizing buffer
References: <20231205215208.195443981@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the ring buffer is being resized, it can cause side effects to the
running tracer. For instance, there's a race with irqsoff tracer that
swaps individual per cpu buffers between the main buffer and the snapshot
buffer. The resize operation modifies the main buffer and then the
snapshot buffer. If a swap happens in between those two operations it will
break the tracer.

Simply stop the running tracer before resizing the buffers and enable it
again when finished.

Cc: stable@vger.kernel.org
Fixes: 3928a8a2d9808 ("ftrace: make work with new ring buffer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 231c173ec04f..e978868b1a22 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6387,9 +6387,12 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
+	/* Do not allow tracing while resizng ring buffer */
+	tracing_stop_tr(tr);
+
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
 	if (ret < 0)
-		return ret;
+		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (!tr->current_trace->use_max_tr)
@@ -6417,7 +6420,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 			WARN_ON(1);
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out_start;
 	}
 
 	update_buffer_entries(&tr->max_buffer, cpu);
@@ -6426,7 +6429,8 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 	update_buffer_entries(&tr->array_buffer, cpu);
-
+ out_start:
+	tracing_start_tr(tr);
 	return ret;
 }
 
-- 
2.42.0



