Return-Path: <stable+bounces-179178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0DB51178
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697F917B8A8
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9F3112C7;
	Wed, 10 Sep 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzTNt0/v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B230F801
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493297; cv=none; b=qlyzQwJ9UABSaV9bC+rnUEdJe1MbQw3BxsmBIHiij1EjajM6jbhRdtCPHKNhj8eg1bJ4M0djfmO6VfN46YJur6B4/MplqiAglqzrKJXnaXr+40nOodIoyi2b2LtXOIfaRXgKUAm+2vCS6tvuVsKTFZIY79IJQU5xeEYESSkTciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493297; c=relaxed/simple;
	bh=SpvRzD0bOjvGf2Nx8OuBFCP4M+Ir0Zip7/CfVuzu4QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJco/PVuQcrGb7LUDjX5NF7KklwEXewdixA+boY5Xi6Vlv/TSgNjP9QZA7SQVFKifsmKUqsmN4pzbr6nb+kx3ar/UXzQD6faibmub83iOHLaRf3E9n+VJWOoYAFLP1N4HTuf/Nx7l+L1E0W3wdBwkWSlq0AbpO+wIFY+9/xlaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzTNt0/v; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5c60ed3so10273315e9.2
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493294; x=1758098094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=AzTNt0/v68SMTQmrd+R2D4oRjd2K/T3QJw4jc3cYeVQVcAHf2/Ffj8oL8pFZl9TzHw
         zKqkal/3N0gD5AkZ26S8nzuEzJdtGPNvwuUtf9Nk/KJxsC0CJVfrcI20V+T/uSUY2l3h
         v6fQBm4F5s1+SV+04nCtBr1v113DuXSz22HHtuT4Plkp5zAz22MlJ53yWWXfIBZ6kW/B
         XdBUnKkZWksiYkhJRxh+aGyDKJxSpkBsZChbb7/x2V+ISIwyDTETlSa3IY2twPSPMDra
         GGO9ugqLsLmf/pHNKUTPGnHsmOSIu2SAvgiMPNwiK8dJF7WiU5YxrJiYQWSItgCTkttV
         HuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493294; x=1758098094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=l3VrxbGuqqidZNrPXJph1EB1aJfgb2iVPDLF7ginINuJrop2sZrxiZfJzm+zqE1oVJ
         P5TH3Qqg/yuLZNqbSDsF5yIrkeag48PbmPr7bQMTYA5E2s0+aYvaUXHTR8W06MxmDX8U
         +KQqKOMizkZY3EEQkq8bndq9KyjEbilvUL8yvil8CTxW3051XOpJJ7nQjYXEbR5qz5AI
         5b8V2c3T8kbA81oHE2avLMWu4dy4CWsn4vKsu/Ucr4aDE0YoLE+bBmLo5aifs72TtpIx
         +WXTV7MuztNB/pfChGwhqjY1W2nX9BMgepEBAj1xvKD+13Jw/o89qJIcGfChsZPOI+Gh
         IeiA==
X-Forwarded-Encrypted: i=1; AJvYcCWde0oR8wYIF4PcZZAmgt440b8Zp/QZ7zpNr9xk+eqYMxDi7iDtNU61m4ihkLY5YuQjrHzmgRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVZuidpVV/1ntGgLt6k862hBV9+bCDVt6yy/LThOnurwiEUiw
	/6lS+PNXj5v7/PgD8cb1WLyW26o3iFOZMScAni03hkaNHXIZAOlBv5wb
X-Gm-Gg: ASbGncu68IFVGGBktYmovIO2KUdINnHm4z9DsXBwgRJBbpefrcJ+PPJ5FJjgckwtlB9
	ZyZbXOpUV7fG9kmi7jstA/l4NBDs04keKrO8EkzRs0d8Kcq3ati55LEX5ooFIG7wNnX3b8JdV6a
	HX0rwSGF+WGXcois8Q7mZTN1KUHSTjg1LKAhse1YYeUpC3qLsgFuBVXpRE6ZWTV934tl3pxF+L/
	U2YVwkbN69fQhJr2asvdyQVWj9CKGjARW7+QZ1TKPhbAKhWFk9BVekhFnkf5IkNmTJRbcSHhQph
	acmNI4zeO9hfz1by0/y+GwmuFxVVktqUSyb5sdurpSyCTdYR1gNCqtqpvQ2oTWFLatHwB2jNcfU
	L/td4OGoKJO5WSddsUykG897dBVWh9J5hyWbfB8n0Fl4TGWY0C8LGYaIYYdTWvLVaOX0=
X-Google-Smtp-Source: AGHT+IFvK6FSXou9OenUrrz/PdbIoxF3WcJL69A9lP4CdFPOW3aq92qZPlSoHiBDeanssK1jlGOOKg==
X-Received: by 2002:a5d:5d05:0:b0:3e4:e4e:3438 with SMTP id ffacd0b85a97d-3e63736d9bcmr5889161f8f.1.1757493294125;
        Wed, 10 Sep 2025 01:34:54 -0700 (PDT)
Received: from thomas-precision3591.inria.fr ([2a0d:e487:311f:7c67:b163:f387:29a1:c54d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a2esm6378854f8f.14.2025.09.10.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:34:53 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Neal Liu <neal_liu@aspeedtech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Johnny Huang <johnny_huang@aspeedtech.com>,
	Dhananjay Phadke <dphadke@linux.microsoft.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: aspeed - Fix dma_unmap_sg() direction
Date: Wed, 10 Sep 2025 10:22:31 +0200
Message-ID: <20250910082232.16723-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems like everywhere in this file, when the request is not
bidirectionala, req->src is mapped with DMA_TO_DEVICE and req->dst is
mapped with DMA_FROM_DEVICE.

Fixes: 62f58b1637b7 ("crypto: aspeed - add HACE crypto driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - fix confusion between dst and src in commit message 

 drivers/crypto/aspeed/aspeed-hace-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index a72dfebc53ff..fa201dae1f81 100644
--- a/drivers/crypto/aspeed/aspeed-hace-crypto.c
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -346,7 +346,7 @@ static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
 
 	} else {
 		dma_unmap_sg(hace_dev->dev, req->dst, rctx->dst_nents,
-			     DMA_TO_DEVICE);
+			     DMA_FROM_DEVICE);
 		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
 			     DMA_TO_DEVICE);
 	}
-- 
2.43.0


