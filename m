Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94979B348
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbjIKV7x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjIKOFI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0555CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42239C433C8;
        Mon, 11 Sep 2023 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441103;
        bh=yB2kiHdc0SYAkpN8vYLLR1ZLLbOk3s3vCLD3ZkBPsy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLXs94JsNkFh+axNRVgVHxhNwk8YeFKzxSZVhqJNum+TeHjSon3IpwhwqsYL0H+wT
         CTWl8ld5O8An4EN/jv50VHrGtwKR0BoVauXrqBFUNR4tS5meO6pYysSFuDJXY0BEG0
         oThuvVV6fwEXUOHLpNNP2NDn+KzW3flTqbCSBHJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 297/739] drm/repaper: Reduce temporary buffer size in repaper_fb_dirty()
Date:   Mon, 11 Sep 2023 15:41:36 +0200
Message-ID: <20230911134659.426026692@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit fedf429e071f6dbbe7a69dfc342492e037692018 ]

As the temporary buffer is no longer used to store 8-bit grayscale data,
its size can be reduced to the size needed to store the monochrome
bitmap data.

Fixes: 24c6bedefbe71de9 ("drm/repaper: Use format helper for xrgb8888 to monochrome conversion")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220317081830.1211400-6-geert@linux-m68k.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c2677d081a7b6..13ae148f59b9b 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -533,7 +533,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
 	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
 		  epd->factored_stage_time);
 
-	buf = kmalloc_array(fb->width, fb->height, GFP_KERNEL);
+	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto out_exit;
-- 
2.40.1



