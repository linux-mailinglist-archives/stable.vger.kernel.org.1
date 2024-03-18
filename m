Return-Path: <stable+bounces-28359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688087E858
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 12:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3770AB22EA0
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1F36114;
	Mon, 18 Mar 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+BCghJm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AD37159
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760690; cv=none; b=HNfOI3uleBSgOKOPkH5iK3AYkQnDrd+Vqd+YHtuUyNhIoNY+LzlpYu24ldPsItbjx/SPi6nu1vgyrmCc2JecGd9nMUKB2SHgUwYknVl5u4BZgiFoVBeHoJzJijwDQTADC1zZyHWCvIpi+tkKa4MaeWcOL3y6iR2K/iL9S/aLIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760690; c=relaxed/simple;
	bh=O8orsh4fpL1MSr02xvuqLOzLtF3YhhKLmLgVXGjAEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjnOdQg/vQiFXWUNQ20BJn4L1Xd4ugulzuJIuK4b2x5EJWCjxd12ppz+ZbAuWJdO/i/ViTCEEhUPaHkuSP1CmW9u6sRhF2q++ov8X6jW3qA0k7xOajZo1GXDdOtKjMzCuB4gz+iYgt2jq7H0+HOHvzxhO6w61zVmscuLt5gU7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+BCghJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710760687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Xrq8vJ1NagCe+cTWlPAdrkNTdkW7Dtp8mrb26EB1sQ=;
	b=I+BCghJmBDPWlPi1sm5z/TnyN1+DTLEpQ0CJWkApjwrUUU48cg/bTfG/LCgVaTJObr2lyD
	Uhk51bt3HvMVJ3mDOLvETYj35T03uY60vEgatXR92fma06Tj6dKL73x6XM/3ENY2dOizDf
	Cy1q08w16U/mRgLw+uIB8AP49AAkevg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-AXyhhxoHONWn_NAucC7XSQ-1; Mon, 18 Mar 2024 07:18:04 -0400
X-MC-Unique: AXyhhxoHONWn_NAucC7XSQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFBA1101A5B3;
	Mon, 18 Mar 2024 11:18:03 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.225.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C333492BD0;
	Mon, 18 Mar 2024 11:18:00 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Bill Peters <wpeters@atpco.net>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: fix affine_move_task failure case
Date: Mon, 18 Mar 2024 12:17:48 +0100
Message-ID: <20240318111750.3097906-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.

Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
can fail when racing with off-/on-lining resulting in a deadlock waiting for
the pending migration stop work completion which is never done.

Fix this by correctly handling such a condition.

Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
Cc: stable@vger.kernel.org
Reported-by: Bill Peters <wpeters@atpco.net>
Tested-by: Bill Peters <wpeters@atpco.net>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 kernel/sched/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc903467..d0ff5c611a1c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3069,8 +3069,17 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		preempt_disable();
 		task_rq_unlock(rq, p, rf);
 		if (!stop_pending) {
-			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-					    &pending->arg, &pending->stop_work);
+			stop_pending =
+				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+						    &pending->arg, &pending->stop_work);
+
+			if (!stop_pending) {
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


