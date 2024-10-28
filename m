Return-Path: <stable+bounces-89002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391309B2D97
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D949E1F210B9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF321DE2D0;
	Mon, 28 Oct 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTWVyZa9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787D1DE2C9;
	Mon, 28 Oct 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112704; cv=none; b=hS3ESSONUvJlbbwZyb2wLB0k/CSrnwjSGuwI1UAVrRxWTT0sriqyTdsAjvSzz0q+N/XKFljB1zH6hY+IMW3o8n61PaDyAF3HPoGK5Qx9OSNLNs4nF+FQHCn7mIo3Tukfm/P5s6JqqtT9iL9uQQA3jQleDQWQhUKHWr9iFSkITWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112704; c=relaxed/simple;
	bh=InZ238puoPKl41A74fGH2wgXn+4jChPfsPt7LKEcKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4WkBnvUAwhaulePsK5EQ6XrOjwu8kGS8iPOhMWRBPH27CqaRu+nqwaFHkKi/RX7EBin8nQYibNtQox477HMawb9WkLeTgvWqjnlw05RFwVJztx596fmidVyzBZcjhI23Tgol806KDM/qUbE8ExPW4yshxvDfb5uS+BTV8qw1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTWVyZa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF79AC4CEE3;
	Mon, 28 Oct 2024 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112704;
	bh=InZ238puoPKl41A74fGH2wgXn+4jChPfsPt7LKEcKr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTWVyZa92xhqWkta+tMxZ4EcsHMG0WTw4xvjvC7Tp9u7tY0Hkfp58qO6S5UFIU+pq
	 2a5z/xlG26BE0bOxERYSTwrqassTBs0AvDNj4yA/yfuIbYTLMncDE2GNwIPJY9PoeP
	 zAAqvScywB89QZwZBvLyIhCVnQDZGfW79rRgtlQr+VwaPGZULWSimeK1kd83GtpDBM
	 UtazdfWo2IoO1TvTa9gOOMyD1vBgcdZm1scdGmCDD88HVy8yRw7EVltPZaKYSPU15I
	 yxYCzbgHz/0KNucImOYE8j5mK1xu4y+4qiskJM+QK5VmO+NRUExMYMtnIuIjEm6JJd
	 4HayZ8J5y3q4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	madalin.bucur@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 20/32] fsl/fman: Save device references taken in mac_probe()
Date: Mon, 28 Oct 2024 06:50:02 -0400
Message-ID: <20241028105050.3559169-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit efeddd552ec6767e4c8884caa516ac80b65f8823 ]

In mac_probe() there are calls to of_find_device_by_node() which takes
references to of_dev->dev. These references are not saved and not released
later on error path in mac_probe() and in mac_remove().

Add new fields into mac_device structure to save references taken for
future use in mac_probe() and mac_remove().

This is a preparation for further reference leaks fix.

Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/mac.c | 6 ++++--
 drivers/net/ethernet/freescale/fman/mac.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9767586b4eb32..9b863db0bf087 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -197,6 +197,7 @@ static int mac_probe(struct platform_device *_of_dev)
 		err = -EINVAL;
 		goto _return_of_node_put;
 	}
+	mac_dev->fman_dev = &of_dev->dev;
 
 	/* Get the FMan cell-index */
 	err = of_property_read_u32(dev_node, "cell-index", &val);
@@ -208,7 +209,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	/* cell-index 0 => FMan id 1 */
 	fman_id = (u8)(val + 1);
 
-	priv->fman = fman_bind(&of_dev->dev);
+	priv->fman = fman_bind(mac_dev->fman_dev);
 	if (!priv->fman) {
 		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
 		err = -ENODEV;
@@ -284,8 +285,9 @@ static int mac_probe(struct platform_device *_of_dev)
 			err = -EINVAL;
 			goto _return_of_node_put;
 		}
+		mac_dev->fman_port_devs[i] = &of_dev->dev;
 
-		mac_dev->port[i] = fman_port_bind(&of_dev->dev);
+		mac_dev->port[i] = fman_port_bind(mac_dev->fman_port_devs[i]);
 		if (!mac_dev->port[i]) {
 			dev_err(dev, "dev_get_drvdata(%pOF) failed\n",
 				dev_node);
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index fe747915cc737..8b5b43d50f8ef 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -19,12 +19,13 @@
 struct fman_mac;
 struct mac_priv_s;
 
+#define PORT_NUM 2
 struct mac_device {
 	void __iomem		*vaddr;
 	struct device		*dev;
 	struct resource		*res;
 	u8			 addr[ETH_ALEN];
-	struct fman_port	*port[2];
+	struct fman_port	*port[PORT_NUM];
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	phy_interface_t		phy_if;
@@ -52,6 +53,9 @@ struct mac_device {
 
 	struct fman_mac		*fman_mac;
 	struct mac_priv_s	*priv;
+
+	struct device		*fman_dev;
+	struct device		*fman_port_devs[PORT_NUM];
 };
 
 static inline struct mac_device
-- 
2.43.0


