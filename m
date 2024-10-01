Return-Path: <stable+bounces-78322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CC98B554
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5638B1F21CA1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1561BCA00;
	Tue,  1 Oct 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iH1/wVlg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EE3307B
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767176; cv=none; b=HyP/M34Op8twJAHgE48t0/3YCCKhyaF3jCBB/81iPLo5JGB7Q6+c7CukEsD4QG+ir2tPP3aOLiTaT42QVKbcC/g/BzLHHYkiJFEBkmAGsdQqDgYAAdtGQrjWuogg42w6wHcK9fhlcFT1LJUQ/msXjfmDhBfCXwpe7c+sx8cOlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767176; c=relaxed/simple;
	bh=3LRdtz6dQSiNI0cII4I3ymCM1PYgISLN1hMXHkaPS2I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZcK6lMxfPyv32r5RVKO+r6vxJyzdAA8lgiqML/zsgBxrcfBQzqT+4PkKwrbm+4FSG19yyJxAuSCECYhfYBrhpma1HBTm2TmBjwwA6pYIdVfxvigoiDh/CaVs7C40abadIwXUx4V54McDicsIFnUQXRfWdD+ArqMQwXWQWNFsawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iH1/wVlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3C4C4CEC6;
	Tue,  1 Oct 2024 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727767175;
	bh=3LRdtz6dQSiNI0cII4I3ymCM1PYgISLN1hMXHkaPS2I=;
	h=Subject:To:Cc:From:Date:From;
	b=iH1/wVlgB14mcToIhng+B71ESkcx/o9PY6xe7DNIiBTod9q09SgyR4DQzT21GI8CM
	 EXAk+4q57xI4nJrgERbySeB0anB6BheSWM+nmQYUGCRQCgIlFjWlqpI9n5Ryqn05Ji
	 2XFlU879SnNqUw2rx8qZ6d/VdnlQyHtmWgEDIG6I=
Subject: FAILED: patch "[PATCH] io_uring/sqpoll: do not allow pinning outside of cpuset" failed to apply to 5.15-stable tree
To: felix.moessbauer@siemens.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 09:19:32 +0200
Message-ID: <2024100131-number-deface-36a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f011c9cf04c06f16b24f583d313d3c012e589e50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100131-number-deface-36a6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f011c9cf04c0 ("io_uring/sqpoll: do not allow pinning outside of cpuset")
17437f311490 ("io_uring: move SQPOLL related handling into its own file")
59915143e89f ("io_uring: move timeout opcodes and handling into its own file")
e418bbc97bff ("io_uring: move our reference counting into a header")
36404b09aa60 ("io_uring: move msg_ring into its own file")
f9ead18c1058 ("io_uring: split network related opcodes into its own file")
e0da14def1ee ("io_uring: move statx handling to its own file")
a9c210cebe13 ("io_uring: move epoll handler to its own file")
4cf90495281b ("io_uring: add a dummy -EOPNOTSUPP prep handler")
99f15d8d6136 ("io_uring: move uring_cmd handling to its own file")
cd40cae29ef8 ("io_uring: split out open/close operations")
453b329be5ea ("io_uring: separate out file table handling code")
f4c163dd7d4b ("io_uring: split out fadvise/madvise operations")
0d5847274037 ("io_uring: split out fs related sync/fallocate functions")
531113bbd5bf ("io_uring: split out splice related operations")
11aeb71406dd ("io_uring: split out filesystem related operations")
e28683bdfc2f ("io_uring: move nop into its own file")
5e2a18d93fec ("io_uring: move xattr related opcodes to its own file")
97b388d70b53 ("io_uring: handle completions in the core")
de23077eda61 ("io_uring: set completion results upfront")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f011c9cf04c06f16b24f583d313d3c012e589e50 Mon Sep 17 00:00:00 2001
From: Felix Moessbauer <felix.moessbauer@siemens.com>
Date: Mon, 9 Sep 2024 17:00:36 +0200
Subject: [PATCH] io_uring/sqpoll: do not allow pinning outside of cpuset

The submit queue polling threads are userland threads that just never
exit to the userland. When creating the thread with IORING_SETUP_SQ_AFF,
the affinity of the poller thread is set to the cpu specified in
sq_thread_cpu. However, this CPU can be outside of the cpuset defined
by the cgroup cpuset controller. This violates the rules defined by the
cpuset controller and is a potential issue for realtime applications.

In b7ed6d8ffd6 we fixed the default affinity of the poller thread, in
case no explicit pinning is required by inheriting the one of the
creating task. In case of explicit pinning, the check is more
complicated, as also a cpu outside of the parent cpumask is allowed.
We implemented this by using cpuset_cpus_allowed (that has support for
cgroup cpusets) and testing if the requested cpu is in the set.

Fixes: 37d1e2e3642e ("io_uring: move SQPOLL thread io-wq forked worker")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Link: https://lore.kernel.org/r/20240909150036.55921-1-felix.moessbauer@siemens.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index e545bf240d35..272df9d00f45 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/cpuset.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -460,10 +461,12 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 			return 0;
 
 		if (p->flags & IORING_SETUP_SQ_AFF) {
+			struct cpumask allowed_mask;
 			int cpu = p->sq_thread_cpu;
 
 			ret = -EINVAL;
-			if (cpu >= nr_cpu_ids || !cpu_online(cpu))
+			cpuset_cpus_allowed(current, &allowed_mask);
+			if (!cpumask_test_cpu(cpu, &allowed_mask))
 				goto err_sqpoll;
 			sqd->sq_cpu = cpu;
 		} else {


