Return-Path: <stable+bounces-144807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC74ABBE07
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E373F7A7D1B
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E60275840;
	Mon, 19 May 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9pdcQaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89765279340
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658245; cv=none; b=kEXOIgh/yi6sKUp/hTtDma9rUPUIDdsLHAXDMj7L93ezbcml8ECpsyjjVF16352baJmaODoJVt8iaFWOShVjrzUB4R5XscaXB2g9fBDVCx5ndD5eYhuIzdJ+TmCOJnPi4MGcRd7uDMrAQKTy7UFd3l62TiWmCqbJ8ua3u2dgBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658245; c=relaxed/simple;
	bh=ucVaN+cD6RviWkokCNXPzf9WlTJw1I6hB/DHCSxf1Ik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RwUzeFecd7xLhwljk7TnQnt2okJ6yKgPwqLgQp14QoQ6EhrQzCDX4yyG4ImfqqHnDhRov/2/vBY2Hw3mp4A1OpcTY6z77OgTdEBv6ig/Inh7wcBjtjWbvOubgsXw+7jRhoVJ7YKBOghmh1bQ7YOoH7n0w1sEpzeO7zizhnvElNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9pdcQaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2DBC4CEE9;
	Mon, 19 May 2025 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658245;
	bh=ucVaN+cD6RviWkokCNXPzf9WlTJw1I6hB/DHCSxf1Ik=;
	h=Subject:To:Cc:From:Date:From;
	b=l9pdcQaY3fxkj7h1LXwDeKRD/Glz5ZFOL9l/08V1JBBEgwEVjE3F2tRJXqi5HE9fT
	 7CVjqKn6SjAMaA38rf+5cQiXErMTQ9q3kcjYNNyGN09DEfRhurzmxvAnILoNXs5yJG
	 nIDFERbewzJvC8XyQkOZWZx6MRwoq7vvwpTehAzY=
Subject: FAILED: patch "[PATCH] ftrace: Fix preemption accounting for stacktrace trigger" failed to apply to 5.4-stable tree
To: pengdonglin@xiaomi.com,dolinux.peng@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:37:19 +0200
Message-ID: <2025051919-daintily-bountiful-20e1@gregkh>
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
git cherry-pick -x e333332657f615ac2b55aa35565c4a882018bbe9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051919-daintily-bountiful-20e1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


