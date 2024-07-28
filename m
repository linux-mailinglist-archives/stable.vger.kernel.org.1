Return-Path: <stable+bounces-62247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4CA93E784
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2523B225B8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899227E112;
	Sun, 28 Jul 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMHp6wXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7C7E0E9;
	Sun, 28 Jul 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182749; cv=none; b=RaT3xDHZvlYuoENcuKRB7jezzkxixV6ks9KIF8P747vmUQenVuOdxUVueAPbAIBKy87YHqUu4D73TgWy6gGM10d1je5524rnHAcbMAzTmvW6KQ8TRnbTWqvxh1vvWiWlD8xeX7SUyAHzfVWIh3xcmGhFzMZt0cih7xGiqe/zz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182749; c=relaxed/simple;
	bh=a8/lOQG2ygBLs+gxW2ifnNKVEh9hog38oEdBdjw2/6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPp95rVgmnVqVJ5LUEf4TLi0osL7p4PQGwHe/S59ioc8PdxjkA88iB0JHrHxwjcrwUDz/qgEKyAtx6HqBSx6+dLnYdm1qqZIkyyp8mt+VHfH2j3osyMVafrVeMa3NLyMLk1xyeJ9SUnY6xVo3WtYyQqdcu7w3qfis79cytkuLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMHp6wXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C73C116B1;
	Sun, 28 Jul 2024 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182748;
	bh=a8/lOQG2ygBLs+gxW2ifnNKVEh9hog38oEdBdjw2/6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMHp6wXXZPl45a90kZfl34eYm3jDiTRBxCAbrwyjMGJEv9gX1Sx/yTpEFL3wmGn3a
	 xDJcQjPdDkZxotsLF5sdUmVFULRwmFc6S0NA8WEPkf2V3d1cwKKnIZCy80kJg15lcV
	 hAoHliT4FB4wnAyfFYVC8W1VRdCfk6YV3/PbF8Dpp13xGCySL0JMYrE9Lv8Vt0Rd7A
	 iSI9nCuXFqsZxcr84TAcwNf0eOdxd7ydenYaZ5DS4yadfTtpEu6SX+zDS2aSvRjFSB
	 t+6E2hTrCUaA1MRE3qPS7WtacbbD+G5Upj7bppAhBbpr9FjfSCH4/hJ5NfEffe93CV
	 vNs5zexF9eq3A==
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
Subject: [PATCH AUTOSEL 6.10 04/23] usb: cdns3: Add quirk flag to enable suspend residency
Date: Sun, 28 Jul 2024 12:04:45 -0400
Message-ID: <20240728160538.2051879-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 8b936a2e93a0d..84fb38a5723a3 100644
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
 			dev_err(cdns->dev, "not supported DID=0x%08x\n", state);
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


