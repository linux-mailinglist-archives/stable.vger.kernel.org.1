Return-Path: <stable+bounces-69324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DA95488A
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 14:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85921C22891
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9F16EC0E;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F81DDF5;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810574; cv=none; b=Vv1XBpitTBp3a196BNQB/f/+AV4bEmDiQ7xg6RbWgNEq93G4XannfSUpslhhZDn6haZTeGzHc8PikusIWaEN6NqxtYjVNGNL/giE200HAEsDuyLK0Cxvrm2Js6WFSBz/f/F1x1+AdyQGAps2H3iFYbNJE2ay0meWfgWRGyXZnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810574; c=relaxed/simple;
	bh=Q7WS1g7YwS/9CWfzKsjizF2Vxs4gQnYfnFdhZbKb38k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qz+BVZRfrTCC8k4VhejWmBWvRL3ZNMUMNWRl/dQY6yXXd2EDuGKTYTYqRpL438N0jUECpWk7ZmOOy9PQbf6ILucsn69f6w5ddEIKAWkRWNmWgxWEoz/8Yea34iNutMt4toFIUP65Y7gVy3bzQcTu6wiZZkvVpyv1eLyh9JLTkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D50C4AF09;
	Fri, 16 Aug 2024 12:16:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sevse-000000024Bi-13ud;
	Fri, 16 Aug 2024 08:16:32 -0400
Message-ID: <20240816121632.119157839@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 16 Aug 2024 08:16:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/2] tracing: Return from tracing_buffers_read() if the file has been
 closed
References: <20240816121611.805849825@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When running the following:

 # cd /sys/kernel/tracing/
 # echo 1 > events/sched/sched_waking/enable
 # echo 1 > events/sched/sched_switch/enable
 # echo 0 > tracing_on
 # dd if=per_cpu/cpu0/trace_pipe_raw of=/tmp/raw0.dat

The dd task would get stuck in an infinite loop in the kernel. What would
happen is the following:

When ring_buffer_read_page() returns -1 (no data) then a check is made to
see if the buffer is empty (as happens when the page is not full), it will
call wait_on_pipe() to wait until the ring buffer has data. When it is it
will try again to read data (unless O_NONBLOCK is set).

The issue happens when there's a reader and the file descriptor is closed.
The wait_on_pipe() will return when that is the case. But this loop will
continue to try again and wait_on_pipe() will again return immediately and
the loop will continue and never stop.

Simply check if the file was closed before looping and exit out if it is.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240808235730.78bf63e5@rorschach.local.home
Fixes: 2aa043a55b9a7 ("tracing/ring-buffer: Fix wait_on_pipe() race")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 10cd38bce2f1..ebe7ce2f5f4a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7956,7 +7956,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
-		if (trace_empty(iter)) {
+		if (trace_empty(iter) && !iter->closed) {
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
-- 
2.43.0



