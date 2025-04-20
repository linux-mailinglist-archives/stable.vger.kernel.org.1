Return-Path: <stable+bounces-134753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA5A948D7
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA94B1891EE3
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817ED20E6E2;
	Sun, 20 Apr 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKND5f/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BC20E03C;
	Sun, 20 Apr 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173695; cv=none; b=VTVjaLy8pYgxnnyy32xdlHBxj1YgGGZFIRmj3n4/puRWAGHmDjPchPKXwmedGpxxJXMtHcFkeC0Tdln45MICwxhLf/YC8yR9WQ3e30SzvyqzvDGZmfrwF6lQsYclxXjY27gylaOWse+a7lZ7NCXDYW65zNlxwzLdQ8i3CEgLR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173695; c=relaxed/simple;
	bh=ug2YuZtVHOS3Xo1DjEh8+JMIxUeK0tUbdFYLjy0kIL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h200xBwUQxJfvKzvQf1pNuTJi+Dys5FYV5LbuhXGbe1Kbva83ktpkV1pJFTPDeBHiAleoYUQckggGmnAv9bGoaujhOuq0bEIsC3vIU05lQvOnVYkmok0Ua1YyKzPiS9UZkyfGTc/NSUOeVMXmpMqoCfTdYKhZ2+lApuWvrYJ0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKND5f/W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2255003f4c6so37915425ad.0;
        Sun, 20 Apr 2025 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173693; x=1745778493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vw6hOxHYdtqSUI3BN1G6zdypvE2XuTrlurxFwJGouU=;
        b=EKND5f/W0xCE/fH1xb2vmBMpbNTuntIYFT0pRaouYTH34Cv2efbIuw/L/2TpaQh7rN
         /DZwYTJk1Ti82Bd1fyBySSxVx6mS/p63uAf7oGbByekcNqfl69GlxZirNVwjvbZ663wl
         Y5osz6byGUr1Hzi0leeBtO64w02RzRY/nWdp/T34go1MV2HlZtfhoQpsPjPsZMRaoUaZ
         KjmSkQiy3+UC4eaxqxePXWh3zo7VjHTUhtRMLr6OJPu+21EJKpFpUn0E+p3KJcaLfRQ7
         53Vtno97v+2fdJhqN6YX7TrJ9udL2mvHFjTeOgL7fLPGQZ96a1Lcf5pD/X+9LhsQwXJy
         Km0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173693; x=1745778493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vw6hOxHYdtqSUI3BN1G6zdypvE2XuTrlurxFwJGouU=;
        b=g714E7DAc0YCkdybagsFqMmVCwhrUdNpAjs/x+/c/OCJb2R5gXuvYmhLExd5ufCeXw
         shbbHhukREK0Hsg8189rDvGcyltVHhgBweJp5r33ry24b7xKVqoOJp+/0md5s+GaePl6
         U3lji70vAZMWdQNHFOZHCgBjsaTM5HB0WXIRL/IjQSEWZMT8jTZ/5ByZeafL5sIq6440
         fhk04N0SHCxwdw7bmWFBv/cLn1wFXnAlTiEphBlBlr2OswCuUii4yuCL9D6V8B/bBd2N
         XQ+7QPUh3rPoJe7Vq7nhnW2rwMc6clNGjiZ95v80Av7WaA8JWIbeqWxQxa84rk90JHYr
         VQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWqiuQET78w7T8/xOrKFSPfg+Yx/eAoazMQ4SWg9KxvCS10kzquZ9WT+4gVy0nh3C4znst0OA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4NQR1ObfSmkoyW+ke/vnmlpAMvvEOekgS09Fb+3umLMcq6Yi
	aoLX6i0CVHPJfCIdxmKyotB+W/IghhENPHwCqzNXDW+cFpR+WGmx
X-Gm-Gg: ASbGnctPkRjyZ/auq7bkT1md+lOcoTtZENMMcBAmhR4abroNEb4Yl2EEz6FA56ayBij
	sHPRdCTSkxs5EUg7msvPbkaN6VM9AoGVa1x7cJGDm4EEJTi1yfKgaVOG13c6WDujO3xTnF+JSg/
	rVdOVZwlsSGlwQHrKXdljr9H+5QZk6ViovRqPLbSkwMkQmKTzrRjRjhHtfyMGpDluse9YBLBtpN
	a8kq+t1oNYB7WmMZVFBkfXU2bsEGmQY5qBN2G8Jsg5QS+Wl0PoVrBqXNC8KYqUMG1NxQUrp7UYa
	s/rDwKG1s50+RRQ53dJtokii1VZ74iugf9rdBoo6YoGCP5Fnjyg5iP8Y4lkc
X-Google-Smtp-Source: AGHT+IGUg2c3Mz6Yc7mPrOWXwSZoN6ipM008iz3KPw09s6bE/es1fzMAZXM3AIfBjlauEtjKJ1/Vmg==
X-Received: by 2002:a17:903:32cd:b0:223:4537:65b1 with SMTP id d9443c01a7336-22c5360c196mr137860105ad.36.1745173693196;
        Sun, 20 Apr 2025 11:28:13 -0700 (PDT)
Received: from [192.168.0.6] ([2804:14c:490:1191:f66d:1f0e:c11e:5e8b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb74sm50550055ad.166.2025.04.20.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:28:12 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Date: Sun, 20 Apr 2025 15:28:02 -0300
Subject: [PATCH 2/2] regulator: max20086: Change enable gpio to optional
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250420-fix-max20086-v1-2-8cc9ee0d5a08@gmail.com>
References: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
In-Reply-To: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Watson Chow <watson.chow@avnet.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

The enable pin can be configured as always enabled by the hardware. Make
the enable gpio request optional so the driver doesn't fail to probe
when `enable-gpios` property is not present in the device tree.

Cc: stable@vger.kernel.org
Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 drivers/regulator/max20086-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index f8081e54815d5045368a43791328b3327cf0b75f..62e9119f446c7a22be9947fa4aafa0c0401d9f12 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -259,7 +259,7 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
 	 * shutdown.
 	 */
 	flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
+	chip->ena_gpiod = devm_gpiod_get_optional(chip->dev, "enable", flags);
 	if (IS_ERR(chip->ena_gpiod)) {
 		ret = PTR_ERR(chip->ena_gpiod);
 		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);

-- 
2.43.0


