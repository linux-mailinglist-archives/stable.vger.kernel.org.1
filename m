Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C47876C8
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbjHXRTi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbjHXRTb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86719BA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39FE627FD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EF8C433C7;
        Thu, 24 Aug 2023 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897568;
        bh=VQbFu4rrFDl+2kvFc0XMJzf4w12XEE2B8b3tkSQv+Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPBoDXc8SvIOdnVZOJ0YBt+RmaQI4EVWEYtSgkBWvSkgvOYEIJwps01G39MNhG1l4
         6T/prRn77AYUkwpI6ZUC1wCqBZOkJx2OxWDhWc3aDvfGUK5nGJdZTuGm8Mfx77tOdt
         coAVSqfKxfP8R3YiGmr1PIy/e3PR4RKnerltF18g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 085/135] drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs
Date:   Thu, 24 Aug 2023 19:09:17 +0200
Message-ID: <20230824170620.931143214@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit e8470c0a7bcaa82f78ad34282d662dd7bd9630c2 ]

Commit 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4
panel") added support for this panel model, but the timings it implements
are very different from what the datasheet describes. I checked both the
G121EAN01.0 datasheet from [0] and the G121EAN01.4 one from [1] and they
all have the same timings: for example the LVDS clock typical value is 74.4
MHz, not 66.7 MHz as implemented.

Replace the timings with the ones from the documentation. These timings
have been tested and the clock frequencies verified with an oscilloscope to
ensure they are correct.

Also use struct display_timing instead of struct drm_display_mode in order
to also specify the minimum and maximum values.

[0] https://embedded.avnet.com/product/g121ean01-0/
[1] https://embedded.avnet.com/product/g121ean01-4/

Fixes: 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4 panel")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804151239.835216-1-luca.ceresoli@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7b69f81444ebd..e40321d798981 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1010,21 +1010,21 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
-static const struct drm_display_mode auo_g121ean01_mode = {
-	.clock = 66700,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 58,
-	.hsync_end = 1280 + 58 + 8,
-	.htotal = 1280 + 58 + 8 + 70,
-	.vdisplay = 800,
-	.vsync_start = 800 + 6,
-	.vsync_end = 800 + 6 + 4,
-	.vtotal = 800 + 6 + 4 + 10,
+static const struct display_timing auo_g121ean01_timing = {
+	.pixelclock = { 60000000, 74400000, 90000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 20, 50, 100 },
+	.hback_porch = { 20, 50, 100 },
+	.hsync_len = { 30, 100, 200 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 2, 10, 25 },
+	.vback_porch = { 2, 10, 25 },
+	.vsync_len = { 4, 18, 50 },
 };
 
 static const struct panel_desc auo_g121ean01 = {
-	.modes = &auo_g121ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_g121ean01_timing,
+	.num_timings = 1,
 	.bpc = 8,
 	.size = {
 		.width = 261,
-- 
2.40.1



