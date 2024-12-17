Return-Path: <stable+bounces-104532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4D9F5101
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE995188A286
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90431F7072;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E050142E77;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452989; cv=none; b=YNq8fObKpHN2u5IvBzT+QSOSk+68Fgr1W8qD9CjtkHkN7qvFU0o5ZrGV0wK4EeeCB+QjWOPIDNQlSNfXZiMS/xnGbC1d6z8YpYi3FBEx643v1HIkP5Q0ydBX5HpvR1QTIJXO50feQpnEXE2hSzRJo1ReobSWGCD094GhYbkOs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452989; c=relaxed/simple;
	bh=qDsAmNXR5n51iXB16Y3+OxPTekINrODSuNbEbMHwiJg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RiHeOe5yT/YgSWBaz0iBfdzxnocz3WdZ3w0XA3zcuIhOkebcZfmDf9CiplH6HVToNXlkfPzJj4Q1RNCg/7duzsGhSkkxJfsFqRiqKD5Tbz00d19nB4XLYPi2iqXnb+cWC85iiJKXHhMY8i0Z1gPrJqXAViP/nHQdad9hoHzkk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F84C4CED7;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNaSn-00000008aeg-1psR;
	Tue, 17 Dec 2024 11:30:25 -0500
Message-ID: <20241217163025.288022517@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 11:18:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>,
 stable@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [for-linus v2][PATCH 1/2] fgraph: Still initialize idle shadow stacks when starting
References: <20241217161840.069495339@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A bug was discovered where the idle shadow stacks were not initialized
for offline CPUs when starting function graph tracer, and when they came
online they were not traced due to the missing shadow stack. To fix
this, the idle task shadow stack initialization was moved to using the
CPU hotplug callbacks. But it removed the initialization when the
function graph was enabled. The problem here is that the hotplug
callbacks are called when the CPUs come online, but the idle shadow
stack initialization only happens if function graph is currently
active. This caused the online CPUs to not get their shadow stack
initialized.

The idle shadow stack initialization still needs to be done when the
function graph is registered, as they will not be allocated if function
graph is not registered.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241211135335.094ba282@batman.local.home
Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Closes: https://lore.kernel.org/all/CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0bf78517b5d4..ddedcb50917f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1215,7 +1215,7 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret;
+	int ret, cpu;
 
 	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
 				 sizeof(*ret_stack_list), GFP_KERNEL);
@@ -1223,6 +1223,12 @@ static int start_graph_tracing(void)
 	if (!ret_stack_list)
 		return -ENOMEM;
 
+	/* The cpu_boot init_task->ret_stack will never be freed */
+	for_each_online_cpu(cpu) {
+		if (!idle_task(cpu)->ret_stack)
+			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	}
+
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
-- 
2.45.2



