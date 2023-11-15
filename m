Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552997ECFF0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjKOTvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjKOTvr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F81B6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C56C433C9;
        Wed, 15 Nov 2023 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077904;
        bh=mOcPKsNWvpHyMdG0XxyeL1TH0tIN70UVAVI48S+DT/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY4J5RNfoZa5exraT3u5zH7jDRjfvbBj/GEYuznm5OCEdeGivvCJQQWXlLbLmS3pD
         AiMfsSwyY5NQqi0VoS7dm6GB0kRZo+ty2NAb9Jhpvrs6M1FBKPlCDBbqmTrT7/+Rzk
         xdVv16DIYTNMYWGkryFt5DhHrpfwQdcjqD/Nuxkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 591/603] fbdev: imsttfb: fix a resource leak in probe
Date:   Wed, 15 Nov 2023 14:18:56 -0500
Message-ID: <20231115191652.125872580@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit aba6ab57a910ad4b940c2024d15f2cdbf5b7f76b ]

I've re-written the error handling but the bug is that if init_imstt()
fails we need to call iounmap(par->cmap_regs).

Fixes: c75f5a550610 ("fbdev: imsttfb: Fix use after free bug in imsttfb_probe")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imsttfb.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 1b322ac35d863..f5eaa58a808fb 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1494,8 +1494,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto release_info;
 	}
 
 	switch (pdev->device) {
@@ -1512,36 +1512,39 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret = -ENODEV;
-			goto error;
+			goto release_mem_region;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_mem_region;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_screen_base;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_dc_regs;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
 	if (ret)
-		goto error;
+		goto unmap_cmap_regs;
 
 	pci_set_drvdata(pdev, info);
-	return ret;
+	return 0;
 
-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_dc_regs:
+	iounmap(par->dc_regs);
+unmap_screen_base:
+	iounmap(info->screen_base);
+release_mem_region:
 	release_mem_region(addr, size);
+release_info:
 	framebuffer_release(info);
 	return ret;
 }
-- 
2.42.0



