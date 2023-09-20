Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A057A7CEE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjITMFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjITMFX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2221F92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:05:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FC1C433C7;
        Wed, 20 Sep 2023 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211517;
        bh=19n01cyGrmy45eIaL4pvoQ0ZSiBWYOkdC9nG1Kd7+vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKZHFx8VK7wlkao2Y3oI9NYDh/uUqPMFKxJWIbojZ8zITCHp+poDZbv7Z5E3YQx76
         UphlqSEK5RZji7Ll0pE86q0X+QMv80syM1biM6AU5FJlQG3R2IpQTn/0kIbaI0UC+H
         gmDgest9/bF0JU2y25H+wc4AhsMBcizUOObciv4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4.14 122/186] fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
Date:   Wed, 20 Sep 2023 13:30:25 +0200
Message-ID: <20230920112841.446824437@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit f90a0e5265b60cdd3c77990e8105f79aa2fac994 upstream.

Do not assing the Linux device to struct fb_info.dev. The call to
register_framebuffer() initializes the field to the fbdev device.
Drivers should not override its value.

Fixes a bug where the driver incorrectly decreases the hardware
device's reference counter and leaks the fbdev device.

v2:
	* add Fixes tag (Dan)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 88017bda96a5 ("ep93xx video driver")
Cc: <stable@vger.kernel.org> # v2.6.32+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230613110953.24176-15-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/ep93xx-fb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -478,7 +478,6 @@ static int ep93xxfb_probe(struct platfor
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
 	fbi = info->par;
 	fbi->mach_info = mach_info;


