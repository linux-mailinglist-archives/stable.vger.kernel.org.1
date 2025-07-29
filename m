Return-Path: <stable+bounces-165028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C714B14744
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A45D17ED51
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964522D7A5;
	Tue, 29 Jul 2025 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a89ex5rM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAF227599
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763340; cv=none; b=bic7hO+wQd59/3kbD43NEj5SFsVxx+5lybmCiC0XtjW5jmezVlOTjAJWsmHS7At7CTY3aNpptWKrr9zfbBBahKqxn3mo54PhYe69lPGUBNl6Lz2ma8zuIkc5XiPIP0JBddZj1G+NK7153iQDAXBfSAqDEBBOeTNDV3qoDmFByHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763340; c=relaxed/simple;
	bh=qI9aGGTuk19zzaPfcSGSwWEYLbP/l9Oq836zmFs2t4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WU32gGpMNbM5KIRBxlVxx6XsRQJY/zQBut8zd665VAr2tmTzBZrosp4nKKCoH53K2ARi8emDQzKh2I5qfPwIc1sYS1j0IicL8rFwe8W5O7n5hhkdxA3l9ujR1jcqmVOng7WUfmwk/B8QtpfMlMvcgwD0f3VpbgznhmRwwtQbEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a89ex5rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36BC4CEF8;
	Tue, 29 Jul 2025 04:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753763339;
	bh=qI9aGGTuk19zzaPfcSGSwWEYLbP/l9Oq836zmFs2t4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a89ex5rMWdF93mAr9PPx30XPR51XPMX6l2xrMkmoTYV97dV8D4K1LgJwagElzb5Ac
	 gpFZsdocBKhJoFFimy8OVE+OxUKRQGqZzX6X8BSZcrfb3srFSKKwtk781tnLDzJMRp
	 rE1em+q9FugQOHTSW8i3M5eRLlYTXBZM4yIVMgQ7Z40SN+rEtpEo95UZCOoHORvjjs
	 dsWCdGQ2/Z8UVLYBuHaowy4p1SUwKDqY7RrBmzmgvSxf8UvoSJF7MMJlPFe8S2aVPl
	 JNpD8AbYyLKtfii852cwVFWVcHjx81XwVVVQctZk044skWqsL6ghJBP9ctVYSCDPEQ
	 cz6rbwKHi2RSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] dpaa2-eth: retry the probe when the MAC is not yet discovered on the bus
Date: Tue, 29 Jul 2025 00:28:52 -0400
Message-Id: <20250729042853.2357022-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729042853.2357022-1-sashal@kernel.org>
References: <2025072840-quickstep-spiny-0e80@gregkh>
 <20250729042853.2357022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 47325da28ef137fa04a0e5d6d244e9635184bf5e ]

The fsl_mc_get_endpoint() function now returns -EPROBE_DEFER when the
dpmac device was not yet discovered by the fsl-mc bus. When this
happens, pass the error code up so that we can retry the probe at a
later time.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ee9f3a81ab08 ("dpaa2-eth: Fix device reference count leak in MAC endpoint handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 217e3004c0cc..9338a7d31545 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4134,7 +4134,11 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 
 	dpni_dev = to_fsl_mc_device(priv->net_dev->dev.parent);
 	dpmac_dev = fsl_mc_get_endpoint(dpni_dev);
-	if (IS_ERR_OR_NULL(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+
+	if (PTR_ERR(dpmac_dev) == -EPROBE_DEFER)
+		return PTR_ERR(dpmac_dev);
+
+	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
 		return 0;
 
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-- 
2.39.5


