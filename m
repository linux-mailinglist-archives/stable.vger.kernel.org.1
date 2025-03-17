Return-Path: <stable+bounces-124572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01609A63D34
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 04:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AAB188E951
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 03:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844C20E03E;
	Mon, 17 Mar 2025 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZkvyFFjw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1620E003
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182272; cv=none; b=LRo9vatrA2VW4YRfTX+b8x/826Bmd5swytOEY3/3OEF9ubtIW/zznCxemDNRcXHAXXU2/dy8iTnE3mTifq7dARYslORgzIuI2LtZg5c5a1J0ixFjZCtCGnOY298szGnvPvMUXe7mhaInkqPujv9YSifR9cOu/dYbmlAg9a0kGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182272; c=relaxed/simple;
	bh=kudviMA1DuI2wDTYuDI7xo5XGTOqxOCKMoOrmMmPrtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6XlRhRWqfY4293UldGYVgegwauF5QLXgUsp11M9DfVnia2TnxwFyYerzbj18C+D338YWRnCQpJuTba8JMkBxbDGz9vYm5gW/VwP4grnscsSOGshZ8QjQH5Ze6qHMpIiuF4aftx2jEjL871N6+ZsJOjqtB/KfH7cV3jEgW3v72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZkvyFFjw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso1705014a91.1
        for <stable@vger.kernel.org>; Sun, 16 Mar 2025 20:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742182269; x=1742787069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTPlUFjuWC4pDrxdDLSuL+gQnvBdp180t1/ncGrM784=;
        b=ZkvyFFjw/DsIym/UsfHYFU+H29Snu+oqlMhU+0kPZ/lXIL5KzU5n3RBf7WDr0iAWr1
         ZFBNUEVBpVFgU3yjQTNpgXaq17Zck5MU1RBdDtdmNjf78HsRLVFIUj77/QUHeDVE0/Tk
         rDUlys+dpYhpRE5bdzzQUdgJ7HvJzACX1V4/cnqN+eB3O3KpJym71nKH7Er4imO1Mhx1
         2NDkJitaeQsBDhokEVThJf67rnUCm0TsmKdvHberSn5WkZuqJ2/7bHkPQOikfgCUETDy
         PPGvIkhQoLyJYT7fnhf1yTKSF9YGldhqkwQQbPF71A5mJV8ydKcC4nNoHhCwYBQd0jKS
         ofGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182269; x=1742787069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTPlUFjuWC4pDrxdDLSuL+gQnvBdp180t1/ncGrM784=;
        b=VIlB/RIounSHqwBrTWUNDZB1LAA088XZziO7iduPNLwZqdBb4SileAZz36VCQz1oJf
         zj1MF0K0tgmD5OoeN0JNNld+H32ea1VrXuRC/oqlPp/R3WShjREf1rU1phkDYpPwuEGg
         s5qKgZXJG8xUTrRY0hGVFlMMGf8sYZs1kGIZmaSlQK1MHCgC4xc9Z0qIYs0PDKWddEkR
         Fvj0gbZZnqmvqLERzoVquZ7QufsLY9Dht7HP2sUXAR/d8duCBmTWnAMwKSGC3JG93WTf
         IxkBAHsxan0K7KNSCfpEoyqUx+NAn7odl0dWCpuyNphPX9TjvMLO5fxzncVMvI13453a
         iyuA==
X-Gm-Message-State: AOJu0Yyt/qifY/F04YsxwoyFy8/pUiIZYaKKe7B02GlxeXBmSO32WEjt
	DDVGmC0CU332EoOES61eCQWs0sl7kiBJPdw9gUobELHvyuovKtjGF2iP6hN1wcCihEmHjrTE/NX
	d9uvtOQ==
X-Gm-Gg: ASbGncvboueq/FpPD8Jkaq14t/Znplh6P/BoayTLYgF19vpY3OLTGzFzvBVDJBEEOiP
	7NZZo4bSEXQoz1MzfVsdo5iXLrfuA7NHBdWPQ1J6grIKYkhw3HWNuznz4bGy/wb73HF0rMeWIaT
	LLwIUbY7Gl9m4woZ11pJqG/+22o8lSe3iAzJZ62h3De1bhljdgZBiXujBvLCKyUTVSWBPv7l2qv
	Wwz86yl2MX4x1mr0kixAnwQQanUuXcyHKvnsHmngbIw7w0+2ID2B9+2swvSXOBzQq02+mFztIbJ
	xMzQCCfA6axp1sRqEHunyCcFOa5ZMSKf5gbP0MYVz10h6fKaFw4bsY0m4QJ6d5CgooLh8QuoWap
	RGA==
X-Google-Smtp-Source: AGHT+IHGHDiJI9T/PDjuSYWEu4fyRaKBLbiMkdEmEMbJPbkkrtQJwU5SagILpTDTF4+mEoIuB7XPJQ==
X-Received: by 2002:a17:90a:fc43:b0:2ff:5357:1c7e with SMTP id 98e67ed59e1d1-30151d049ffmr13539315a91.20.1742182268884;
        Sun, 16 Mar 2025 20:31:08 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539d4042sm4865664a91.3.2025.03.16.20.31.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Mar 2025 20:31:08 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: stable@vger.kernel.org
Cc: muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] block: fix missing dispatching request when queue is started or unquiesced
Date: Mon, 17 Mar 2025 11:30:39 +0800
Message-Id: <20250317033039.6475-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2024120323-snowiness-subway-3844@gregkh>
References: <2024120323-snowiness-subway-3844@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                    CPU1                    CPU2

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                                                virtblk_done()
                        blk_mq_try_issue_directly()
                          if (blk_mq_hctx_stopped())
  blk_mq_request_bypass_insert()                  blk_mq_run_hw_queue()
  blk_mq_run_hw_queue()     blk_mq_run_hw_queue()
                            blk_mq_insert_request()
                            return

After CPU0 has marked the queue as stopped, CPU1 will see the queue is
stopped. But before CPU1 puts the request on the dispatch list, CPU2
receives the interrupt of completion of request, so it will run the
hardware queue and marks the queue as non-stopped. Meanwhile, CPU1 also
runs the same hardware queue. After both CPU1 and CPU2 complete
blk_mq_run_hw_queue(), CPU1 just puts the request to the same hardware
queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly()
should handle a similar situation. Fix it as well.

Fixes: d964f04a8fde ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241014092934.53630-2-songmuchun@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 46cb802cfcf05..a15c665a77100 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2048,7 +2048,6 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 * and avoid driver to try to dispatch again.
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
-		run_queue = false;
 		bypass_insert = false;
 		goto insert;
 	}
-- 
2.20.1


