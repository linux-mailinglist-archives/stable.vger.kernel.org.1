Return-Path: <stable+bounces-7319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC1817202
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320EF1C2454E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6724989E;
	Mon, 18 Dec 2023 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7/0cLuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D63786C;
	Mon, 18 Dec 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2F6C433C8;
	Mon, 18 Dec 2023 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908149;
	bh=zEwDMfVbB70Xwayc0RcbiPGcwUmfIFQtC1YBln2glGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y7/0cLuUdWhkJgk491uJgW60k11Tf6ExB5GKWQ9YmyxXgHYFdQMxn+W1yIW8Vo9Lp
	 14rCEzXBMR6wevPxKL6xRl1/FmK/IS3P+m1YSohYVBcNLbu41O/I9exd7LnwQG8U/Q
	 1LME8RYH97eFU7k53M5081LBnZ3PAkjDvpg0chTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/166] net: stmmac: Handle disabled MDIO busses from devicetree
Date: Mon, 18 Dec 2023 14:50:20 +0100
Message-ID: <20231218135107.438804096@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Halaney <ahalaney@redhat.com>

[ Upstream commit e23c0d21ce9234fbc31ece35663ababbb83f9347 ]

Many hardware configurations have the MDIO bus disabled, and are instead
using some other MDIO bus to talk to the MAC's phy.

of_mdiobus_register() returns -ENODEV in this case. Let's handle it
gracefully instead of failing to probe the MAC.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b94..0542cfd1817e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -591,7 +591,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
 		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}
-- 
2.43.0




