Return-Path: <stable+bounces-81027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4A990DF7
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56AA1F215A6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB52218D7D;
	Fri,  4 Oct 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvbecYG4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEE1E283D;
	Fri,  4 Oct 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066519; cv=none; b=ZBB3pEQhOt+6H+xQoKTx8y56VAkwlXcDAP0kLYw77/wm7J7DglU4C9Lv5ZNrIhKfC/5qD7BeV/ddB8JB7G8pVSfCGvh5l7UyTGR02y9tcmQ8jzXJHUufFccXaAW5A8IOhUIUnlvS/EUBpoS0zRkAkdplkVrh/N6PsUkeoPxPu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066519; c=relaxed/simple;
	bh=R6ujciq4JJRrnvovbSEAsC5ALp4y99Jk0QndgasHk3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+Rq2nwHEwLNupfwiQGKb2MZL+2yQs+8rYIp8nwqxIa/D3whbwY3QmYbjzRO03PKw1T2wkq1L1d82pSwsVXoOjPNR2WYiLgtJn4G5udmx40h2pOB7fxrGk/jVzkn4vuj9iHd5NIBxLTOepNmgXBCw8oV+4MIRdSTknDiWVTW5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvbecYG4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so24771885e9.0;
        Fri, 04 Oct 2024 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728066516; x=1728671316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxeYKpM2Q4pY2mSFZGOr8Df4aSHhLK/ZPcDMOZ4Tm6E=;
        b=QvbecYG4DmQYQnWjDDRrOoAKWYdud5AlRuztiDpBOpwGfcV4cYRrC14awfL8XQOkXv
         fSs0HEhekA5cwm+hBJ3yOfEUYJGbzfzikmLmP5IOYcyG9IEcHqWIRybhQI3dTOwTKoqi
         gB0X2+YaVAHFJrzS16n0AS1hSbfsdGl1Ha/tpQWp4A5ScF3Ge4B23w8PUzts6wTC7L2O
         m/4OhEpiHQ72VBAhXZqihdeXZ9vhhoHIJ77Vk/hcbbD8b74AlqSzohJZnwyPNmzCr/aO
         /DZnl6OXddA6JMTnTwDLgwhX7UtLtlE7LbRZq0UxRJMHafkAWsIrJcaXN6niCP4R7jpu
         uVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728066516; x=1728671316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxeYKpM2Q4pY2mSFZGOr8Df4aSHhLK/ZPcDMOZ4Tm6E=;
        b=k0IEDT28BDSGT4Nnhr718Pa4k+Gi2vOONAWhXjVqeWzXIi/lsj4SStQZPwLQisTzpr
         pEY+2C7w4vGdsZFuhMWG66oVP2Nd+gnxMf6YR9+Tc7ullUK4uNB5cCZnQIredIFDkddu
         WcHdeBzcr0QY4r5aobW/B6BMjI7xlKlXnDq01zFNnTNAunbFKjFCJkOMIZe06agP0li1
         HSFRKrYrJi290jt+5gxZVUrtUcD3N8kYM+E0yUoS+hYdIwhWVKnpUp95IffKlJa2TqA1
         Ay2+XJOicC8DAbwe7u0mchUqPU4UIFV1/IOa57t1p8942yweZZJTk0dq9aB6XKv1sMzP
         9rng==
X-Forwarded-Encrypted: i=1; AJvYcCV/12S8F7dwSaqxKYMqT1uYcR0MUgFXgjSUu8q5ZcsJYHiARFcIR4PaDnhqCwfXqqz7Q+2RsE+h@vger.kernel.org, AJvYcCWW9LfVF+siVBJIm1jq0NPi90UlnDaetfY4r8ZSBIKdsaZjL9VdiQs85oTNB1Sti447Por0Qucy@vger.kernel.org, AJvYcCWpUOwSOAms1EfNQvEeWHQLcwiHjlXi7JpUFUvXnTIgKCFLGEtwchZu0aaXsUGogRx+NQEJwAVq+qIvvGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdm/mF1wdPR9zk6j3oBpmDygF8DuEhNzIEwD/Hu7Ym1Z9iFJUe
	JTPR9YRRH32BfT+sMTezJeHoN1BrC3QrT7KtSXy5Bmoi74YSDAbw
X-Google-Smtp-Source: AGHT+IEsNCrEJP0r79niDXfZvRYF98O1t43V5c+NOEbYu2embuYhfU8nbZ9thVuDal+36S6NguwWFg==
X-Received: by 2002:a05:600c:548a:b0:42c:a905:9384 with SMTP id 5b1f17b1804b1-42f85ab9ffcmr27814045e9.20.1728066514265;
        Fri, 04 Oct 2024 11:28:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d1690f34asm202748f8f.3.2024.10.04.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:28:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: [net PATCH v2] net: phy: Remove LED entry from LEDs list on unregister
Date: Fri,  4 Oct 2024 20:27:58 +0200
Message-ID: <20241004182759.14032-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c938ab4da0eb ("net: phy: Manual remove LEDs to ensure correct
ordering") correctly fixed a problem with using devm_ but missed
removing the LED entry from the LEDs list.

This cause kernel panic on specific scenario where the port for the PHY
is torn down and up and the kmod for the PHY is removed.

On setting the port down the first time, the assosiacted LEDs are
correctly unregistered. The associated kmod for the PHY is now removed.
The kmod is now added again and the port is now put up, the associated LED
are registered again.
On putting the port down again for the second time after these step, the
LED list now have 4 elements. With the first 2 already unregistered
previously and the 2 new one registered again.

This cause a kernel panic as the first 2 element should have been
removed.

Fix this by correctly removing the element when LED is unregistered.

Reported-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
Cc: stable@vger.kernel.org
Fixes: c938ab4da0eb ("net: phy: Manual remove LEDs to ensure correct ordering")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v2:
- Drop second patch
- Add Reviewed-by tag

 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 560e338b307a..499797646580 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3326,10 +3326,11 @@ static __maybe_unused int phy_led_hw_is_supported(struct led_classdev *led_cdev,
 
 static void phy_leds_unregister(struct phy_device *phydev)
 {
-	struct phy_led *phyled;
+	struct phy_led *phyled, *tmp;
 
-	list_for_each_entry(phyled, &phydev->leds, list) {
+	list_for_each_entry_safe(phyled, tmp, &phydev->leds, list) {
 		led_classdev_unregister(&phyled->led_cdev);
+		list_del(&phyled->list);
 	}
 }
 
-- 
2.45.2


