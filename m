Return-Path: <stable+bounces-88856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1489B27CC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5056D285CFC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC418E35B;
	Mon, 28 Oct 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHbRr8tE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CE8837;
	Mon, 28 Oct 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098276; cv=none; b=l1+pvRPxZ7Cg7xOcrnySlPPSYa++vSusnGyrEHZ0p6fePGTcwbPYuXDU/PVTr1WSjQbc6RAJa8vUY379u+9nNcPyIGLHMEOYr3FCbWNfmnUUcxsFlxNzmY/1Kkq2uyNHHMFqKAC+xTAKkodn6O8YD+vxAC88IcAYCSAST02BXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098276; c=relaxed/simple;
	bh=1tJWwJgzwbVmbT/UjDZT3fRdlcqfhYUcTjS3Xbq2638=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nrud1oPoe7Q6jPt+XqdH3B/GhWdBvEUiebUCkrvcP/xTZPNMtDc0EiUuuDuFFDRFOxmTp2Hp3Ht4WNOvcal75b2wuZk0ce76w0T++tsUQcr5CteblzUZDKKyElHeQTmcsvzuVwX5HxBfhLS/LITljJyoIMEQiwXcgWCFEpsFdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHbRr8tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E41C4CEC7;
	Mon, 28 Oct 2024 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098276;
	bh=1tJWwJgzwbVmbT/UjDZT3fRdlcqfhYUcTjS3Xbq2638=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHbRr8tE/dmx3XJJRMCwS166olRYWEKUT5fUKzJqwL+HK9hBp49ZLwIfk6Sioy0vW
	 R5LnT5uYD8UfbCNkAEyRoAZLi+T4XC3ab249WNx+QZLdKa9N3KczskmjmD/ctt448q
	 Qm5jYDMm2vtHWBxe73Rnm16xTKJ7Odp3B7uEST+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 155/261] fsl/fman: Fix refcount handling of fman-related devices
Date: Mon, 28 Oct 2024 07:24:57 +0100
Message-ID: <20241028062315.908079534@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit 1dec67e0d9fbb087c2ab17bf1bd17208231c3bb1 ]

In mac_probe() there are multiple calls to of_find_device_by_node(),
fman_bind() and fman_port_bind() which takes references to of_dev->dev.
Not all references taken by these calls are released later on error path
in mac_probe() and in mac_remove() which lead to reference leaks.

Add references release.

Fixes: 3933961682a3 ("fsl/fman: Add FMan MAC driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/mac.c | 62 +++++++++++++++++------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9b863db0bf087..11da139082e1b 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -204,7 +204,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (err) {
 		dev_err(dev, "failed to read cell-index for %pOF\n", dev_node);
 		err = -EINVAL;
-		goto _return_of_node_put;
+		goto _return_dev_put;
 	}
 	/* cell-index 0 => FMan id 1 */
 	fman_id = (u8)(val + 1);
@@ -213,40 +213,51 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (!priv->fman) {
 		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
 		err = -ENODEV;
-		goto _return_of_node_put;
+		goto _return_dev_put;
 	}
 
+	/* Two references have been taken in of_find_device_by_node()
+	 * and fman_bind(). Release one of them here. The second one
+	 * will be released in mac_remove().
+	 */
+	put_device(mac_dev->fman_dev);
 	of_node_put(dev_node);
