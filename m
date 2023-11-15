Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ADE7ECF51
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjKOTrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjKOTrq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EC01A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB36C433C8;
        Wed, 15 Nov 2023 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077662;
        bh=OXe2xr3PXByl1B0nR1dK+FORvow8ADO3Qh8KorO3sHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKn+KiTZdOQheXC77hfRPfMoZx/ZfaHrYPnScclGhmAQhRiGc0fnbVSIL1yj9lp4j
         HbeZRtlrcqxBuLX0aoTHwlMPjlMdy8yqmDfCpRIeoOWm4nrNETq5syi13jQRUuHC48
         mlwIFYDqxaqjN12eKOQOLJszyk4cu+UubqD4JFqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Disha Goel <disgoel@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 440/603] tools/perf: Update call stack check in builtin-lock.c
Date:   Wed, 15 Nov 2023 14:16:25 -0500
Message-ID: <20231115191643.252046387@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit d7c9ae8d5d1be0c4156d1e20e4369a77b711a4cc ]

The perf test named "kernel lock contention analysis test"
fails in powerpc system with below error:

  [command]# ./perf test 81 -vv
   81: kernel lock contention analysis test                            :
   --- start ---
  test child forked, pid 2140
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  [Skip] No BPF support
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  [Fail] Recorded result should have a lock from unix_stream:
  test child finished with -1
   ---- end ----
  kernel lock contention analysis test: FAILED!

The test is failing because we get an address entry with 0 in
perf lock samples for powerpc, and code for lock contention
option "--callstack-filter" will not check further entries after
address 0.

Below are some of the samples from test generated perf.data file, which
have 0 address in the 2nd entry of callstack:
 --------
sched-messaging    3409 [001]  7152.904029: lock:contention_begin: 0xc00000c80904ef00 (flags=SPIN)
        c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kallsyms])
                       0 [unknown] ([unknown])
        c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.kallsyms])
        c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
        c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
        c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
        c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
        c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])

sched-messaging    3408 [005]  7152.904036: lock:contention_begin: 0xc00000c80904ef00 (flags=SPIN)
        c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kallsyms])
                       0 [unknown] ([unknown])
        c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.kallsyms])
        c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
        c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
        c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
        c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
        c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])
 --------

Based on commit 20002ded4d93 ("perf_counter: powerpc: Add callchain support"),
incase of powerpc, the callchain saved by kernel always includes first
three entries as the NIP (next instruction pointer), LR (link register), and
the contents of LR save area in the second stack frame. In certain scenarios
its possible to have invalid kernel instruction addresses in either of LR or the
second stack frame's LR. In that case, kernel will store the address as zer0.
Hence, its possible to have 2nd or 3rd callstack entry as 0.

As per the current code in match_callstack_filter function, we skip the callstack
check incase we get 0 address. And hence the test case is failing in powerpc.

Fix this issue by updating the check in match_callstack_filter function,
to not skip callstack check if the 2nd or 3rd entry have 0 address
for powerpc.

Result in powerpc after patch changes:

  [command]# ./perf test 81 -vv
   81: kernel lock contention analysis test                            :
   --- start ---
  test child forked, pid 4570
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  [Skip] No BPF support
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  [Skip] Could not find 'tasklist_lock'
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  Testing perf lock contention --callstack-filter with task aggregation
  Testing perf lock contention CSV output
  [Skip] No BPF support
  test child finished with 0
   ---- end ----
  kernel lock contention analysis test: Ok

Fixes: ebab291641be ("perf lock contention: Support filters for different aggregation")
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Cc: maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com
Link: https://lore.kernel.org/r/20231003092113.252380-1-kjain@linux.ibm.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-lock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f21342740..0b4b4445c5207 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -524,6 +524,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack)
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
+	const char *arch = perf_env__arch(machine->env);
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -531,7 +532,21 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack)
 	for (int i = 0; i < max_stack_depth; i++) {
 		struct callstack_filter *filter;
 
-		if (!callstack || !callstack[i])
+		/*
+		 * In powerpc, the callchain saved by kernel always includes
+		 * first three entries as the NIP (next instruction pointer),
+		 * LR (link register), and the contents of LR save area in the
+		 * second stack frame. In certain scenarios its possible to have
+		 * invalid kernel instruction addresses in either LR or the second
+		 * stack frame's LR. In that case, kernel will store that address as
+		 * zero.
+		 *
+		 * The below check will continue to look into callstack,
+		 * incase first or second callstack index entry has 0
+		 * address for powerpc.
+		 */
+		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
+						(i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.42.0



