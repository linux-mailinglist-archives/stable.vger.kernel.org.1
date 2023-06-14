Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F34713EDC
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjE1Tjh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjE1Tjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167CEA8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A759061EA2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70AEC433EF;
        Sun, 28 May 2023 19:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302775;
        bh=2i5rl0T7r5dQ0zNhfbtTJGobJvi98+IV0QbPBzKLZBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yT/fes3WChXNJPTcL3afYtkPrCC8psVHuSfHORhoDbF9OnlaC1ySr8eBxh0j7xufD
         idqJnKeo9Piy9I2O8K/q/kjKYLGnSNPg7ZytuMiQe9BR8jesY/KDXxSN83iWiLYrAk
         laIeEVFHmhmn/sEj+zu11PRl69JaJA/oa29g+Frk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zongjie Li <u202112089@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 020/211] fbdev: arcfb: Fix error handling in arcfb_probe()
Date:   Sun, 28 May 2023 20:09:01 +0100
Message-Id: <20230528190844.028690598@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zongjie Li <u202112089@hust.edu.cn>

[ Upstream commit 5a6bef734247c7a8c19511664ff77634ab86f45b ]

Smatch complains that:
arcfb_probe() warn: 'irq' from request_irq() not released on lines: 587.

Fix error handling in the arcfb_probe() function. If IO addresses are
not provided or framebuffer registration fails, the code will jump to
the err_addr or err_register_fb label to release resources.
If IRQ request fails, previously allocated resources will be freed.

Fixes: 1154ea7dcd8e ("[PATCH] Framebuffer driver for Arc LCD board")
Signed-off-by: Zongjie Li <u202112089@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/arcfb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 1447324ed0b64..08da436265d92 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -523,7 +523,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
 	if (!info)
-		goto err;
+		goto err_fb_alloc;
 
 	info->screen_base = (char __iomem *)videomemory;
 	info->fbops = &arcfb_ops;
@@ -535,7 +535,7 @@ static int arcfb_probe(struct platform_device *dev)
 
 	if (!dio_addr || !cio_addr || !c2io_addr) {
 		printk(KERN_WARNING "no IO addresses supplied\n");
-		goto err1;
+		goto err_addr;
 	}
 	par->dio_addr = dio_addr;
 	par->cio_addr = cio_addr;
@@ -551,12 +551,12 @@ static int arcfb_probe(struct platform_device *dev)
 			printk(KERN_INFO
 				"arcfb: Failed req IRQ %d\n", par->irq);
 			retval = -EBUSY;
-			goto err1;
+			goto err_addr;
 		}
 	}
 	retval = register_framebuffer(info);
 	if (retval < 0)
-		goto err1;
+		goto err_register_fb;
 	platform_set_drvdata(dev, info);
 	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
 		videomemorysize >> 10);
@@ -580,9 +580,12 @@ static int arcfb_probe(struct platform_device *dev)
 	}
 
 	return 0;
-err1:
+
+err_register_fb:
+	free_irq(par->irq, info);
+err_addr:
 	framebuffer_release(info);
-err:
+err_fb_alloc:
 	vfree(videomemory);
 	return retval;
 }
-- 
2.39.2



