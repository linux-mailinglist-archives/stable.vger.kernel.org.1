Return-Path: <stable+bounces-182360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05512BAD863
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C363A62D1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6830594A;
	Tue, 30 Sep 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swRYsQXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96461F152D;
	Tue, 30 Sep 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244689; cv=none; b=HLh1DXqzBBDd1TAUjSsieaIrFTBUnS7RPJ6/7KL5AxiSotXYo7K8Cj2ReqRWAYu59G+ekgNft/AphlTif9yLb9PIAKZIv3x6001AvHXmRx1F3QyR8nKVDqXva0ZOcIir31dCije6qxpykIXp4hC5lYT0BYB7rKB5XXrFtCezbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244689; c=relaxed/simple;
	bh=wZbQKnaanteGfp8G4TLJ2BThy6HeyhVRqtQjQgr/sqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5kmI5YY8ajlFbLOpzY14D2LBmzIVt2JNDiuH8TilGi4FyBBU4iHXuZI41wRwVA3RdrcFNDcitjt4Zq7z2uN6Flw0d3G/qV7qy0sIexahFObf0FgTo/jM61Qxpo3jTrnzpzIv8FG4WGAmvgbOdXZRFK+ooOsZHlkCKjyjMnt/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swRYsQXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32987C4CEF0;
	Tue, 30 Sep 2025 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244689;
	bh=wZbQKnaanteGfp8G4TLJ2BThy6HeyhVRqtQjQgr/sqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swRYsQXMeo/+FcQ44l3rkiTlnXvF4d3OO9QExf5+xvaVyGoqUv+T1t9jBJox74dd/
	 hNNN9cn2S0kj3HWMCZnzQ28aG2MThxaxDpocoTVgHklpJ5b36OBEvtUR3ajH5XKTRW
	 q5IIq81dkVp41AmCilBHo/pssu8rbP8x3lUKkSXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 083/143] net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
Date: Tue, 30 Sep 2025 16:46:47 +0200
Message-ID: <20250930143834.544361423@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit c0054b25e2f1045f47b4954cf13a539e5e6047df ]

A port added to a "single port bridge" operates as standalone, and this
is mutually exclusive to being part of a Linux bridge. In fact,
gswip_port_bridge_join() calls gswip_add_single_port_br() with
add=false, i.e. removes the port from the "single port bridge" to enable
autonomous forwarding.

The blamed commit seems to have incorrectly thought that ds->ops->port_enable()
is called one time per port, during the setup phase of the switch.

However, it is actually called during the ndo_open() implementation of
DSA user ports, which is to say that this sequence of events:

1. ip link set swp0 down
2. ip link add br0 type bridge
3. ip link set swp0 master br0
4. ip link set swp0 up

would cause swp0 to join back the "single port bridge" which step 3 had
just removed it from.

The correct DSA hook for one-time actions per port at switch init time
is ds->ops->port_setup(). This is what seems to match the coder's
intention; also see the comment at the beginning of the file:

 * At the initialization the driver allocates one bridge table entry for
   ~~~~~~~~~~~~~~~~~~~~~
 * each switch port which is used when the port is used without an
 * explicit bridge.

Fixes: 8206e0ce96b3 ("net: dsa: lantiq: Add VLAN unaware bridge offloading")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250918072142.894692-2-vladimir.oltean@nxp.com
Tested-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d40444..d416c072dd28c 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -685,18 +685,27 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
-static int gswip_port_enable(struct dsa_switch *ds, int port,
-			     struct phy_device *phydev)
+static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
 	if (!dsa_is_cpu_port(ds, port)) {
-		u32 mdio_phy = 0;
-
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
+	}
+
+	return 0;
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		u32 mdio_phy = 0;
 
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
@@ -1829,6 +1838,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
 	.port_bridge_join	= gswip_port_bridge_join,
-- 
2.51.0




