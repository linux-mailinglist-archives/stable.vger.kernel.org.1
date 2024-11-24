Return-Path: <stable+bounces-95226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401A9D7457
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB728718C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109823F341;
	Sun, 24 Nov 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPDwV2Zr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B651E3789;
	Sun, 24 Nov 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456399; cv=none; b=dbG9T7TVZ8bE28kWHU2WrbRsyZsfsBxSQ4S7anPwnNG4KLblZTrs7LwN6SkSV/BX7jNFhsQRnAVxUCWZEUkI8yDBLB/0DRcQM6F18pzIvQciaLN850BAfl8laPj6ZK6mCNZFYxR5dQQyUJnWxWTVQ1ZiIBoe0o8sXPm1DyAT00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456399; c=relaxed/simple;
	bh=srJlU4aNNbRgnBmPFIN2NWWKkEiHresnpyZ/UyKAXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cecGQRkJQtJjHwLuuig7VGtgpFbOMo+vGjSVo4cGzFeqvOj+44mQTpBw/M6H+2Yhm8pK/LTwFPzWWRu1kbeusahV7pxu45d+PPzfDYVC6KPjoXg9/d0cR3ryzMbPOvWjRN7voVxbQk2MhMLaj3sBHWUdX7GHuisanZG5VygnjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPDwV2Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5266C4CECC;
	Sun, 24 Nov 2024 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456399;
	bh=srJlU4aNNbRgnBmPFIN2NWWKkEiHresnpyZ/UyKAXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPDwV2ZrB9mACDWO+NfRXV4dIdlOGmX09+GZCRpqADjhJQU2WeZ7P3equZCkfPZOa
	 FTUOCJ1FdiAQr2ACn+pmx8iXu2dAaTPTQxF7SuyyCx/njsRjtCf+HzikbSG66ypcst
	 jM2e1BCB5NrbrLTSV/GWO0zlAkGDZhJ7UOxmlutj34lru2hatka+ev0ng/eaHZUg7D
	 8g7XOPu2hsL5wEHgdPdvFBsFE+uSPh2pqodES9Cky1aF+ZB7NN2RETVAFCzFvU9wNh
	 uo8+t208edQN0KRT1+EkmTIKVXUVGl6wRy4X2P1iXeWGugAtlEwYB4nmtptAZog698
	 p2bZhmiF1p5Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/36] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:51:41 -0500
Message-ID: <20241124135219.3349183-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit a52201fb9caa9b33b4d881725d1ec733438b07f2 ]

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 15f37c5b8dc14..ffa7caabd8c99 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -4,6 +4,8 @@
 #include <linux/of_mdio.h>
 #include "enetc_pf.h"
 
+#define NETC_EMDIO_VEN_ID	0x1131
+#define NETC_EMDIO_DEV_ID	0xee00
 #define ENETC_MDIO_DEV_ID	0xee01
 #define ENETC_MDIO_DEV_NAME	"FSL PCIe IE Central MDIO"
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
@@ -94,6 +96,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.43.0


