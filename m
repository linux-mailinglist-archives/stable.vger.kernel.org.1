Return-Path: <stable+bounces-66505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09294EC8F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4048A1C20C18
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716B17967F;
	Mon, 12 Aug 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o5zyRrXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DB175D3E
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464872; cv=none; b=Vz0fG2lMCRoHuE8gW/hWX9ahIGKHT3LRpQbtRA+8eZC7/CZmw1bRs/JrmC5Nsd2m4D+40GBV9z+3MdZw6TWRCv1oL/G1BNGJnBTZ5eYDO4krn6bnaMlMW86XXHzbfwsXXibiv9bqj4zhKQRkyn+CRNONIxlheObZ7UWsadpUh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464872; c=relaxed/simple;
	bh=x39KKw1dvORRIgXPCWZhQxFVwwFJZy1gyTCQS+ZricM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gi0JTgkT/JJA0xOD/fk+HJyGcDdh6FiTFf4nxy0bLzuT5/fdEwDCvVWO5NGj31QkSDzXaUSEog1NgH2Kua01YOHCDkbZQiumTKqdwSVlkcaYFHzCcgfVIuv1a7LQiPyfvIzu5uvNZ/wZXx3aBsYag0hzj9W2s8nKT7aDt153p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o5zyRrXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CF9C32782;
	Mon, 12 Aug 2024 12:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464870;
	bh=x39KKw1dvORRIgXPCWZhQxFVwwFJZy1gyTCQS+ZricM=;
	h=Subject:To:Cc:From:Date:From;
	b=o5zyRrXNMZOUJD0RlI8o3HvBYnDgfo3el3ESvH7h1Waq1C6AFWXRRPIHaNSs8UvKb
	 CZYp0bwTrlDzjv9YpveBd9g1UqMDFURTS2iCN/urhLQ5z3F1R9rLptfRDtJXA+V7Wa
	 hwvvGzb5o2Q8s5+3fItxus7w3ZcRTtW7XtrKKsdA=
Subject: FAILED: patch "[PATCH] sched/core: Introduce sched_set_rq_on/offline() helper" failed to apply to 5.10-stable tree
To: yangyingliang@huawei.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:14:20 +0200
Message-ID: <2024081220-explore-caption-ec0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2f027354122f58ee846468a6f6b48672fff92e9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081220-explore-caption-ec0b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2f027354122f ("sched/core: Introduce sched_set_rq_on/offline() helper")
cab3ecaed5cd ("sched/core: Fixed missing rq clock update before calling set_rq_offline()")
5cb9eaa3d274 ("sched: Wrap rq::lock access")
39d371b7c0c2 ("sched: Provide raw_spin_rq_*lock*() helpers")
ed3cd45f8ca8 ("Merge tag 'v5.11' into sched/core, to pick up fixes & refresh the branch")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f027354122f58ee846468a6f6b48672fff92e9b Mon Sep 17 00:00:00 2001
From: Yang Yingliang <yangyingliang@huawei.com>
Date: Wed, 3 Jul 2024 11:16:09 +0800
Subject: [PATCH] sched/core: Introduce sched_set_rq_on/offline() helper

Introduce sched_set_rq_on/offline() helper, so it can be called
in normal or error path simply. No functional changed.

Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240703031610.587047-4-yangyingliang@huaweicloud.com

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 949473e414f9..4d119e930beb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7845,6 +7845,30 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
+static inline void sched_set_rq_online(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_online(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void sched_set_rq_offline(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -7914,7 +7938,6 @@ static inline void sched_smt_present_dec(int cpu)
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
 	/*
 	 * Clear the balance_push callback and prepare to schedule
@@ -7943,12 +7966,7 @@ int sched_cpu_activate(unsigned int cpu)
 	 * 2) At runtime, if cpuset_cpu_active() fails to rebuild the
 	 *    domains.
 	 */
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_online(rq, cpu);
 
 	return 0;
 }
@@ -7956,7 +7974,6 @@ int sched_cpu_activate(unsigned int cpu)
 int sched_cpu_deactivate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 	int ret;
 
 	/*
@@ -7987,12 +8004,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_offline(rq, cpu);
 
 	/*
 	 * When going down, decrement the number of cores with SMT present.


