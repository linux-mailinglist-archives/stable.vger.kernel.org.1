Return-Path: <stable+bounces-124610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0CA6433A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B266168833
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966221ABA4;
	Mon, 17 Mar 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lk9RwNIV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D12215046
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195941; cv=none; b=s9e8pyiKQKUImeTA84LZPc4vXQvFsBfyp8Z3uRkY7c6I9FuOxm0gLHqW7zO33P30O6GX4DfNKzpM11b+9Jqt/OKIXnx8C2hOke/02ZtagV001uTVV6WUBhTpz+KVyWvshLh9WmAQQojDSToiZwFFNBerKEY9pfGFvbbUsurlsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195941; c=relaxed/simple;
	bh=Lv+WQ1ZxB2m63z9sPK5atDsi5HCWR3guGcOZF9xvoak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sm/TOecA7zTJXHDEXZ9oxXGiLD/OwuWWRj4b1+PKna69vaOpMrmYI0vczlLAULAvNaRfi3AJgQeur+kKwE+ciqPGAtDG02dU/3qvZV9bGfQmuneqXGqM1if/cVrvQ9uWuN7jeHVBftUFaxtcBj+zGxPu5FrAD9UHrSTuK/mDcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lk9RwNIV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso21719425ad.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742195937; x=1742800737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORxkt9MEvG6odcaKIZrmr6gSHyjIxXPlZQh0sCay6hs=;
        b=Lk9RwNIVM6o3j+wgRK0KS6NCbGWlotGO3KP+/hATCb7FssZ55vVbbQ8xns4lhgpnnq
         wlEpIpBoCHEtemv03dObf9yu0BlOuzsr8mMDgKZmnbgSjem0NI6S7w05uTfZXJ4gOyHV
         Xc2G5vL00khXg/afCfFUxbyZ5Ku/r03F9pojMrDPaF9Jd71+2U7PTQm5nuMxv0XEUrZK
         3ol5Jnd3xktdMUUUXFHCx457VVigH0WRYjdt04ewlXrW+fOcUcPFXlTkoObwNDGC3i+D
         yclZ1cTqoVZKjY8YdEIjs8RFA0kRxNkEQpIz/Gxb/uknqcoDkIKS6OvXbpvIldUmOYm7
         ezCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742195937; x=1742800737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORxkt9MEvG6odcaKIZrmr6gSHyjIxXPlZQh0sCay6hs=;
        b=oebkmHgvgJlYWaB8NPzxAaIo0aUDONu2wt/W93q1CE/zE0S1azCpiOyLfrhG7UiUe+
         dOrbcBrj8nr+jUFyrtWufbNYN/0I0YDUjLxAgSYFLRsIawLWUPNbqmdUfJ59dCa4SjeW
         aNH0/8rEWEn9I440yyECj5LzwM4Unryeax/4dctO9kEhnMj6KqnNOXrU9sRvyGw6eiZt
         t1/gYwx3gY4MyI7QjNInpMulZhFGT+xiDwB06tMiZctVE3oJUt90Wgr8QHPbR5UJKftm
         3vff0AiCHMt2jUYWOq8d8bJ1OTnDaWfY8E8fb4X7js+T7M8a6r0OaNiuv2K8nvh1P8kG
         tYAQ==
X-Gm-Message-State: AOJu0YyCrahTvE5KIQcpkBjXe4RE6JCIE2xKvF8Yvh6AKEGDmVbJHFei
	gh7KIJv6CYCReoH2M/8ksSvTiKDykXoMRnCf5bDsghPdyjY0nFy3ASQL3wyV6hKv10Dv2D1jnRX
	H1DkM4A==
X-Gm-Gg: ASbGnctS1R+qrFN27guEw5TH1086VWuQbGDp5QyRiHWx6z+idb1YQgMSfZvxp5i5hwx
	Ky5AsPUR4xFF8hEc20athTO6nkYHU03mF2kve30KBagXQEVvyn8eFcB5c+FqJcF9xgNy0g0HJQ6
	PwAHC2GEJHpCEgmVE6TVzZHX9AHUfM1Z+QMKtNdXi2UnbXrUMuoZ4tf23A0TOl5nIwAmGXBTK26
	Q4Xf57ILojHQgCuyj3L2kmu2idIQahclm8t0vbp3kgft9YFlit8zw9+t0gx2QVnGRAUHvlJSMhg
	5S9i/Y1M8rfBwRYMsfmCmzEX4gtLHy15SUV/m7KRJ3mDwzpSFFqpeENEBEr6IF42Zot2g9ABxkA
	pW+nWpzd1k1k=
X-Google-Smtp-Source: AGHT+IHQfmRY9CMJMqATM+q6HEV0EXa4QO41oYyPvs9RxL76xt2cup+5WXBhVcRlZOFT/V+gj5qm0A==
X-Received: by 2002:a17:903:2f8a:b0:21f:52e:939e with SMTP id d9443c01a7336-225e0a8eaa1mr164454185ad.28.1742195937492;
        Mon, 17 Mar 2025 00:18:57 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbca45sm68069985ad.166.2025.03.17.00.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 00:18:56 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: stable@vger.kernel.org
Cc: muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] block: fix missing dispatching request when queue is started or unquiesced
Date: Mon, 17 Mar 2025 15:18:21 +0800
Message-Id: <20250317071821.22449-1-songmuchun@bytedance.com>
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
(cherry picked from commit 2003ee8a9aa14d766b06088156978d53c2e9be3d)
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


