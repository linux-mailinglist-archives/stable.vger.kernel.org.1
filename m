Return-Path: <stable+bounces-73115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7996CAEA
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5201F28575
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525118454D;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BF17BEA7;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493406; cv=none; b=oFM9SWd6nLgbcMsQsKuaVL8z1+DlNtda4rv4fSUg3vR1KGExe/7hxhPHQ29a7Aos1zMWzNXaiG/lowznW3eYivg57108buOuu66xmhagp2gYz2vlA+0ihoUQY0NCXXCG68D7yFouljeExeU4N1glGdtOe6d55fKF28OXdCrDDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493406; c=relaxed/simple;
	bh=I8pfGr9tNLSa03+h5g9vvW/v1zZshm0EIxFsxc/oTFQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TXmkvpob2qcF+Bx67moJTs7mBQsu65XPyke9Kvbp5b9cl0MojsdFIPoyuw7NtSiXMbUPbmzfhCvI+h2Ddy4Cij5DNsyEPWXnbeE3+et4srzxgzgrU7t7sLziz3VJfyMErNmthjHTdmHzkB0FBX8VT8xIKZqPXFs6XjEUNxTVIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4ABC4CEC9;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfn-00000005Bnv-3nbT;
	Wed, 04 Sep 2024 19:44:27 -0400
Message-ID: <20240904234427.774268849@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/6] tracing: Fix memory leak in fgraph storage selftest
References: <20240904234411.443593140@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

With ftrace boot-time selftest, kmemleak reported some memory leaks in
the new test case for function graph storage for multiple tracers.

unreferenced object 0xffff888005060080 (size 32):
  comm "swapper/0", pid 1, jiffies 4294676440
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 10 06 05 80 88 ff ff  ........ .......
    54 0c 1e 81 ff ff ff ff 00 00 00 00 00 00 00 00  T...............
  backtrace (crc 7c93416c):
    [<000000000238ee6f>] __kmalloc_cache_noprof+0x11f/0x2a0
    [<0000000033d2b6c5>] enter_record+0xe8/0x150
    [<0000000054c38424>] match_records+0x1cd/0x230
    [<00000000c775b63d>] ftrace_set_hash+0xff/0x380
    [<000000007bf7208c>] ftrace_set_filter+0x70/0x90
    [<00000000a5c08dda>] test_graph_storage_multi+0x2e/0xf0
    [<000000006ba028ca>] trace_selftest_startup_function_graph+0x1e8/0x260
    [<00000000a715d3eb>] run_tracer_selftest+0x111/0x190
    [<00000000395cbf90>] register_tracer+0xdf/0x1f0
    [<0000000093e67f7b>] do_one_initcall+0x141/0x3b0
    [<00000000c591b682>] do_initcall_level+0x82/0xa0
    [<000000004e4c6600>] do_initcalls+0x43/0x70
    [<0000000034f3c4e4>] kernel_init_freeable+0x170/0x1f0
    [<00000000c7a5dab2>] kernel_init+0x1a/0x1a0
    [<00000000ea105947>] ret_from_fork+0x3a/0x50
    [<00000000a1932e84>] ret_from_fork_asm+0x1a/0x30
...

This means filter hash allocated for the fixtures are not correctly
released after the test.

Free those hash lists after tests are done and split the loop for
initialize fixture and register fixture for rollback.

Fixes: dd120af2d5f8 ("ftrace: Add multiple fgraph storage selftest")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/172411539857.28895.13119957560263401102.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 97f1e4bc47dc..c4ad7cd7e778 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -942,7 +942,7 @@ static __init int test_graph_storage_multi(void)
 {
 	struct fgraph_fixture *fixture;
 	bool printed = false;
-	int i, ret;
+	int i, j, ret;
 
 	pr_cont("PASSED\n");
 	pr_info("Testing multiple fgraph storage on a function: ");
@@ -953,22 +953,35 @@ static __init int test_graph_storage_multi(void)
 		if (ret && ret != -ENODEV) {
 			pr_cont("*Could not set filter* ");
 			printed = true;
-			goto out;
+			goto out2;
 		}
+	}
 
+	for (j = 0; j < ARRAY_SIZE(store_bytes); j++) {
+		fixture = &store_bytes[j];
 		ret = register_ftrace_graph(&fixture->gops);
 		if (ret) {
 			pr_warn("Failed to init store_bytes fgraph tracing\n");
 			printed = true;
-			goto out;
+			goto out1;
 		}
 	}
 
 	DYN_FTRACE_TEST_NAME();
-out:
+out1:
+	while (--j >= 0) {
+		fixture = &store_bytes[j];
+		unregister_ftrace_graph(&fixture->gops);
+
+		if (fixture->error_str && !printed) {
+			pr_cont("*** %s ***", fixture->error_str);
+			printed = true;
+		}
+	}
+out2:
 	while (--i >= 0) {
 		fixture = &store_bytes[i];
-		unregister_ftrace_graph(&fixture->gops);
+		ftrace_free_filter(&fixture->gops.ops);
 
 		if (fixture->error_str && !printed) {
 			pr_cont("*** %s ***", fixture->error_str);
-- 
2.43.0



