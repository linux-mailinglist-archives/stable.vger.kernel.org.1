Return-Path: <stable+bounces-72775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BC9696C1
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C041F2698A
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03F20FAA8;
	Tue,  3 Sep 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XN9Jxqps"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0F205E0F
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351434; cv=none; b=NXpnIxLtRilTWBmPUGb0NqawBfl8wXVBMe0VoCt7z17fk85iHLGlg8fUY0FrR2mMslNS8SU2NsMc6CS5Sp7CBqVKVZtkO4TstadewrlXmNBXlTvzM0pMOy74BDymczjyEWIo6gvE1KSfHgEMPyUDHsOYoSyFmcpIVnGYo44HTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351434; c=relaxed/simple;
	bh=SDvrf8Qpiz7hwXgQkgMbvx6pHfwmjuJf1BI3qF5qsUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQiSR96Ae2JYq38sEwhzcNxd4lL54BvDR5zThXcsZfUMblpTrpPWs2blBq6HvCzVZdFfEJfymmYjzOkYwJDJJDfFfj/zOe0G0m5vl0Z+X2Z+u2qwn8gWoYCKWZYBawNFWz6c5ajU8Q2E2txUJBl00I4vx0ospTzUL1Sljs5MdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XN9Jxqps; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso19090a12.3
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351432; x=1725956232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=XN9Jxqps54SlOFrHvi6vO+cbKpfK3kPweI6WP6vaDsWZSIFMh+7VsAHJGJYxcMKf97
         2N/z8vP67KV5V6Q5CQn14BWkYGyVreexvTSgms5H52L96pvfEik9tdnq7Xpi58Rvvv8y
         tSAnBPGjEf7f3NGf30cEyvGrdf75SxS1V6d7pxDbx75SL5tEyUp7LYdxWzS9/eXBDcHo
         YLgosILWZaIPKiic/3n8VF1RIL8IiizgViTtkWKuid8WldJYFeCoE7r7z8nZxrkeiPF5
         Ct3QVu5mk52F6egzD1WJHFDYORDJ3G8ZFMH+UukSZmncN1//o6aVsmFdicgkWcGL94MG
         /yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351432; x=1725956232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibW+O9NpvNOI9jTnJvwxWKx05ZtMP1ehfDgoD0Cwn/o=;
        b=FpfGw/LTdDbXqcg4WRTdijNOowMv+LEveJu4Jitds+36gj9+ZvDspF/nDEILmPvf1b
         c3PnISK2rh7fYbCujssHKkN6Vc1DP8T4YeKhmFsUBF71Teeajs5qLMC9C74Yg/Pj1XgX
         9DeFysenlez2mR6xD3DA5KPr4ZshW5V/V1hkeqqCrFpKP9jHTduhSOLwh1XIQ6GDchZm
         byfps4UQDvg4qiOpA79BU8UxFfqtZCf/KZL+1qLliB3+E4aWZGSbtK5S7osdD8iPPooA
         8FK4wbSpF+Vgu9jgoUPQtnX2AgYoy9KLsVGRzL7ayfZF9SxBnwS3MjpyjNtrXFTrxmCC
         o3uw==
X-Forwarded-Encrypted: i=1; AJvYcCXX/YjZ18xGyM91UL/7mzObP4xgsQTo5LERyU2re6toBZI+mDeJCAt0hm0dsRAj0U/pM4+CTUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDDy2dycO/Ll78COTCkgTEA/1LAfU09JqzlZtrJfgBjGiVZKp
	uphSMWfWSfzbpjoYNT8iVDhq6qzJPpbnBppx/JIgKxpy4cWo96lNkc+7qEwrB2k7kuZRo+HAakC
	AG28=
X-Google-Smtp-Source: AGHT+IH8T062SK2gcp022LHlt/cN78AcsQ9Ou2pVs6Q14mJRrrNfE/3voyxn4xjoc1ocTKZsy05PnQ==
X-Received: by 2002:a17:903:26c5:b0:202:4666:f018 with SMTP id d9443c01a7336-20584193b42mr34059395ad.15.1725351432090;
        Tue, 03 Sep 2024 01:17:12 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:11 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Tue,  3 Sep 2024 16:16:51 +0800
Message-Id: <20240903081653.65613-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240903081653.65613-1-songmuchun@bytedance.com>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario with a virtio_blk driver.

CPU0                                    CPU1                                    CPU2

blk_mq_try_issue_directly()
    __blk_mq_issue_directly()
        q->mq_ops->queue_rq()
            virtio_queue_rq()
                blk_mq_stop_hw_queue()
                                        blk_mq_try_issue_directly()             virtblk_done()
                                            if (blk_mq_hctx_stopped())
    blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
    blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
                                                blk_mq_insert_request()
                                                return // Who is responsible for dispatching this IO request?

After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
of completion of request, so it will run the hardware queue and marks the queue
as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
hardware queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly() should handle
a similar situation. Fix it as well.

Fixes: d964f04a8fde8 ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b553..b2d0f22de0c7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2619,6 +2619,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2649,6 +2650,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return BLK_STS_OK;
 	}
 
-- 
2.20.1


