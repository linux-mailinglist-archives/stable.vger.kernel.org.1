Return-Path: <stable+bounces-106632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592349FF4CB
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE18E7A128E
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2217BA9;
	Wed,  1 Jan 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xzgqp3A+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBA79E1;
	Wed,  1 Jan 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735758521; cv=none; b=YMHCzZuMqvHMDbIsgxeYBByDqmlvUAe6AlXKug9NfNFr4l93tFbd/5IzAgIfzqZpTzXU9I1HyCX5FnzVnw6kNYhuy0iFfsTUoscl4fOTbmLe1uGD7bM+5R8L2Rlej9BRWPjvZByN9fX2n2jk9QP1pJiu6wXMy60+DiduN971awY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735758521; c=relaxed/simple;
	bh=P+0y2TLmRO7pqjgmJI9L5h/PJXPqqryVP8ryiPG+PgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQvPXVzo6rOUaZ2SuMTJ1n66i+e5MDr4H5TxzFAdU/mEudJ5Hw6fuDk0YQODDERSb1BMe0mgV31POVQVpk0zmyskBEdIuqZS5bNLwLV+tBhXa93qcfsgh7WpGW0r5wrmDuDXcFGy8bkUyCdG8CSpAn959F7KnI/m68kC5Se+Y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xzgqp3A+; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735758372; x=1767294372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vl3J2ymtj17hTfc7xIB9ScQElhna+/JXnRmbV+pz1jU=;
  b=Xzgqp3A+BRYkdBcaOHI0727EEZBBnhZ+xYvIUrMiZMuo93++dOvvwCcq
   mVFgg1zocasCS7WQ1AuBsdjsL96ZuKK+HxHkCBQSuJqE/RA7SsLlyoO0+
   HRCmz7vkl5aFC6rj9xdn3/s++bRxZN+YDRjAPVG8gH8NQfQJcFaA10g0J
   0=;
X-IronPort-AV: E=Sophos;i="6.12,283,1728950400"; 
   d="scan'208,223";a="11201301"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:06:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:53390]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.144:2525] with esmtp (Farcaster)
 id 3a57c88d-f93b-4f57-8de0-6a8e3ae283ee; Wed, 1 Jan 2025 19:08:38 +0000 (UTC)
X-Farcaster-Flow-ID: 3a57c88d-f93b-4f57-8de0-6a8e3ae283ee
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 19:08:37 +0000
Received: from b0be8375a521.amazon.com (10.119.15.26) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 19:08:34 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Takamitsu Iwai <takamitz@amazon.co.jp>, Kohei Enju
	<enjuk@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH v1] ftrace: Fix function profiler's filtering functionality
Date: Thu, 2 Jan 2025 04:08:20 +0900
Message-ID: <20250101190820.72534-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

From commit c132be2c4fcc ("function_graph: Have the instances use their own
 ftrace_ops for filtering"), function profiler (enabled via function_profil
e_enabled) has been showing statistics for all functions, ignoring set_ftra
ce_filter settings.

While tracers are instantiated, the function profiler is not. Therefore, it
 should use the global set_ftrace_filter for consistency.
This patch modifies the function profiler to use the global filter, fixing
the filtering functionality.

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
Fixes: c132be2c4fcc ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
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
2.39.5 (Apple Git-154)


