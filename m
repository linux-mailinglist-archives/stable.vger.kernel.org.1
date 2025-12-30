Return-Path: <stable+bounces-204192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B31ECCE9168
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7681B301B2CD
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F02D9EDC;
	Tue, 30 Dec 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itf5ved1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BD21D3F0
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767084719; cv=none; b=Ky1OZZ/EEF19pB9R9QHagmE9RqNvF38mdYjkzkaUVKRPPM3ihizdXSvGWuEGzczRYctJIuOOhVrGrYsBA392ofcGELp6oGP0he88DV63ZMZAEt0lXEJfRUfoGuMfwVQUtoOzpUVBdDH+O+CBafe/rkMA6152WmviPfkVZMrxZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767084719; c=relaxed/simple;
	bh=Rz9VAzWK4Ky5ZPQiDOshvUDcCO4ts7w+laQYywDcql8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3p99OQqOSwIiQE27hrzF3j1biNG8BI23eZJd1crJL8qWOqazuzMu8YYfsGfFTP/LToB8X8t0dELqu/RTlliT2V1RODj3hKb/OdKMHVyh/sBybK/vQJmdU+6etccu9CymTEkZvF/Ck9llf0x7oKBUJCselO/MoP1MOsdTS9RXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itf5ved1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b5dfa4e9eso658186f8f.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 00:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767084716; x=1767689516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+s5KBJM7BB4n/dwDL+pLDqdA//SJhdpHdX39Ce5ZSM=;
        b=itf5ved1BIuDoAp4Yo+7eF7MzpI6bUYiITyIcZHUBLgXssuAmCw+4bSxpgf7CO4ydb
         yMfPdzpk+HMulFyF0amfitYZKRKtqdvhqEfW8zU/cKVvw4KXbDb3mnLR6OHKPcWiLmuY
         Ung8TgXFOQEAvscA5wn7pVN1qcvvShj6M2SBrpTjvWIWnDM8Hc7MLTGlynEWzHmmixOY
         43pH3S1Tuy3z2RP82RKt5zE13sCoOfE1kuzcNTEF5sy+a3lUN1VCkIkf9OZA6jBeQaah
         TFYtmecd2X1YfPzFKf5BBV2RCyZjxjZRrxyaxY6o5ejGDPMp+Tvtu7lRMrEX29a2Zr57
         ND1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767084716; x=1767689516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+s5KBJM7BB4n/dwDL+pLDqdA//SJhdpHdX39Ce5ZSM=;
        b=nGjvZUaI6ULkhq2JpSdL3Kreu9lvpmo/ftXJyfkcEhkgSHtS908KCeSJeOG6ussfBU
         fEK9U4BR81Pt+0hbuLqWveK35K1YS0g3jg50PqC+9iYJ9sM9L508+Q+18vZ/Ti2E1y7+
         ikaNR8fsFuWC52jf1Y5SmeuosJlkK/qvL6VVwXK6UASY8yqD4b94R24L4Fji+i+8m8cw
         S8Oq+RNX6kHIaXh0Q5FqTxdt60+MLu0AAXPzbPG0yzI2HfbHQjFp6WzlBRJdg/ojHojG
         GNkQGOU5EJYnxZSr6z2xXWH2Nt4ta4CAST75014fIxPqP5oS47KT2a8y7RYSkHemEI7z
         iniA==
X-Forwarded-Encrypted: i=1; AJvYcCVwIHgAHVYNOdED4pwNKUP2UXmOEG3bVjdrwji+E7MnIuiA481whMVul90AB7VeFP3f8cQ3DDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTpstaqNy0dDE+Vmh+LIO8PYR6LS1ei8zLbDK3aovZ1GtZRdL
	mfd+jBmXN4Fow8Q5IPm/oIUKTPGnIdyVso843xfh+XWlDFa1tTisLWLf
X-Gm-Gg: AY/fxX5Fiq1VLjLaUlbwRU4zZxT/UaCltOi91Sq5AYeGMNdwwyzw1xgzGE/QiNtZDGY
	fydUU5y99RVb0ot5OxQrcDHKAk/T9mgM685hnTigjX9SHjKDHOmpqkZ/IwJ1sIFmFWQ6E2hM/Bb
	zgOE7amfkEJKVLR1w6tNaQpyoMQ7Nq0jvGOHbMWO9OubqozgV4tCeoZLFRw2uJLNU0ZynV72soQ
	Tjz0V2Ie8q3uMCYgnoIz7WaTED2iEZ1DXdDWokvkvOm2BpmIoQ7eumE86IMON8UFtDkwuUx1rme
	60kfqIKBB1/5ZTWinCL5FQZnOiT20P/638omcKOiEziCfjPrbP8mlsh1bztW9C5MxnkbIskItVw
	k6yb4s+tJ/1M8X9IAf11Axndb/BshFD43CxXnIDHgV+yStLPyK4ZeWNPr1fk85YZlAI86WM52n6
	t2y0mzHSXxRFCC8IcO6mFxo6Xha6eBXKHD294SvzruSIrk
X-Google-Smtp-Source: AGHT+IHec5uXtWPBtCO651euG6xiqodNjQ+bvtnHnde+66W/0bFaWLjw0VmILtloPnLZeqsXytXQwA==
X-Received: by 2002:a05:600c:a46:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-47d195a27a6mr212413505e9.8.1767084715469;
        Tue, 30 Dec 2025 00:51:55 -0800 (PST)
Received: from thomas-precision3591.inria.fr ([2a0d:e487:217e:be3a:c66c:743e:e8b4:feeb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm66538968f8f.8.2025.12.30.00.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:51:55 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Eddie Wai <eddie.wai@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: fix dma_free_coherent() pointer
Date: Tue, 30 Dec 2025 09:51:21 +0100
Message-ID: <20251230085121.8023-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_alloc_coherent() allocates a dma-mapped buffer, pbl->pg_arr[i].
The dma_free_coherent() should pass the same buffer to
dma_free_coherent() and not page-aligned.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..866dc22a2ab8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -64,9 +64,7 @@ static void __free_pbl(struct bnxt_qplib_res *res, struct bnxt_qplib_pbl *pbl,
 		for (i = 0; i < pbl->pg_count; i++) {
 			if (pbl->pg_arr[i])
 				dma_free_coherent(&pdev->dev, pbl->pg_size,
-						  (void *)((unsigned long)
-						   pbl->pg_arr[i] &
-						  PAGE_MASK),
+						  pbl->pg_arr[i],
 						  pbl->pg_map_arr[i]);
 			else
 				dev_warn(&pdev->dev,
-- 
2.43.0


