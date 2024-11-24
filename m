Return-Path: <stable+bounces-95259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317589D775A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801FCB82151
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1FA240FD1;
	Sun, 24 Nov 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9qrDLH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB751E503D;
	Sun, 24 Nov 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456501; cv=none; b=YenK/nOH0/T+2XNoqQKHoJiJ4Dkz2dNnq2Rrqv5BXVKTYkF2Wbh2UHm1urvjGF5/sYjKYQMwWzXHHBVzL0th6AM79hkng6SfqOKdSYll4eJo5MypaSBHgo1GYsmJbdnrWrUAqX8v6DxoU4t/lMRjaYt4JtZnYQ8WL9kaCGjwYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456501; c=relaxed/simple;
	bh=srJlU4aNNbRgnBmPFIN2NWWKkEiHresnpyZ/UyKAXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6ZdqzSChrlh0cKQEAaxbXB3UBSWOIUyRzwl7J9P0S2QnWhShJnSt6FLOeY7gpWcsCgA2+RAhDfRdu3h84Sqn52kHcTywXweGDXvi92ikT1KAFLP7oAEdy17f1OuKkzjGKwe+Ie+IvkjSRjE1NEmklTuvzcRB7Cb0HEAn5LYvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9qrDLH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F858C4CED3;
	Sun, 24 Nov 2024 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456501;
	bh=srJlU4aNNbRgnBmPFIN2NWWKkEiHresnpyZ/UyKAXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9qrDLH9H3+kpK8iW63kibydp0CB9+wN6ZECNcdvizSe2lsvBloGomLtnI9ZNsiEj
	 9YqvSwxw30BZbfkS54NyfySL2uxDqavWCQyAbrBn/TnLLWuR7ouPFFp2hBlKEe8u3b
	 99As4sXnmY0P5VreVr9U8n7+DaNtTpEXwfMa5RgAAg2LjRTnwlAvzh95QCKs7/0o5x
	 zjVq7pkUQ2lP0l3nw1lhtomYqr+MWlP5ZHdExnGtj0I8J1QRSsBJFmD1riftqbb0O7
	 CfFwXcj8MfSY1djxXdso8g6KyENNUtVZc+h19K41DlvsnvKz4zrtcOLQ92WzO0WQwl
	 9HQF39tCznKBQ==
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
Subject: [PATCH AUTOSEL 5.10 24/33] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:53:36 -0500
Message-ID: <20241124135410.3349976-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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


