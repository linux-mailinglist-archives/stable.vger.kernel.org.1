Return-Path: <stable+bounces-48009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304D8FCB18
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D858E28F831
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FF19413D;
	Wed,  5 Jun 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4I8IlOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A7194132;
	Wed,  5 Jun 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588208; cv=none; b=KMmyyXGDfMNhgk/NMjVitUcIeBRdO+wfJgVC4PdAUx/beacxmDne5PKCflZmksruAKATzxp3m1HuMwTl3o1lp52zRgw4rau+68SS0n1eMH4lZQyLhur6RTQKUqYbarbCkeaHAwa8CJeyx6Q3Fw7RbXxL596EgULGlatMfSSiiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588208; c=relaxed/simple;
	bh=EYp+tHxTlNi+xqUWCTw9Ze0+vpVOXoGpuZygwD0VbKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdqXmyffDLTC2DaseoaOkgn0gIOtf7y8Gmh/sfWXR80F7v7xSk4AV3dI6sWRed5YjUSn7dhsZr7M6t9RljTsyQwyTXhKUy+Q1kNupfH8sOh+rTP+CzxvfoWhpaiUlySS1os5IyAm3s/irsMH7PsBt/0cDfzJ1Na5rrG12QGKfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4I8IlOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ED3C4AF07;
	Wed,  5 Jun 2024 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588207;
	bh=EYp+tHxTlNi+xqUWCTw9Ze0+vpVOXoGpuZygwD0VbKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4I8IlOcm9hheaO/ZtDY3QYQ7/s5k8u4S8IWQSjjkco4IAXwis9CQrgbT+fvy1I9F
	 8cK2F41xE32iM6pg3WZ93OOtj5BvvloZ1zEF7x0H1vFGdew7HWq9eY1lyT50Hnp+C7
	 STEWWKwjKjkJbdixGHsCD/vc52ojRKXfm78EZLVv5+DT0AVQoDav46d+QjEofMrKFT
	 RxsfrO5Kad+ZbtBqEafoWV7yG8yi4pQLNgRdQ5f9CD5j8FAzEEo1zYWlJFxPUn8Dnh
	 m9g0jHZCp2ptmq5GZG8odkrx0KEiHzINIDWkUyn0f/T5dVR/CFI3wBEIyUnRMtUEdR
	 BMdb2/RnCCapw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 16/28] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date: Wed,  5 Jun 2024 07:48:45 -0400
Message-ID: <20240605114927.2961639-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Krishna Kurapati <quic_kriskura@quicinc.com>

[ Upstream commit 921e109c6200741499ad0136e41cca9d16431c92 ]

All DWC3 Multi Port controllers that exist today only support host mode.
Temporarily map XHCI address space for host-only controllers and parse
XHCI Extended Capabilities registers to read number of usb2 ports and
usb3 ports present on multiport controller. Each USB Port is at least HS
capable.

The port info for usb2 and usb3 phy are identified as num_usb2_ports
and num_usb3_ports and these are used as iterators for phy operations
and for modifying GUSB2PHYCFG/ GUSB3PIPECTL registers accordingly.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240420044901.884098-3-quic_kriskura@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 100041320e8dd..2a93468bdce50 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1867,10 +1868,56 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_get_num_ports(struct dwc3 *dwc)
+{
+	void __iomem *base;
+	u8 major_revision;
+	u32 offset;
+	u32 val;
+
+	/*
+	 * Remap xHCI address space to access XHCI ext cap regs since it is
+	 * needed to get information on number of ports present.
+	 */
+	base = ioremap(dwc->xhci_resources[0].start,
+		       resource_size(&dwc->xhci_resources[0]));
+	if (!base)
+		return -ENOMEM;
+
+	offset = 0;
+	do {
+		offset = xhci_find_next_ext_cap(base, offset,
+						XHCI_EXT_CAPS_PROTOCOL);
+		if (!offset)
+			break;
+
+		val = readl(base + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(val);
+
+		val = readl(base + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
+		} else {
+			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
+				 major_revision);
+		}
+	} while (1);
+
+	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
+		dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+	iounmap(base);
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
+	unsigned int		hw_mode;
 	void __iomem		*regs;
 	struct dwc3		*dwc;
 	int			ret;
@@ -1954,6 +2001,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto err_disable_clks;
 	}
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_get_num_ports(dwc);
+		if (ret)
+			goto err_disable_clks;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 180dd8d29287c..ef80864fcd57b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1039,6 +1039,8 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1187,6 +1189,9 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
+
 	bool			phys_ready;
 
 	struct ulpi		*ulpi;
-- 
2.43.0


