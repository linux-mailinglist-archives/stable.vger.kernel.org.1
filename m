Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949879AEC3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbjIKU5s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbjIKPNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:13:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCDCCC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:13:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903DEC433C7;
        Mon, 11 Sep 2023 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445217;
        bh=B9k9ZuV3EXTW7Rhy1lwBz70cXHh+WS3bodOyzFKiZPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJ85r0LQ5oyJCCEKA7XmVPenFL6FSUP5Fl/3bB3g07NWQzBp75eIziUrHREJUFnxx
         Bg8KWtbBFqg0bHtBgqp9W5m+wJkjr5LD2jgzv37+zVcw1M/wG3PuUxVTwdqTMgGtwP
         teGMY5tThdxa1T1ibH7Xnln8BZeQmf+qVFLF4YT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Foss <rfoss@kernel.org>,
        Nuno Sa <nuno.sa@analog.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Alexandru Ardelean <alex@shruggie.ro>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 269/600] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Mon, 11 Sep 2023 15:45:02 +0200
Message-ID: <20230911134641.548730958@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bogdan Togorean <bogdan.togorean@analog.com>

[ Upstream commit d281eeaa4de2636ff0c8e6ae387bb07b50e5fcbb ]

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
Reviewed-by: Robert Foss <rfoss@kernel.org>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230719060143.63649-1-alex@shruggie.ro
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 78b72739e5c3e..9f9874acfb2b7 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+				   0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+				   0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.40.1



