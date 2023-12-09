Return-Path: <stable+bounces-5127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD580B42E
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B928108B
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AD14282;
	Sat,  9 Dec 2023 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rG8Ba2gi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93513FE5
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C77C433C8;
	Sat,  9 Dec 2023 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702124826;
	bh=2MDZthgMtn3RewceDAp1G9IxG1awz99f+wpWwdHq9x4=;
	h=Subject:To:Cc:From:Date:From;
	b=rG8Ba2givkC3UnZLad+Nc7wgsrGVb5oDVOOahDba5iJe38tyn/RS/ZmQbrvY1cM1I
	 eZPflH8BZCTD+39FEtw/Z3cAPBShCg7sXxmfQSbDVR+Ba9y7OQQJWF/w86khwyu/1K
	 b4MtHvyRzlnjMpIcyuQFFDz60hZZcLCYMMt1QKz8=
Subject: FAILED: patch "[PATCH] tracing: Stop current tracer when resizing buffer" failed to apply to 4.19-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:26:54 +0100
Message-ID: <2023120954-satisfy-sample-730b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d78ab792705c7be1b91243b2544d1a79406a2ad7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120954-satisfy-sample-730b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d78ab792705c ("tracing: Stop current tracer when resizing buffer")
6d98a0f2ac3c ("tracing: Set actual size after ring buffer resize")
1c5eb4481e01 ("tracing: Rename trace_buffer to array_buffer")
a47b53e95acc ("tracing: Rename tracing_reset() to tracing_reset_cpu()")
46cc0b44428d ("tracing/snapshot: Resize spare buffer if size changed")
d2d8b146043a ("Merge tag 'trace-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d78ab792705c7be1b91243b2544d1a79406a2ad7 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 5 Dec 2023 16:52:10 -0500
Subject: [PATCH] tracing: Stop current tracer when resizing buffer

When the ring buffer is being resized, it can cause side effects to the
running tracer. For instance, there's a race with irqsoff tracer that
swaps individual per cpu buffers between the main buffer and the snapshot
buffer. The resize operation modifies the main buffer and then the
snapshot buffer. If a swap happens in between those two operations it will
break the tracer.

Simply stop the running tracer before resizing the buffers and enable it
again when finished.

Link: https://lkml.kernel.org/r/20231205220010.748996423@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 3928a8a2d9808 ("ftrace: make work with new ring buffer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

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
 


