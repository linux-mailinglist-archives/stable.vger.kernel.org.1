Return-Path: <stable+bounces-203136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949DFCD2DD3
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B673303FE06
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8D3081BE;
	Sat, 20 Dec 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqTeyUF5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA33090E0
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228598; cv=none; b=DhyPcwj6K4fECpvq9zItg7g5++RUvZXRb51/ZW4rI9ZQJwOD/GjWqaUP5uOcje3klkU4C9jwKJaIAWv5NgGrBdmX5+OmexAvjbd91q2rjTDp/DEGyUNUs3coHBGZwvm1kTbGppXyzjAs0Fv9POn5IY35ppJRTQAf8nxaMxma5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228598; c=relaxed/simple;
	bh=o+vEFROiqUoDAPTJIDN1NXPMAkTeLu+cB5g1KoffBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5NAhFiVbF8NiYlaaBjo/iUb9eiUu+EpQO9r/i0VwY/U1EreTuy4RgvzyKEB1L8eyy4mcUuarkzkp87K5TSFODuFT3UVOCG5pALQYEeBdlRjeEl1QIKN4XtDlgGP9qN5qFNqd4oqBinjJTHrSSjDox0Qi6TyI28B9OBHE33vjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqTeyUF5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1716678b3a.2
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228595; x=1766833395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=SqTeyUF5qSB0bWs/TjWh+IANzwyLtcU5nZKbZVxUQ4kIZfqGv7kp5vMG8qM+rxE0ff
         y0j/WO3b8WIM34PoCjukuO8+TFJc6HU51pbvTkMlDlUj4asMiiNy5ongYqZ5xDBPvYRe
         WayxD91Nlo0j2m0VptnpkYIo4ITdeJMBtVXZMstNL5uRIid0soNprtOkLSAUnploWrko
         6I96mKkmgIuXkzcuU1rinI9xp59gxKVxb+6Dgptt/Zi0M3f1l9TlXnMdVt7iv2VQ/2M2
         dIO88u5sXC4Nd8jzeGlHAbCSPvb2ERUiNIxd71twmGyci7GbwHAwq01eCDlpksiW9jg5
         88wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228595; x=1766833395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=oe5JQWvBv0IuYuazyIwI/AXPE/hwjdTIMFTpriCbXDCyNZIh3F+mY0R4DcTn4T0bR7
         hBZFWFB+ugxm/WGooZyGuene4Cenu5ElDmorIQujAEvAfRIKUUsdWiG68VczCcL8JRQj
         k8HTE0dcIbV+YUUaX7eJJ43kzS2Vv2aLqdLjAm+r15Zb0OlsYucRz/L6xMJ4YF0IPNcl
         0pJ+dfVSqYwiXjRFydRqGL+6VRkUKroyfh/umrqxmDL/2i77FF2r+2pweeZ1JB03/+KB
         MjzadotQKwuI8dcInHuWJGcqQc238QX8vKRjlK1uRpJSqXorOE8MCwyB0yWDGAC8rLSZ
         o5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXIHMHg5OStdlpMp+Idmf4Mtg0UBP1+iB+jJ7aEhNAUMB6Vo6PL68KX8TC5eS8u7KN7Z3XtnqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvyRkkL3E+6plRrKM6M8pFSx1XqEc5HRHUVvrgaRY5R2sNRts
	84fvqU8KdliHecQXWNq+Z4JoMFc2piUD36Q8VomEvrEvDs7qR36mrmox
X-Gm-Gg: AY/fxX59sCCP7oiVEWjYmypPHHS/Xe68ddbhe4Q+4Bvf5j2YRfSdcRWtqlVXRI5P3ru
	HyPS7iQTGNUPSBsn+6gmoWrwYQkgRecu32tXL6B2Ds+8dylJiDdeAZl0aSu2wXaMXkUJKZBd8CP
	EndL9ajXej20W3KmXKcR/2EYwKMnkU82fgEYPL6Sa0Ux2Z82DqUbSNdilb7a+78QxSkPvwuDqsa
	GDQ79Q6qvCJo355JfWKfZeC/Aofyq8LbhdjIFf7nhTboD1POTUKycVP2xF/wcB/zOnHPLy//EtN
	kkuuF3dK1/YSmNjb0Uc8hwc2pdzXU1E2SjbdEl5RRVMRGmdzX1LFKqyfx+9xTSIy4EyqFXUptcn
	3GxO2Wq2QV4SiY5x1ZmBLcfsDhVSbhKIpOMqhZ2toAvmzGmCITL9GZiJlhzfS32a5T2iRUQIOfn
	fbGXt+Vyw35llO9hFsUMYKlSNqdkJQ7auUQD19X7g4q6R6+lV9DhM=
X-Google-Smtp-Source: AGHT+IGbAZ0JhMv5C7UPQHUgypPKxamy+ux8uZDHLsQ7+9J/dXNnA0eGTxwDCnt+Pb+rIopbPEgwTA==
X-Received: by 2002:a05:6a00:e11:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-7ff6421137cmr4854852b3a.12.1766228595290;
        Sat, 20 Dec 2025 03:03:15 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a84368dsm5015547b3a.2.2025.12.20.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:03:14 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Sat, 20 Dec 2025 13:02:40 +0200
Message-ID: <20251220110241.8435-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220110241.8435-1-ionut.nechita@windriver.com>
References: <20251220110241.8435-1-ionut.nechita@windriver.com>
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


