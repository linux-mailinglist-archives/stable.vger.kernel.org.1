Return-Path: <stable+bounces-74040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA78971D5F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B375E285126
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8219470;
	Mon,  9 Sep 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="UEYY5X7T"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE914295
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894059; cv=none; b=gNt5zwBG6jtCo24PGC0av9WzhYSfkn2KDyaz4C4+68xnIhROxs3/jVi2p1B0sRiUBEQTn3DKcBF7J4IE15eZhx5Y6hi0CAsSCPYbsDfeIYotR7JU93OldYi8vYj8/1COa16vfhVvx7Yx3wNcLYcfN45urf3PUVZTdiBEebq+BmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894059; c=relaxed/simple;
	bh=RzOo4nswEo3jSmFZkHprYDJX4YMV6YOVmHsXRuguc3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJZqs7TUlck110RYuSCUPJ+Xi9mZSBdo4KevlzJRaRkmmwbYedu88VytNQjPsacHJIl/r5U4RMP1wsKQBili9+L7pfIZrRAtoKblIKuxEiyij6GL6GJ5i8y/8a54xIRe/lzb8cY0cmtH5R7Zyc48rvxgioPm7HdH0kr2TgOCzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=UEYY5X7T; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240909150052cf9d7150e6a994b10b
        for <stable@vger.kernel.org>;
        Mon, 09 Sep 2024 17:00:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=X8ddSxPwoRliEpQfz+Jf+VCcHRWUMvdaMj1Nlh/9NU8=;
 b=UEYY5X7TmjROFRyYtCHlEzx4t24DMp5YL4hySPe6h9WTnpz0lWSLABoy7dAvKjnNF4b2s8
 miG+PXci6F0GzQyXFt2C1WEkjpYWd8ybyLc3vzvpsIm2AHdaQ0nq33CQFK/hbU2zcnknNez7
 ZJ/AMH5sWfu0/KgJqTCGoPF+J+zqjnUfjI5oWO4dNi/rIxz/lm5cyqne6k/Cbz9RKxASI8P5
 59eeZXbsQW/5kCh1kRKGvr8WUrl5pb8ptwj6dvQcuCNC1gyTGDF7ZrLwUhKqau0otFK+5tXj
 hMa7SxWede2zJX1NGLh8ZTVb8s0bDuygmUzy3P1jK0d022gRhWUVDglw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	stable@vger.kernel.org,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of cpuset
Date: Mon,  9 Sep 2024 17:00:36 +0200
Message-Id: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

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
---
Hi,

that's hopefully the last fix of cpu pinnings of the sq poller threads.
However, there is more to come on the io-wq side. E.g the syscalls for
IORING_REGISTER_IOWQ_AFF that can be used to change the affinites are
not yet protected. I'm currently just lacking good reproducers for that.
I also have to admit that I don't feel too comfortable making changes to
the wq part, given that I don't have good tests.

While fixing this, I'm wondering if it makes sense to add tests for the
combination of pinning and cpuset. If yes, where should these tests be
added?

Best regards,
Felix Moessbauer
Siemens AG

 io_uring/sqpoll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 713be7c29388..b8ec8fec99b8 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/cpuset.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -459,10 +460,12 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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
-- 
2.39.2


