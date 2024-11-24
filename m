Return-Path: <stable+bounces-95065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D19D72C0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC057285587
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AF205E1F;
	Sun, 24 Nov 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJK1cL45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B383205E0C;
	Sun, 24 Nov 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455863; cv=none; b=b7UFxPDnHSPFc0Tvnqjfy/fIP8npRtwSehDkujxHHeEZpVfZOmWi2XsMnIVrjBfWuR+tOJQX3lg0rC8r9PSaufyj2FMD/QG477o/OqKmlMNQyDUv/JeuIClvLTx46UQ2TqIXfNPZVWnlj3fKsy8HA25unUn3Yf8VG+Tw6DGWAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455863; c=relaxed/simple;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ0agiBDZQJUkzIkgQmPq/cg5/ATeTv9bvCn+eLD33VGrq8SEvNxzUaiD27QkEn6//ROCclb9saVf8ViXDRIx3IuxMXYT7phmbDp0E2ct1yvrj37ID2aP/aIXahNbnkAlXLVus9OsoXCYwyVIhC7PRXnxeKY4SfbrCdsOc+SljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJK1cL45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1833C4CECC;
	Sun, 24 Nov 2024 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455863;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJK1cL45myoT4Pbl72PEScMPvxm0sja8FbR2Ps6CKqzp5mE+OGEcG0CUKNdFgsHCZ
	 LSmWJ/SX8O+NVg4cb5Xzcru7xZ/4HPTzBmx44N9BF1tV5W646+dqUev0CrTdPxqbHm
	 9NWIE70i+OWv9mNtcuutIlHEuN9+Xp0HbcBIpFTBnroELHrTKN/4XjQ8ZoKGUK/dTb
	 DrYL8S1figl3K8Ik06jGZY9K5pXsFdG4e+v9oz0N4zPmFeN2xxZXzDpaWtKLvy4qLb
	 oOTQWNi/qfpvHkM/yNKngaaXf7qNR7jUBG4nLs8yU4Ma9HEHdvXrWQq8hku9aLolmH
	 posZLtv1x0khA==
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
Subject: [PATCH AUTOSEL 6.11 62/87] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:38:40 -0500
Message-ID: <20241124134102.3344326-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


