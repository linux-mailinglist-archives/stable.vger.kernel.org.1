Return-Path: <stable+bounces-98311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFA9E3F82
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CA2B44171
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEC215F54;
	Wed,  4 Dec 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ESSoFeqg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439612144CB
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327903; cv=none; b=M34lQTi0PgC/UiEEMIhpyNQ1AY63TYafRtR8soEeTzBWSb1hE4+O0vghUz9n8W3eZQnJhjd1ni3VF0mpbbhyodxoB0mLPKZQCt/4GJZNitHe8zk6pNAvqnLml0zj2PjtY1RHsMUZQwCWFscSGiVFrB04knbjKbbcMHkbAPgyLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327903; c=relaxed/simple;
	bh=vd24ELPUpzIEthODLFQ5qLWi9e3qKvukCK4lkf0j1CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QglVfZFkyPlstO1S66gt447hQfriWm9HPO0roYoyyK+GQ51M6G5mlHKTYLtDxS14sBpWXuSOL8v7QCiOZ0Hc+IXTUWpmBOMf1CPDyPWPrF+Nfd2tpsBQY9v6iV3lS/KHJHL80Y7R0x8k7CbOyUfrBgaxTMFS/tVTkUCRQBbDeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ESSoFeqg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso64926535e9.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327897; x=1733932697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI/FcgkOifwXXzXlvk8zo5YFKecagbmROLu06ZFniA0=;
        b=ESSoFeqgAkRcjblLHxccnALnvO5s38lf9FD0kZkU+b5gom6Rt3ekj1uZHNpyf1eJUn
         ycfokj0PQ9TKic9L7JNu9vIZWevcIxJe6L2XHCzvBJtxTk+3XNBERDmrRObL9rAVKyK3
         jqdRsmJ/cOuXrn2QlwpHPZnvKnlYzwMNhbL0ysUOBtIn2sFZAtn9KaLzNtmyO30ERFqU
         Ma1rM/JWZkL6XgY+ocSkMMdeXFzmkIiibxO1JUT1bvetJaczP8jw0Dr7e2zWmge8IpmY
         W8PG0t4FaV81W/RwsZUHVv1HoExjum8ND+0Qx3shNXKhTGNK/tBQLacc6szeTRwMqP1R
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327897; x=1733932697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI/FcgkOifwXXzXlvk8zo5YFKecagbmROLu06ZFniA0=;
        b=lagfmH0ph4/wFBlriFZITBA/SwJjPaKYOe9RetI1+RTXMV/XN1CiuVe+0/qpy+XaTL
         hsCon2rpct+3lPRjBxU9PIp2Ih7XjfM9mZFX2pLenwbfCYnoR9qEvbqcy+YQDtB3CT2g
         pp7n/2gWwaT1cPq8yumfu74Cdpe8sCBCHXfMHIl4ciSnh2Yb9+/AlmrQSdwb6DfmTGNW
         0rBtp/J/vpKuNZptGQ48WeQUeDniqytaad36KPK6bazfViCJuEoCA59GbpF7wB7342sB
         Bjn2iXilYqzw0EpIp1TqIOBld9Up8PIoq6aWE8J/b+YOirr84C8gMaIoZkk15FLNFhYq
         v1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXdcTxPEAdKZgsIGWXMO74+Yeof+++/J3r0S3xRb0hVqF1RBG0mUxeWlYFBLf01tEmQuFc+FFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq1CzQUckBPK6ijQ010tsGe2HJTbT3D8Duz/FMmi/dhkq7dbC
	NMYzJx8+lKYG1GcU1iWuW8ppEtdUgbbbq/w9XK1bR0rcSUYQYqjJ2s1O6ib2kXQ=
X-Gm-Gg: ASbGncsQrU4TrzJOOTcS3MqorgyOv9ETTKaPpHWR+3qQBgKuIvbuijkzeIxo3GRwz+9
	EE9ffWBAeASI5T5ek4HsIkY2d+rsIcFNThkRUAZhxOhx1bhzLizwyGsY0bFO0IGmz1RaD/HRI//
	btw9baXxf6F5FPPQoKKZzJu8YceWbcxWJILOJf1YNPKR8MhAlUXEeXo2P6vIFVR3EsbT/T3pGfn
	Bp9DzGJxl/w29tjqjM/rCNPeuoZyRI85kQKL88mISyA7IXGp9kxH12v4aHP7ejlPvJwurfCW8OO
	sLNO
X-Google-Smtp-Source: AGHT+IGPLwKQh57Ead8RRrh1gxEVt29W9QxQJZdC/e01yLZTzadTaRF9r6H13On42Alm4HnNGJ6b+A==
X-Received: by 2002:a05:600c:19d1:b0:434:a765:7f9c with SMTP id 5b1f17b1804b1-434d09acf91mr62725955e9.6.1733327897506;
        Wed, 04 Dec 2024 07:58:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 2/6] serial: sh-sci: Drop __initdata macro for port_cfg
Date: Wed,  4 Dec 2024 17:58:02 +0200
Message-Id: <20241204155806.3781200-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The port_cfg object is used by serial_console_write(), which serves as
the write function for the earlycon device. Marking port_cfg as __initdata
causes it to be freed after kernel initialization, resulting in earlycon
becoming unavailable thereafter. Remove the __initdata macro from port_cfg
to resolve this issue.

Fixes: dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct 'port_cfg'")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 924b803af440..4f5da3254420 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3562,7 +3562,7 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
-- 
2.39.2


