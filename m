Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C17A3C7E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjIQUcC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjIQUbg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:31:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534C10F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:31:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C657C433CD;
        Sun, 17 Sep 2023 20:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982690;
        bh=p0ZewTQoaaLjtbAlbhx/Izk4prT5Dxm9vyRoqQFEmCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cb1ePaz9x5knOoUS00tcgoS6DVXzuPAAL+JEYWXipJFf0IqTagfCG+reDpUgcdP74
         nVOHDMRaOaHCkYNkI/K8h1S/0n/AnzYEhQStGZPn0y/heMnyv0vQ6Kvi33MFA1WhN+
         7gPeBF6rIKPkdCkpkk9nCQ4y3ABx9hUwzSENNimw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 307/511] leds: multicolor: Use rounded division when calculating color components
Date:   Sun, 17 Sep 2023 21:12:14 +0200
Message-ID: <20230917191121.241419653@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 065d099f1be58187e6629273c50b948a02b7e1bf ]

Given channel intensity, LED brightness and max LED brightness, the
multicolor LED framework helper led_mc_calc_color_components() computes
the color channel brightness as

    chan_brightness = brightness * chan_intensity / max_brightness

Consider the situation when (brightness, intensity, max_brightness) is
for example (16, 15, 255), then chan_brightness is computed to 0
although the fractional divison would give 0.94, which should be rounded
to 1.

Use DIV_ROUND_CLOSEST here for the division to give more realistic
component computation:

    chan_brightness = DIV_ROUND_CLOSEST(brightness * chan_intensity,
                                        max_brightness)

Fixes: 55d5d3b46b08 ("leds: multicolor: Introduce a multicolor class definition")
Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/r/20230801124931.8661-1-kabel@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-class-multicolor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df9..ec62a48116135 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -19,9 +20,10 @@ int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
 	int i;
 
 	for (i = 0; i < mcled_cdev->num_colors; i++)
-		mcled_cdev->subled_info[i].brightness = brightness *
-					mcled_cdev->subled_info[i].intensity /
-					led_cdev->max_brightness;
+		mcled_cdev->subled_info[i].brightness =
+			DIV_ROUND_CLOSEST(brightness *
+					  mcled_cdev->subled_info[i].intensity,
+					  led_cdev->max_brightness);
 
 	return 0;
 }
-- 
2.40.1



