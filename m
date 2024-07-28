Return-Path: <stable+bounces-62301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833C93E830
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABDA1F21013
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB707186E5B;
	Sun, 28 Jul 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLb7F4Ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87336186E4F;
	Sun, 28 Jul 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182954; cv=none; b=jGvV1y7gERFI8SQhvMnXKSDqqbemXo+8taPkGBtXLRybD5XjD+j/SixM0bT6W8b5+gZGG2i3uvJKiSrj4weBq58t4f8ajoxOTkf+XLFEsnIdqAHKCEVYlZYd4Swba1x6RylqKixQdojyzuXOHjkEYq1BMBwK9963FscDEfrwJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182954; c=relaxed/simple;
	bh=bNWE2W3IXLygnyXMiD7vkYLRNmZ3V4s3MClWWoeFX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHQYDJmgeY0A32R0IjdR5jGkOzXqm1HInuOm744GPy48aaHzMqzUTSj2CJFjmI0c4r3314LqhaFnEMcGQFupBeOhOffhn7j16x6erhnoMUA/kt97TpBfsot2sgApwKL/2RQelsdRHi1i7xL2PmDq7dijRQywiLGoMMuGqVgwqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLb7F4Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF7C116B1;
	Sun, 28 Jul 2024 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182954;
	bh=bNWE2W3IXLygnyXMiD7vkYLRNmZ3V4s3MClWWoeFX+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLb7F4EvrxrqkpxZNeiaY//kxFyklTsBc4S+51DfawKkkRS1cQp9U23hYLuN8rm06
	 htX2IuJhkKXJHfK/Yq8w+ddThbs+gWg2Xh0bkJaXCpAvlQ75o/ZIP1tEr6ifWP9850
	 OOnQcEvzJMXhUrrFC5bFpbPsCB08YxF/XVvq5UFiON4Zj5Sedk9Q5ch3SOR3JM4nXZ
	 rYPD/Afzc+SxseXkf0GPwY1N1f0a7CdSrg7omeaKvQQJgbiS6QZxv38u+3KqJ0oqQ4
	 8krZqAb/xVWC6gs25YAU7KM6wi8UTh5Gj8/jLKEWA7k/50BnYQ9r1paodvVEnN9UdI
	 JKeTASJ1kPdrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	pawell@cadence.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/13] usb: cdns3: Add quirk flag to enable suspend residency
Date: Sun, 28 Jul 2024 12:08:45 -0400
Message-ID: <20240728160907.2053634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160907.2053634-1-sashal@kernel.org>
References: <20240728160907.2053634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 0aca19e4037a4143273e90f1b44666b78b4dde9b ]

Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
this bit to be set to workaround a lockup issue with PHY
short suspend intervals [1]. Add a platform quirk flag
to indicate if Suspend Residency should be enabled.

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
i2409 - USB: USB2 PHY locks up due to short suspend

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240516044537.16801-2-r-gunasekaran@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.h |  1 +
 drivers/usb/cdns3/drd.c  | 10 +++++++++-
 drivers/usb/cdns3/drd.h  |  3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 1726799367d19..7d4b8311051d8 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 33ba30f79b337..8e19ee72c1207 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -385,7 +385,7 @@ static irqreturn_t cdns_drd_irq(int irq, void *data)
 int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -429,6 +429,14 @@ int cdns_drd_init(struct cdns *cdns)
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
+
+			if (cdns->pdata &&
+			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+			}
+
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		} else {
 			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index d72370c321d39..1e2aee14d6293 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
 /* OTGREFCLK - bitmasks */
 #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
 
+/* SUPS_CTRL - bitmasks */
+#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
+
 /* OVERRIDE - bitmasks */
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
-- 
2.43.0


