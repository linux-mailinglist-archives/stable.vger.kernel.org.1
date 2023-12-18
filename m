Return-Path: <stable+bounces-7438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291781728F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C497728662F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361EA5A868;
	Mon, 18 Dec 2023 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AsYpPVvI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C293D54B;
	Mon, 18 Dec 2023 14:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BEEC433C8;
	Mon, 18 Dec 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908467;
	bh=qyrDsr5GNBFrM6kMe5gOqXCKt96WqCg1Xpwj7ESu968=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsYpPVvINFMYgJUCv8Ggdm2+ynMmFTiIrr5g9zZ/elaY8xlTBLc76RcGLuiJ3hOs6
	 aWfImNuxBaJtdK59G45S3eVh9MxeQu9aRlauxGINo6uDVB1iML0+LSQ8CDRQ+7Xodb
	 hVd7L+5JKIVcrjKHUV7M1/b09Tk6uNat4ouvGFdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 21/62] net: stmmac: Handle disabled MDIO busses from devicetree
Date: Mon, 18 Dec 2023 14:51:45 +0100
Message-ID: <20231218135047.172746765@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index ecc7f4842f849..d9b76e1e09493 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -459,7 +459,11 @@ int stmmac_mdio_register(struct net_device *ndev)
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