+	dev_node = NULL;
 
 	/* Get the address of the memory mapped registers */
 	mac_dev->res = platform_get_mem_or_io(_of_dev, 0);
 	if (!mac_dev->res) {
 		dev_err(dev, "could not get registers\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 
 	err = devm_request_resource(dev, fman_get_mem_region(priv->fman),
 				    mac_dev->res);
 	if (err) {
 		dev_err_probe(dev, err, "could not request resource\n");
-		return err;
+		goto _return_dev_put;
 	}
 
 	mac_dev->vaddr = devm_ioremap(dev, mac_dev->res->start,
 				      resource_size(mac_dev->res));
 	if (!mac_dev->vaddr) {
 		dev_err(dev, "devm_ioremap() failed\n");
-		return -EIO;
+		err = -EIO;
+		goto _return_dev_put;
 	}
 
-	if (!of_device_is_available(mac_node))
-		return -ENODEV;
+	if (!of_device_is_available(mac_node)) {
+		err = -ENODEV;
+		goto _return_dev_put;
+	}
 
 	/* Get the cell-index */
 	err = of_property_read_u32(mac_node, "cell-index", &val);
 	if (err) {
 		dev_err(dev, "failed to read cell-index for %pOF\n", mac_node);
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 	priv->cell_index = (u8)val;
 
@@ -260,22 +271,26 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (unlikely(nph < 0)) {
 		dev_err(dev, "of_count_phandle_with_args(%pOF, fsl,fman-ports) failed\n",
 			mac_node);
-		return nph;
+		err = nph;
+		goto _return_dev_put;
 	}
 
 	if (nph != ARRAY_SIZE(mac_dev->port)) {
 		dev_err(dev, "Not supported number of fman-ports handles of mac node %pOF from device tree\n",
 			mac_node);
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mac_dev->port); i++) {
+	/* PORT_NUM determines the size of the port array */
+	for (i = 0; i < PORT_NUM; i++) {
 		/* Find the port node */
 		dev_node = of_parse_phandle(mac_node, "fsl,fman-ports", i);
 		if (!dev_node) {
 			dev_err(dev, "of_parse_phandle(%pOF, fsl,fman-ports) failed\n",
 				mac_node);
-			return -EINVAL;
+			err = -EINVAL;
+			goto _return_dev_arr_put;
 		}
 
 		of_dev = of_find_device_by_node(dev_node);
@@ -283,7 +298,7 @@ static int mac_probe(struct platform_device *_of_dev)
 			dev_err(dev, "of_find_device_by_node(%pOF) failed\n",
 				dev_node);
 			err = -EINVAL;
-			goto _return_of_node_put;
+			goto _return_dev_arr_put;
 		}
 		mac_dev->fman_port_devs[i] = &of_dev->dev;
 
@@ -292,9 +307,15 @@ static int mac_probe(struct platform_device *_of_dev)
 			dev_err(dev, "dev_get_drvdata(%pOF) failed\n",
 				dev_node);
 			err = -EINVAL;
-			goto _return_of_node_put;
+			goto _return_dev_arr_put;
 		}
+		/* Two references have been taken in of_find_device_by_node()
+		 * and fman_port_bind(). Release one of them here. The second
+		 * one will be released in mac_remove().
+		 */
+		put_device(mac_dev->fman_port_devs[i]);
 		of_node_put(dev_node);
+		dev_node = NULL;
 	}
 
 	/* Get the PHY connection type */
@@ -314,7 +335,7 @@ static int mac_probe(struct platform_device *_of_dev)
 
 	err = init(mac_dev, mac_node, &params);
 	if (err < 0)
-		return err;
+		goto _return_dev_arr_put;
 
 	if (!is_zero_ether_addr(mac_dev->addr))
 		dev_info(dev, "FMan MAC address: %pM\n", mac_dev->addr);
@@ -329,6 +350,12 @@ static int mac_probe(struct platform_device *_of_dev)
 
 	return err;
 
+_return_dev_arr_put:
+	/* mac_dev is kzalloc'ed */
+	for (i = 0; i < PORT_NUM; i++)
+		put_device(mac_dev->fman_port_devs[i]);
+_return_dev_put:
+	put_device(mac_dev->fman_dev);
 _return_of_node_put:
 	of_node_put(dev_node);
 	return err;
@@ -337,6 +364,11 @@ static int mac_probe(struct platform_device *_of_dev)
 static void mac_remove(struct platform_device *pdev)
 {
 	struct mac_device *mac_dev = platform_get_drvdata(pdev);
+	int		   i;
+
+	for (i = 0; i < PORT_NUM; i++)
+		put_device(mac_dev->fman_port_devs[i]);
+	put_device(mac_dev->fman_dev);
 
 	platform_device_unregister(mac_dev->priv->eth_dev);
 }
-- 
2.43.0




