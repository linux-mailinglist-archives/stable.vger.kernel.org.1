Return-Path: <stable+bounces-76133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80884978EEE
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E861C25A85
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD11CDFCC;
	Sat, 14 Sep 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JF69Bhha"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF61CDA30
	for <stable@vger.kernel.org>; Sat, 14 Sep 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299063; cv=none; b=sxfIig+urXmmic0qArVED3KqnlrKrNhC129qNPvRoVV0tglrb3Aa2pHhWER5IKCjV2/m+Aan/xioD6WOrlDhQZ2BbBIML4iVeADjRk/QZ8DFYmcz7wdXQsEJvyxieXdrOTD3JVYstgxR7GpRUyQtQFUEdKz8PHKzMYb0y9gD3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299063; c=relaxed/simple;
	bh=Nlu7sy6nlj6YleTyQBt/cJY6uYT2Pq2MXEk7kWoy/Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqSRVbQ5E5y3UK63mO2ilJDB7CG4xImrkRJcmuSPEdHUD7Fy8ysCJMZ1fHvVVtpL0xWvX8GA6LqmcjtHn/ZkngdfrVul1YYJR1MvBTHvul45jO9fun2BuQy0Q7N8lXBdy8/4BJWjP7mSfA6L465LQspLd1otbl2pSQcZqP9TW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JF69Bhha; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7191fb54147so2054567b3a.2
        for <stable@vger.kernel.org>; Sat, 14 Sep 2024 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726299061; x=1726903861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEcd+IiEv1ro72y/n/abcXpVwZU0hZ5zkZIt5HG485g=;
        b=JF69Bhhas/aaQMM/zk5S9sSa8XHiqpbOBP5yX16Rdhl8rAxwGrVqzw1Y8xNBrkc5E4
         ZrPJ+AzghfrHWxSn/YuJEhNENPmbn3GIFha1hGzkJgej+ARh6YylWKgiMeqtXaS5ap+S
         aqU9cIFUSh/1L2O8lAMYU0/LcLkHRFvGNDWq+rwq5fLOXTYbYwPQ3sVtLR2OUVQK5BA6
         UsYnHP+ChzErO+P0pLypgF9GRsh6gHiDwLHPphV8xXDuFnaiLS2LJhE8g4nIOQsmmP5I
         22hIKnMWkB00J6JVNBXXS/ioNE9TntE5rIEdwmcWV8BbeDhQsCpjrVNGZoLI0KwbhhHy
         BYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726299061; x=1726903861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEcd+IiEv1ro72y/n/abcXpVwZU0hZ5zkZIt5HG485g=;
        b=OsRIfCSiMfwoUd1OfrlqYW0E9hNHT0lFdYzcO31yjOzh98wtEBaeCHgRl8VY8HnEs5
         JPu6PEQ2ahdwA6pYKQdjR9VGL7koggsXbj0vEw1GDDJ74Ig0xYwuRRJvqG4sdzOVVXH1
         oDszSmMSwIOd+S0upTWpnTBlT7YZb53aqpKSKwWz36QDTLf7tSefAIE5xiJK9mxkFoTC
         NcryZaUDAhUu20RMtVq69bzh2AkipIulVDag+HkNaTRdVAB4kTGerfPwT55ZaFnOxrtx
         j+MAhhCCf0yHrp2TvCvPfOiLmIEdQMnJ2Mj7VP79OFzemWZOKrVel0YRF0qIcez7C/V9
         Bd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0c8lxoy5Fds+WLt2sxYLXk7VY65zaOuwb0uBNDiJbnC48SuFyqykvm4vsNwBMhcD01GMVkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfvcbbkfW/OoRJ9BIllafpWINOji+6GHpRaRGE6ZEo3YwcTAC
	PtoaJ/cMl9fkb/A9E5Ad+szl0HuRV8Uo9cZnguNGLV7NBKZRjRfnUMmLZso4wQM=
X-Google-Smtp-Source: AGHT+IHm8y07ns7Yps/Sk2jgRKzY5hcTv8FT68ZZZ+L+kPEqfVSn3egGBhElYkjQW1mZy3fYVyID4g==
X-Received: by 2002:a05:6a20:c99a:b0:1cf:6ef0:c6b9 with SMTP id adf61e73a8af0-1cf7624b46cmr15117559637.32.1726299061341;
        Sat, 14 Sep 2024 00:31:01 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ac05sm555687b3a.155.2024.09.14.00.30.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 00:31:00 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] block: fix ordering between checking BLK_MQ_S_STOPPED and adding requests
Date: Sat, 14 Sep 2024 15:28:44 +0800
Message-Id: <20240914072844.18150-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240914072844.18150-1-songmuchun@bytedance.com>
References: <20240914072844.18150-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing first scenario with a virtio_blk driver.

CPU0                        CPU1

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                            virtblk_done()
  blk_mq_request_bypass_insert()  1) store
                              blk_mq_start_stopped_hw_queue()
                                clear_bit(BLK_MQ_S_STOPPED)       3) store
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
                                  blk_mq_sched_dispatch_requests()
  blk_mq_run_hw_queue()
    if (!blk_mq_hctx_has_pending())
      return
    blk_mq_sched_dispatch_requests()
      if (blk_mq_hctx_stopped())  2) load
        return
      __blk_mq_sched_dispatch_requests()

Supposing another scenario.

CPU0                        CPU1

blk_mq_requeue_work()
  blk_mq_insert_request() 1) store
                            virtblk_done()
                              blk_mq_start_stopped_hw_queue()
  blk_mq_run_hw_queues()        clear_bit(BLK_MQ_S_STOPPED)       3) store
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
                                  blk_mq_sched_dispatch_requests()
    if (blk_mq_hctx_stopped())  2) load
      continue
    blk_mq_run_hw_queue()

Both scenarios are similar, the full memory barrier should be inserted
between 1) and 2), as well as between 3) and 4) to make sure that either
CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list.
Otherwise, either CPU will not rerun the hardware queue causing starvation
of the request.

The easy way to fix it is to add the essential full memory barrier into
helper of blk_mq_hctx_stopped(). In order to not affect the fast path
(hardware queue is not stopped most of the time), we only insert the
barrier into the slow path. Actually, only slow path needs to care about
missing of dispatching the request to the low-level device driver.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c |  6 ++++++
 block/blk-mq.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ff6df6c7eeb25..b90c1680cb780 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2413,6 +2413,12 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	/*
+	 * Pairs with the smp_mb() in blk_mq_hctx_stopped() to order the
+	 * clearing of BLK_MQ_S_STOPPED above and the checking of dispatch
+	 * list in the subsequent routine.
+	 */
+	smp_mb__after_atomic();
 	blk_mq_run_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 260beea8e332c..f36f3bff70d86 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -228,6 +228,19 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
+	/* Fast path: hardware queue is not stopped most of the time. */
+	if (likely(!test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+		return false;
+
+	/*
+	 * This barrier is used to order adding of dispatch list before and
+	 * the test of BLK_MQ_S_STOPPED below. Pairs with the memory barrier
+	 * in blk_mq_start_stopped_hw_queue() so that dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list is not
+	 * empty to avoid missing dispatching requests.
+	 */
+	smp_mb();
+
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
-- 
2.20.1


