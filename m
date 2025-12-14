Return-Path: <stable+bounces-200964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A182CCBBAB0
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 116003008059
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371719922D;
	Sun, 14 Dec 2025 12:47:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF35898;
	Sun, 14 Dec 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765716425; cv=none; b=Z3M52OTcKEP/8T0iAwxXIQfI/7kxJZ9QIr3Uh80BtqMQbNTgra2HtESyxk4M0M0fMHprXMUNj0yOWBjzfz4MCpPRaKp0uchs5V+v3GZM3pthvRutgnriFC4fpNfP/iY+MxxMABBWz+7oUjjKJxNewcDohdjyyVvzIz5ECtG+o+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765716425; c=relaxed/simple;
	bh=9Ay/wC9If+WWunqAu0FiBWLrUf4OyfOQVihjNNnWl7Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EU8jGdiASEboDeHVcligHGKM0c5azK8KkN2PfqvpsKtHptaZfj579+MP5DKXbsFlTExBAi2xls5O5REw7yDkJk/T/ChNXREbpsXjHpmvZ2R6pWCIs3WabPRggGIWKb4I2m2JcVcohdG76aiWx/H4Y0cDPumn7v6Cgf0kq7Kh7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACHqN+usT5py8WyAA--.7876S2;
	Sun, 14 Dec 2025 20:46:45 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: anitha.chrisanthus@intel.com,
	edmund.j.dea@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/kmb: Fix error handling in kmb_probe
Date: Sun, 14 Dec 2025 20:46:26 +0800
Message-Id: <20251214124626.1326-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACHqN+usT5py8WyAA--.7876S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry8uF43tryftrWkXF4fZrb_yoW8tF1DpF
	ZrGFyFyrWrGF4IkrW7A3W8Za43Aa12yayfursrG3ykWr4YyryqgF97Z3W7AayrJFW8WFWf
	tFZrKa18uF4DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

kmb_probe() obtain a reference to a platform device by
of_find_device_by_node(). This call increases the reference count of
the returned device, which should be dropped by calling put_device()
when the device is no longer needed. However, the code fails to call
put_device() in several error handling paths and the normal device
removal path. This could result in reference count leaks that prevent
the proper cleanup of the platform device when the driver is unloaded
or during error recovery.

Add put_device() in all code paths where dsi_pdev is no longer needed,
including error paths and the normal removal path.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..9733337abe92 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -474,6 +474,8 @@ static void kmb_remove(struct platform_device *pdev)
 
 	/* Unregister DSI host */
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
+	if (kmb->kmb_dsi && kmb->kmb_dsi->pdev)
+		put_device(&kmb->kmb_dsi->pdev->dev);
 	drm_atomic_helper_shutdown(drm);
 }
 
@@ -518,17 +520,20 @@ static int kmb_probe(struct platform_device *pdev)
 	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
 
 	if (ret == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto err_free2;
 	} else if (ret) {
 		DRM_ERROR("probe failed to initialize DSI host bridge\n");
-		return ret;
+		goto err_free2;
 	}
 
 	/* Create DRM device */
 	kmb = devm_drm_dev_alloc(dev, &kmb_driver,
 				 struct kmb_drm_private, drm);
-	if (IS_ERR(kmb))
-		return PTR_ERR(kmb);
+	if (IS_ERR(kmb)) {
+		ret = PTR_ERR(kmb);
+		goto err_free2;
+	}
 
 	dev_set_drvdata(dev, &kmb->drm);
 
@@ -577,7 +582,8 @@ static int kmb_probe(struct platform_device *pdev)
  err_free1:
 	dev_set_drvdata(dev, NULL);
 	kmb_dsi_host_unregister(kmb->kmb_dsi);
-
+err_free2:
+	put_device(&dsi_pdev->dev);
 	return ret;
 }
 
-- 
2.17.1


