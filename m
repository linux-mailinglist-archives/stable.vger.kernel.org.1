Return-Path: <stable+bounces-15033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301F83839B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B9F2946AE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA263406;
	Tue, 23 Jan 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eyiE3tO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15E6313F;
	Tue, 23 Jan 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975019; cv=none; b=KcIN+xmQm9Tof9PlaxS4EBhq/4i2oWOn+dYoDbEa6L3dQMYDBubALID7BYSP/VYMcuCYDr59J7+Am6Ii6lcI0Q9UC90J4qe6tm6SzGkC8yjtS9k0qLZA8bSWShuRmTQPUxg/rAYtmp+SLB1tuJWRcjEVqInGGxENAb257kTHhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975019; c=relaxed/simple;
	bh=ZJIv4dOnbvmQmJSPdM/4K1sz2uO1xlJjKtdIl5PF7Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB9lfE/rFCybbGMMsmuiyEzCuQp0gSMXyTwMzWwMzbNqPNSSwtkS2YwMOY2ZNZWvC68toMy7oYQsxZSrJ1NtcruKXVaF3kSI3dVG6qXPt8bGyXfPTwosay4NJbO/iHNS1dOSReQImsYIDMi4z3PhPXQG4+orRrTn0+p20YdNpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eyiE3tO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98C6C43394;
	Tue, 23 Jan 2024 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975019;
	bh=ZJIv4dOnbvmQmJSPdM/4K1sz2uO1xlJjKtdIl5PF7Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyiE3tO8JBodi86tcIDlyp37pRtCjRqL3eh7ZErEA34OZg5mclHG4UVahVn/ARL6x
	 +YZ2hwmNXNHsRATLaEZhQ0KcsnvwKMGCbCNsY9Cd7fKgVXEzUYOCFg3dqzlNJTkHEI
	 lWCzfbbuCvHxfGU22YXT8/Qh7UPSvWHUysnEVnbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 326/374] usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer
Date: Mon, 22 Jan 2024 15:59:42 -0800
Message-ID: <20240122235756.240071895@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 017dbfc05c31284150819890b4cc86a699cbdb71 ]

For Gen1 isoc-in transfer, host still send out unexpected ACK after device
finish the burst with a short packet, this will cause an exception on the
connected device, such as, a usb 4k camera.
It can be fixed by setting rxfifo depth less than 4k bytes, prefer to use
3k here, the side-effect is that may cause performance drop about 10%,
including bulk transfer.

Fixes: 926d60ae64a6 ("usb: xhci-mtk: modify the SOF/ITP interval for mt8195")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/20240104061640.7335-2-chunfeng.yun@mediatek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-mtk.c | 40 +++++++++++++++++++++++++++++++++++--
 drivers/usb/host/xhci-mtk.h |  2 ++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b55ddc1156cc..4e5c7d3fb4bc 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -7,6 +7,7 @@
  *  Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -72,6 +73,9 @@
 #define FRMCNT_LEV1_RANG	(0x12b << 8)
 #define FRMCNT_LEV1_RANG_MASK	GENMASK(19, 8)
 
+#define HSCH_CFG1		0x960
+#define SCH3_RXFIFO_DEPTH_MASK	GENMASK(21, 20)
+
 #define SS_GEN2_EOF_CFG		0x990
 #define SSG2EOF_OFFSET		0x3c
 
@@ -100,6 +104,8 @@
 #define SSC_IP_SLEEP_EN	BIT(4)
 #define SSC_SPM_INT_EN		BIT(1)
 
+#define SCH_FIFO_TO_KB(x)	((x) >> 10)
+
 enum ssusb_uwk_vers {
 	SSUSB_UWK_V1 = 1,
 	SSUSB_UWK_V2,
@@ -147,6 +153,35 @@ static void xhci_mtk_set_frame_interval(struct xhci_hcd_mtk *mtk)
 	writel(value, hcd->regs + SS_GEN2_EOF_CFG);
 }
 
+/*
+ * workaround: usb3.2 gen1 isoc rx hw issue
+ * host send out unexpected ACK afer device fininsh a burst transfer with
+ * a short packet.
+ */
+static void xhci_mtk_rxfifo_depth_set(struct xhci_hcd_mtk *mtk)
+{
+	struct usb_hcd *hcd = mtk->hcd;
+	u32 value;
+
+	if (!mtk->rxfifo_depth)
+		return;
+
+	value = readl(hcd->regs + HSCH_CFG1);
+	value &= ~SCH3_RXFIFO_DEPTH_MASK;
+	value |= FIELD_PREP(SCH3_RXFIFO_DEPTH_MASK,
+			    SCH_FIFO_TO_KB(mtk->rxfifo_depth) - 1);
+	writel(value, hcd->regs + HSCH_CFG1);
+}
+
+static void xhci_mtk_init_quirk(struct xhci_hcd_mtk *mtk)
+{
+	/* workaround only for mt8195 */
+	xhci_mtk_set_frame_interval(mtk);
+
+	/* workaround for SoCs using SSUSB about before IPM v1.6.0 */
+	xhci_mtk_rxfifo_depth_set(mtk);
+}
+
 static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 {
 	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
@@ -429,8 +464,7 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 		if (ret)
 			return ret;
 
-		/* workaround only for mt8195 */
-		xhci_mtk_set_frame_interval(mtk);
+		xhci_mtk_init_quirk(mtk);
 	}
 
 	ret = xhci_gen_setup(hcd, xhci_mtk_quirks);
@@ -517,6 +551,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	of_property_read_u32(node, "mediatek,u2p-dis-msk",
 			     &mtk->u2p_dis_msk);
 
+	of_property_read_u32(node, "rx-fifo-depth", &mtk->rxfifo_depth);
+
 	ret = usb_wakeup_of_property_parse(mtk, node);
 	if (ret) {
 		dev_err(dev, "failed to parse uwk property\n");
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 4b1ea89f959a..153fc7ba1609 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -161,6 +161,8 @@ struct xhci_hcd_mtk {
 	struct regmap *uwk;
 	u32 uwk_reg_base;
 	u32 uwk_vers;
+	/* quirk */
+	u32 rxfifo_depth;
 };
 
 static inline struct xhci_hcd_mtk *hcd_to_mtk(struct usb_hcd *hcd)
-- 
2.43.0




