Return-Path: <stable+bounces-6961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49620816779
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18B3B20E9E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02606846E;
	Mon, 18 Dec 2023 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q13Vs6F/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBBE541
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3FAC433C8;
	Mon, 18 Dec 2023 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702885024;
	bh=AAWYvgleO4PLyypboVP5WhIipatc0/3xQ2hjlKggNLc=;
	h=Subject:To:Cc:From:Date:From;
	b=q13Vs6F/DBeAIWSKs08OTcA5V/49hUNNSxcutMZdMn5zDTh7Cdh18uz6aixovqfTS
	 n1mqJMdXboBXWTwyKHbpz8mYwVGLjJcdLgVl3kHLDGTp+LiQ5BaxgpviYddDyJ73qa
	 uy2tlWyphzx77QfJU5XfHiXjsnA0k09zyYJ+MZuM=
Subject: FAILED: patch "[PATCH] tracing: Update snapshot buffer on resize if it is allocated" failed to apply to 5.4-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:37:01 +0100
Message-ID: <2023121801-lustfully-gulf-2543@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d06aff1cb13d2a0d52b48e605462518149c98c81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121801-lustfully-gulf-2543@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d06aff1cb13d ("tracing: Update snapshot buffer on resize if it is allocated")
d78ab792705c ("tracing: Stop current tracer when resizing buffer")
7be76461f302 ("tracing: Always update snapshot buffer size")
6d98a0f2ac3c ("tracing: Set actual size after ring buffer resize")
1c5eb4481e01 ("tracing: Rename trace_buffer to array_buffer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d06aff1cb13d2a0d52b48e605462518149c98c81 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Sun, 10 Dec 2023 22:54:47 -0500
Subject: [PATCH] tracing: Update snapshot buffer on resize if it is allocated

The snapshot buffer is to mimic the main buffer so that when a snapshot is
needed, the snapshot and main buffer are swapped. When the snapshot buffer
is allocated, it is set to the minimal size that the ring buffer may be at
and still functional. When it is allocated it becomes the same size as the
main ring buffer, and when the main ring buffer changes in size, it should
do.

Currently, the resize only updates the snapshot buffer if it's used by the
current tracer (ie. the preemptirqsoff tracer). But it needs to be updated
anytime it is allocated.

When changing the size of the main buffer, instead of looking to see if
the current tracer is utilizing the snapshot buffer, just check if it is
allocated to know if it should be updated or not.

Also fix typo in comment just above the code change.

Link: https://lore.kernel.org/linux-trace-kernel/20231210225447.48476a6a@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: ad909e21bbe69 ("tracing: Add internal tracing_snapshot() functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aa8f99f3e5de..6c79548f9574 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6348,7 +6348,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
-	/* Do not allow tracing while resizng ring buffer */
+	/* Do not allow tracing while resizing ring buffer */
 	tracing_stop_tr(tr);
 
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
@@ -6356,7 +6356,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!tr->current_trace->use_max_tr)
+	if (!tr->allocated_snapshot)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);


