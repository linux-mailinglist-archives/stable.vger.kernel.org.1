Return-Path: <stable+bounces-97051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3B9E28E9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A576BA69DF
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF11F473A;
	Tue,  3 Dec 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rm1utosH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B12D7BF;
	Tue,  3 Dec 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239378; cv=none; b=Ap4bmFa34IH9Cg1fqa3qUP+fkwmngvfF2X7GFCK+XjFWwheMLlQWPG8qP5xAGu9YrHNOlL0Im6+VYwxyGf1sFHWCGwVhZcAPRgexhfO0CQQuL8EdUnHY5CFA+RJTeLHt0GC3X6ym7cNvcPKVx7iKNQc26IDR5CJ2W2M+jBOlqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239378; c=relaxed/simple;
	bh=qygzK5HXTckJpa/BUEaFEAkoz58d5+uqG/d8K36ZCWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShVKzfOIADmYatk6I23Vs6bvKgbZN/SixLJvqzcQ/XjWln/F2ezn3GS/S1O6zPZbeSgRPs2vbJc5b3hcZJeOw42SK+lrQZbxi7kzhW9/g7NSS2Vxvo0esIDZLGuTREcqigFo4B0Y89AmU7Tm/t6EdWpaAaLGxN33UAVYn4KzaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rm1utosH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC0C4CECF;
	Tue,  3 Dec 2024 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239378;
	bh=qygzK5HXTckJpa/BUEaFEAkoz58d5+uqG/d8K36ZCWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rm1utosHRE7S0iZ0bpxkcUQiKRGzhwXqTczMLbqng4qV/vw3m+4eL8rqrt4wyZxLa
	 6tcyjbjA0/dOEMuUY8SbpNIrf46lNImK+nBQ1wvV/DGaljS22L5TDx1HEYyKkX8iLP
	 4v/WRF3uXKLXOnNLdYVAOs83DXOJyZO9zj77KPr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitalii Mordan <mordan@ispras.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 576/817] marvell: pxa168_eth: fix call balance of pep->clk handling routines
Date: Tue,  3 Dec 2024 15:42:28 +0100
Message-ID: <20241203144018.397137373@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitalii Mordan <mordan@ispras.ru>

[ Upstream commit b032ae57d4fe2b2445e3bc190db6fcaa8c102f68 ]

If the clock pep->clk was not enabled in pxa168_eth_probe,
it should not be disabled in any path.

Conversely, if it was enabled in pxa168_eth_probe, it must be disabled
in all error paths to ensure proper cleanup.

Use the devm_clk_get_enabled helper function to ensure proper call balance
for pep->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: a49f37eed22b ("net: add Fast Ethernet driver for PXA168.")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
Link: https://patch.msgid.link/20241121200658.2203871-1-mordan@ispras.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 1a59c952aa01c..45f115e41857b 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1394,18 +1394,15 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 
 	printk(KERN_NOTICE "PXA168 10/100 Ethernet Driver\n");
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Fast Ethernet failed to get clock\n");
+		dev_err(&pdev->dev, "Fast Ethernet failed to get and enable clock\n");
 		return -ENODEV;
 	}
-	clk_prepare_enable(clk);
 
 	dev = alloc_etherdev(sizeof(struct pxa168_eth_private));
-	if (!dev) {
-		err = -ENOMEM;
-		goto err_clk;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, dev);
 	pep = netdev_priv(dev);
@@ -1523,8 +1520,6 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 	mdiobus_free(pep->smi_bus);
 err_netdev:
 	free_netdev(dev);
-err_clk:
-	clk_disable_unprepare(clk);
 	return err;
 }
 
@@ -1542,7 +1537,6 @@ static void pxa168_eth_remove(struct platform_device *pdev)
 	if (dev->phydev)
 		phy_disconnect(dev->phydev);
 
-	clk_disable_unprepare(pep->clk);
 	mdiobus_unregister(pep->smi_bus);
 	mdiobus_free(pep->smi_bus);
 	unregister_netdev(dev);
-- 
2.43.0




