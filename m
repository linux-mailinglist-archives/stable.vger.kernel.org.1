Return-Path: <stable+bounces-89023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F819B2DD2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF4A1F21284
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7131E0DC3;
	Mon, 28 Oct 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuicN0HW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986581E0DB5;
	Mon, 28 Oct 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112757; cv=none; b=QtROGIun81PH+nD9+ceNbqNiOS3lMdFlCz81BuRP52LLBNG4UedZbiimmoQFWvh4FjJyCDBRT+OvhUQKQd70jVizubH4EdpUWMpKcqUyoxYmJc2savWXzAyYUFw9Q67X1uxl/RA//QcsaAGKPI7TSZ55NO7xkx6jLn0nYAQLBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112757; c=relaxed/simple;
	bh=InZ238puoPKl41A74fGH2wgXn+4jChPfsPt7LKEcKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iohb2kbUszdFYRQnkKJRT1Qc/IrZqq/Rt8uab0BZgFppJK03SzpOPxckKyRKK5bn3FfIlIMnnx1OJT4U6b4Ptm+OX9sNR1jnPZB6rWkARaICMTRpcyC+Y+QooOIU2SSRw3LIQmw7Y6kSz+i4qvrBuayjt+U+jXt3yAhw10xtSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuicN0HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CEFC4CEC3;
	Mon, 28 Oct 2024 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112757;
	bh=InZ238puoPKl41A74fGH2wgXn+4jChPfsPt7LKEcKr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuicN0HWKlvyGhbVurDl8MhMkS+4bf2IEYq63VOMpKFklIzWtWCkvkw997GTCB3gz
	 0vr2+LaMjAFYkpTimdiQXN03i7GtjMkM7z6+qKD1Mnma9Habqu4Hxr5m6mEhr1HxY8
	 AXBRu8XUEk2VGM5HaMDMJK2yz9+4VlyRpEdY6qGWX/EslDcRQW6JJyXDWEmzlmlBUk
	 lqhvNJsxn+i7cDaqDC6YN7lQPpwapwUJRg8SvuOTOhOcJ4Z6o4TfKKPKlzOARdiRL6
	 3tlnNiHDedkyuGDZq3yexHKQrDyKyoKoir2ALQeleEbwvxS6GAYnmBj1YrCXqdPYXQ
	 az5MlchfD40Rw==
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
Subject: [PATCH AUTOSEL 6.6 09/15] fsl/fman: Save device references taken in mac_probe()
Date: Mon, 28 Oct 2024 06:52:05 -0400
Message-ID: <20241028105218.3559888-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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


