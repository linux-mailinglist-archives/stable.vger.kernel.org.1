Return-Path: <stable+bounces-16593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40C840D9C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31811F2CF4F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4815B995;
	Mon, 29 Jan 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aFuCovP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BC15A4A3;
	Mon, 29 Jan 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548134; cv=none; b=jmwb3oYM9oxeAm5bNzXiiXfH6aSwaoaRGaACZr89o9yTt5m5Nihg5e69Gj+9yP0coAs//plaIa4Xukgj07aU35SXDfMKNgjzKBXmI1NONzDqlUQosrvWrrUCOjxuMGh0yTiIUbW1u/xE1Zln+ZO/4eHe3NPexChWCT/D70Wuz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548134; c=relaxed/simple;
	bh=VWnFCHyNs3OLx7gn5lkjxpn07F7a+hMk8PR9xBPIxM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8Yh9C/twn3hW2VDoriWX03uXgwCahbrea5/meQ2x8ARPtHfb3D85V3ry8bLQtWPrLSpmsmM3sLZnVT0ixnP3dFhGuzcAf+rGWTb6YBB+exjTpEvTbEt/iAb/+j555FZO4EMm+M8Wz2Y2gK7EMHncvKE1lR+VAWqApZolW+M/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aFuCovP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66900C433C7;
	Mon, 29 Jan 2024 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548134;
	bh=VWnFCHyNs3OLx7gn5lkjxpn07F7a+hMk8PR9xBPIxM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1aFuCovPXsKSSC+t5b1GxFmbrdfAV7wSqMYzTAviFuoJmg55rMv0zx0cOdcbGzMH6
	 SO8Ks10WH/nqStIcOY5/jDxRC1GTtTmg37Hz11h+j8DyFnqpyCDFpejylL61T8WfMg
	 Cq9gQWfqpHBWvLhavApPEFQ4kKfVUl+zQNehHZIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Divya Koppera <divya.koppera@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 165/346] net: micrel: Fix PTP frame parsing for lan8814
Date: Mon, 29 Jan 2024 09:03:16 -0800
Message-ID: <20240129170021.252385544@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit aaf632f7ab6dec57bc9329a438f94504fe8034b9 ]

The HW has the capability to check each frame if it is a PTP frame,
which domain it is, which ptp frame type it is, different ip address in
the frame. And if one of these checks fail then the frame is not
timestamp. Most of these checks were disabled except checking the field
minorVersionPTP inside the PTP header. Meaning that once a partner sends
a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
frame was not timestamp because the HW expected by default a value of 0
in minorVersionPTP. This is exactly the same issue as on lan8841.
Fix this issue by removing this check so the userspace can decide on this.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Divya Koppera <divya.koppera@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ce5ad4a82481..858175ca58cd 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -120,6 +120,11 @@
  */
 #define LAN8814_1PPM_FORMAT			17179
 
+#define PTP_RX_VERSION				0x0248
+#define PTP_TX_VERSION				0x0288
+#define PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
+#define PTP_MIN_VERSION(x)			((x) & GENMASK(7, 0))
+
 #define PTP_RX_MOD				0x024F
 #define PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_ BIT(3)
 #define PTP_RX_TIMESTAMP_EN			0x024D
@@ -3147,6 +3152,12 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
 	lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
 
+	/* Disable checking for minorVersionPTP field */
+	lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION,
+			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
+	lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION,
+			      PTP_MAX_VERSION(0xff) | PTP_MIN_VERSION(0x0));
+
 	skb_queue_head_init(&ptp_priv->tx_queue);
 	skb_queue_head_init(&ptp_priv->rx_queue);
 	INIT_LIST_HEAD(&ptp_priv->rx_ts_list);
-- 
2.43.0




