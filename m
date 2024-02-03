Return-Path: <stable+bounces-18194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2678481C0
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23D5B29685
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D312B77;
	Sat,  3 Feb 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="veLW1lWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4B125C4;
	Sat,  3 Feb 2024 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933616; cv=none; b=keyau0gtQZCkuxuLvGALEyvzzhHj+KjmHXrpIGhEwZMb9G2qaVAYtm95WotSbQiBHQa52b+hpxK1WZtn438+64ILeUysSLa9cNJVIKg6pwJ2CpHYmbDuX7aRzsgY9NYjc4vtUNQEyqLeftloAIeDQFMUCnoIVhbvWjaojRzNI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933616; c=relaxed/simple;
	bh=VJlJyN0SDKSrdJE9dOxy6HBaaaQYdEDkD9PsqJhpr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUz40MqytabOHBKTR5NCRmtHU+XHv0TuvtgLe6SyeYKrFs5DSEM3HsvjOdUXpk+RAKfP65ibazfBLOIYtBy3MoaUDXtz6b1CLHEr1SUtbSChp5hlZVP1Xw7+gO1h1grAl83HCBjvA3273DSuMIFxNNxFP1jtCb7OJ4haIYXBBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=veLW1lWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06309C433C7;
	Sat,  3 Feb 2024 04:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933616;
	bh=VJlJyN0SDKSrdJE9dOxy6HBaaaQYdEDkD9PsqJhpr9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=veLW1lWCrq8pQV7gR90JXMtYuUV6hjKwYMt9SNC3PUrxLXmg5cXEA0gPihNOTwmgp
	 J+99fRLG+wgtx3xlBK6Diz+tcUHQoKw4OShuZ5+3nqkIF/EMHji5QV9r5bO2LwFT/M
	 bV2E1GaQe8n1a9ERRBtY/agjj45b0eEG+oWND5K0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Adam Ford <aford173@gmail.com>
Subject: [PATCH 6.6 182/322] media: rkisp1: Store IRQ lines
Date: Fri,  2 Feb 2024 20:04:39 -0800
Message-ID: <20240203035405.137541743@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 0753874617de883c6d4da903142f334f76a75d70 ]

Store the IRQ lines used by the driver for easy access. These are needed
in future patches which fix IRQ race issues.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-3-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/rockchip/rkisp1/rkisp1-common.h    | 11 ++++++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index d30f0ecb1bfd..104a1dbeff43 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -61,6 +61,14 @@ struct dentry;
 						 RKISP1_CIF_ISP_EXP_END |	\
 						 RKISP1_CIF_ISP_HIST_MEASURE_RDY)
 
+/* IRQ lines */
+enum rkisp1_irq_line {
+	RKISP1_IRQ_ISP = 0,
+	RKISP1_IRQ_MI,
+	RKISP1_IRQ_MIPI,
+	RKISP1_NUM_IRQS,
+};
+
 /* enum for the resizer pads */
 enum rkisp1_rsz_pad {
 	RKISP1_RSZ_PAD_SINK,
@@ -441,7 +449,6 @@ struct rkisp1_debug {
  * struct rkisp1_device - ISP platform device
  *
  * @base_addr:	   base register address
- * @irq:	   the irq number
  * @dev:	   a pointer to the struct device
  * @clk_size:	   number of clocks
  * @clks:	   array of clocks
@@ -459,6 +466,7 @@ struct rkisp1_debug {
  * @stream_lock:   serializes {start/stop}_streaming callbacks between the capture devices.
  * @debug:	   debug params to be exposed on debugfs
  * @info:	   version-specific ISP information
+ * @irqs:          IRQ line numbers
  */
 struct rkisp1_device {
 	void __iomem *base_addr;
@@ -479,6 +487,7 @@ struct rkisp1_device {
 	struct mutex stream_lock; /* serialize {start/stop}_streaming cb between capture devices */
 	struct rkisp1_debug debug;
 	const struct rkisp1_info *info;
+	int irqs[RKISP1_NUM_IRQS];
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 7b8a361d4c4a..f96f821a7b50 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -114,6 +114,7 @@
 struct rkisp1_isr_data {
 	const char *name;
 	irqreturn_t (*isr)(int irq, void *ctx);
+	u32 line_mask;
 };
 
 /* ----------------------------------------------------------------------------
@@ -471,9 +472,9 @@ static const char * const px30_isp_clks[] = {
 };
 
 static const struct rkisp1_isr_data px30_isp_isrs[] = {
-	{ "isp", rkisp1_isp_isr },
-	{ "mi", rkisp1_capture_isr },
-	{ "mipi", rkisp1_csi_isr },
+	{ "isp", rkisp1_isp_isr, BIT(RKISP1_IRQ_ISP) },
+	{ "mi", rkisp1_capture_isr, BIT(RKISP1_IRQ_MI) },
+	{ "mipi", rkisp1_csi_isr, BIT(RKISP1_IRQ_MIPI) },
 };
 
 static const struct rkisp1_info px30_isp_info = {
@@ -492,7 +493,7 @@ static const char * const rk3399_isp_clks[] = {
 };
 
 static const struct rkisp1_isr_data rk3399_isp_isrs[] = {
-	{ NULL, rkisp1_isr },
+	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) | BIT(RKISP1_IRQ_MIPI) },
 };
 
 static const struct rkisp1_info rk3399_isp_info = {
@@ -543,6 +544,9 @@ static int rkisp1_probe(struct platform_device *pdev)
 	if (IS_ERR(rkisp1->base_addr))
 		return PTR_ERR(rkisp1->base_addr);
 
+	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il)
+		rkisp1->irqs[il] = -1;
+
 	for (i = 0; i < info->isr_size; i++) {
 		irq = info->isrs[i].name
 		    ? platform_get_irq_byname(pdev, info->isrs[i].name)
@@ -550,6 +554,11 @@ static int rkisp1_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
+		for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
+			if (info->isrs[i].line_mask & BIT(il))
+				rkisp1->irqs[il] = irq;
+		}
+
 		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
 				       dev_driver_string(dev), dev);
 		if (ret) {
-- 
2.43.0




