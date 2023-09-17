Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA89B7A3A7D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbjIQUEw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbjIQUEg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:04:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53155EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352E8C433C7;
        Sun, 17 Sep 2023 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981071;
        bh=mMjKLVLtlXUTKWlNpdPjY8YYnQOqqF8jIgAL7EI81PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbzkeCGK7eYw2sirJzUPI+IoxFImhV0hnRPVtUz6tk80s0MP6ShPcZw2UiUDZWsv0
         bqGDbivQ89tzoNQ27TAZnYoFqtKQ8utgggpgzN6SorAlO2efDZMeNX0JNxmTO3GTzf
         1ZYn2S3ZkkyzpVGJkvkW/cEtIY+UHBwmNaawI+e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Ying <victor.liu@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/219] backlight: gpio_backlight: Drop output GPIO direction check for initial power state
Date:   Sun, 17 Sep 2023 21:13:16 +0200
Message-ID: <20230917191043.492308208@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ying Liu <victor.liu@nxp.com>

[ Upstream commit fe1328b5b2a087221e31da77e617f4c2b70f3b7f ]

So, let's drop output GPIO direction check and only check GPIO value to set
the initial power state.

Fixes: 706dc68102bc ("backlight: gpio: Explicitly set the direction of the GPIO")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20230721093342.1532531-1-victor.liu@nxp.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/gpio_backlight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 5c5c99f7979e3..30ec5b6845335 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -87,8 +87,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		/* Not booted with device tree or no phandle link to the node */
 		bl->props.power = def_value ? FB_BLANK_UNBLANK
 					    : FB_BLANK_POWERDOWN;
-	else if (gpiod_get_direction(gbl->gpiod) == 0 &&
-		 gpiod_get_value_cansleep(gbl->gpiod) == 0)
+	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
 		bl->props.power = FB_BLANK_POWERDOWN;
 	else
 		bl->props.power = FB_BLANK_UNBLANK;
-- 
2.40.1



