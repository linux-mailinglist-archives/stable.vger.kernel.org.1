Return-Path: <stable+bounces-104123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D649F10F1
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0748282DA3
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298091E32DC;
	Fri, 13 Dec 2024 15:26:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC931E2850;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103599; cv=none; b=DzFOV98okFSC7UVxVhJ0Nbzf67EMb73WiwRhaUCXSt9C3udaApzPyjsRyLt1ArV/rwoWgUSfWrbUiDrOZ+o3NNu3t97+aTbW+RON4s/Nvf3PJPGCluROK9WooFteLNN4rzNtI6Q+9GYHjRsIi7lri4aI4RqWlLB+umkpmYXCWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103599; c=relaxed/simple;
	bh=qDsAmNXR5n51iXB16Y3+OxPTekINrODSuNbEbMHwiJg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nSA91j5whXSWmiNJDJPO95sn0a5bcDgUCXSE7idJVujGVotIJj3for0OcXGt6j6CPSIe2LBfsNVevdOPuws5rA0PWepz9HhWNF2GQGG4LwZwm9UN7ZLXQH9gcBksNTfJ5rzvswWCgAeKcST2rxHHIdjTzZL96gme7zxP8VBVfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92335C4CEE2;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tM7ZI-00000005PHC-1nIt;
	Fri, 13 Dec 2024 10:27:04 -0500
Message-ID: <20241213152704.275936323@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Dec 2024 10:26:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [for-linus][PATCH 2/3] fgraph: Still initialize idle shadow stacks when starting
References: <20241213152647.904822987@goodmis.org>
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



