Return-Path: <stable+bounces-197082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA935C8DBFE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71E3D4E6CB9
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2C32C93C;
	Thu, 27 Nov 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wc30LcY7"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492D32BF54
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239196; cv=none; b=P+M8C0cNtBZ9E85ISrzJpIWB1IF/FPXsbgV4vMgRb42mQkDwP4xcuLRPmSdV1dSjanC1V45vXYHNoyZKIUo8jQjKAxgkfJ5gwH33jdRLgSfjvRL/sq1n/uG0kA9UG3E8b76x1hTJ9K8fm5fyEJcJziwkOYFmVCv7O2F7a7JS4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239196; c=relaxed/simple;
	bh=IbIDrxgoDHoF8aog/iMyWY3FWH7ZnyYgwNXo+F8LmaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acXXU5E2Ti+yMpUoVWOTICdqqXKVOP8mNJtdaGBGMndDMtp9kvnPJX7MNMDdbb5xBF+l0hO6s4fdAlAs6QwBlo4Y/ezT+uo1UhNR1ymxddfjnkZvl+Vzg16qjYLHkJyhzkoeZFbK2nILTn9jhqLv5uBIPY3Zic3lP8c4kGjaaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wc30LcY7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 23BD41A1DC9;
	Thu, 27 Nov 2025 10:26:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E90836068C;
	Thu, 27 Nov 2025 10:26:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24E03102F275B;
	Thu, 27 Nov 2025 11:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764239191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ty06Lu9jM47nhD5kJlUx5SDRAvr8cRr/zqTlMHAryT0=;
	b=Wc30LcY70goGq8iaS1mGSVu5Y0iZMA/xWEDEr+bupHRRWd7a9GFE4e4teqRSRR6pyVB8YE
	LnD7SV+r4SZYeNSIfoNG9i4+OcYNZEK7xVh1prdAx2i2dHSui/cnQOXTPfhHPKmmiBJFV7
	+kF9yO9uwv/QdeZYARzn8IIdcYZk61+6j6gi/hk1XjzE41HTEiFtaAkus8pN9otPj1Yws+
	8haIUY2u3HFmraaWVyjR77tXzDgy/9M+FO/rSUH7vFAbuYD0d5sq5S3ZYyNI0sOYlBOY+N
	kK4iKRJsX80WCzOi2a+Yd+C74H+JV97zYul1k05CSPggeWkmJDTn9x2wIsY0PA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 27 Nov 2025 11:26:16 +0100
Subject: [PATCH v2 1/2] phy: rockchip: inno-usb2: fix disconnection in
 gadget mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-1-dac8a02cd2ca@bootlin.com>
References: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-0-dac8a02cd2ca@bootlin.com>
In-Reply-To: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-0-dac8a02cd2ca@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, William Wu <wulf@rock-chips.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

From: Louis Chauvet <louis.chauvet@bootlin.com>

When the OTG USB port is used to power the SoC, configured as peripheral
and used in gadget mode, there is a disconnection about 6 seconds after the
gadget is configured and enumerated.

The problem was observed on a Radxa Rock Pi S board, which can only be
powered by the only USB-C connector. That connector is the only one usable
in gadget mode. This implies the USB cable is connected from before boot
and never disconnects while the kernel runs.

The problem happens because of the PHY driver code flow, summarized as:

 * UDC start code (triggered via configfs at any time after boot)
   -> phy_init
       -> rockchip_usb2phy_init
           -> schedule_delayed_work(otg_sm_work [A], 6 sec)
   -> phy_power_on
       -> rockchip_usb2phy_power_on
           -> enable clock
           -> rockchip_usb2phy_reset

 * Now the gadget interface is up and running.

 * 6 seconds later otg_sm_work starts [A]
   -> rockchip_usb2phy_otg_sm_work():
       if (B_IDLE state && VBUS present && ...):
           schedule_delayed_work(&rport->chg_work [B], 0);

 * immediately the chg_detect_work starts [B]
   -> rockchip_chg_detect_work():
       if chg_state is UNDEFINED:
           if (!rport->suspended):
               rockchip_usb2phy_power_off() <--- [X]

At [X], the PHY is powered off, causing a disconnection. This quickly
triggers a new connection and following re-enumeration, but any connection
that had been established during the 6 seconds is broken.

The code already checks for !rport->suspended (which, somewhat
counter-intuitively, means the PHY is powered on), so add a guard for VBUS
as well to avoid a disconnection when a cable is connected.

Fixes: 98898f3bc83c ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec30..0106d7b7ae24 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -821,14 +821,16 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		container_of(work, struct rockchip_usb2phy_port, chg_work.work);
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 	struct regmap *base = get_reg_base(rphy);
-	bool is_dcd, tmout, vout;
+	bool is_dcd, tmout, vout, vbus_attach;
 	unsigned long delay;
 
+	vbus_attach = property_enabled(rphy->grf, &rport->port_cfg->utmi_bvalid);
+
 	dev_dbg(&rport->phy->dev, "chg detection work state = %d\n",
 		rphy->chg_state);
 	switch (rphy->chg_state) {
 	case USB_CHG_STATE_UNDEFINED:
-		if (!rport->suspended)
+		if (!rport->suspended && !vbus_attach)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* put the controller in non-driving mode */
 		property_enable(base, &rphy->phy_cfg->chg_det.opmode, false);

-- 
2.51.1


