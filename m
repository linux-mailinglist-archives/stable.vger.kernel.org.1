Return-Path: <stable+bounces-134752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CBA948D5
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190D23B1384
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D820E018;
	Sun, 20 Apr 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggtKY2Fe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465020D505;
	Sun, 20 Apr 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173692; cv=none; b=rVgASNfZog+bvBYOfitP8IUonuO8TKNhbJW2gqKAYvtaZBIQG7imNqwEQhgeqmqKBGsaphYNkasHOQxYB39amrJ9g6AXXTKwIWaX4nW3V/ge1/QWhyWMgyr+wrT66Y2ivv3adCpUOrIsYJbs5uJacwxRB7aeIwKkJHneTMoFhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173692; c=relaxed/simple;
	bh=mQihOWv8xBALIX3TAcEWzTiJaGpGPS1iJr+MBXyPdQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZrfNRnvFz9L4oImeHweBWi9WoLBetxG+NyZCPWvGcmKn3P+jiF8pbz3CFRnGwGLzsTHmybituv7HWeSsfhQRv2Htx/RVRua6QzLmpsK7hrcOCmrXJ7jyTngoVKosSPQyGmiIG8cod82jBvJU4sE15aMWIcAdm/cZOPVW3kZwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggtKY2Fe; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af590aea813so4111359a12.0;
        Sun, 20 Apr 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173690; x=1745778490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcRYApCGgcFr/cRT0jz04VlStr9b3Rm85w3Cx/6Dhlg=;
        b=ggtKY2FeuPjU1H6BL5Au4kV4c0owTuHDWTeGvDUc+iP2/fBEvw12eCBEGOsNVwhwi6
         /GU36jj0rGTxYDQGZBG1vMkpFIbEww9mNqeA7HIE6lvO+MTATkY5xZa5vCG55KkRAWGj
         v4M8byEzTW8DOgwGTC3HQ0HrwhyKSCvJVLP0s5o6XPXAk8V5NaLweNVomuW4Hxy3JSwn
         aMDsPVjrvX5M9TxOqCzjgbIqgnnBSER08lpkqk12frnbpyCd3rsnAv4vVEEAgXsUgAz+
         JsDHcpzhFF7cA6Gi81+2sK7SGzu9rMos2OfcNYcd+W+inhmvGy7vty6c40zLmNjIDW6Y
         1qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173690; x=1745778490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcRYApCGgcFr/cRT0jz04VlStr9b3Rm85w3Cx/6Dhlg=;
        b=LWbXTlhPYnkkaTFT5LAO88clHgX/kT/aBGUpYZ3yKM8e19CT01wbrXhcc2ww9lrPSb
         7sTN0stA4ynP6h02uXGXv5yo0ROJDvGVrDffjEMjtaOVx7wgicCJ3vcS4Pa2zKmsYwjF
         Vdpk1eoTsDs7GAbrgdarAsbDiuSdS7iGzC0W3WsEXsyaj+RrBiVvRVxI4aa2iguoR++L
         JKlN2tGNd1VFUIWvTOqOw+pH5cAI167bQOYdPrl6YC1vex23HkrppAOZSiNWm/EzvvFr
         26C0kPoCzPcW2w6F0SDT2o7G1G8xLR0DCo4HN0vRvjmp/5XVP1w3xMH4v1cL2D0vvqQR
         XK5A==
X-Forwarded-Encrypted: i=1; AJvYcCWErmHCdvzLU9L/nWjjZHvYb4SUhymTkXc8VqlePDDrGD9ZE9He4p4DjNGv8bt2yCsNkxUKB8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLDsc/wszcqMA3tuJFAqiARuak4f5YUw01loYDW+OMfOEBpR4
	4nZjsVeldjgVCIJub6pVfKl7jcy3zOnpG2WoKcQuaXMVnFULepoDyoQujstMQwI=
X-Gm-Gg: ASbGncuNIn0CGz/VZVK7fkuZI1a6wMC4Iod1GniBN0qxyR9BUdxU++jSsCwbMNnBHw3
	uKJVqCy6R5/eo/oqhGEVIZyVu0UN4VJCCG/Vgb5J5cgMXffszTltm6C77S7KG8Ibb25MRCorAXP
	UUeakMN90Vx/5A8PkOC/2RS2LugivuF79A+YDdFl78pts7UjOQr0z2x6LrRBrtY1n/w+5+KUwx8
	Nar3jhw9cWvUP0JTqQ2vOlgNZPgJ7Mrgujrl6MWNwI9DZICpWhP9o50PY+c5+kFJt+KayWzqx1e
	jH5ol6I8bxwQL/t8/zqO7sQoVCL3BeN4plLGSt9cGvJwIMKzGgz1tkNzwwgT
X-Google-Smtp-Source: AGHT+IHEfDcqBZ/8UilBBzQgUsdzafTEEbbClYsk/pbpMpKTMLTox4/6oBGYGwVVX0alm/Mr6jcB7g==
X-Received: by 2002:a17:902:cf10:b0:215:58be:334e with SMTP id d9443c01a7336-22c53e3b25fmr130214735ad.10.1745173690529;
        Sun, 20 Apr 2025 11:28:10 -0700 (PDT)
Received: from [192.168.0.6] ([2804:14c:490:1191:f66d:1f0e:c11e:5e8b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb74sm50550055ad.166.2025.04.20.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:28:10 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Date: Sun, 20 Apr 2025 15:28:01 -0300
Subject: [PATCH 1/2] regulator: max20086: Fix MAX200086 chip id
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250420-fix-max20086-v1-1-8cc9ee0d5a08@gmail.com>
References: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
In-Reply-To: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Watson Chow <watson.chow@avnet.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

From MAX20086-MAX20089 datasheet, the id for a MAX20086 is 0x30 and not
0x40. With the current code, the driver will fail on probe when the
driver tries to identify the chip id from a MAX20086 device over I2C.

Cc: stable@vger.kernel.org
Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 drivers/regulator/max20086-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 59eb23d467ec058d3647d1bfb01831738bcd256c..f8081e54815d5045368a43791328b3327cf0b75f 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -28,7 +28,7 @@
 #define	MAX20086_REG_ADC4		0x09
 
 /* DEVICE IDs */
-#define MAX20086_DEVICE_ID_MAX20086	0x40
+#define MAX20086_DEVICE_ID_MAX20086	0x30
 #define MAX20086_DEVICE_ID_MAX20087	0x20
 #define MAX20086_DEVICE_ID_MAX20088	0x10
 #define MAX20086_DEVICE_ID_MAX20089	0x00

-- 
2.43.0


