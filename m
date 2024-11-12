Return-Path: <stable+bounces-92328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EE9C5567
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED26B285B7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AC20EA37;
	Tue, 12 Nov 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="faB/ENWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347820E31D;
	Tue, 12 Nov 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407297; cv=none; b=WICtcquLEFBsfSmbaOK7Is3f7KauzMsASeFfg+3Cfc2rOZk2CHCFw0hO5JY8TUjnOQ3nGeN9tgl7PE1rtE0N4uqUuqeUTw3fUTeuqbuE17oRZcsojXAJopszwfVeWpwWiQJpbhPqMQMw5nSOscpc6PSPuQWMVMQpsRXvCS9B7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407297; c=relaxed/simple;
	bh=I1+WChsAd4l3+oeaKBWi/C+W396I0Rn7zSDJsOc1EbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyG8etp6Bhxy1piD+TjOJJayCUEkjOFX88UrSdhHIouO3rk/QtitrmAWmOwluPCh4RFOnUH/4Lf5T0J7RPGYr6gWJUDwE4BVnUvNbzCF2AQn9bHzlPoMy5aP5AuG+YXyedyaEBX2CQ9uQLpKju9ii5OGBlJ+Gn9bl55vtds+Td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=faB/ENWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FD5C4CECD;
	Tue, 12 Nov 2024 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407297;
	bh=I1+WChsAd4l3+oeaKBWi/C+W396I0Rn7zSDJsOc1EbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=faB/ENWXBQUWyyU2o9C61J1ELhv+MnR35+84atb9kSEkMrlxYbQk2QgV8ntl9Z3g5
	 1I9I0ngeOc4tlZp/CxVLjwHWkZxPwfO9ItyCvhYJWPJzVta+LFw3gMozRCYNtHmJUH
	 4mpZGHTHrPt6i5UD8U3EoSkdsLDV4PDWLQJfUw3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Jonker <jbx6244@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 33/98] net: arc: rockchip: fix emac mdio node support
Date: Tue, 12 Nov 2024 11:20:48 +0100
Message-ID: <20241112101845.534988251@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 0a1c7a7b0adbf595ce7f218609db53749e966573 ]

The binding emac_rockchip.txt is converted to YAML.
Changed against the original binding is an added MDIO subnode.
This make the driver failed to find the PHY, and given the 'mdio
has invalid PHY address' it is probably looking in the wrong node.
Fix emac_mdio.c so that it can handle both old and new
device trees.

Fixes: 1dabb74971b3 ("ARM: dts: rockchip: restyle emac nodes")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Tested-by: Andy Yan <andyshrk@163.com>
Link: https://lore.kernel.org/r/20220603163539.537-3-jbx6244@gmail.com
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/arc/emac_mdio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/arc/emac_mdio.c b/drivers/net/ethernet/arc/emac_mdio.c
index 87f40c2ba9040..078b1a72c1613 100644
--- a/drivers/net/ethernet/arc/emac_mdio.c
+++ b/drivers/net/ethernet/arc/emac_mdio.c
@@ -133,6 +133,7 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 	struct arc_emac_mdio_bus_data *data = &priv->bus_data;
 	struct device_node *np = priv->dev->of_node;
 	const char *name = "Synopsys MII Bus";
+	struct device_node *mdio_node;
 	struct mii_bus *bus;
 	int error;
 
@@ -164,7 +165,13 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", bus->name);
 
-	error = of_mdiobus_register(bus, priv->dev->of_node);
+	/* Backwards compatibility for EMAC nodes without MDIO subnode. */
+	mdio_node = of_get_child_by_name(np, "mdio");
+	if (!mdio_node)
+		mdio_node = of_node_get(np);
+
+	error = of_mdiobus_register(bus, mdio_node);
+	of_node_put(mdio_node);
 	if (error) {
 		mdiobus_free(bus);
 		return dev_err_probe(priv->dev, error,
-- 
2.43.0




