Return-Path: <stable+bounces-67673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65478951E92
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977181C21F4D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748F1B29BA;
	Wed, 14 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VulC//mL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85A2E62D
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649497; cv=none; b=SBVQCvX7rbP82L7wd1eJLwjv9w3jt4avzF7AVhpwmD1/kpWRANNcTR3M/1qIAl0Q0edu3aZZyfhTRr2zIK5SVQ0MBfybIXhsXgWbSEWghn6PyaCg5xoU+NG5Xa01nNALfaiVddg+bAfwJtLoGmZ3U2SrN2Ks9UrgSvJGkpXebpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649497; c=relaxed/simple;
	bh=9XSsEMnw7mjj4lpRgFPcQiUbJQJa5ZJfpuFAqlCw2tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtSJxbrpDlbyozlNDa7D6+V5RpYM0rIJk1GZyI+pDx0YoR/DSz6/DyC1+eBiX4z95T5VQ9dThlFVje0fmSLKHc9iyfvYtEiR1OslwJQ1UpTWWESPYm0bKUJT04V4Be1FiK8ibYARsM4+pygs8ZDXsyqgxrPBqMndkgofxBonUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VulC//mL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723649495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IiMPsWJPYDK3P+MCQiM10rUyO4cGMHXEZ4jmPZHJ+ME=;
	b=VulC//mLR16JgZsFya5Z7UZIhog+zZ6My3Nz9o/Xz4aRje083zR9hfuFiGGLje3kk6aCy7
	f/iEUUUj1DPY09iJWgZTTLRcnigtjO7HIXthBVzLN5GVbWeMCsF/AfsPpauLn7SX9F4jbw
	18iHX4kPyo5ConXx5scSHl1YWfNTz5I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-5pYwyYgWPCe6U5M_RfEoUQ-1; Wed,
 14 Aug 2024 11:31:31 -0400
X-MC-Unique: 5pYwyYgWPCe6U5M_RfEoUQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D3A019541A9;
	Wed, 14 Aug 2024 15:31:29 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.225.193])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 741FF1955E80;
	Wed, 14 Aug 2024 15:31:24 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Bill Peters <wpeters@atpco.net>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: handle affine_move_task failure case gracefully
Date: Wed, 14 Aug 2024 17:31:18 +0200
Message-ID: <20240814153119.27681-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

CPU hangs were reported while offlining/onlining CPUs on s390.

Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
can fail when racing with off-/on-lining resulting in a deadlock waiting for
the pending migration stop work completion which is never done.

Fix this by gracefully handling such condition.

Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
Cc: stable@vger.kernel.org
Reported-by: Bill Peters <wpeters@atpco.net>
Tested-by: Bill Peters <wpeters@atpco.net>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 kernel/sched/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5b..40a3c9ff74077 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2871,8 +2871,25 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		preempt_disable();
 		task_rq_unlock(rq, p, rf);
 		if (!stop_pending) {
-			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-					    &pending->arg, &pending->stop_work);
+			stop_pending =
+				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+						    &pending->arg, &pending->stop_work);
+			/*
+			 * The state resulting in this failure is not expected
+			 * at this point. At least report a WARNING to be able
+			 * to panic and further debug if reproduced.
+			 */
+			if (WARN_ON(!stop_pending)) {
+				/*
+				 * Then try to handle the failure gracefully
+				 * to prevent the deadlock a few lines later.
+				 */
+				rq = task_rq_lock(p, rf);
+				pending->stop_pending = false;
+				p->migration_pending = NULL;
+				task_rq_unlock(rq, p, rf);
+				complete_all(&pending->done);
+			}
 		}
 		preempt_enable();
 
-- 
2.43.0


