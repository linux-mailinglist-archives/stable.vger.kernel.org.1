Return-Path: <stable+bounces-145518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB8ABDC31
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A19C7B8C6C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0424C07A;
	Tue, 20 May 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dAMSCOmu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154224887D;
	Tue, 20 May 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750409; cv=none; b=NQW5rCQN53wmrrjW7/4ySGi54M9XJ82+TNgRhVdcDAx/VwEP1Y5lm8cfaQfyU6iOrYhxOcqj8Sfkv9IxtupIrtkBgARct5dzW3qXa+L8+Ih95YG9Syw+JGX+62uB9CEvzZb5X34qFamn11pIDcfg27kPEQ9ARVhOY9mrhID+6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750409; c=relaxed/simple;
	bh=tN3hhz6s9nFMFUbEf44hSMe28osXB0lHkbdd8MEj4p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRti2xgdppTO84QzsHfzfM628sJRfH5xWcAsivfGvr8Z8unB6OrsfoPpT/WKJh0aDDNk78PiXdchnW+aLqL2hRK0pZxDt31kz9vC62Ip0LjdVWXlHUyZthXy7vygQ0VNaimWWUxATu+3VnyzqPlpG2aRDkW8bVoO7/RMFhU7w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dAMSCOmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC6CC4CEE9;
	Tue, 20 May 2025 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750409;
	bh=tN3hhz6s9nFMFUbEf44hSMe28osXB0lHkbdd8MEj4p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAMSCOmuyQDFlJT9j7QL7N1pUz+r+udx341Bb2R+8LVwaqVCGFnh6YTDf51MttBy/
	 4Xf1bdmtAxjBX9PLoJsHfy12aXfKSEcOy25dvHP0435A9MiJF++dPFhjoSzzeG31sf
	 d3XwYJXEZholzPR65YGlkZtp16ayXF7ocYs0yhBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	pengdonglin <dolinux.peng@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.12 103/143] ftrace: Fix preemption accounting for stacktrace trigger command
Date: Tue, 20 May 2025 15:50:58 +0200
Message-ID: <20250520125814.096950681@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: pengdonglin <pengdonglin@xiaomi.com>

commit e333332657f615ac2b55aa35565c4a882018bbe9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_trigger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1581,7 +1581,7 @@ stacktrace_trigger(struct event_trigger_
 	struct trace_event_file *file = data->private_data;
 
 	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 	else
 		trace_dump_stack(STACK_SKIP);
 }



