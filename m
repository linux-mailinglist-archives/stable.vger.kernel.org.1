Return-Path: <stable+bounces-181840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD94BA6F8F
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A333BB479
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33552DCF58;
	Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUn7rIAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19F2C2376;
	Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057651; cv=none; b=L/FCJIAW9NC/UQ8fAshUnzAD5zozCWqzpdh3MEQbqEWf2a2SqELCb7lhQS2hTWfBKDZFlXSWP2/9CxQLSvHTO4eOJ4N7KmyBPTUtJOur1SlNgPfnWSPIFWP30da12mKiZRE+FIKoDVs5L7mTQMevSCY2ZDP6rNjylMwdwuVdciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057651; c=relaxed/simple;
	bh=FH2sTDQJhpTphvaX4szRy8f0pnudRzvD6RNhp4vVOyE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XGtBO7Kn3kh/deviY0mdRtQ9xxv1bLogIQd5iNIbdlcTB4tdqUh3JvxJW5sPDJMpJ0L1/p/keDDaH1+m2aKjAKAQJCAEpouUINmI3uoUf8JkSt0+Y9o38cnyh7wY8plfVzr9BV7w8uCm0wN8w6Ueq/4IEb7lX8C7VEgkKaJ/Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUn7rIAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16977C19422;
	Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057651;
	bh=FH2sTDQJhpTphvaX4szRy8f0pnudRzvD6RNhp4vVOyE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=IUn7rIAFypO58pGw0RWD9/heiJoxLdpdO4mpxAfEPnjXSZYy8t0s3Mp4NOpfd6PI8
	 bRiT2SmpVgQUlq4b7Gx/SGXIhGkxrMaHRl2OTdSBpRkQqxpuGm5DW+m9AJkdRdDjuJ
	 VLeLhBOCK9MjiUiQQebio7mTMqMjeFXN6KsQCxDBGmWdozSNO43cx77XKpVrSOzMPn
	 4n/QlBuBVkJUHSDOoF0g+fswiuxV897iKwnFQsg+rtOw4jWEf5HdQq8I3nyW2WEV3Y
	 f/72Xx1rwF3vc/DAiOz0Ao9oIOlfjgZtellQSs8I9UFVjC6dGt0dFZByfAncjx9rhj
	 6xv8n7/SZ5Pmw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2pH4-0000000D8Ot-0N9g;
	Sun, 28 Sep 2025 07:09:02 -0400
Message-ID: <20250928110901.942338034@kernel.org>
User-Agent: quilt/0.68
Date: Sun, 28 Sep 2025 07:08:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wang Liang <wangliang74@huawei.com>,
 Menglong Dong <menglong8.dong@gmail.com>,
 stable@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 3/3] tracing: fgraph: Protect return handler from recursion loop
References: <20250928110832.098564441@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

function_graph_enter_regs() prevents itself from recursion by
ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
which is called at the exit, does not prevent such recursion.
Therefore, while it can prevent recursive calls from
fgraph_ops::entryfunc(), it is not able to prevent recursive calls
to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
This can lead an unexpected recursion bug reported by Menglong.

 is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
  -> kprobe_multi_link_exit_handler -> is_endbr.

To fix this issue, acquire ftrace_test_recursion_trylock() in the
__ftrace_return_to_handler() after unwind the shadow stack to mark
this section must prevent recursive call of fgraph inside user-defined
fgraph_ops::retfunc().

This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
fprobe on function-graph tracer"), because before that fgraph was
only used from the function graph tracer. Fprobe allowed user to run
any callbacks from fgraph after that commit.

Reported-by: Menglong Dong <menglong8.dong@gmail.com>
Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/175852292275.307379.9040117316112640553.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Menglong Dong <menglong8.dong@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1e3b32b1e82c..484ad7a18463 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	unsigned long bitmap;
 	unsigned long ret;
 	int offset;
+	int bit;
 	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
@@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
+	bit = ftrace_test_recursion_trylock(trace.func, ret);
+	/*
+	 * This can fail because ftrace_test_recursion_trylock() allows one nest
+	 * call. If we are already in a nested call, then we don't probe this and
+	 * just return the original return address.
+	 */
+	if (unlikely(bit < 0))
+		goto out;
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		}
 	}
 
+	ftrace_test_recursion_unlock(bit);
+out:
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
-- 
2.50.1



