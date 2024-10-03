Return-Path: <stable+bounces-80692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DF98F9A6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF6DB2239E
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD751CF296;
	Thu,  3 Oct 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4XqXL0E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F51CEAD7;
	Thu,  3 Oct 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993444; cv=none; b=FDfVPvXirrVd0IBaj0K3GSjOu7vai4PNu8bJJ6jb/KLIPD4PohciinUSX+Rwu3llYIh2xz29/gttFLagxT12GAfo6ruJS1N4ZeNSW6P1wETHbsoLW8jsVNXuYWSt69x+ngd4RnStjDAEzO1YMQhsYD8/S8kGEiYTktwNgaySbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993444; c=relaxed/simple;
	bh=GavArUkKww24mgKtAyasen4ZhpDZdFNpOqgfdzNwIdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icqtrNmfHUu3kjgl6y+1z6ejTzkhSIVT5Pl54NPqV0gkmJQhj9qSaIayfsQnYOeKSB+qfozDYnD63zr4b0aDTxb8ur5zYdazng7B42jpoutEwrL/kHmSEouEIncTF7YbqyhIUt3mBLuWl7nPDXkwZneH6gmlzEDFDF+R0YreTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4XqXL0E; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so887610f8f.2;
        Thu, 03 Oct 2024 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993441; x=1728598241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtyXZhQOdZSWlMwX/3ym2xo9GQ01udbth4iGbL7BUug=;
        b=T4XqXL0E6BxaUjcNuzf+8LwNwFeSHV1LaIQhVce6FV2VoKsohGZnlzIj34q6O7/Z3/
         gqOJJMObAqD7OPmBMHYfjODmHeiwJGwZSmS/xTPosC87rstr1OblyUG0dAYClWZaKiYb
         6IQqRLWufPraRWTZ74IuwN62JFYJmHCx+vihn08eLOxOVwlVkeibHBlBihDkhWctGYyt
         RiroY42nEr0hzQWxGOnvJ8C1r1N7O/WSdpi3IBiyRWGy+gpdVp40BRaQnsPDSuZk9NvB
         iDmh24WKEFJDUp0k0qRyamXt1G079rCy4ByreECPll8hcr4jskybRsVI6Me4MTqK/Xxh
         m0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993441; x=1728598241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtyXZhQOdZSWlMwX/3ym2xo9GQ01udbth4iGbL7BUug=;
        b=axCB9xUwte9p66buF1OQkKXmcIJOoQ004tgrIvkVZ1H8Xzrezz+3sc79li1UFe64Yp
         +v6yZX9/yV82yiy5aU8tjUyEn/NBaOihNCCMZnpA4XmPsDAwCSGoBVCDa6pRTiEjryF7
         waMU2ZbdqIFG0eAMroXhEQiHuFcsV4U1N464ydSppCYY+wVhMf3RCqsojiAYf6ti3Dvr
         dexOlSZBhO5in/K7kUt3QIYRn4glFA+45rGPOf8lZKbH1gCKR8TjaAGsdEuFJ39+syqS
         TEm4ZbbhDfyQW4Y8iKZzrbqWRLU01570h+WVfor3ak916srWgKH7lO861nIhlfDrfaJ+
         SN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU61WmmBM4g6RtaiB9ojIv9onYCqPOBOlS6tMf90lC2X6NQ6NP2InGqxmlzVyIuYMTLymgbYvNd@vger.kernel.org, AJvYcCUq6XqnBqdm24ra88gk56ufkv74qolm3wnbset2Pqe11fJS+Ho4syQEaJeXFRRmEeyPlF2m1Xuw@vger.kernel.org, AJvYcCVSNsagFJr67hjRsyzH/QCT5u4ed5CnQN5IStbJhh6KXH5XsDjIsrhednYA5lfRYyP3FGTAluqrKOBlk0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHH2oMFL+IRLZoW3ypKz3S+TsoM2NKm0AIAzhgeAabb/NFfb46
	TlyFSwVVLiSdOVcacQynbe/wx3MIh2zqH1+fUWIk7x0sTDiAePgh
X-Google-Smtp-Source: AGHT+IGIVO3kNwan/N+L0Eg7udZx2Sx7NC0DNk3w5ImFayGlFUVlPbofnen1833tz6NQFpF+XcWj3w==
X-Received: by 2002:a05:6000:10e:b0:374:c942:a6b4 with SMTP id ffacd0b85a97d-37d0e6f0e26mr439840f8f.20.1727993440506;
        Thu, 03 Oct 2024 15:10:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d0822995fsm2079334f8f.38.2024.10.03.15.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:10:39 -0700 (PDT)
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
Subject: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for Generic PHY driver
Date: Fri,  4 Oct 2024 00:10:05 +0200
Message-ID: <20241003221006.4568-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003221006.4568-1-ansuelsmth@gmail.com>
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It might happen that a PHY driver fails to probe or is not present in
the system as it's a kmod. In such case the Device Tree might have LED
entry but the Generic PHY is probed instead.

In this scenario, PHY LEDs OF registration should be skipped as
controlling the PHY LEDs is not possible.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Cc: stable@vger.kernel.org
Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..af088bf00bae 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3411,6 +3411,11 @@ static int of_phy_leds(struct phy_device *phydev)
 	struct device_node *leds;
 	int err;
 
+	/* Skip LED registration if we are Generic PHY */
+	if (phy_driver_is_genphy(phydev) ||
+	    phy_driver_is_genphy_10g(phydev))
+		return 0;
+
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
 		return 0;
 
-- 
2.45.2


