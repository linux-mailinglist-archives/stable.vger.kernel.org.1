Return-Path: <stable+bounces-13744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE7837DA6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63381F221A6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4658232;
	Tue, 23 Jan 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPkpM7le"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E155797;
	Tue, 23 Jan 2024 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970103; cv=none; b=rX31gkp+J0ZsUd/LtpRJY18SL4gFHq12S30ZxeazkASqG5EwoN3s8K7HXu50KURJUmmhNQPCLLJHNQhgN6rPZcnkD+XYCQYbIWhdZm1NJyUy3Etu2ov6qg2akwq24jUJZuTs2IefYT4OwWpDKgxuOB8u6oiEUJAK2hLPjy+6mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970103; c=relaxed/simple;
	bh=maE2XnqWvrDKsk04bL3JYFVFtwZYwYwSjUByr5CPWMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlAHSbFyNcqRsvhuihRBprDknN0BydnsvEdfGi0NlSlqRAnN1zLcqiyGm6Q/Xr4S6o0YKArb2yjgyuR2biGyB08tUdNCc9W6wKl8k8EtEx3/Mtpm7jDAIrevCP9MVJXgB0jmUO4V3WY8r9GLyJGgHStVxzOm94urVWcpauAO9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPkpM7le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288D9C433C7;
	Tue, 23 Jan 2024 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970103;
	bh=maE2XnqWvrDKsk04bL3JYFVFtwZYwYwSjUByr5CPWMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPkpM7le9ECtD0KH4R+YVdF/yNdomKtQeULEK4uM2cvR37l763RFaupuIQJOB4NIL
	 6WUs+vkZAMTEMdWOObWiKwe9KKe1WQY6c6j+rTy0pmUKqQlxsW/VZm4gjzZS8iT/kf
	 6ILn7zadQ0ZEPZPxGVfZw9WjaOjt1kdJZ72+K/zw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 589/641] net: phy: micrel: populate .soft_reset for KSZ9131
Date: Mon, 22 Jan 2024 15:58:13 -0800
Message-ID: <20240122235836.645816448@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit e398822c4751017fe401f57409488f5948d12fb5 ]

The RZ/G3S SMARC Module has 2 KSZ9131 PHYs. In this setup, the KSZ9131 PHY
is used with the ravb Ethernet driver. It has been discovered that when
bringing the Ethernet interface down/up continuously, e.g., with the
following sh script:

$ while :; do ifconfig eth0 down; ifconfig eth0 up; done

the link speed and duplex are wrong after interrupting the bring down/up
operation even though the Ethernet interface is up. To recover from this
state the following configuration sequence is necessary (executed
manually):

$ ifconfig eth0 down
$ ifconfig eth0 up

The behavior has been identified also on the Microchip SAMA7G5-EK board
which runs the macb driver and uses the same PHY.

The order of PHY-related operations in ravb_open() is as follows:
ravb_open() ->
  ravb_phy_start() ->
    ravb_phy_init() ->
      of_phy_connect() ->
        phy_connect_direct() ->
	  phy_attach_direct() ->
	    phy_init_hw() ->
	      phydev->drv->soft_reset()
	      phydev->drv->config_init()
	      phydev->drv->config_intr()
	    phy_resume()
	      kszphy_resume()

The order of PHY-related operations in ravb_close is as follows:
ravb_close() ->
  phy_stop() ->
    phy_suspend() ->
      kszphy_suspend() ->
        genphy_suspend()
	  // set BMCR_PDOWN bit in MII_BMCR

In genphy_suspend() setting the BMCR_PDWN bit in MII_BMCR switches the PHY
to Software Power-Down (SPD) mode (according to the KSZ9131 datasheet).
Thus, when opening the interface after it has been  previously closed (via
ravb_close()), the phydev->drv->config_init() and
phydev->drv->config_intr() reach the KSZ9131 PHY driver via the
ksz9131_config_init() and kszphy_config_intr() functions.

KSZ9131 specifies that the MII management interface remains operational
during SPD (Software Power-Down), but (according to manual):
- Only access to the standard registers (0 through 31) is supported.
- Access to MMD address spaces other than MMD address space 1 is possible
  if the spd_clock_gate_override bit is set.
- Access to MMD address space 1 is not possible.

The spd_clock_gate_override bit is not used in the KSZ9131 driver.

ksz9131_config_init() configures RGMII delay, pad skews and LEDs by
accessesing MMD registers other than those in address space 1.

The datasheet for the KSZ9131 does not specify what happens if registers
from an unsupported address space are accessed while the PHY is in SPD.

To fix the issue the .soft_reset method has been instantiated for KSZ9131,
too. This resets the PHY to the default state before doing any
configurations to it, thus switching it out of SPD.

Fixes: bff5b4b37372 ("net: phy: micrel: add Microchip KSZ9131 initial driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 73ee81c583ef..ce5ad4a82481 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4850,6 +4850,7 @@ static struct phy_driver ksphy_driver[] = {
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9131_type,
 	.probe		= kszphy_probe,
+	.soft_reset	= genphy_soft_reset,
 	.config_init	= ksz9131_config_init,
 	.config_intr	= kszphy_config_intr,
 	.config_aneg	= ksz9131_config_aneg,
-- 
2.43.0




