Return-Path: <stable+bounces-177912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40019B467A0
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE365566D05
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE50146585;
	Sat,  6 Sep 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIbB08IJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D6315D3F
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119423; cv=none; b=oWYgiRlOx82uVNxF+Tz3Qbz7UMpmDROqrz3atHhbC6imDFiXx52e0UXPC2kP7KTgIMtDuX2d4oRNAGCdBvq7sr5EZzIszoO1YFFR9rPr+OCxoZCuM+E3vELG1K46lr7ktBFKrcYMtSHONwi5JOoVtZY+kpHIcN+frUt0P8HAeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119423; c=relaxed/simple;
	bh=74+53pv8jZOFZFzVlGe0f7W9khJ1kY99THuqfv8by4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1dTYqHDu1wZbRS7CIE4NU31EX74BBHBZ8re1WY9Vww2EifGRu+Ux9zealb4KLekHr6SyxsjhbWZCAONMBx7HIOAWrzyWvgf4ucCQ7UkVwSxqrhBBlwFeRfCmqM37fD8qERSs9ty4HAMBCqGnteTPcnWcw1qqM6+7NthiuEn2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIbB08IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD8FC4CEF1;
	Sat,  6 Sep 2025 00:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757119423;
	bh=74+53pv8jZOFZFzVlGe0f7W9khJ1kY99THuqfv8by4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIbB08IJ7ZRkWKyknRFnFK5rpDrr17XBOryqrkkkqlV8PRLy2QByNo4rCQPBxDbaB
	 g4OT4jDjzMK05H7cUL98OPZVwZ5+tKD3c+9hosg4GuPGsWw9QEisNDqCanHAWSEN1j
	 L7JEB7a2xO/TrsrsYRj5nvbux6oq3Cb8syApXMP4isvkUE6c4HkF3cBzwi263ynTxl
	 4/JL/Mw+q0aN4HgXa3bo/nVtQ6JNX6LbXB4dmy3vZfO1k7oWZpylq2NYZMRY58Cawa
	 uZg9Sy8BFwPj5VqrhIzv4g6wuoS2Gg35Ej9uKCJemT4o+Nzk9RngWhHBf1PKc0Vs/1
	 qgwZ8PYzrsacA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyejeong Choi <hjeong.choi@samsung.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dma-buf: insert memory barrier before updating num_fences
Date: Fri,  5 Sep 2025 20:43:40 -0400
Message-ID: <20250906004340.3608878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051948-crumpet-repair-31b7@gregkh>
References: <2025051948-crumpet-repair-31b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hyejeong Choi <hjeong.choi@samsung.com>

[ Upstream commit 72c7d62583ebce7baeb61acce6057c361f73be4a ]

smp_store_mb() inserts memory barrier after storing operation.
It is different with what the comment is originally aiming so Null
pointer dereference can be happened if memory update is reordered.

Signed-off-by: Hyejeong Choi <hjeong.choi@samsung.com>
Fixes: a590d0fdbaa5 ("dma-buf: Update reservation shared_count after adding the new fence")
CC: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250513020638.GA2329653@au1-maretx-p37.eng.sarc.samsung.com
Signed-off-by: Christian König <christian.koenig@amd.com>
[ adjusted `fobj->num_fences` to `fobj->shared_count` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/dma-resv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index cafaa54c3d9f1..bcce96d4a7530 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -267,8 +267,9 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 
 replace:
 	RCU_INIT_POINTER(fobj->shared[i], fence);
-	/* pointer update must be visible before we extend the shared_count */
-	smp_store_mb(fobj->shared_count, count);
+	/* fence update must be visible before we extend the shared_count */
+	smp_wmb();
+	fobj->shared_count = count;
 
 	write_seqcount_end(&obj->seq);
 	dma_fence_put(old);
-- 
2.50.1


