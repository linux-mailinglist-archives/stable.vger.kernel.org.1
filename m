Return-Path: <stable+bounces-106665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDFA000FB
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 23:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E56163050
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39281B982E;
	Thu,  2 Jan 2025 22:01:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54261AAA22;
	Thu,  2 Jan 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855313; cv=none; b=Z5bULTqhAAOyt1+hykRnSnIja0ynScXKdlChVZHzSGy7h8TXOzF37CMCZQouAok9Yt1utXkeS3pJcHRRSpOoVP0G/TsghGMnnd3VCbxbyH1w2jhAItijVFLNqIUOIZhg/OfBvc8pwewNMaPO3sBGzmcr3/Z4aNfW9tsLPFh+yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855313; c=relaxed/simple;
	bh=/1O+5kOz7KTGVhdbBQyXehylW2sP5GGTL5wL/boKBT0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZEL6XlPxF0jWwY2sl8K/YKNnhfw8NPUOMqXRbiHcNf722NcGvqcM69DTtCDnLfdAE8mOJ6VUJcUyMUKzBrjtBjCMPkaDN78pADHmdLAQg6jrhwfFl9uSLQYaDzdpj3bIdIYhcKYli2B9HkI6VgbWLS4ksjyqd5jA2TXYbdcR8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB6CC4CEDF;
	Thu,  2 Jan 2025 22:01:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTTHa-00000005Ut2-18DI;
	Thu, 02 Jan 2025 17:03:10 -0500
Message-ID: <20250102220310.109629698@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 17:02:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Kohei Enju <enjuk@amazon.com>
Subject: [for-linus][PATCH 2/2] ftrace: Fix function profilers filtering functionality
References: <20250102220238.225015816@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kohei Enju <enjuk@amazon.com>

Commit c132be2c4fcc ("function_graph: Have the instances use their own
ftrace_ops for filtering"), function profiler (enabled via
function_profile_enabled) has been showing statistics for all functions,
ignoring set_ftrace_filter settings.

While tracers are instantiated, the function profiler is not. Therefore, it
should use the global set_ftrace_filter for consistency.  This patch
modifies the function profiler to use the global filter, fixing the
filtering functionality.

Before (filtering not working):
```
root@localhost:~# echo 'vfs*' > /sys/kernel/tracing/set_ftrace_filter
root@localhost:~# echo 1 > /sys/kernel/tracing/function_profile_enabled
root@localhost:~# sleep 1
root@localhost:~# echo 0 > /sys/kernel/tracing/function_profile_enabled
root@localhost:~# head /sys/kernel/tracing/trace_stat/*
  Function                               Hit    Time            Avg
     s^2
  --------                               ---    ----            ---
     ---
  schedule                               314    22290594 us     70989.15 us
     40372231 us
  x64_sys_call                          1527    8762510 us      5738.382 us
     3414354 us
  schedule_hrtimeout_range               176    8665356 us      49234.98 us
     405618876 us
  __x64_sys_ppoll                        324    5656635 us      17458.75 us
     19203976 us
  do_sys_poll                            324    5653747 us      17449.83 us
     19214945 us
  schedule_timeout                        67    5531396 us      82558.15 us
     2136740827 us
  __x64_sys_pselect6                      12    3029540 us      252461.7 us
     63296940171 us
  do_pselect.constprop.0                  12    3029532 us      252461.0 us
     63296952931 us
```

After (filtering working):
```
root@localhost:~# echo 'vfs*' > /sys/kernel/tracing/set_ftrace_filter
root@localhost:~# echo 1 > /sys/kernel/tracing/function_profile_enabled
root@localhost:~# sleep 1
root@localhost:~# echo 0 > /sys/kernel/tracing/function_profile_enabled
root@localhost:~# head /sys/kernel/tracing/trace_stat/*
  Function                               Hit    Time            Avg
     s^2
  --------                               ---    ----            ---
     ---
  vfs_write                              462    68476.43 us     148.217 us
     25874.48 us
  vfs_read                               641    9611.356 us     14.994 us
     28868.07 us
  vfs_fstat                              890    878.094 us      0.986 us
     1.667 us
  vfs_fstatat                            227    757.176 us      3.335 us
     18.928 us
  vfs_statx                              226    610.610 us      2.701 us
     17.749 us
  vfs_getattr_nosec                     1187    460.919 us      0.388 us
     0.326 us
  vfs_statx_path                         297    343.287 us      1.155 us
     11.116 us
  vfs_rename                               6    291.575 us      48.595 us
     9889.236 us
```

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250101190820.72534-1-enjuk@amazon.com
Fixes: c132be2c4fcc ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..2e113f8b13a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -902,16 +902,13 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
-	.ops = {
-		.flags = FTRACE_OPS_FL_INITIALIZED,
-		INIT_OPS_HASH(fprofiler_ops.ops)
-	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };
 
 static int register_ftrace_profiler(void)
 {
+	ftrace_ops_set_global_filter(&fprofiler_ops.ops);
 	return register_ftrace_graph(&fprofiler_ops);
 }
 
@@ -922,12 +919,11 @@ static void unregister_ftrace_profiler(void)
 #else
 static struct ftrace_ops ftrace_profile_ops __read_mostly = {
 	.func		= function_profile_call,
-	.flags		= FTRACE_OPS_FL_INITIALIZED,
-	INIT_OPS_HASH(ftrace_profile_ops)
 };
 
 static int register_ftrace_profiler(void)
 {
+	ftrace_ops_set_global_filter(&ftrace_profile_ops);
 	return register_ftrace_function(&ftrace_profile_ops);
 }
 
-- 
2.45.2



