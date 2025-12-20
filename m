Return-Path: <stable+bounces-203133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6421CD2D8D
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6297A3010A84
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A62877EA;
	Sat, 20 Dec 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEf6wFu3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3083168BD
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228132; cv=none; b=fhvcYZ4AC+fSsL6eYDJaVh/siaG8ZA4E4C8M29f8Em74hiR89NIBgrNq346sOg5fpvM+vt/3AXipKqNXqGn37iy9RfDcw7nVGNfdGDYP9jcWoZWY33L+W5PaSS6FBwoRLwAIawSDnDqGWyV6WslMbgyDrXYFuAa/zN3PklC9dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228132; c=relaxed/simple;
	bh=o+vEFROiqUoDAPTJIDN1NXPMAkTeLu+cB5g1KoffBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcZ30kxux7iXmD57EALJ2mxlAy8zBV//tdyDUEDImaGoKzV3EMBxywBMBeV7fDNEo7jmgftZOG1HvC/HYFyD4kLSEz1hwP2FufyEyXmo9gR8W131L7ZuhWfYDwHcoeY/9TxQ75YN+mfJ6EAHzDDO9xzddviEMLltb9LXkLN36uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEf6wFu3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso3683976b3a.1
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228130; x=1766832930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=YEf6wFu3O75GYsV5lUjhvtvGRvpGIH1r39J5JkHOO/ckUJghuBesIIYxEddnncxv6U
         u9nYFYId1z3ToSGzvR+HECTcHYgRACdpPIHwq3zZgSsIgAcTITG22rD17V65tiWUUjMF
         jLJLGooXhl9St0kqY83P4klI3s+T6sSpsSrpPTP8t8njezbmKZ+tqctg+b6yiycRHAWU
         DJzT9pA3Fxmmre3bS71TkOZ5TRf3QBLdP49kT4G6sfOXSkwTkAw0/eyJ0t6WV629whS8
         crY1i36cDP3lKppi7tPRsmX2aeqzW/puz6kZWJOuWjNnO5QSc80S/CAJYx0NS8comsmj
         SWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228130; x=1766832930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmUq8CHI3JkNtGWiGFMZyA0zmDp2QcgRy2thJxu/yXE=;
        b=wXHZdevTHGgZc+dx8WpSe3e3m9q5O8s+wc2jn6B65HbbgdXoQ9c1GnMzwnZSk2nuXf
         3TqvpZIYZ7i6vvZubRBn+zRzrqqXMV4GbBcoQPMWdPgBi+ikHD6AycsaW9LbJtGyCjAo
         7h9XVgKuusx8r6XrwEWbu/d6x0axlQCONIDiFT8gqcDmhy+apvnEZvtQDKh3jbbadhy2
         /9PDu7XLCmIkwORK7INrxvB2adCfvfeSdE6wuDAz830aslAVbuDWCzRmAwTiswx+Hyvx
         wdCI/LIBuVBF0bNVXLYFCw2emZ0COK2l96Z8PGe5H8Xf2H4mYkltj/oUS8fBb8APC4h5
         UVbw==
X-Forwarded-Encrypted: i=1; AJvYcCWKPAFBPFXFB1nbKDHYBeZrb9Y6QYV9rzSUMacXliMjMwKzAGcgLei3Sae1POgeECvTPYq8nKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JnNQheJamPZNmGW7IC3sywoBABKUIw12dlUVDOoWmvaBv611
	xIOqfynC8XW6oKzr05dj3uJ1pKweHdVvFJKJsM2aKQ0NreitcuY2PKMvnjtrjQ==
X-Gm-Gg: AY/fxX695fjfZVuRXIQvoLBg3aSJZvT67ovC+mHGBpxu272pVVR4wQxhwy6A6a1Qrzc
	jrzCI9UaWS0hyZIajiCuimiz8kclHclV6bUvkE8CegUWuX7CdeC+9zTYvlO97HqJ7MawmCNvsVs
	QVV2CfsrgaAE4QJrA6FvyIU8UAc5Zez6ewqItzLsf66dOj/N8SWNJplCvpOXIdCCaxK/+HcZw7D
	euq8eB1Cr9CIkLqAk77VX6dZFkjxN8WKuKFGFpd+ZiIEJbsmZXo5I+HEPshgZU4Lcmd9ouEqE9v
	IELiWHSfxB9v0nJqJRRlRrGMslEJSgQNYu369dK25djIfrGsiOAI+ngIHrCVgsIEQR/S6p47Qrg
	SodeCtQCv4rMSUdhewwRhy+3p99S9RbIGXNZR8uLGYtXnDwHnQm2VRUKxwCUpfS8xHirpwcBE9d
	r8dX0gkpCBb3O56Kf6tyCnNQIAoMl5849b2xTA27vO1kNCwqsfwML9QOXdS9b1UQ==
X-Google-Smtp-Source: AGHT+IHG2QmxV9/fFFIzdKkXfEvMByaR3GOU1putADLjycKCDfCuCgMLesPURRicsUaJI09J8HdI7A==
X-Received: by 2002:a05:6a21:6d98:b0:366:14ac:e1f6 with SMTP id adf61e73a8af0-376aa5f5dd9mr6438275637.72.1766228129779;
        Sat, 20 Dec 2025 02:55:29 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc4dcsm7704222a91.14.2025.12.20.02.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 02:55:29 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ionut_n2001@yahoo.com
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] block/blk-mq: fix RT kernel regression with queue_lock in hot path
Date: Sat, 20 Dec 2025 12:54:47 +0200
Message-ID: <20251220105448.8065-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220105448.8065-1-ionut.nechita@windriver.com>
References: <20251220105448.8065-1-ionut.nechita@windriver.com>
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


