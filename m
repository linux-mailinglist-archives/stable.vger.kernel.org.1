Return-Path: <stable+bounces-114085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349BA2A8EC
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1378E188778A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411822E3EC;
	Thu,  6 Feb 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XrTLxR5w"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755013D897;
	Thu,  6 Feb 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846802; cv=none; b=gzaYN8NjKK4sZuUHvXbak34ynpz+qGq9u5zeBN6wiKUUY9OTe2TfooE11x9eAYta+MOYtGz0uvpi2OCxjZegHn6gWVOSKAbucP0g/GP+Kz86J/2eTSB6UZm3S9c7b2Oj7zyKJfpPGSguLdKKwlovn9CkuCG7Pou6ztDdPJcdask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846802; c=relaxed/simple;
	bh=xxbDZdqWo3K/8PCwFPnRCr7uf9tUfjynoOu26v/FlfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuhzFgN+1EUMMdGTKzY9wohWqLqLsr5yR6lTRXBtrVCFjXeni1e0io5iEI01QGXvZjJav2D9jX0/AYH1dm5VH3jvPV66XEZZ6ipgMoAI6Gumqy+8YTxiYsnkFdbiI8vV2E2EeHHx8N+G9kiKW/ItYmHJTzQjGJ7m7AjBsdJS0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XrTLxR5w; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516Cxmmr3553666
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 06:59:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738846788;
	bh=Mv0wdh7SmM7WMLkdwxSV1wkm7zvheEOu8m9g8tZ+KPI=;
	h=From:To:CC:Subject:Date;
	b=XrTLxR5wO8p6ersm33yDywbwUdJb5nIdCWOIuRR2+l8AnSWrgBBsCi40/sqGEZ9qq
	 TRNHphQJO7WGmGZn2oiSJ8YrYp3kDbFjuilteo542lDVMKNSRma3Y/b+XGTqjm8M7X
	 qW7ubqUEzu+OWEbVngTMOgwR7fLGI7RIeChkMwuo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 516Cxm5T012943
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Feb 2025 06:59:48 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 06:59:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 06:59:48 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516CxhVf101205;
	Thu, 6 Feb 2025 06:59:44 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>,
        <gregkh@linuxfoundation.org>, <balbi@kernel.org>, <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: cdns3: exit cdns3_gadget_udc_start if FAST_REG_ACCESS cannot be set
Date: Thu, 6 Feb 2025 18:29:36 +0530
Message-ID: <20250206125943.786949-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When the device is in a low power state, access to the following
registers takes a long time:
- EP_CFG
- EP_TRADDR
- EP_CMD
- EP_SEL
- EP_STS
- USB_CONF

To address this, the fast register access feature can be enabled by
setting PUSB_PWR_FST_REG_ACCESS bit of the USB_PWR register, which
allows quick access by software. Software is expected to poll on
PUSB_PWR_FST_REG_ACCESS_STAT to ensure that fast register access has
been enabled by the controller. Attempting to access any of the
aforementioned registers after setting PUSB_PWR_FST_REG_ACCESS but
before PUSB_PWR_FST_REG_ACCESS_STAT has been set will result in
undefined behavior and potentially result in system hang.

Hence, poll on PUSB_PWR_FST_REG_ACCESS_STAT before proceeding with
gadget configuration, and exit if it cannot be enabled.

Fixes: b5148d946f45 ("usb: cdns3: gadget: set fast access bit")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
of Mainline Linux.

Regards,
Siddharth.

 drivers/usb/cdns3/cdns3-gadget.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba7..b62691944272 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2971,8 +2971,6 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 	/* enable generic interrupt*/
 	writel(USB_IEN_INIT, &regs->usb_ien);
 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
-	/*  keep Fast Access bit */
-	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
 
 	cdns3_configure_dmult(priv_dev, NULL);
 }
@@ -2990,6 +2988,8 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
 	unsigned long flags;
 	enum usb_device_speed max_speed = driver->max_speed;
+	int ret;
+	u32 reg;
 
 	spin_lock_irqsave(&priv_dev->lock, flags);
 	priv_dev->gadget_driver = driver;
@@ -2997,6 +2997,20 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
 	/* limit speed if necessary */
 	max_speed = min(driver->max_speed, gadget->max_speed);
 
+	/*  keep Fast Access bit */
+	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
+	reg = readl(&priv_dev->regs->usb_pwr);
+	if (!(reg & PUSB_PWR_FST_REG_ACCESS_STAT)) {
+		ret = readl_poll_timeout_atomic(&priv_dev->regs->usb_pwr, reg,
+						(reg & PUSB_PWR_FST_REG_ACCESS_STAT),
+						10, 1000);
+		if (ret) {
+			dev_err(priv_dev->dev, "Failed to enable fast access\n");
+			spin_unlock_irqrestore(&priv_dev->lock, flags);
+			return ret;
+		}
+	}
+
 	switch (max_speed) {
 	case USB_SPEED_FULL:
 		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
-- 
2.43.0


