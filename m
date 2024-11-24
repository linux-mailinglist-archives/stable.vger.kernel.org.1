Return-Path: <stable+bounces-95288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66F9D74ED
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1449C1652FB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2041FE457;
	Sun, 24 Nov 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCAz8iX+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F651FE44D;
	Sun, 24 Nov 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456592; cv=none; b=bPDfoMyUPD4ivwODanmxnwuUQ7q29tBKbAei4QdD1zXqsgiwuag7PtKeHk6xETYVrNfRWFcI8zkPm2oHOd1Zxcl0g1i26WU/nzKCz25GQg+/GXk5RHx/YoAfAcenA2G7P4BvzR++ZvbyEq9tDYcXsCOciFKi0gQzd0dKA89sL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456592; c=relaxed/simple;
	bh=ttcfOWb4cgTr6uMTNT+d9shflIzpo9/f8EQx30jS0AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWtv0upUJKzKZY+W7tMBy6EVrFPDUoldfSxWrsvUYEWbC+NnYO5nSZnP5eDEXMp3lPuzOV95A6WxI0nZL3+HH1vjKXhivayokmbGt+ddDQp9eI++UmK2ukYY/HYE6mkb2fbN4cAAnT59riNbkd9UCJOfODrViE/DXS3r4AkygUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCAz8iX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE09C4CECC;
	Sun, 24 Nov 2024 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456592;
	bh=ttcfOWb4cgTr6uMTNT+d9shflIzpo9/f8EQx30jS0AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCAz8iX+3uqTH0jauiEe97PYlAFnaNRldEK1ru+gmxeF3Oo4amZz3KSplHlgOO4Dx
	 Q2WaxIEEqi8FD5b94dUZc7rybcnoj9QHFNg2bAwzDpXAwgYjbEqTeqUUL1b71UYdEl
	 +tPBaiTvFe5Tetd+91HfjwTbNvsEHzMzYYKs2bIXGC1ugv6jsx1KO7wZLw0m5+G3qp
	 IgHex1d7zoF+cFov1EGbMO8XGxI6Ixs0Q9JcjllaHEmk1MSWKiNKT2+f5TosZ2uw+M
	 3ei1d1opxeFaLzgmrI+aDMZAMK+z0a+ZUwA5xdaSLLawUCfJNpdH+kJXKk6KwUA44G
	 ij4HPShuH+Crw==
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
Subject: [PATCH AUTOSEL 5.4 20/28] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:55:20 -0500
Message-ID: <20241124135549.3350700-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index fbd41ce01f068..aeffc3bd00afe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -3,6 +3,8 @@
 #include <linux/of_mdio.h>
 #include "enetc_mdio.h"
 
+#define NETC_EMDIO_VEN_ID	0x1131
+#define NETC_EMDIO_DEV_ID	0xee00
 #define ENETC_MDIO_DEV_ID	0xee01
 #define ENETC_MDIO_DEV_NAME	"FSL PCIe IE Central MDIO"
 #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
@@ -85,6 +87,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.43.0


