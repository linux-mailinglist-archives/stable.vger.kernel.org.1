Return-Path: <stable+bounces-75935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60826975F9E
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 05:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216872840A6
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 03:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC9126BE4;
	Thu, 12 Sep 2024 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaqtE//L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2F7581A;
	Thu, 12 Sep 2024 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111261; cv=none; b=gBMBcmU3KfnF+BtjEcKvq3JG79MDyzKzIvpWwgu6THkxIODJEHM+TAj0IKqSUl4P9uXq1vR8qK7mnpphVmIxt4BbB5GNBBJn8B7Pp6Wf1rpH/sel6CFDHJ8qqmGM4rkezSeXcvzKtn0xEm25kvYFQUclf51K1QAI6GRL/fGhYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111261; c=relaxed/simple;
	bh=GUqCDR+y1+YOIGBqeNIT2ogINr0OduQatYWQKAqbfyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPpPCTv9NxeL82boUeLXSYJqlpbQE2kH4c8A2rM9tHYlcTbXPCsxXFMHWPycaYlIndUUxrslxnl0L3uCt9xfzKqjWse4U/Jl80TlEBbyT3gkqaS9cpwzo2DBA/Yp6XEYHIY6nDXN+ztp1mdKblAS9hBcajXVxfKJIkOMH0B2NPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaqtE//L; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71781f42f75so359725b3a.1;
        Wed, 11 Sep 2024 20:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726111259; x=1726716059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEKP3pkgJvbS9JmjvVYc0s7DNvaW/qUR+vrAHcWJhrY=;
        b=AaqtE//LxUPtundSEYjWiigbkOYWeRcm+yc8r1p8k1hONkN52HSK+0fNfXE6H5AydL
         irawKPdMwXZB9144PX2SS2mbJlcUPURQCFEnHRfWasbSp0/uAEwZ5SJAZ0fJGAFMi1M9
         ZRmHukP5BHvJjY8AV5X+/0R58dYTiE4lx2vWedOzDAqZ1N97bHwla2fkYOYfFQi85m0S
         2AlunxhJidCCDM7AAELcNZN0yuLkq81lf9f17vOClTb/mwg0AEMBHEGMLDsu+r5VxV4i
         7HQj3nY7V4MFZIYP+2H10H4/YnqUboL93Ag3B950+qJnedsaOp2+Eakze4JepW0HVUF7
         L2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726111259; x=1726716059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEKP3pkgJvbS9JmjvVYc0s7DNvaW/qUR+vrAHcWJhrY=;
        b=ghbufOmqhAMS0vViPtv4FdHoEUBl+fPcDD0zURmQcC7KS8HlWL2VDUos31PzdzhAQI
         gYRhuk+9MCSnShyzO2I6b9U1zXJL9SfjKpOQg9lpvqzXSLBcJrIBiEDx9m0BkQLHp5Ua
         IqcROV8H6R7fpjQXfviwNrPlgeZ9HFqlpeE3tYoZ8mub94K8+z+bghEdVWq7YcNJXSgX
         vO4F3EI+0aDAhd31Mgg96yodeoUYLgSsFDtBimQPic6WDvMOVUOYR1/o6BVxnwD1ycYT
         VKG+E6E6205keR7ccsl2+NDY/XzBPFYNqgv3fmE++SI4W9Fu++LzD/ZAWrk5BqUWpLuC
         DKPA==
X-Forwarded-Encrypted: i=1; AJvYcCU6dWdFPV8rsVHGeY14XuX94/xt9xB18wMK+IbFRmUgD0zCLVNt5vrXvok9oILCGBmHYAR55IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WQnGr2DZhyBJpDLFzPu5UlXYDrPXkrXUYA+5g8474qPxWQG0
	t3eO8JUMiQOikCm+FQ/WlqPLH4VM4H92swYHAh9Nm4aamaS4DSSkThEuDw==
