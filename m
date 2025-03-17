Return-Path: <stable+bounces-124571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58715A63D14
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 04:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C1B188D24E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF362080FE;
	Mon, 17 Mar 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bsVba3kB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1082080DA
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182205; cv=none; b=e+wOxuJS883ZpWYw3qnK8Jf6MvktpuBN4axjSF60xyPSROjPxVC2Dic8fsYpgsHw8TG59YviU23WxH215PWSYgyDWSsIt1NgZ3uR7MrJJupTeUQSg3HbEQ3ZYdnKv/tHOhrG/QDCVZNDZuhB6UivAWCK0kwZ8xcQ0VsqWtaYd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182205; c=relaxed/simple;
	bh=LzVprPYZ1GziQTm61u/Ebv/c8T9NMrKP/bERDV5bs2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzcPUsoZQgrIwOdsELP011ovP1l7n+UxikqYqzcVn+HOWn/yuZySmZtmA+SoeB2zEOkqxmePBuuGPu1jtEsn0cJec4G7Q1hDYtg99D7Zi6HNkR0cJlUP53NiNpj83GOXgWZPTlxQ/vN621faoieF/lCk857E9UNNsCAvJF0XcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bsVba3kB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so2770478a91.0
        for <stable@vger.kernel.org>; Sun, 16 Mar 2025 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742182201; x=1742787001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPRTr3+3Y+KmaghQeMayzzreYZtFvdiskKhR6hnY1ms=;
        b=bsVba3kBdoTaNoiTub8TWQ7RYIngBluRWElBaQOZ1XH/6Wr9+rgdZPpWwMdn5iNw82
         1kJr88s07mzOwRWTCkEWk/Ou16NrrA5eRBS6Djg3GIM20gkJ/98quq0+RX6qQi1yf5hX
         U37gZamNYW9Zw5lFmoZ29AEmWVvZ///Oid54oQ5KMTssytge+dgnrbqo6+kuOgyukiXg
         MmsZdra6cl8XvW5rvHyKVjt54LsaMVibPzKz/7T9bS8pUR0YCvUxPEuUfUDiRu0vrLux
         zdGcZJ413UvfrqMxgnaX0fxSr41fO+h925A1KRLaiiFX7zVXmxgkwmgHE9LLUaNNyQBu
         KjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182201; x=1742787001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPRTr3+3Y+KmaghQeMayzzreYZtFvdiskKhR6hnY1ms=;
        b=rQgWr8RgYR/fAgNdiOOvW8jD/C0J9BaRk4DAG3rIsnyIyYSfakFGpDYedbk8kBvWNj
         jcR8Lv9+50GcbxIUfnzesddqBz6BjbBaBXtExYksjZGrOhugjtT1RAqdpYtGw+OZgZ/l
         z62PFlLGLhP21/oDJqYiUyJw323OjhLhCs2HaVMnXhd17BSKt6zDUkXmsyJgkd3HQaWO
         +QM3bznT/tvi/WiZpNU+TABBT7Zqm0m8I2TvhGfQjXvSS52uj9tK+Sz402oHgFYE5FWm
         i1za/kzNSps5McOoX+BQis0d5H935v7ApLUGJE8+18cC2WA6KZW3PQYXOe+1rD6V1WuM
         x1ZA==
X-Gm-Message-State: AOJu0YyyPdUHzZ5pIKXVqOsEZdXPY3tzwi2jxJcF2Xn+hUYFP/HoR0S+
	7Hp8wnJMzukhG+Q+SM+qcXPMwUnXcIiOe1Sg/IagAbsVUFf7lSBZ8Y2CtYZWd7/zmQpvn5vyOQq
	MoXKuYg==
X-Gm-Gg: ASbGncsh5w1tUk3ErM0RU0PqsGOAF5APNyC7ahx2U7RTpOsae2UXmpwrw9uwoD9f9Vq
	3FxnKZYDtweJfcLf/VSI4qkvgXxhbSUXJEf64iSRZH6cU9i9bfyuVKI0chVZNJxYFCMTIqWgnSk
	0NaxKHs4OWHh7cdkGHSfEmMNe4yKIjOxPwmp4i+2yNlkUJ9z1woR6q0JsBgXEcsF1Q/n92psJHu
	SUiKG+HDr0qzWxjm2sbGifrnDw7sNJOKqAWOANqqpLNtIR0maT4kuwWbqNYHodIEbL8VnfaFDRZ
	8n2W82+mvnJ/6Mf9b1GCAR2KDIwZZCPbUCacn1CS0H9fML5E3aBQH5y1/kJ1OzhXJGtx8e4PSBZ
	okw==
X-Google-Smtp-Source: AGHT+IFyFF9Q11GbwFeSvyCDmIhDMh8BqMzRv+6bKamQnsIFpjhfuzLh9kFA3hJY/NNsiMA/xxm5Yw==
X-Received: by 2002:a17:90b:5387:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-30151ca744bmr14965634a91.17.1742182201500;
        Sun, 16 Mar 2025 20:30:01 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363217dsm4902784a91.32.2025.03.16.20.29.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Mar 2025 20:30:00 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: stable@vger.kernel.org
Cc: muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
Date: Mon, 17 Mar 2025 11:29:34 +0800
Message-Id: <20250317032934.6093-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2024120342-monsoon-wildcat-d0a1@gregkh>
References: <2024120342-monsoon-wildcat-d0a1@gregkh>
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
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED
is cleared or CPU1 sees dispatch list or setting of bitmap of software
queue. Otherwise, either CPU will not rerun the hardware queue causing
starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to
synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since
memory barrier is not easy to be maintained.

Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241014092934.53630-3-songmuchun@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a15c665a77100..3db8cc6b51fb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1610,16 +1610,7 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
-/**
- * blk_mq_run_hw_queue - Start to run a hardware queue.
- * @hctx: Pointer to the hardware queue to run.
- * @async: If we want to run the queue asynchronously.
- *
- * Check if the request queue is not in a quiesced state and if there are
- * pending requests to be sent. If this is true, run the queue to send requests
- * to hardware.
- */
-void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
 	bool need_run;
@@ -1637,6 +1628,37 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		blk_mq_hctx_has_pending(hctx);
 	hctx_unlock(hctx, srcu_idx);
 
+	return need_run;
+}
+
+/**
+ * blk_mq_run_hw_queue - Start to run a hardware queue.
+ * @hctx: Pointer to the hardware queue to run.
+ * @async: If we want to run the queue asynchronously.
+ *
+ * Check if the request queue is not in a quiesced state and if there are
+ * pending requests to be sent. If this is true, run the queue to send requests
+ * to hardware.
+ */
+void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
+{
+	bool need_run;
+
+	need_run = blk_mq_hw_queue_need_run(hctx);
+	if (!need_run) {
+		unsigned long flags;
+
+		/*
+		 * Synchronize with blk_mq_unquiesce_queue(), because we check
+		 * if hw queue is quiesced locklessly above, we need the use
+		 * ->queue_lock to make sure we see the up-to-date status to
+		 * not miss rerunning the hw queue.
+		 */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+	}
+
 	if (need_run)
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
 }
-- 
2.20.1


