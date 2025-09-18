Return-Path: <stable+bounces-170536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741FB2A527
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B21898C88
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A07342CBA;
	Mon, 18 Aug 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLmcPb23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95467342CB0;
	Mon, 18 Aug 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522957; cv=none; b=Wh6svwMbidBEBjWjfOr2GPCKC+N1KplH739ISJCtQoAgRHWKwcig+CJRWcMVhlSzQU4/QKn1L9+cKdWsC9/vEF4eHyPZVXXfV1uhgnN+o1ib2bq//yg6uH/f/8D53sJ7QRT2zghGVTRxeyvBgdgosJiDCBWBIqMhhscdh4hBrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522957; c=relaxed/simple;
	bh=TNjud2H7hOvjCA7R43tw3sF88Afn9AS6Ud59Ducxjk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiG/RQZFP7K4Ojdu4m2P1VC4gfak/gromOx52RFKVu6Oh+4b/3nvromTO1mVsgMWNOFFZuf/Mspo9aBu3FXD4coJfaOq8kUVyFsc337X2Rond7WgyO4o767U8Yda0JwueH3IFeM2SS0Za217dwjnojAKX8yO0rnUNFE6jacz8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLmcPb23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1876AC116C6;
	Mon, 18 Aug 2025 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522957;
	bh=TNjud2H7hOvjCA7R43tw3sF88Afn9AS6Ud59Ducxjk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLmcPb230KRlJGhyklofY23xb+3y64JyMVsrIDbwdDdI11tedwmdLOqrlNfdWlDUP
	 mUtLU2cczJEucYSNG50zfJODd9m/l34I3NqqwBh9tpXes3wxTmuBhRfl3p7yh7ce1H
	 RT41z5YuL9Sq/Bd8H2sHP0k9MQdTwTsas+X0GFJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Yang <xu.yang_2@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.15 027/515] net: usb: asix_devices: add phy_mask for ax88772 mdio bus
Date: Mon, 18 Aug 2025 14:40:13 +0200
Message-ID: <20250818124459.507196950@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit 4faff70959d51078f9ee8372f8cff0d7045e4114 upstream.

Without setting phy_mask for ax88772 mdio bus, current driver may create
at most 32 mdio phy devices with phy address range from 0x00 ~ 0x1f.
DLink DUB-E100 H/W Ver B1 is such a device. However, only one main phy
device will bind to net phy driver. This is creating issue during system
suspend/resume since phy_polling_mode() in phy_state_machine() will
directly deference member of phydev->drv for non-main phy devices. Then
NULL pointer dereference issue will occur. Due to only external phy or
internal phy is necessary, add phy_mask for ax88772 mdio bus to workarnoud
the issue.

Closes: https://lore.kernel.org/netdev/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250811092931.860333-1-xu.yang_2@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/asix_devices.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbn
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);



