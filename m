Return-Path: <stable+bounces-118348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D1BA3CBFA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EE47A5347
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D722586D7;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024E22CBC7;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002686; cv=none; b=Hg4wLf+m2TosdIwiEs5v5c7OpDoHN5kBaG7qwkLZSj1wIvHMcC+uz2uXhvDEw/WzmopwnSnFilQ0uoQXK6NwcvfeqZJA9MOPmKw6dEQMVdcdVMsZZXpThuzNkxtb4+bZz2VtSSQavUsei9hU0m4yoYRMVPZ1BLLARTwhzue1WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002686; c=relaxed/simple;
	bh=Jb0rh3NHBslpBtXxbufzkwA8ihOLrJe4xkc4ZG++80Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kwt4C7fSg94ZFDGzchH00HZV+ZVUUsah/NqMmjn1vLpBDMd3jEmCxJr3ogz45mn5qrJvGGd38gy8wFCXngCm/j6fG/lo1qULGPhQl/7iSnf9+PVBZeHXWQDwv3SmXq89dssEFe8zf506qaY7aXfGjaNDaTdn3niwTInPINCuyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C2C4CEEA;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tksBr-00000004qd9-1Yyr;
	Wed, 19 Feb 2025 17:05:11 -0500
Message-ID: <20250219220511.227410168@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 17:04:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 3/5] fprobe: Always unregister fgraph function from ops
References: <20250219220436.498041541@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the last fprobe is removed, it calls unregister_ftrace_graph() to
remove the graph_ops from function graph. The issue is when it does so, it
calls return before removing the function from its graph ops via
ftrace_set_filter_ips(). This leaves the last function lingering in the
fprobe's fgraph ops and if a probe is added it also enables that last
function (even though the callback will just drop it, it does add unneeded
overhead to make that call).

  # echo "f:myevent1 kernel_clone" >> /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions
kernel_clone (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60

  # echo "f:myevent2 schedule_timeout" >> /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions
kernel_clone (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
schedule_timeout (1)           	tramp: 0xffffffffc02f3000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60

  # > /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions

  # echo "f:myevent3 kmem_cache_free" >> /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions
kmem_cache_free (1)           	tramp: 0xffffffffc0219000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
schedule_timeout (1)           	tramp: 0xffffffffc0219000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60

The above enabled a fprobe on kernel_clone, and then on schedule_timeout.
The content of the enabled_functions shows the functions that have a
callback attached to them. The fprobe attached to those functions
properly. Then the fprobes were cleared, and enabled_functions was empty
after that. But after adding a fprobe on kmem_cache_free, the
enabled_functions shows that the schedule_timeout was attached again. This
is because it was still left in the fprobe ops that is used to tell
function graph what functions it wants callbacks from.

Cc: stable@vger.kernel.org
Fixes: 4346ba1604093 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fprobe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 2560b312ad57..62e8f7d56602 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -403,11 +403,9 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 	lockdep_assert_held(&fprobe_mutex);
 
 	fprobe_graph_active--;
-	if (!fprobe_graph_active) {
-		/* Q: should we unregister it ? */
+	/* Q: should we unregister it ? */
+	if (!fprobe_graph_active)
 		unregister_ftrace_graph(&fprobe_graph_ops);
-		return;
-	}
 
 	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
-- 
2.47.2



