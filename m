Return-Path: <stable+bounces-80691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB17398F9A3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199011C2170F
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1101CC143;
	Thu,  3 Oct 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUMi/xmS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6B1C2DB2;
	Thu,  3 Oct 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993441; cv=none; b=BU1Zd+1+ghOaZ0kFwTdIt7cX82h/x77nSrZeoOIK0QSDQReP43uhfLWP55YcjZPDFj7Kgwo04XLEa1KU42FGiOjkJ063QAQ0LSXOp924g0YQ1vU8I3FcbCNYmKlUKgyVU09KUFqx/TGnlymGfyta539k5/ndinvTNmghh2OZKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993441; c=relaxed/simple;
	bh=2ruyZa95IziUZXPWi0IJh7ReSJdmiH/rP39WJPPvJ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnTQvBCJwXo2yFgKmzS2H909MFkQBqspBgxEzy0nuWcLBttTVLOg97ZzsYbzyAJRfbSu0zQ+VmdnRb/j+RdN4Ge3yakmp6o2VvInbXndPkjFryonxGWeZoxJSZePIqFFChqizsGxouRzgYGUBwH/5PH0RYeLHWhxaUH7rceB7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUMi/xmS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so12140925e9.0;
        Thu, 03 Oct 2024 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993438; x=1728598238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C92rcUtVqnNfXPCgxcCPv2PyEiym9G5diOBGvpjsBrU=;
        b=aUMi/xmSHyJQOll0s3hpW77UaM8q8DQdruuNQ0so2O+/0J5gbLfAr5w6Xk/lMt/t9q
         9JyvsRewDK0VePpjPrHUIIIqICmiOrwbfArZ7xs5EYbGCUwtW0t3arR54hElEa5hFchc
         0TvtJSfscn55SrDx4WD94Zpl6JOmAYcNBFNPUcOUa1+FHlqcJMua7iD5GiztYcteASb0
         4qbAVFNPdiFZcCzKl+7tdY3G6BWteun3XXGYfZ+y0SPuZCsnxWcqbp+ZHXrUwngdrKmQ
         mRRjswYqyjAR2nssh67TSB2xfo/Urr9YxSr6LkjH1HCbqsLWUUetRp/KjTxrXYTW+/dF
         gM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993438; x=1728598238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C92rcUtVqnNfXPCgxcCPv2PyEiym9G5diOBGvpjsBrU=;
        b=TpviM2xYTr2uC5zqw/y9Lzt8/mIJix6RzEnorpKcqT9dEALiae6OvEuFjlw5W06Dwy
         dtUYXzg+4J1Xu6487e89f1AGXn1QhStRtX9byDNa8aLpfj3Kff6WqDkdNSl+QWWMUdSt
         i/cq8rOafpsNBHDszeRKJeSIcvphO1ywcor7gJplDrN4azmlschFk6+ooIRRmqWpdI6p
         ZYiDUYIuA/SoXSHFTbzaHMGk0EGQj/crbT2awoWEjUtXki0f6tDeW8KZgMaIB8qpNyn4
         XNMhQ9/LSRTI5qF6NpTnorLpsrUPKT81MfwJSzulqM2s2f4XwTU514SdtU99Df4nhEu1
         Ebzg==
X-Forwarded-Encrypted: i=1; AJvYcCViIZi1xBGNRwitJCSntK873qF2UYnXQmLc2co1mI48dlKDiPuesz+xIjDkdga2me6LDAEujuyW@vger.kernel.org, AJvYcCWF4mBnokF5gzRanA35r5TXOYCcnKdjvdf+tdJZwoKEwUqYW1jtS9dH/61CGBOztggcM2yCwy0W@vger.kernel.org, AJvYcCXQLisbqqV1HI/7GGEIGrV3NxOCgj8Ecd7SCMOXtCqWBzxwFHFMm1hhtfZrDyyJsSon5fRUPenmHcaRXyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uKeinNrI3u6E8hL8qyAlJsTLcntjFbXvnBPdCWFMzqtHxLfy
	FRtdCIg/UoU+1FqtLb3Znl3H7mk8bdM1SOXurdvK45zqUx4XDvor
X-Google-Smtp-Source: AGHT+IGA89vqGhblOrD5/6Jy9UL6C7XcJGVX50m6iOPle18rO83og1WfKAZfbCpwnmg1BTf0BO7Oqw==
X-Received: by 2002:a5d:59a1:0:b0:371:88b9:256d with SMTP id ffacd0b85a97d-37d0e6cae5emr653101f8f.6.1727993438034;
        Thu, 03 Oct 2024 15:10:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d0822995fsm2079334f8f.38.2024.10.03.15.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:10:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: [net PATCH 1/2] net: phy: Remove LED entry from LEDs list on unregister
Date: Fri,  4 Oct 2024 00:10:04 +0200
Message-ID: <20241003221006.4568-1-ansuelsmth@gmail.com>
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
---
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


