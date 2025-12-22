Return-Path: <stable+bounces-203235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B2CD70CB
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 21:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3385E3001007
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28C1DF261;
	Mon, 22 Dec 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgHTrhDa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007791FC0EF
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434578; cv=none; b=jwh033SiZQ4nlPQqBFCpuvBY99OOnMXD4VqvmhproeqYNcEqYRSFBsn6Y+MTJUJPR8V6o/8RWOZbAsuubXlVIZPDYrpw4Lr7Mn9B6YYpcDLFPrOk6brM4sgLDUB+Qf4Y5UGjjzK7MNnGFpooSggLLYEzcQOPAvr774aE5r5XKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434578; c=relaxed/simple;
	bh=o+vEFROiqUoDAPTJIDN1NXPMAkTeLu+cB5g1KoffBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTuqpguBvMNt6QH6rtvNxW/JX8+VYofX6M28vIHJvMh701HUTfbgjK3s4RBQooJqcyYhEyh3F5XsbE/YtPBvDha9V3MuzDnLVHYJ2JLpgxTHu0rZTLmMvI+e4lJkRnw6vkQaMk4dqkh79CZgyL2K8QvSH9rQWKJ1cvmUh90I13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgHTrhDa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a2ea96930cso48665675ad.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766434576; x=1767039376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=NgHTrhDaWxgLy5d2rvpOBnTTvvfF1rnRysmlCB5uWDsfO9ieNB5TNv/BygfS9EW6Xj
         VjEUO68u5qGnDUmcw2Of2CjPodC+OyiLpGM1bMlXlFde30tuuGjrEV8X2648HElW8Y1Z
         1Y3KZpuzivSD+yvPY+bzJ18TrC+Khgve50tRNHEebwlyKtX5ORADT+ZKM3Ddhchhri0Q
         bkr+eZqpIRxoBCon7hs0qbW+HIwxFRnfB3CNI0/7b9mLzYH3jT+ATzvD2UvI+MW8Ka/0
         7ABxTTdRZgMjRayCCrhgG1pYQeYFiJAaVMkz406yb0hOlNHFnWScJ5C8uDpE8KJ7icYd
         me6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434576; x=1767039376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=r/tfDZtf2FMAuMZLEQfFCAVvFoEt7bi7IUAMaz2TjSh5UPk3+Op2T/xhZx2lpLN9Vo
         U6MO29VIZDz3e5w6U1Rg/EjqqJmU5CN6StoU/XyQRaHSh/lAIggRQjbn+Vj923V/MbT4
         GU4ICWZpCKd/f7P3IMrL7cPRvStnabMAfSOuaIzVdLQ2ZUhj/kY3OYVg5Wtqdiits3ui
         3jpcWfsl5b2cnGlpTieUMTlb6ZJE9VJmOGy/7Fj4xwWS1xWT5virMjfu9d3fdBmjsCYk
         Na8buK4aspYgmnoXlWWhlNsqkaSgsPK4cX7OXmaTR/xteZ/s5I30gIHukFSaPKcZhSH9
         yEJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7O/Ho0ttP87LIx3STrCUIHPYUrR+gbsIBju5p6DhyE5czAVnoLzt88LE80w9Mok55ephEt3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTaAb2NidGPmgMmUaAGcLTtQe3FOt7advIXrbUE2Wzdan4r4a
	fW52WttwR/Rcb03Kk16wrNXnNdn3WgvjGuYWgA3+t7EdMsyBx40u8xTL
X-Gm-Gg: AY/fxX6bK0IOMZWORz6s3HedDVjmvf0MXbl1ABqFkmHpAXfR7H9tc2LqHHvSY5jOXkq
	mHjR3648BYmx2GzKsoCcKjYpc+1b/5m1iLE0iPPWckhOFN+hBxLjhkNObq8MRLNLjEZ0N4fza3E
	YvBM5kbgSwuIgtpghKfKhgrKpk2o9uYhfO9SsOfeWczHQshlT5Drt5IlMfiOxQUP4eUF8WsBI/w
	iyknP8wN5w8AJQmqxsGDB/rIMQiaYHe6q4QN+Z3Ocg1Otz0O7FJptwZ1nNHORR/YYfqMlusFMBI
	lwxYaWIgXnRX7zI5lOdR6qPN0ZwmPzJuTUhJiWfXIK/pmjdlO0PQ4pMOGqyu/l3Nu3AovBVBLLA
	TfbyySAn3x0XM3mPvToiE/hU6z05BxpFHKZ7/I+/xQxT0mbepnFz1ifD5T/6u4/ViynLiEk2tAN
	OjZOa3KXjHHlR7wpt7NfuVdzlfF52zLdbn9gxLgRlAQC+b
X-Google-Smtp-Source: AGHT+IGGCPRsUbtdnSyNVH6HcSffxoPpOEnbF7UGpOntHaM5661Ya5XibckfxkPrf4FjkYaBiYk8BQ==
X-Received: by 2002:a17:903:120b:b0:294:def6:5961 with SMTP id d9443c01a7336-2a2f2840071mr108551835ad.45.1766434575985;
        Mon, 22 Dec 2025 12:16:15 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f07:6016:fa00:48f6:1551:3b44:fd83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f330d25esm104358905ad.0.2025.12.22.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:16:15 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Mon, 22 Dec 2025 22:15:40 +0200
Message-ID: <20251222201541.11961-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222201541.11961-1-ionut.nechita@windriver.com>
References: <20251222201541.11961-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Commit 679b1874eba7 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding") introduced queue_lock acquisition
in blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks.

On RT kernels (CONFIG_PREEMPT_RT), regular spinlocks are converted to
rt_mutex (sleeping locks). When multiple MSI-X IRQ threads process I/O
completions concurrently, they contend on queue_lock in the hot path,
causing all IRQ threads to enter D (uninterruptible sleep) state. This
serializes interrupt processing completely.

Test case (MegaRAID 12GSAS with 8 MSI-X vectors on RT kernel):
- Good (v6.6.52-rt):  640 MB/s sequential read
- Bad  (v6.6.64-rt):  153 MB/s sequential read (-76% regression)
- 6-8 out of 8 MSI-X IRQ threads stuck in D-state waiting on queue_lock

The original commit message mentioned memory barriers as an alternative
approach. Use full memory barriers (smp_mb) instead of queue_lock to
provide the same ordering guarantees without sleeping in RT kernel.

Memory barriers ensure proper synchronization:
- CPU0 either sees QUEUE_FLAG_QUIESCED cleared, OR
- CPU1 sees dispatch list/sw queue bitmap updates

This maintains correctness while avoiding lock contention that causes
RT kernel IRQ threads to sleep in the I/O completion path.

Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-mq.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5da948b07058..5fb8da4958d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2292,22 +2292,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
+	/*
+	 * First lockless check to avoid unnecessary overhead.
+	 * Memory barrier below synchronizes with blk_mq_unquiesce_queue().
+	 */
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
-		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
-		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		/* Synchronize with blk_mq_unquiesce_queue() */
+		smp_mb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
-
 		if (!need_run)
 			return;
+		/* Ensure dispatch list/sw queue updates visible before execution */
+		smp_mb();
 	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
-- 
2.52.0


