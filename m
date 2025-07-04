Return-Path: <stable+bounces-160220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89572AF9A15
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8377B5E97
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543D12D8393;
	Fri,  4 Jul 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AYeaM9Bc"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6F288CB7;
	Fri,  4 Jul 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651334; cv=none; b=XEx5OAQMYJeDi+rSNWeBaB/ebpWrG/KVnTDJSxrV+XRdC0wJNRE0+G2TNWFhy7IPRuRjUp0hBFgAFyFjuOlJd4Lwli5J4TDpb6mcXrriEKao/jAEzkRP76XvvY7133Uv6lBrWQh2qcTVQkhTej6a1BIbu+DyYA+kBYDPdQcQYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651334; c=relaxed/simple;
	bh=pH2alqUfQKKZd/5SMroJOan/R7rRGQmDaLvmIoSTLsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SiR42WvNX4136n/NBSqPS9mEa2neAIxN3Pm5iq9oMp3Z9ILhonHbDeFMrm/nJWMJspLbPr5LiEOGrww98qy7jssOuLnmMJ3L4M62F1I5fnlgLA49THk0O1z6mmX6S8W6DjLOcq8BvyDSxiZDFcMPPH8fdrjOi8rfTnsMxPm/PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AYeaM9Bc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751651328;
	bh=pH2alqUfQKKZd/5SMroJOan/R7rRGQmDaLvmIoSTLsI=;
	h=From:Date:Subject:To:Cc:From;
	b=AYeaM9BcxjKbB63KwRW18vWpq5SeLLhcVlmXO10GmD5fovYQaHqxFPgk7A+z8NZ8B
	 sK78U9d8euY2gdcABJ9BU8EusJ9imK4WaWcd1IRwrdQpAFimvo/KqjIweoC4oKwel/
	 yGL+JnvkqVzmlZoIF+Ts+2Llt3sJzdol304UUOk/CZNCkKfhnmDEakJ4D9BJtvX1Bh
	 8RxrY1+alh8kBwwgEPMyAWwtIpjTVC1zuWbGMYd0FRkixCtmWHzk5q/KnHCfP3pHJX
	 qAl5lpeiD2eZbAVsA69jroRJpAyrYEDVKPsBlivfQ5AewQQE6dpDSoZMUbZmW8rKxa
	 Oc5eAugFKDp4A==
Received: from jupiter.universe (dyndsl-091-248-191-229.ewe-ip-backbone.de [91.248.191.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16F4F17E0202;
	Fri,  4 Jul 2025 19:48:48 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id CAF90480039; Fri, 04 Jul 2025 19:48:47 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 04 Jul 2025 19:48:44 +0200
Subject: [PATCH net] net: phy: realtek: Reset after clock enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPsTaGgC/x2MzQqDMBAGX0X27EKMtv68iniI69e6KFESkRbx3
 Rt6nIGZiyKCIlKXXRRwatTNJyjyjGR2/g3WKTFZYx+mNhXv85cD3HpgYVk3WfilH37KVLYlGhm
 to9TuAUn/vz15HDTc9w8SF9PlbAAAAA==
X-Change-ID: 20250704-phy-realtek-clock-fix-6cd393e8cb2a
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=sre@kernel.org;
 h=from:subject:message-id; bh=pH2alqUfQKKZd/5SMroJOan/R7rRGQmDaLvmIoSTLsI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGhoE/9kuhThZC9uUhc+SydJjXTClkWudj+jr
 3uQCDIFPdFexokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoaBP/AAoJENju1/PI
 O/qarbYP/RqARAqGLaY+U7cYZ1YCCysuO2LWxXRBBGlzTEEswJ/vb9XBuRwHBQdTi1zyB7W3jku
 szYC/2eO3msYEs4djDxR0dPsdgZh0Hy5m952mEzlAopjBOdUP60BMcxjOcffC/GmHL2/NGLPlUB
 GOD7wwhp/MTDHX0H4BniY+ychaZJncGQquadHp4s3WDZbGFSy8geu89r5yOMCBgymKKjgSW7UB3
 TYkxo2RD+FvJKZb0qIKEFl9nHVtogfBPxJN4quwmZtXewil3kN9cus0MrsBYvamtvRNnHhMBfYN
 90V/1B00xRJAnZ7Vf5CInCBNPLCD5DYy+RUK0E67Yp68PZksCsmxWft/FBJcmbVUMc+apQjahCv
 fUBTOVshcHUJo8SExCb+P9xLOr5P1lnfZjcU368m0RBYOUou/ADj76r1/ICMUcBzijwozoiW/oS
 tgkD+59egWcPd7/w7S5HV/f3fjN8Fl9rJz5mAa4xg8c8yY6XbA66eigqRzIQfmr0o3am/HkbIe2
 T9aQamq73Fj5r1t57kZ4SlT3lHVwpjahk1jx2TTdKiLcFjNPHBHTpUtvIinEFaX48+KsnP41TAh
 VwS0RCqUIg39HMs7TvxMyLR69qphywXs4Po5ygJILNZxmxLmee9OJBgrlv5pGop+DazUcACiBn7
 1lvMIqCx/xlp58cavX5UoWw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
stability (e.g. link loss, or not capable of transceiving packages)
after new board revisions switched from a dedicated crystal to providing
the 25 MHz PHY input clock from the SoC instead.

This board is using a RTL8211F PHY, which is connected to an always-on
regulator. Unfortunately the datasheet does not explicitly mention the
power-up sequence regarding the clock, but it seems to assume that the
clock is always-on (i.e. dedicated crystal).

By doing an explicit reset after enabling the clock, the issue on the
boards could no longer be observed.

Cc: stable@vger.kernel.org
Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/net/phy/realtek/realtek_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index c3dcb62574303374666b46a454cd4e10de455d24..3a783f0c3b4f2a4f6aa63a16ad309e3471b0932a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -231,6 +231,10 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
+	/* enabling the clock might produce glitches, so hard-reset the PHY */
+	phy_device_reset(phydev, 1);
+	phy_device_reset(phydev, 0);
+
 	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;

---
base-commit: 4c06e63b92038fadb566b652ec3ec04e228931e8
change-id: 20250704-phy-realtek-clock-fix-6cd393e8cb2a

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


