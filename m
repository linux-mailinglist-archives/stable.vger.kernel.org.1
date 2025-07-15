Return-Path: <stable+bounces-161960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83614B0597D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA703A28A7
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6C2DAFB0;
	Tue, 15 Jul 2025 12:01:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA662DC359;
	Tue, 15 Jul 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580893; cv=none; b=eC2QTcdZ8dNnSZAK6eGRbkkWLZ3Nl3Hrb6SVYy0VYDfDEvWjtg7faa5JZvzTTqav1moxiDsZOrzv1lsyqcR63ed0CdSrACdCsYOfIM1txo8YIxr42/VxKu2aj2upgbw2OhkMeBI/u9ku+n5sDzwUGVz4xK0jwiJcEAU9d/pUbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580893; c=relaxed/simple;
	bh=Uit/bRubTiyDNAb7Oh76MrdVa16vELT94DebeHjoOio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SaMqqdFJv1BCjX+SaJTBkt1OtVj8zwIQD8hjjNxt53zrNFDMr0Viu1PqCx8S4uWCOterehdo/DICMSD9aJWJ4Q0BctYW5QhHEZnEo4PqYza3r0JpBQ/3b7Cx3zEimPYvNuW3eHiFSt4/456HLddeb2fNvgbtm51B6XCN8LT+5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowAC3SHr5QnZoKgtBBA--.14063S2;
	Tue, 15 Jul 2025 20:01:07 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: ioana.ciornei@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dpaa2: Fix device reference count leak in MAC endpoint handling
Date: Tue, 15 Jul 2025 20:00:56 +0800
Message-Id: <20250715120056.3274056-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3SHr5QnZoKgtBBA--.14063S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3Gw15XF1rAr4DXr18Zrb_yoWrGr4Dpa
	yUAas8Xrykta13WFs7ua1kZFy5Ca10ka48WF1xu34fZFs0qw15urWUtFyjyry09FWkAr15
	Jr4qyanruFyDGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhL0nUUUUU
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The fsl_mc_get_endpoint() function uses device_find_child() for
localization, which implicitly calls get_device() to increment the
device's reference count before returning the pointer. However, the
caller dpaa2_switch_port_connect_mac() and dpaa2_eth_connect_mac()
fails to properly release this reference in multiple scenarios. We
should call put_device() to decrement reference count properly.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 15 ++++++++++++---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c  | 15 ++++++++++++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index b82f121cadad..f1543039a5b6 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4666,12 +4666,19 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 		return PTR_ERR(dpmac_dev);
 	}
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		put_device(&dpmac_dev->dev);
+		return 0;
+	}
+
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-	if (!mac)
+	if (!mac) {
+		put_device(&dpmac_dev->dev);
 		return -ENOMEM;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = priv->mc_io;
@@ -4679,7 +4686,7 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 
 	err = dpaa2_mac_open(mac);
 	if (err)
-		goto err_free_mac;
+		goto err_put_device;
 
 	if (dpaa2_mac_is_type_phy(mac)) {
 		err = dpaa2_mac_connect(mac);
@@ -4703,6 +4710,8 @@ static int dpaa2_eth_connect_mac(struct dpaa2_eth_priv *priv)
 
 err_close_mac:
 	dpaa2_mac_close(mac);
+err_put_device:
+	put_device(&dpmac_dev->dev);
 err_free_mac:
 	kfree(mac);
 	return err;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 147a93bf9fa9..6bf1c164129a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1448,12 +1448,20 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	if (PTR_ERR(dpmac_dev) == -EPROBE_DEFER)
 		return PTR_ERR(dpmac_dev);
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
+
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		put_device(&dpmac_dev->dev);
+		return 0;
+	}
 
 	mac = kzalloc(sizeof(*mac), GFP_KERNEL);
-	if (!mac)
+	if (!mac) {
+		put_device(&dpmac_dev->dev);
 		return -ENOMEM;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = port_priv->ethsw_data->mc_io;
@@ -1461,7 +1469,7 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 
 	err = dpaa2_mac_open(mac);
 	if (err)
-		goto err_free_mac;
+		goto err_put_device;
 
 	if (dpaa2_mac_is_type_phy(mac)) {
 		err = dpaa2_mac_connect(mac);
@@ -1481,6 +1489,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 
 err_close_mac:
 	dpaa2_mac_close(mac);
+err_put_device:
+	put_device(&dpmac_dev->dev);
 err_free_mac:
 	kfree(mac);
 	return err;
-- 
2.25.1


