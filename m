Return-Path: <stable+bounces-163215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD7B082E8
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96267189C6A9
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEC1FFC77;
	Thu, 17 Jul 2025 02:24:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64581EB9E1;
	Thu, 17 Jul 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719051; cv=none; b=HDhOEf77ojD11leKxNxiopwxmRO8QwzzuC3rppalWh1EYsETXr/05VQH4HiNmjSQGhgbAXEaqd/8P4CxzCJE5I6Yf2a7vlBlZLv0hsFi9mjJXn/HDnwWAPNlgrilygvIL4+SAKBj02yFmIyF3SHThnR9EhwE9XLKfbWHeOQJvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719051; c=relaxed/simple;
	bh=i0em1g0OYljs2NENi+GHha9uquM7drJTCuBSMnI1Uik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtK2FPFGlZnXOxNUIvVceotpe07U4llpfrgCGraWClj/RWm9opP8xLV9SB/SHU1LBFmrzaD5XybE+m97ZU/LXjA6z7An5BwKzzJ7kgZj1rp2YAaAT4IfrxCppbWcVk3dqwYkQh51g8oryT5hXGrQFJ1TDpY3IVXH7ddraz0dBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowACX74CvXnhoGPjBBA--.29325S4;
	Thu, 17 Jul 2025 10:23:57 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: ioana.ciornei@nxp.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/3] dpaa2-switch: Fix device reference count leak in MAC endpoint handling
Date: Thu, 17 Jul 2025 10:23:09 +0800
Message-Id: <20250717022309.3339976-3-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717022309.3339976-1-make24@iscas.ac.cn>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACX74CvXnhoGPjBBA--.29325S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xZw1kJry3Kw13ZrWkWFg_yoW8ZrWfpF
	W8Aa45XrykJF47Wrs7ua18ZFy5Ca109a4rWFyxu34fZan8X345WrWUtryjvr109rZ7ZrW5
	JrWqya109FyDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOzV1UUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The fsl_mc_get_endpoint() function uses device_find_child() for
localization, which implicitly calls get_device() to increment the
device's reference count before returning the pointer. However, the
caller dpaa2_switch_port_connect_mac() fails to properly release this 
reference in multiple scenarios. We should call put_device() to 
decrement reference count properly.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 147a93bf9fa9..4643a3380618 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1448,12 +1448,19 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	if (PTR_ERR(dpmac_dev) == -EPROBE_DEFER)
 		return PTR_ERR(dpmac_dev);
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(*mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = port_priv->ethsw_data->mc_io;
@@ -1483,6 +1490,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 
-- 
2.25.1


