Return-Path: <stable+bounces-160341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C851AFAD54
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2835B1899807
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43EC285CBD;
	Mon,  7 Jul 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyW4sbvD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE91F4CB2;
	Mon,  7 Jul 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874040; cv=none; b=mPdKrE80bAE5qC70UGKLDRX6IrJzQ9xeiZAjV/WCeJEVNwDFbWoej5KRlFwsmgbv1vsG81KLI0rPGtfkWQPLMFMBPVvTuOhAwH7ysv0t2JXCDVJhbN0LWELgjjdWNN+3cnOe2VGp/Kj2DqPyRoy4aqExWbe4KZ0lf8b1Kt4kr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874040; c=relaxed/simple;
	bh=4gqhnQEkJDF6bHtp4rmW9Ksife78gMcwUkAdVum2gUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czhVOvDmdE0qbVFebHHLiU9vNqHnn8+PLRIAWR72oVfYpdF860ifw68t5flFjH7Xu70yHFnV8rI5gc5LVJo/QHv7qmMswTFMLe+n5YXPbGEXEgr2xlPEoT+3a030otbPPP/mexd4D7hIZsVuAR6d9k8JcbhfJk6JnKF+K++kbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyW4sbvD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso453725f8f.2;
        Mon, 07 Jul 2025 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751874036; x=1752478836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrm1zhsxweRW1Vz623z7OAal5eScBLTdY72cStBJEjY=;
        b=AyW4sbvDlVFhCrWVWTFXKO/NJohrZ70nu3ko+FEfi4i8ngQwf3w7/QQm537q6OOp8k
         ismOcbPCJRSpMC17n1VaYAJwFK4PEMe9FEazL1sgA+mVy3f7N8KdRRYAfRfrMgSgfcBr
         MBDCGz0jEY0E/ZSbN5KJ1jiDNccpln3RRx+oiM3o2kNlbB2FqrD5PF1onnTLDrTbR0J7
         r1p9sj9Shp9Y2KTGs6kwzEebeQeIiv/bJPY/LsR9ad/ulhdArqaf9k6utZ5h2j9d68+r
         wKV90NiU3VtBWZX6uBAP+RUTBiaUI3qzC7k5NaRve9wI7bBw86fWM3gZT5MyksFZsBmr
         sl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874036; x=1752478836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nrm1zhsxweRW1Vz623z7OAal5eScBLTdY72cStBJEjY=;
        b=iVzxAJ+TQ36oG9sUosxF8VInbSMmIIyIL/e2p2JdV2Jr8VWuyuYP/eTstLCBLx3v4r
         PqJrX35+bfbsb+028+wglY7SHzcssIP9AAe6cu3fZHG/bxx+n17WrHu7ZZaCqU63O49s
         DiAGkjk2+S9S1J7isGJj+luetZW9j7rCOh6hR0bnEaHRm3DHYp7dPF/IQiwhY4rUcbuL
         EDK60bImd40hA5MDeehHSLuOn03H8R7IuZVB1NK4+7ksZBQH2u6bJIijXj2E1aEozlMw
         D6e4NoyexMyQ2YMI80AqqO0Cp01HVbzebbNdc1/d6WQoaVcscu7GO8oxsQpG7eJIpuxG
         ZK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCULZO0fMg+DbqySYCb/zzjBlq+aDJl6/DjZahseHBve5fDQ9eEcIfOmKEwzZHKPoCkLQxENQ1fy9zTRyxY=@vger.kernel.org, AJvYcCUqnHRLsiYO+q1YtK21Z3MAQPDV66ez4cM6UhfN1wSivvEv0q1rF/7tgk+m6fcVmp8nzNFDweOj@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZHU0Rh24XnBwzS05uytEjz+2x6Xm6S0SlYyyl3eZVUeU37iy
	dOvgHL78DlS9/gxgRR91G/Mr69cavRlrj8nRMAq8S21gQwa5Uhul67W1
X-Gm-Gg: ASbGncvmXwuEGYF1qNv2vvikCqQ1el2Bk80gP9BWQOk9sJwEZbREACNVj/WVJVYLepJ
	htqPC6VU7o+0zWCnbEXrQg1PQWohvh3IvBGZYKMttMGK3z/dC5NiLbpqvESQauM3sBzRPl5NfbD
	cf5Nny2+pNFWWrUJPpPOGDeP4TTSIruE9MROmR9ooC3CBUUCbAqyRM/uWQu02T9/0Zt1YL8Kpfd
	acv/xNC5ydhLSQRDWHIFHpOxk66hazjvpeNsiCjaW3xHMo31Rve9Ky+Hy63E+YRPDO8kl1bZWys
	J2o5/4DFfQFVHEeWz2AoQj5I75m0YSAUOj5CHlOPDqIk2NwoD+IvlNyUI76xJYP/m5iqIfqxu1T
	IGCKEyXH21f32Gz0=
X-Google-Smtp-Source: AGHT+IF3n+flLeuVI/pFKTChluG9p2jOYqIX7r6WUuLRebZdYWS2Stumfh3b9JF7lRWIWCNv81GN4A==
X-Received: by 2002:a05:600c:a21c:b0:453:4376:8f48 with SMTP id 5b1f17b1804b1-454b3a7bdfcmr21353395e9.6.1751874036109;
        Mon, 07 Jul 2025 00:40:36 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:ef01:c9dd:1349:ddcf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454a9bcececsm132671305e9.23.2025.07.07.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:40:35 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Vipin Kumar <vipin.kumar@st.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mtd: rawnand: fsmc: Add missing check after DMA map
Date: Mon,  7 Jul 2025 09:39:37 +0200
Message-ID: <20250707073941.22407-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Fixes: 4774fb0a48aa ("mtd: nand/fsmc: Add DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index d579d5dd60d6..df61db8ce466 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -503,6 +503,8 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;
-- 
2.43.0


