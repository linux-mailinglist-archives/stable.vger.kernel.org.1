Return-Path: <stable+bounces-83760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9899C5C9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7BC1F23D7B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38281591EA;
	Mon, 14 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SXF2Ncj6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00705158DD8
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898371; cv=none; b=g9pqIS92UUYueDa0OADhN2Zj0MwlnM8OvcOrk7cEOJhBrGfwXj0IerNVXPtWgS6iSTASd5kD2k/bPLCcZQtZgjalG1hGVtyiEiFJT/8WBU4WoMdIAu+dhMNmia81HzCxDziQ6ktI8qKgcfAzsuUz+YFCf8hZfMlTUZgD/En2ECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898371; c=relaxed/simple;
	bh=KPYlAEycxQewUTOUahfTRncxoD2+pw617t+q4Tal4uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUCYC83ZzyRD8BZQZiddhhxAoR4nKJ1wvIrd1pnQORvTQWztCY2kcnFAkU/N8aOZRvq1Sc5olvI0KP89fm70vU18MURL8ahGzDO1/k8wgQtXLuFTwKy0aHINM6UYU5XYgZwWsf9YJMd6T/pi59C/SOam+jxy0tHTxy8tWzr7Sbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SXF2Ncj6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e453c7408so1564481b3a.2
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728898369; x=1729503169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=SXF2Ncj6g9TFV6T6I8WCm2zJGEIq+Ktc6KmjRAaO4i+Dy2SycqoTEvA5UHe48HApJk
         PRfzmOOuh6JgxPY0cjsuIVz/svvHGnxtTzM2UtlZrCvAzy0Z5uRjc7vuYAUnLnEuuO+r
         gMwNSKF5e55VGPoaV1mn2TUM3TPP7YMG31R/A3YJdayhJVoLPlZCnBgRmo+ThN2MOuPo
         pXxFIVR0C5RidkPJs+8eoF3WoARlNUQS2PLg8AQ7zJ2Nes/qmVPV9u1hXmmw3pHjSxsD
         jDQlVInhtoUuPyQnznQipG/rrImp+WUy1Bonyu+SxQwr3Z0p8rFYNiKUXxzoCzu1ATtX
         onlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898369; x=1729503169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=iqr4jHdr0TxVG7BLzjkby1kft0TUEHgoJdfHvFDrp55byEpC5QpDScarCtVIEvzhFZ
         cR5LWIP7TBeF64cuwVl2gUak6fKBZiHL1G/48329v4WFLrGZtFmr5K0YgJi2FO9/ldJa
         8EyeD6VDiQaig1SE7A9yIzmme4A7IHVsAQyVvmHoW+sFYOKa+7q0FqJ2EuYICshIZCul
         PI3e99bmIU3Ge8I5gbu1jOFw9GOAaNb7Q/eR6Pq4yUuDXmz5pBRcvA7CTopOlnLy2cje
         kvGjPzj+MQEO8WsJizR+O02ZK4xboRghQfzG9rGSYAJRl67NT4JvL2s1saGALTda19A0
         xzQA==
X-Forwarded-Encrypted: i=1; AJvYcCXaMJd27ra1JK7GKUyXRFMFZ2HGLsGQ+e1NZ1TA/bRVoGfpUolOiSttkgrfjocZWci5qzPKdxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8BOvjR+Xx+Z0j7urNY6Njgk4hw8xclCWq42vuxldZHoNs23J
	xbeqhvklL5n+6e0lbvtQJKTayt+NdavigU1cCsDRll4owcY9cHFi6a/HsNGI+HQ=
X-Google-Smtp-Source: AGHT+IGBMDRNMKLO//5sYGfMXInq4aAF8gwrpnqlC4y4fsMFrWqYiR5I8wa6nev+Irqz/anUVaW0UQ==
X-Received: by 2002:a05:6a00:23d1:b0:71e:3b51:e856 with SMTP id d2e1a72fcca58-71e4c13dd24mr10888349b3a.1.1728898369262;
        Mon, 14 Oct 2024 02:32:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e60bbec80sm2339338b3a.95.2024.10.14.02.32.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:32:48 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3 2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
Date: Mon, 14 Oct 2024 17:29:33 +0800
Message-Id: <20241014092934.53630-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014092934.53630-1-songmuchun@bytedance.com>
References: <20241014092934.53630-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                        CPU1

blk_mq_insert_request()     1) store
                            blk_mq_unquiesce_queue()
                            blk_queue_flag_clear()                3) store
                              blk_mq_run_hw_queues()
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
blk_mq_run_hw_queue()
  if (blk_queue_quiesced()) 2) load
    return
  blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not rerun the hardware queue causing starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to
synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory
barrier is not easy to be maintained.

Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..ff6df6c7eeb25 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
+{
+	bool need_run;
+
+	/*
+	 * When queue is quiesced, we may be switching io scheduler, or
+	 * updating nr_hw_queues, or other things, and we can't run queue
+	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
+	 *
+	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
+	 * quiesced.
+	 */
+	__blk_mq_run_dispatch_ops(hctx->queue, false,
+		need_run = !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx));
+	return need_run;
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
-	/*
-	 * When queue is quiesced, we may be switching io scheduler, or
-	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
-	 *
-	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
-	 * quiesced.
-	 */
-	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+	need_run = blk_mq_hw_queue_need_run(hctx);
+	if (!need_run) {
+		unsigned long flags;
 
-	if (!need_run)
-		return;
+		/*
+		 * Synchronize with blk_mq_unquiesce_queue(), because we check
+		 * if hw queue is quiesced locklessly above, we need the use
+		 * ->queue_lock to make sure we see the up-to-date status to
+		 * not miss rerunning the hw queue.
+		 */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+
+		if (!need_run)
+			return;
+	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
-- 
2.20.1


