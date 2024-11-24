Return-Path: <stable+bounces-94973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E569D740D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C195B2F276
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C71E32DA;
	Sun, 24 Nov 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByG9Tiud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288881E32C8;
	Sun, 24 Nov 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455456; cv=none; b=J7mOjlAKkLF13O4FeJgCmP4r/g2pLkiKeJl+bCsgolimToXFGeOHQe5wsrJ62h+xlCEAa2Hqk5ME5ssBchapbRKd5obKCFh1AZEcAN+HZNA8aBmd8O6P3n75eE/Ufls64QVKaqPTVpDgnCSzukM4jN7Qt0jb2d5aOQPCk3sJtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455456; c=relaxed/simple;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZLxR2ljEI+q8MIHcDNyjbazgzWDTJSAmO6B+go0kwOjGwKhsjg190OrbiOEBDTXoMTy3Se+vqpRAExTc5TjpnnqHgqGCKFrlQGE9UuxyMhX+4R6n7n/KYLGu6z9+dTSFbjPQ3wS0jkIeR2iYDQhqxqIf8JG1Ufqg9rHilmQo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByG9Tiud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D5C4CECC;
	Sun, 24 Nov 2024 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455455;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByG9TiudELLxwy/ki8VX+7vpZC7DkvLAjUzvu+EpmichKOrcG0aGdHnPkTtKiJOX4
	 dxT8fElm0itVPTvn2+eBVtljTLhRGFRaY5IQ80Plzw6NcKqwZVoBL6eRxhnxlL74Bo
	 StZ7BsYf649ndit5tPuXjfhtnwCTVcV0eIWHieQVyWTuaKn9wVnxTzwqAbqH2cVtfX
	 3oEQZQf4rRv7WcabnXe3i5SdgE1AlHAlWCAEqpGzF+BpE9Xicx4zih/dWB2dGSx4wb
	 sw/qrxfVPju3af13lJiIpcAGr1PZkRrai1UA+14nKplfZQULvIOGo7d1ElzHqFbQB1
	 s9CaO3hzNKIMg==
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
Subject: [PATCH AUTOSEL 6.12 077/107] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:29:37 -0500
Message-ID: <20241124133301.3341829-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index e178cd9375a13..e108cac8288d3 100644
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
@@ -124,6 +126,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.43.0