X-Google-Smtp-Source: AGHT+IENt6VnrE0aUFNOWmLcvSgsV8s5ZJGD6414LG2whJOZY0T6yN3T2/bO5jLO5L/5U5Ks2fdBhQ==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-7192607fcb9mr2200779b3a.9.1726111258744;
        Wed, 11 Sep 2024 20:20:58 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc9c89sm3679015b3a.33.2024.09.11.20.20.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 20:20:58 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Clear worker->pool in the worker thread context
Date: Thu, 12 Sep 2024 11:23:29 +0800
Message-Id: <20240912032329.419054-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Marc Hartmayer reported:
        [   23.133876] Unable to handle kernel pointer dereference in virtual kernel address space
        [   23.133950] Failing address: 0000000000000000 TEID: 0000000000000483
        [   23.133954] Fault in home space mode while using kernel ASCE.
        [   23.133957] AS:000000001b8f0007 R3:0000000056cf4007 S:0000000056cf3800 P:000000000000003d
        [   23.134207] Oops: 0004 ilc:2 [#1] SMP
	(snip)
        [   23.134516] Call Trace:
        [   23.134520]  [<0000024e326caf28>] worker_thread+0x48/0x430
        [   23.134525] ([<0000024e326caf18>] worker_thread+0x38/0x430)
        [   23.134528]  [<0000024e326d3a3e>] kthread+0x11e/0x130
        [   23.134533]  [<0000024e3264b0dc>] __ret_from_fork+0x3c/0x60
        [   23.134536]  [<0000024e333fb37a>] ret_from_fork+0xa/0x38
        [   23.134552] Last Breaking-Event-Address:
        [   23.134553]  [<0000024e333f4c04>] mutex_unlock+0x24/0x30
        [   23.134562] Kernel panic - not syncing: Fatal exception: panic_on_oops

With debuging and analysis, worker_thread() accesses to the nullified
worker->pool when the newly created worker is destroyed before being
waken-up, in which case worker_thread() can see the result detach_worker()
reseting worker->pool to NULL at the begining.

Move the code "worker->pool = NULL;" out from detach_worker() to fix the
problem.

worker->pool had been designed to be constant for regular workers and
changeable for rescuer. To share attaching/detaching code for regular
and rescuer workers and to avoid worker->pool being accessed inadvertently
when the worker has been detached, worker->pool is reset to NULL when
detached no matter the worker is rescuer or not.

To maintain worker->pool being reset after detached, move the code
"worker->pool = NULL;" in the worker thread context after detached.

It is either be in the regular worker thread context after PF_WQ_WORKER
is cleared or in rescuer worker thread context with wq_pool_attach_mutex
held. So it is safe to do so.

Cc: Marc Hartmayer <mhartmay@linux.ibm.com>
Link: https://lore.kernel.org/lkml/87wmjj971b.fsf@linux.ibm.com/
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: f4b7b53c94af ("workqueue: Detach workers directly in idle_cull_fn()")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e7b005ff3750..6f2545037e57 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2709,7 +2709,6 @@ static void detach_worker(struct worker *worker)
 
 	unbind_worker(worker);
 	list_del(&worker->node);
-	worker->pool = NULL;
 }
 
 /**
@@ -2729,6 +2728,7 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	mutex_lock(&wq_pool_attach_mutex);
 	detach_worker(worker);
+	worker->pool = NULL;
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
@@ -3349,7 +3349,11 @@ static int worker_thread(void *__worker)
 	if (unlikely(worker->flags & WORKER_DIE)) {
 		raw_spin_unlock_irq(&pool->lock);
 		set_pf_worker(false);
-
+		/*
+		 * The worker is dead and PF_WQ_WORKER is cleared, worker->pool
+		 * shouldn't be accessed, reset it to NULL in case otherwise.
+		 */
+		worker->pool = NULL;
 		ida_free(&pool->worker_ida, worker->id);
 		return 0;
 	}
-- 
2.19.1.6.gb485710b


