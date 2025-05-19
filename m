Return-Path: <stable+bounces-144806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65DABBE04
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795F617E27E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9E26AA93;
	Mon, 19 May 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZdDfzwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446801E1A3B
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658242; cv=none; b=mFvGB95E4hystUcSMMQ6uJewB+KLDx8e5QhcFlAP5Ozmw4UnAZ8ip0jz9rLu0ceVS/7De49k9izd46tzLVLE5kPL070Yd+HOYcKJTnfv4ZFsMh530utSYSKdMn08+eIlh38ScynCpRHiO5NhvUGYC+NKgxv5zOivozX1d39CcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658242; c=relaxed/simple;
	bh=n3qMlWCUumX0N5hvloLFX9DSDm8Nv0CUE3a6VYSQ8NI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mimSmltqCg4vzsegYvUYKbQsh/XFB0WGOzAyGwgYVGgxbW8qJnjOPN4nDEEDSHbSZlofSgJBcGQYCtCRqDIa+uVpo3Ls9Z818Gwi/YAR+JF0tYWp5yiWgDwpncKsRKUpY/bJXOxW8Ymzfq39na/CFERkHEdVUa86lLNE5+su3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZdDfzwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB74C4CEE4;
	Mon, 19 May 2025 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658241;
	bh=n3qMlWCUumX0N5hvloLFX9DSDm8Nv0CUE3a6VYSQ8NI=;
	h=Subject:To:Cc:From:Date:From;
	b=iZdDfzwZNsF+/Qq/cEpJ86PSOjNEmyXQmZgmi9/riWfiHMF+1SdC2M+PsLLe5X+ap
	 gVtYnvOpm7nw7RTN7s3OcEpFaRisNrrySZtuXNXWdH9ovnJsHrlEnlyGTXPYdfbkqQ
	 5JtvzGex91MbCLJUkaLWYSzZ7qq20YINJhmo+m7Y=
Subject: FAILED: patch "[PATCH] ftrace: Fix preemption accounting for stacktrace trigger" failed to apply to 5.10-stable tree
To: pengdonglin@xiaomi.com,dolinux.peng@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:37:18 +0200
Message-ID: <2025051918-embellish-voting-0097@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e333332657f615ac2b55aa35565c4a882018bbe9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051918-embellish-voting-0097@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e333332657f615ac2b55aa35565c4a882018bbe9 Mon Sep 17 00:00:00 2001
From: pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 12 May 2025 17:42:45 +0800
Subject: [PATCH] ftrace: Fix preemption accounting for stacktrace trigger
 command

When using the stacktrace trigger command to trace syscalls, the
preemption count was consistently reported as 1 when the system call
event itself had 0 (".").

For example:

root@ubuntu22-vm:/sys/kernel/tracing/events/syscalls/sys_enter_read
$ echo stacktrace > trigger
$ echo 1 > enable

    sshd-416     [002] .....   232.864910: sys_read(fd: a, buf: 556b1f3221d0, count: 8000)
    sshd-416     [002] ...1.   232.864913: <stack trace>
 => ftrace_syscall_enter
 => syscall_trace_enter
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

The root cause is that the trace framework disables preemption in __DO_TRACE before
invoking the trigger callback.

Use the tracing_gen_ctx_dec() that will accommodate for the increase of
the preemption count in __DO_TRACE when calling the callback. The result
is the accurate reporting of:

    sshd-410     [004] .....   210.117660: sys_read(fd: 4, buf: 559b725ba130, count: 40000)
    sshd-410     [004] .....   210.117662: <stack trace>
 => ftrace_syscall_enter
 => syscall_trace_enter
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

Cc: stable@vger.kernel.org
Fixes: ce33c845b030c ("tracing: Dump stacktrace trigger to the corresponding instance")
Link: https://lore.kernel.org/20250512094246.1167956-1-dolinux.peng@gmail.com
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b66b6d235d91..6e87ae2a1a66 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1560,7 +1560,7 @@ stacktrace_trigger(struct event_trigger_data *data,
 	struct trace_event_file *file = data->private_data;
 
 	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 	else
 		trace_dump_stack(STACK_SKIP);
 }


