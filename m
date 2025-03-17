Return-Path: <stable+bounces-124611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B9BA64357
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B566B1883A44
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3EE1DE2A0;
	Mon, 17 Mar 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UYLrr5vq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B761D9324
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196050; cv=none; b=Ooygdxls3EpFA9N/iqfYeTUiaSWvec52zJ0hwP2gbcXddOGs5Z37OnAONTF9cD5K4Ccf7QGtXNU7l7ztqR5ftEO3jM4A8zScX7+cxkBNdp4VRQ/xM31tc7A39tkJUfPG7Y+h8CWgofPyhfmkVWDyRbcfhdPLBkgeeWIHtI6g/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196050; c=relaxed/simple;
	bh=EkU3LmWrXJ8xPmTftOyGBGTNA7Lkv9zQxh3xVlBYFZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnp21FmBqu9vlyhOwYATEPfTuNmPN+28Q+xoNxuPnUEqnN3k+fenBQy7out1GvpeRV22vckfsR9rtp6+i+cxJjI9+x50iH8noZQulXQNpWNp79rPIJX297QAcp/RoC6Gen6WW7FHWBc0qtjLYnhoL6LowANlo3YkTUV/qLaOKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UYLrr5vq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223594b3c6dso78376865ad.2
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742196047; x=1742800847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzmAtzBtZEPUysI2r9KEIU3Wcwsb6Hl3wXRjg6svhnY=;
        b=UYLrr5vqcvASz8v3YcdufrhoYhGXukQiRFnaYI+zsfrl24UVsSroeZwL+Mqhjklo5x
         TKbMx3f3kCqaN4pJ+iHlEQ77RT3ctsdY74qw2uLnwgJJxBABmjfnRL8VPE4IfyqRvja8
         UQIAvOxN8qXwYj2dHQgjdZkdKqNOkTlaGzCOzmiEQu53A2TXRkTgPNtMRmAQpLQcHdVF
         bmPWTJjZ1iRrvS3DQEnPx/vg6rOO28MpesD83BfCtP9/gZyhYvosQsl8kGY+XqD8cD7W
         GJw/PPFJKgrK6NAkWILfdbNQLlrqDFW3W+vKHsHn7RSOQCagdCH6b2+AwRF6c0NegDI7
         U5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742196047; x=1742800847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzmAtzBtZEPUysI2r9KEIU3Wcwsb6Hl3wXRjg6svhnY=;
        b=KW8h13RYFG5ht1xsO1TQPuftWBBXSaq6cXiqpslQMz9PPSNbv17bdX5a+2IBNSeIcH
         tpE2I+XMcjxO/g5qVvMJSPYCcaOkVt8Dcbpba4f4KJZ00v2MP/WYc5kNoyXWMdD0+PFi
         lYFxwJ5YKRWnjlXIbA0K377HdXIhV4qYOqIvAFvibpXSNJIdWBG/Fh42BaOkJ51F7ApV
         pVpS6wIfKALh9nYy2Tcz/aa59S66kwzUQKYwzUe5hTNmFZKxBnHaPutjdLW1b97NODAE
         4c2PAn5ilNBBI/ATBiTy/QoN7IjKKtamPwz+TkgATA/7F1ELBFzsyU7vZQkeYQioLPN/
         WEiA==
X-Gm-Message-State: AOJu0Yz+ADIuAC/94edL2ziCZCaW/dU7ICUsDx2h7sUBRPZu1k7h7lig
	K39xoj9DgKqChE5l+/mRFp7evc4VYh6upTXxd7/p2aGztTDaiSWQC+0Bt1BzwGRi1JnQ+dGomO8
	lBAWLTw==
X-Gm-Gg: ASbGncta7EsYIKRQxNC2FB0qZTMVhRcj26uspeFtvKLeEHOZbC5HWvc8nGg9heOxl9/
	UwpyMZ8ViPHPyy8sltXazPObCEambNtAUy8vHVGauzs7Sr0cvOa9emXnIYLfBEMGwTHozpvjGSc
	jUpXKWJ0MXi6hC0hic2qwPIQgLlEmSZlUVTD+DM+bhgD9JJIZV7mfWU6Ean7Du8aF9ATevWBVBC
	2AYIAQeObRLBiJ/3Vj121vS7RCBA2p9cq76HLvi25PXyelHrN6EJggDVZutkDeM1UOYJHppE3pX
	I3QipH76/8vp22cxmW2Xuhpaoj3Qugb10PxvORTp0XC4X7kga5PLSPYun+dKf48vJ+r2W8wVzFI
	XHw==
X-Google-Smtp-Source: AGHT+IF2ot/JC5zmDfcpyEiFUi1MZEA72pWiN/yxVe/8ruF9mDhKcdsKchWy52vV5lxWhBd5hoEIaQ==
X-Received: by 2002:a17:902:e809:b0:21f:988d:5756 with SMTP id d9443c01a7336-225e0b14f4emr126450695ad.42.1742196047128;
        Mon, 17 Mar 2025 00:20:47 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbca77sm68127875ad.167.2025.03.17.00.20.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 00:20:46 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: stable@vger.kernel.org
Cc: muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
Date: Mon, 17 Mar 2025 15:20:21 +0800
Message-Id: <20250317072021.22578-1-songmuchun@bytedance.com>
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
(cherry picked from commit 6bda857bcbb86fb9d0e54fbef93a093d51172acc)
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


