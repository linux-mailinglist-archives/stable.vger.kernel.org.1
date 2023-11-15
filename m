Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598AA7ECDF0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjKOTjW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjKOTjR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF61A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF1EC433C7;
        Wed, 15 Nov 2023 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077153;
        bh=j8TZaEzgDqw6vUwOZlJCU8r/ZGv+ZfS6vSw+/B5vGH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzn9GPSgE4EbeaoD+xqIUKLZdjBQdOJqz5mBadhHe6Z+Z3hr4xbYJWqKpH3a/mjB9
         974alx+aL82XCP0Ud+DFfK5QUdGMc8lVL3Gtn4NGJTE5nD9K3wHe2djQOPBO9gzeLq
         LdfCzTu3cIjVR3SQVAptT0BW00ZGikpwGC2ZIq4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 538/550] fbdev: imsttfb: fix double free in probe()
Date:   Wed, 15 Nov 2023 14:18:42 -0500
Message-ID: <20231115191638.233923192@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e08c30efda21ef4c0ec084a3a9581c220b442ba9 ]

The init_imstt() function calls framebuffer_release() on error and then
the probe() function calls it again.  It should only be done in probe.

Fixes: 518ecb6a209f ("fbdev: imsttfb: Fix error path of imsttfb_probe()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imsttfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index ee7d01ad14068..db7cf995aa784 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1419,7 +1419,6 @@ static int init_imstt(struct fb_info *info)
 	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> 3) > info->fix.smem_len
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
-		framebuffer_release(info);
 		return -ENODEV;
 	}
 
@@ -1452,14 +1451,11 @@ static int init_imstt(struct fb_info *info)
 	              FBINFO_HWACCEL_FILLRECT |
 	              FBINFO_HWACCEL_YPAN;
 
-	if (fb_alloc_cmap(&info->cmap, 0, 0)) {
-		framebuffer_release(info);
+	if (fb_alloc_cmap(&info->cmap, 0, 0))
 		return -ENODEV;
-	}
 
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
 		return -ENODEV;
 	}
 
-- 
2.42.0



