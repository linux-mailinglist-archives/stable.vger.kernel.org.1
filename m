Return-Path: <stable+bounces-118613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0615A3F998
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B4C7ACD9A
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD082147F6;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9F214210;
	Fri, 21 Feb 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153143; cv=none; b=JrfgiHmsL5KvSdfI22I9Y3LESQAuXooUNLROM34Mt1jRnBEJYABK2gMuAQbGvQeUWW+UhtWtFtglcS3nUuKo37OaTaTsHboxdTokSEoCKFpaWTQcBUDUhVysLDoBT/8Na9Y2XCasZR883t7O4vWZhtsqupKAeckO3VSwPfeHQcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153143; c=relaxed/simple;
	bh=AiY9PGwSpTvpL/xaZ7Dd84wfvgNcgWBdqdNMH/Ge6Ws=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OPkI8YQF8OjBVuZahvj5aTPzRmrh+DmM1SBFH8QrlUDViNiSxRz8AIVk6ZtJJxXgn853k0wfGVpFslJxs64hA2LOPPsNmC6nkj1SLZdh6AaYfOAKdPu7rpE9Rgu7tsaw/FyGWfPzQ0TwVRe3X1r2Uvn47w2VzYsw5HowhRln43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ED9C4CEE7;
	Fri, 21 Feb 2025 15:52:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKd-00000006KRc-3SCB;
	Fri, 21 Feb 2025 10:52:51 -0500
Message-ID: <20250221155251.673749961@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [for-linus][PATCH 1/7] ftrace: Fix accounting of adding subops to a manager ops
References: <20250221155210.755295517@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Function graph uses a subops and manager ops mechanism to attach to
ftrace.  The manager ops connects to ftrace and the functions it connects
to is defined by a list of subops that it manages.

The function hash that defines what the above ops attaches to limits the
functions to attach if the hash has any content. If the hash is empty, it
means to trace all functions.

The creation of the manager ops hash is done by iterating over all the
subops hashes. If any of the subops hashes is empty, it means that the
manager ops hash must trace all functions as well.

The issue is in the creation of the manager ops. When a second subops is
attached, a new hash is created by starting it as NULL and adding the
subops one at a time. But the NULL ops is mistaken as an empty hash, and
once an empty hash is found, it stops the loop of subops and just enables
all functions.

  # echo "f:myevent1 kernel_clone" >> /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions
kernel_clone (1)           	tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60

  # echo "f:myevent2 schedule_timeout" >> /sys/kernel/tracing/dynamic_events
  # cat /sys/kernel/tracing/enabled_functions
trace_initcall_start_cb (1)             tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
run_init_process (1)            tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
try_to_run_init_process (1)             tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
x86_pmu_show_pmu_cap (1)                tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
cleanup_rapl_pmus (1)                   tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
uncore_free_pcibus_map (1)              tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
uncore_types_exit (1)                   tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
uncore_pci_exit.part.0 (1)              tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
kvm_shutdown (1)                tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
vmx_dump_msrs (1)               tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
vmx_cleanup_l1d_flush (1)               tramp: 0xffffffffc0309000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60
[..]

Fix this by initializing the new hash to NULL and if the hash is NULL do
not treat it as an empty hash but instead allocate by copying the content
of the first sub ops. Then on subsequent iterations, the new hash will not
be NULL, but the content of the previous subops. If that first subops
attached to all functions, then new hash may assume that the manager ops
also needs to attach to all functions.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250220202055.060300046@goodmis.org
Fixes: 5fccc7552ccbc ("ftrace: Add subops logic to allow one ops to manage many")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 728ecda6e8d4..bec54dc27204 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3220,15 +3220,22 @@ static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
  *  The filter_hash updates uses just the append_hash() function
  *  and the notrace_hash does not.
  */
-static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
+static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash,
+		       int size_bits)
 {
 	struct ftrace_func_entry *entry;
 	int size;
 	int i;
 
-	/* An empty hash does everything */
-	if (ftrace_hash_empty(*hash))
-		return 0;
+	if (*hash) {
+		/* An empty hash does everything */
+		if (ftrace_hash_empty(*hash))
+			return 0;
+	} else {
+		*hash = alloc_ftrace_hash(size_bits);
+		if (!*hash)
+			return -ENOMEM;
+	}
 
 	/* If new_hash has everything make hash have everything */
 	if (ftrace_hash_empty(new_hash)) {
@@ -3292,16 +3299,18 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
 /* Return a new hash that has a union of all @ops->filter_hash entries */
 static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 {
-	struct ftrace_hash *new_hash;
+	struct ftrace_hash *new_hash = NULL;
 	struct ftrace_ops *subops;
+	int size_bits;
 	int ret;
 
-	new_hash = alloc_ftrace_hash(ops->func_hash->filter_hash->size_bits);
-	if (!new_hash)
-		return NULL;
+	if (ops->func_hash->filter_hash)
+		size_bits = ops->func_hash->filter_hash->size_bits;
+	else
+		size_bits = FTRACE_HASH_DEFAULT_BITS;
 
 	list_for_each_entry(subops, &ops->subop_list, list) {
-		ret = append_hash(&new_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&new_hash, subops->func_hash->filter_hash, size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(new_hash);
 			return NULL;
@@ -3310,7 +3319,8 @@ static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
 		if (ftrace_hash_empty(new_hash))
 			break;
 	}
-	return new_hash;
+	/* Can't return NULL as that means this failed */
+	return new_hash ? : EMPTY_HASH;
 }
 
 /* Make @ops trace evenything except what all its subops do not trace */
@@ -3505,7 +3515,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
 		if (!filter_hash)
 			return -ENOMEM;
-		ret = append_hash(&filter_hash, subops->func_hash->filter_hash);
+		ret = append_hash(&filter_hash, subops->func_hash->filter_hash,
+				  size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(filter_hash);
 			return ret;
-- 
2.47.2



