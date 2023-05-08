Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5D6FA480
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjEHKAJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjEHKAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406182D40E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA0D8622B0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB853C433D2;
        Mon,  8 May 2023 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540006;
        bh=TYhLZf9HGvk/5ketayLrKkQZro4l5qqfiBU/gD04Upk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXiRCKZ02HBGgCoyINWZ+fheutf69KYmsx/QcdX0OesjeygNp6ZI9DTH8/tJlPuw+
         FV1j5W3Ow8ACThCfnMyNmaEjJdJLy83uyS0DPVY0diq2TKQunUaR513tibjwdR2yux
         gwmgSumSqvl5xOg3jSwdCOZci1K1d5MmZwIqMetU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Foss <rfoss@kernel.org>,
        Adam Ford <aford173@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/611] drm/bridge: adv7533: Fix adv7533_mode_valid for adv7533 and adv7535
Date:   Mon,  8 May 2023 11:40:18 +0200
Message-Id: <20230508094428.096400955@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit ee0285e13455fdbce5de315bdbe91b5f198a2a06 ]

When dynamically switching lanes was removed, the intent of the code
was to check to make sure that higher speed items used 4 lanes, but
it had the unintended consequence of removing the slower speeds for
4-lane users.

This attempts to remedy this by doing a check to see that the
max frequency doesn't exceed the chip limit, and a second
check to make sure that the max bit-rate doesn't exceed the
number of lanes * max bit rate / lane.

Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switching from adv7533 bridge")
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230319125524.58803-1-aford173@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7533.c | 25 +++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index 258c79d4dab0a..b8eeaf4736e70 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
 enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 					const struct drm_display_mode *mode)
 {
-	int lanes;
+	unsigned long max_lane_freq;
 	struct mipi_dsi_device *dsi = adv->dsi;
+	u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 
-	if (mode->clock > 80000)
-		lanes = 4;
-	else
-		lanes = 3;
-
-	/*
-	 * TODO: add support for dynamic switching of lanes
-	 * by using the bridge pre_enable() op . Till then filter
-	 * out the modes which shall need different number of lanes
-	 * than what was configured in the device tree.
-	 */
-	if (lanes != dsi->lanes)
-		return MODE_BAD;
+	/* Check max clock for either 7533 or 7535 */
+	if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
+		return MODE_CLOCK_HIGH;
+
+	/* Check max clock for each lane */
+	max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
+
+	if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
-- 
2.39.2



