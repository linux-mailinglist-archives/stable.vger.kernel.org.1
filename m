Return-Path: <stable+bounces-50654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66599906BBB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E02B1F2118B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29743143892;
	Thu, 13 Jun 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tU1Drsnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BC14430D;
	Thu, 13 Jun 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278996; cv=none; b=qUvBDQS0kLSmLpNjKWe6Fybf09m8+6GkMq/q2now/7kDV097z+D687B4ovAIX2OQBS85vOdzHy/IJo171XWYmzhL5RRHLvnvHYDeQvTtZ7UafW/d0Y4dOdfxzIcvjK6yZnN4vBZMacGB6fUM1N2ii3Wu8QEyYcxVASYfsDXjozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278996; c=relaxed/simple;
	bh=1sV4tu7k8/g05I9jOl1Kx32WxPqzYYWKOJq64P/RllQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSPUcI4TyINfnIpH3oKH1hF9hetmm4+YQWlCamdvoif1MhPfOKLF4+uT3bXwZ0uKUa6mn/r3Uwn/n+FWWTKuwmTI45nuPHYvzX8bVRSbwfWh8zMD4qhvpY49nx62XiBeIYIb2sZYccxnfEL932k45ZeyVY85QMmRN4EMjFLmBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tU1Drsnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F4C2BBFC;
	Thu, 13 Jun 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278996;
	bh=1sV4tu7k8/g05I9jOl1Kx32WxPqzYYWKOJq64P/RllQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tU1Drsnc0IN0XUnfsnba9tIQN2BonMxWfbJQuVFOwL3vJVTcV0eG0ZxyuCeFAFzBP
	 fALkYGdfUGEam6revxHEPbfyAWSrZhfsg7CZu7WLZ+T5MAtjRXWaTDBaM1kNhDefsy
	 vpN6YS/5c1Cwz2l6lhIsFiisG51AqpmOHBXI5yzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/213] net:fec: Add fec_enet_deinit()
Date: Thu, 13 Jun 2024 13:33:08 +0200
Message-ID: <20240613113233.395073951@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit bf0497f53c8535f99b72041529d3f7708a6e2c0d ]

When fec_probe() fails or fec_drv_remove() needs to release the
fec queue and remove a NAPI context, therefore add a function
corresponding to fec_enet_init() and call fec_enet_deinit() which
does the opposite to release memory and remove a NAPI context.

Fixes: 59d0f7465644 ("net: fec: init multi queue date structure")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240524050528.4115581-1-xiaolei.wang@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9c4c892bfc837..35593b41e6c12 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3320,6 +3320,14 @@ static int fec_enet_init(struct net_device *ndev)
 	return ret;
 }
 
+static void fec_enet_deinit(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	netif_napi_del(&fep->napi);
+	fec_enet_free_queue(ndev);
+}
+
 #ifdef CONFIG_OF
 static int fec_reset_phy(struct platform_device *pdev)
 {
@@ -3687,6 +3695,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -3748,6 +3757,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 	return 0;
 }
-- 
2.43.0




