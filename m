Return-Path: <stable+bounces-52556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548F990B37F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EFE2855ED
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66B153573;
	Mon, 17 Jun 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XctQEhPc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907E1534F9
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634217; cv=none; b=OHg5cw2i15b2D3r1pEydffAnD1+Lg1bOTsTH1g9M1VL/tINVh/7pBBAKOJGVL0j4UMUkYGEM+zBefDLFuTioUwplWD/JhggiYJXqt6Gp+RPr4ywC3mO0GgYIyaBBX8iPIeUD/OiYNwsunEbSzPqsORu/IyN+rWDPwDMLunFlT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634217; c=relaxed/simple;
	bh=SzEc9Mrhc4L56zyt1qLV2Vvy4jLW+40SAhosVjCfLzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWgbPN4uq/hgZt0mR3KKTzzUhvTDMrN+/pkaJwm6bo0Q0h9vEYtBUN6ApQt+dOlkI2hT5Nuta9PzLTeGEM8+CjSutCTNGJs5PJ/ImA4fEe6I8HYaPmXe+r78czJQ1cr9rJWyrWiqeBvwf/2pJvbacwuNhW14okGTAl1CdZRoEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XctQEhPc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f737bd5cfeso3798125ad.1
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634215; x=1719239015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf1pI2be2Xi5G9g3L52PqxNq7QeksCerQp2mEw9fytc=;
        b=XctQEhPc1wBlpYZD3NTULY8NUOBcf21JB424CWEc4t9xfr1yUL5U61wGutn40Xk3y+
         EU2XIvE6vgLEOGvbR26EGkmGSCqPrF+DgLcSd0BAJ3hnFPZwcXxkp8ognOWlZRGrHthP
         eLCrFYHJ73XuZ8Eew2Tm1I/Kc1dHkAd2s+A/zH0Zf61ol58yOOq7GgZmo2CSae5NJrMO
         tHcGwIMZHb7oF53xdyzo4Ir8Bb2j1Y7dmOLQ25//rl+zi6c1niRRWIiNAqK7RGTgNc9E
         w9YMjkKLu3fAqhUi8ivYKa5R9LRd7yBKA0OglL6Rq1bjPFZDbkg54Z0oT4GPY/467vTi
         4XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634215; x=1719239015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf1pI2be2Xi5G9g3L52PqxNq7QeksCerQp2mEw9fytc=;
        b=hInAn9tOV8UPJBp2/DzlJGU3B/zxG+J5CsWPUQtGscRZ2MjqNSyn2mGxTaNCM1f1rc
         UHj2y1DjF+H9H2iRCV43CBi1pVjPz6F8M8zMFYqofpsF0H2py2WboL4NnB+DK3q/HvIy
         NQ/tZAKxATRiozW9GXB0QbQedZRyrgGfTwoJNslm5Vyo1GOkdJSe25w/dvtVEZZAfmf+
         s/x0DAXJ/2WA6nLlz/fWALVpJpnqa8z6WSrxshC1MKNQ+ZpKx00xUhYesuCUQw8KIhGs
         jAAGYUlJqvm4sESdrroUy54t9ib173xfg60KqJmDD1YvBkrnXLiIuD+fFgJElpIRDQ8h
         A0cg==
X-Gm-Message-State: AOJu0YxD0nRdKeLVerNnSBrtlV0sUffTt7dPUNZbhnNXBRGSa4QGKuJg
	5ALOXPA1MNEGm9aa2I5er06owbNBIpsN2jLjhp7+jGnzN331YtJO1CS7DA==
X-Google-Smtp-Source: AGHT+IHeI6qvnbYFXe0jCI58Xfim2CysZrqkETHo20JV2mXx+plLhev65/9hA2QH4ZI0MwInx4eu9w==
X-Received: by 2002:a17:903:2283:b0:1f7:2576:7fbe with SMTP id d9443c01a7336-1f862c39e88mr110306875ad.5.1718634214977;
        Mon, 17 Jun 2024 07:23:34 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:774f:1c4c:a7d2:bccd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e82sm79645965ad.22.2024.06.17.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:23:34 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: will@kernel.org,
	mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com,
	nicolinc@nvidia.com,
	hch@lst.de,
	Robin Murphy <robin.murphy@arm.com>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE
Date: Mon, 17 Jun 2024 11:23:14 -0300
Message-Id: <20240617142315.2656683-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617142315.2656683-1-festevam@gmail.com>
References: <20240617142315.2656683-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

commit 14cebf689a78e8a1c041138af221ef6eac6bc7da upstream.

For swiotlb allocations >= PAGE_SIZE, the slab search historically
adjusted the stride to avoid checking unaligned slots. This had the
side-effect of aligning large mapping requests to PAGE_SIZE, but that
was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").

Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
alignment for swiotlb mappings >= PAGE_SIZE.

Cc: stable@vger.kernel.org # v6.6+
Reported-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 kernel/dma/swiotlb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4c10700c61d2..0dc3ec199fe4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -992,6 +992,17 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= pool->nareas);
 
+	/*
+	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
+	 * page-aligned in the absence of any other alignment requirements.
+	 * 'alloc_align_mask' was later introduced to specify the alignment
+	 * explicitly, however this is passed as zero for streaming mappings
+	 * and so we preserve the old behaviour there in case any drivers are
+	 * relying on it.
+	 */
+	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
+		alloc_align_mask = PAGE_SIZE - 1;
+
 	/*
 	 * Ensure that the allocation is at least slot-aligned and update
 	 * 'iotlb_align_mask' to ignore bits that will be preserved when
@@ -1006,13 +1017,6 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	 */
 	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
 
-	/*
-	 * For allocations of PAGE_SIZE or larger only look for page aligned
-	 * allocations.
-	 */
-	if (alloc_size >= PAGE_SIZE)
-		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
-
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > pool->area_nslabs - area->used))
 		goto not_found;
-- 
2.34.1


