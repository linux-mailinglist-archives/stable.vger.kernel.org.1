Return-Path: <stable+bounces-95134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D09D7394
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82042165709
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46F224BE8;
	Sun, 24 Nov 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJkjhw3+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9E1F682F;
	Sun, 24 Nov 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456105; cv=none; b=aG0vV+CAYTFNaBrVGF78UdosZO1mel0o+yhTdh1n5p/727lUdLyIX0L/5SckfZsMFXCQM52hRZVmjtsSzKsDpCM9uhXNai7+1LiYyENcLx9G8C8tXmoqu4DU0YA9igLYSroSgizje1QJKa0f4cZNiiQyxFZjUXBjdhZuGhTwvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456105; c=relaxed/simple;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7xbOXARdcSllkBxm0321ezxnwoVXkjgZQCvufdOuTghwOQm5mK4YbIWC5ial5tLchRnwu2oOMpI9cVzzbm0u2ffWGpkLzBsLMttoheEDaCxlVVWEn7+f+45G+HykqRLWbTU8Wlp2b3uCWK8aEi0v0Hg7a+4pchc4v/m3YeYDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJkjhw3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49634C4CECC;
	Sun, 24 Nov 2024 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456105;
	bh=IrncszXAlY37bheEyzX1W0R8+6aW7EZqwIL8KR6xRCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJkjhw3+URqJT2Gw9mb+8Gsa8FY4w8PFhCHpYNHAZkFIaA5DIeHTsy41jNO5eyoXQ
	 p6/x2mOtI+xJQMikfUALlN38mtzDv8e7js/tmg+KLBR26SrY1OWYA19MVyDsMWcMZt
	 jdMdKb3hku/sHO/H+bIq+ITciL7oJfDa8luj0s/XR2rNo2z21SJfFEOF525DStn4pp
	 cRhNQ3vvMPIH28aLnpl7et8M9+eX452JGAfQxAjEGrh+kVOHytS4mQMwGTdqwhot7k
	 7xunckgB0CRD+tK+eLAR3KKTMChjXdRPNIsED0BRhiEpbPEbjdL0v3rQ55Qq4MjPt8
	 2f0GrvbnUFVZA==
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
Subject: [PATCH AUTOSEL 6.6 44/61] net: enetc: add i.MX95 EMDIO support
Date: Sun, 24 Nov 2024 08:45:19 -0500
Message-ID: <20241124134637.3346391-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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


