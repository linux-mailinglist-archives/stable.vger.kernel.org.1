Return-Path: <stable+bounces-203124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D87CD2387
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 01:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F5E301A709
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313E322A;
	Sat, 20 Dec 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSSh1kho"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F31FC8
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189085; cv=none; b=VPA0fC8ZFAF3EhhVnOTq52LB6evWYbPD2YHUf5YhSYWvWbSIuSU+c+9jKKBYi2oO2jMjC0BKj2R5ARQiBMSHViB1uFXvYV1/L9yVkwDVSNUlTbLe3RCf9pMI0A1XQIgLpJUOOWVCNxK7+xyCitW5xLKfpBpGZdjoXWzwwjTqIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189085; c=relaxed/simple;
	bh=AJ3e3bRiBWjEGw8xkCxosnkqnv57QiDWgHX2ezcQoeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ol14ETaBRQPMoIfmJbbs5u5DJMJWyLCmOb78njAqG3bfAVDBJ8V+owDGQ8sOHRfnNXV19H+YPBsAVE9m47XylyIolyXVxG7YNbK3S0td5E1XMvKZu+Tnq0xtYD/t9LeY0bVMcJUoZIgtWmfgpxucm64KAhrZYZhoMhzvN0jssVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSSh1kho; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29efd139227so30105155ad.1
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766189084; x=1766793884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd24kysrUovZVeApt0ykDaPQf0m2yZBmfya4w+CDVLQ=;
        b=gSSh1khoXehQsxmWdrFwmLrent61FF1InKTHeit5PSPD5bY4/BV/QvF/muz8X5GEGN
         jL2NvFbiNv9vaTc/IBlEJNI1bNlr1E7xtdz2weALMw3WpAaXTf3q/8oj1D7mF4RbfJhI
         OWWcAQQSX+d5Nkb7gv1NttMdvLXAVFl+B4JfsOIAWUG4YFnFA52/HF0ZdQJ03oD1fDBI
         lnAkdvtw8T64NGdSmobKt7LuxEsWrv/QgOmP8zpQrUsBbss2a3NmzUcVxQshBBsYy2ZP
         eWELQUyrs4EfBg2PEafzJrOrVo9qQxgbRzkuwruMQhmXO6DSaXORnF5JbUuq9jfyaY/n
         JEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766189084; x=1766793884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd24kysrUovZVeApt0ykDaPQf0m2yZBmfya4w+CDVLQ=;
        b=VqTQNDtYGdTDLCZkn5IkMwrWQA3O2D21drAqZxoBnf27jeTgs4y6LVX/Iw50kX5rGV
         9dr7KR3k0Es3MT7zovNwSsm7LIWGijG3Ii4O79tYkYdH+hNTZ1bTbp0OQzE2T2sXU2l2
         3qbqnCb2DwMtiQZ/acqHEjHqx3QzRyjbTgi/n5U7TndM3FXJbMainwceWMTn7Er2mo6M
         4UReZa54RvqESDtAODfip6Sp66ccTZwy6amwkdmoBSxF2iiVpUNnzYB//xOHKECndVht
         yno9VNBpB8vDJsErvWFmp1IM0YMpBQ21P3pS1IogxwS3YTL1W15wCHSHBU3VxWhkbi/J
         u5VA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXxtaiyezkil/iQjDBtQwfW5YS8SVieomSaqRbxakjj4ytigwaN/K2J4WBKbBClxJXMWbkdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjBlCm0zO38CcINz3r1EXRqMaWRakWbJAmHHJ8R8QKGwsEaZQ
	Aa+bYlTFtus9MB0FtvwGF2tEdmV8Q69etR3ZC9OnKFQNm/E+9bB4mhXu
X-Gm-Gg: AY/fxX5mw5qsgRwWiSmroX/MHFthJsGNqouk7K9blbHijxSdSttrbuTyRxV0gcmezXF
	ecE1VFszZPiNvifl2fy3fgHRwzj1Elumn519Wf2h8wJgp52oOYaYm5G/Bmlnp4dFYbhdHQ4BdiN
	cX6r1yko5KNMe0FbEuK7440bc/hx9bGhwJ3a52SNugmoFIshZ9Bd4aBwCP5iyi0Mro1XgaZNVyU
	UYaLdUWRtsqJTi5uKpK6cieN1F639WyCDamR6M7bGwfqNXK5cmVDTxppTz3oBeOvpEnXe47MYbY
	7JJgQR+UaQBA4ia7YPNN94j1BKAkAdp4NvKkRrGD5iuZISY2g8h3pydRHYYcdk9n6jLi385TI2m
	Gc3U3O0lG0oXf743rRoDYe4l0L7cBh2SqOte3Bc83+3b46TwaYSMLwKvO2d5dnt9IL8U17/G8z1
	/wcrsBzFVNGFLYy7K+dPpNTRA8eFcs9nTuB1EOOgxp/c7B1cNRkw3sYxQKjA==
X-Google-Smtp-Source: AGHT+IGHS4lu7eHRC5VIhQaJQk3U3vK2tvT4P3COPqOTlfuSk62XgyRyjg85zKiAsWDhpQiRvbqAuw==
X-Received: by 2002:a05:7022:910:b0:119:e569:f26c with SMTP id a92af1059eb24-121722b56d1mr5535526c88.21.1766189083463;
        Fri, 19 Dec 2025 16:04:43 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfc0esm13581804c88.2.2025.12.19.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 16:04:43 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: leon@kernel.org
Cc: jgg@nvidia.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: fix partial IOVA mapping cleanup in blk_rq_dma_map_iova
Date: Fri, 19 Dec 2025 16:04:40 -0800
Message-Id: <20251220000440.4248-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dma_iova_link() fails partway through mapping a request's
bvec list, the function breaks out of the loop without cleaning up the
already-mapped portions. Similarly, if dma_iova_sync() fails after all
segments are linked, no cleanup is performed.

This leaves the IOVA state partially mapped. The completion path
(via dma_iova_destroy() or nvme_unmap_data()) then attempts to unmap
the full expected size, but only a partial size was actually mapped.

Fix by adding an out_unlink error path that calls dma_iova_destroy()
to clean up any partial mapping before returning failure. The
dma_iova_destroy() function handles both partial unlink and IOVA space
freeing, and correctly handles the case where mapped_len is zero
(first dma_iova_link() failed) by just freeing the IOVA allocation.

This ensures that when an error occurs:
1. All partially-mapped IOVA ranges are properly unmapped
2. The IOVA address space is freed
3. The completion path won't attempt to unmap non-existent mappings

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

Hi Leon,

Your last email is not accessible to me.

Updated the patch description to explain dma_iova_destroy().

Please let me know for any issues you want me to fix before I send.

-ck

---
 block/blk-mq-dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index fb018fffffdc..feead1934301 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -126,17 +126,20 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
 				vec->len, dir, attrs);
 		if (error)
-			break;
+			goto out_unlink;
 		mapped += vec->len;
 	} while (blk_map_iter_next(req, &iter->iter, vec));
 
 	error = dma_iova_sync(dma_dev, state, 0, mapped);
-	if (error) {
-		iter->status = errno_to_blk_status(error);
-		return false;
-	}
+	if (error)
+		goto out_unlink;
 
 	return true;
+
+out_unlink:
+	dma_iova_destroy(dma_dev, state, mapped, dir, attrs);
+	iter->status = errno_to_blk_status(error);
+	return false;
 }
 
 static inline void blk_rq_map_iter_init(struct request *rq,
-- 
2.40.0


