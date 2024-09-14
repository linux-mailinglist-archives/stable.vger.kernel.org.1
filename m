Return-Path: <stable+bounces-76131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93713978EE8
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D7328A97A
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357E148304;
	Sat, 14 Sep 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PB4Qvvdw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2789146D5A
	for <stable@vger.kernel.org>; Sat, 14 Sep 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299057; cv=none; b=gW9qnvxPZBkfLvVAYwCAvlm/x6CkuJbpxUTNaa7+Ih9MHyeav+YzMl342dxXtXmSXjutX99cyKKSE6bflzmq+UgoPzUj8jnucG4S08ccS+DQJbjOUQYKa28vC78nmdTVSmOJUyXHPOR5+WsGkS/RyvM9CxyblFdJQ5HrKnCuAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299057; c=relaxed/simple;
	bh=NfYRJbO+n9KlpHo78YK1kJWVU0JEHSyMKcCC/4kPv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZULghLnmd58vFW5UMSrEsmZqKEU5rlRom8YflXEtoPh/yLIy2bTQf66AHBM2Tvow9TTn6Tg6jn0kN1Aaji3RJMHLCS8k3x/WBPe2GbShou/e0XAc0rTSHNiGFN9FV+5Z17ajklO6GQRy8yZrqoHMmvmWNUs8vzX+KTaJlFEfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PB4Qvvdw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717911ef035so1991851b3a.3
        for <stable@vger.kernel.org>; Sat, 14 Sep 2024 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726299055; x=1726903855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=PB4Qvvdwm51+gOBZprDFm8tkkOYMvdxGtcu/a3L47vXsT/g3hHUPcJEYLh+ZmSEWWJ
         XTqy1V/u4qeNrXYw3q6/HOxsOROKvgnNhAPV8pCPcjVRnQ7PEYmW18RnfDSKt8uYRcjr
         Iv0l+yRu9jLmkSRGFAClJHMShW/H6ncFlO8+NgDFbAas+6HyWk12oYDdVkaPiHX4dFNk
         bA/gtBFo0HkLbvLl208uiYIM/wpnSYoC9CghPGAsZkWz5BmylCEo8Wh4wtJohOT1TJvy
         VOGzSSkYfZOId6C3JaF5spIk10XNg+FhiXKAMH1fhJoyDT2kdh3jDvKFzVkG+MltYMeC
         r4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726299055; x=1726903855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqOMUsIf1mnLDxR4ticuxNbonVeXyKT1mpHNVeoepzQ=;
        b=J9Hrcse85Ido+YtPU8cDubSjXTPztBRlAPWAOcPowFR41IAy+hmvH47HmPtKuvgr5y
         +M81RaQp52qcB2oB7hGZJaPkPOt72BuhHhBnePceSbeWwtvy/Pw+e4rA/HujkP4hVyPn
         +QvqKop50bHvFi2WRxuZvfZydGU9s+pWag17bNbfxz8887PRIGb66nxNxTzAKTUUEmRd
         H8FSlXsVqDfLm7CnOWcnz9v2+g5Hlgv6i8c1B2dEb/PU0m9ugj2sSPXlm+0WPOAzff/L
         APIvNtY/WVUuQcgLBnxDCzbUVFaHDnzNzthuHdF1ihEQvtEJcYfH7uf8SKKq/g6N6Ox8
         pexQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQIP8mw6Mc4YeaLdb8Ao/2qdg9OYLaMabsEgTV3YiuauMRMPkYfnulAP1ai6i+DXCDI+i7lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsPPV4TafkxeRnNp5UnaO1OD6ht59GaU5RqLU4AHsAyzLunmu
	TEk65yd3N+YGLu72+tL8zgPArBnrd2Zk9L9q3HfhRH5TM6fEbqGdzneuSlqVQRI=
X-Google-Smtp-Source: AGHT+IHDTQbRO6cV5Mbr0x+fq++p+seJtKKFdtV1cqhsFN5NWwbtCCv5rOqEpU4gF1AdgNhIZhWkdQ==
X-Received: by 2002:a05:6a00:993:b0:714:157a:bfc7 with SMTP id d2e1a72fcca58-71926084bb4mr13041594b3a.15.1726299055036;
        Sat, 14 Sep 2024 00:30:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ac05sm555687b3a.155.2024.09.14.00.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 00:30:54 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] block: fix missing dispatching request when queue is started or unquiesced
Date: Sat, 14 Sep 2024 15:28:42 +0800
Message-Id: <20240914072844.18150-2-songmuchun@bytedance.com>
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


