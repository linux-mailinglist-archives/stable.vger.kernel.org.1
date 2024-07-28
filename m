Return-Path: <stable+bounces-62269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02193E7D0
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01F3B23CD0
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AFD1448C9;
	Sun, 28 Jul 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erWJwJ+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6414431C;
	Sun, 28 Jul 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182836; cv=none; b=NbPhe8mqgIvEZ7P3WUJ5oV2AB/Ecmen/YSbWMhLwp1OFD9ad+8dubhVneGfjwvPoGdRgYh2wOrZLViiFxAdwVbLwZC+q1geA1jW+YKOIGFETmWMpiP8uT49vYyutfCes/sEZFbNfX7vSQqTcUaRoQTHpURBb5E9zREKfufNAbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182836; c=relaxed/simple;
	bh=SH10y7gd0gcz+ofnXhBupe1/Dl/xba400Ea4AucRzEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTO7FVNDPsSss+Gyk22OTQ6RblNedXAJmFBpKrKzlOUDcNHgKgYQKPP90uI60int5UjpqVwH6mrrr0LbEdm5vz7uSPsLR/R75YsGqYwN8F0dPBNC57Dhw3aejh4Eqt5FvnryYzx72GcfpME98M60FXt5Suk73TIOBm3PCrQoVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erWJwJ+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D64C116B1;
	Sun, 28 Jul 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182836;
	bh=SH10y7gd0gcz+ofnXhBupe1/Dl/xba400Ea4AucRzEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erWJwJ+C5qZBxIpNPbOTolHz0mQaWdZ52te+FB8y2m3xgLacxkGt1trDrGTZZGS8W
	 idp88P+AclW25AlLJIzsIT9hFTDUQxFC3b/6RVwYu8HTrd+dAu2I9KasTkkXh7xEht
	 g4kYSDyI+6uL4oMCKPLUkIUb7cNmAdh95SPpYvKye09yeA6MF3nEO5XFiLiR40eSyO
	 eo1iZg20JTDjvOeI+pMFQjy9uuD22MhgAdd0uEMameByXsCee93muxsSrhsJRWcXAa
	 xjARBwRUjAmfmTSfJ7Ll5Mb42WozE0GrFzl+DmprPr+pSJMrBxQWN7Lzo+dJA4ubIV
	 6MY5ZwEBxd4Fw==
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
Subject: [PATCH AUTOSEL 6.6 03/17] usb: cdns3: Add quirk flag to enable suspend residency
Date: Sun, 28 Jul 2024 12:06:39 -0400
Message-ID: <20240728160709.2052627-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 81a9c9d6be08b..57d47348dc193 100644
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
index ee917f1b091c8..1b4ce2da1e4b8 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -389,7 +389,7 @@ static irqreturn_t cdns_drd_irq(int irq, void *data)
 int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -433,6 +433,14 @@ int cdns_drd_init(struct cdns *cdns)
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


