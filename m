Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857397A80AA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjITMjH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjITMjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DCCC7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:38:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5D5C433CA;
        Wed, 20 Sep 2023 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213526;
        bh=Xp4ASzR2jQieP4rnh4zRV+EcK8gdj6yKmAHdpFUvRrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zx3Pf9h37hP/4e1VoENhtzg7Zrsgbv/qgO6cttpsiiATs7U/EkkXIKTdvNLpuNlkP
         6vDd7r2EoXr5dePyMleGrgxjB1zp7jQ2KVfWoOLVm42T8t5kZGf5icPmSOJcxcTkao
         d1jalbroQBL/uHvsWnRw6VEM5vnHiFu/hQrXbAEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5.4 244/367] fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
Date:   Wed, 20 Sep 2023 13:30:21 +0200
Message-ID: <20230920112904.872849279@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -474,7 +474,6 @@ static int ep93xxfb_probe(struct platfor
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
 	fbi = info->par;
 	fbi->mach_info = mach_info;


