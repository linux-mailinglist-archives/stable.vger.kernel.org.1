Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE27A807E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjITMhi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjITMhg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:37:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392DB6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:37:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FCDC433C7;
        Wed, 20 Sep 2023 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213449;
        bh=Kefqz6l+qkwVFjeSl1f57tNLdR2/g9pRtGEaKFKuqWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQvcF7NSc2bHe/0kpW3ZhmY+ZzLKmcuM0QklFEdtUE1QLJpnFtm3m6CaPAogzvPDN
         xrrsJ1ck+otz/WUQtn5TrCzlB6GNM5dO7qGobAWnJfzoHwE5rOFye6/TWkJDf2wlRr
         gqmrXwlXU8rPC5mdNHBINkG/r8hrcCROuN+72lUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5.4 215/367] backlight/bd6107: Compare against struct fb_info.device
Date:   Wed, 20 Sep 2023 13:29:52 +0200
Message-ID: <20230920112904.167331544@linuxfoundation.org>
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

commit 992bdddaabfba19bdc77c1c7a4977b2aa41ec891 upstream.

Struct bd6107_platform_data refers to a platform device within
the Linux device hierarchy. The test in bd6107_backlight_check_fb()
compares it against the fbdev device in struct fb_info.dev, which
is different. Fix the test by comparing to struct fb_info.device.

Fixes a bug in the backlight driver and prepares fbdev for making
struct fb_info.dev optional.

v2:
	* move renames into separate patch (Javier, Sam, Michael)

Fixes: 67b43e590415 ("backlight: Add ROHM BD6107 backlight driver")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.12+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230613110953.24176-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/backlight/bd6107.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -107,7 +107,7 @@ static int bd6107_backlight_check_fb(str
 {
 	struct bd6107 *bd = bl_get_data(backlight);
 
-	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->dev;
+	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->device;
 }
 
 static const struct backlight_ops bd6107_backlight_ops = {


