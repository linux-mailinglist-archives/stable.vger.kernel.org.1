Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF87D31C0
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjJWLMu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjJWLMp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67663D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9DBC433C9;
        Mon, 23 Oct 2023 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059563;
        bh=qHvHZVCcSm1p31bbyJECAf+gvg36IvnGJkAGPbJQPm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fYhfX7noiniYbrXuiD/woxSHiOuvdmNqAQmetOpHS56tfZWmlIl/L1VfNdkvKyBM
         9JkXsMEUh0qEtiqSMqiwQh+FvpEWYn2PCoBhWRx3YoV7zGl8C4XXVgaXassOYzOnE4
         xAi+DEhWEclQASpFV4UOWAqrTkpBWLWB9RH7nDxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anton Bambura <jenneron@postmarketos.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 219/241] drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple
Date:   Mon, 23 Oct 2023 12:56:45 +0200
Message-ID: <20231023104839.191685463@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit ad3e33fe071dffea07279f96dab4f3773c430fe2 ]

In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
panel-simple") I moved a pile of panels out of panel-simple driver
into the newly created panel-edp driver. One of those panels, however,
shouldn't have been moved.

As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used in
exynos5250-snow and exynos5420-peach-pit where it's clear that the
panel is hooked up with LVDS. Furthermore, searching for datasheets I
found one that makes it clear that this panel is LVDS.

As far as I can tell, I got confused because in commit 88d3457ceb82
("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
downstream ChromeOS trees, it seems like some Mediatek boards are
using a panel that they call "auo,b116xw03" that's an eDP panel. The
best I can guess is that they actually have a different panel that has
similar timing. If so then the proper panel should be used or they
should switch to the generic "edp-panel" compatible.

When moving this back to panel-edp, I wasn't sure what to use for
.bus_flags and .bus_format and whether to add the extra "enable" delay
from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
backlight when power on"). I've added formats/flags/delays based on my
(inexpert) analysis of the datasheet. These are untested.

NOTE: if/when this is backported to stable, we might run into some
trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
jacuzzi: Move panel under aux-bus") this panel was used by
"mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
know what to suggest for that other than someone making up a bogus
panel for jacuzzi that's just for the stable channel.

Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when power on")
Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
Tested-by: Anton Bambura <jenneron@postmarketos.org>
Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230925150010.1.Iff672233861bcc4cf25a7ad0a81308adc3bda8a4@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c    | 29 -----------------------
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fbd114b4f0be0..856f73a46ee61 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -976,32 +976,6 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 };
 
-static const struct drm_display_mode auo_b116xw03_mode = {
-	.clock = 70589,
-	.hdisplay = 1366,
-	.hsync_start = 1366 + 40,
-	.hsync_end = 1366 + 40 + 40,
-	.htotal = 1366 + 40 + 40 + 32,
-	.vdisplay = 768,
-	.vsync_start = 768 + 10,
-	.vsync_end = 768 + 10 + 12,
-	.vtotal = 768 + 10 + 12 + 6,
-	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-};
-
-static const struct panel_desc auo_b116xw03 = {
-	.modes = &auo_b116xw03_mode,
-	.num_modes = 1,
-	.bpc = 6,
-	.size = {
-		.width = 256,
-		.height = 144,
-	},
-	.delay = {
-		.enable = 400,
-	},
-};
-
 static const struct drm_display_mode auo_b133han05_mode = {
 	.clock = 142600,
 	.hdisplay = 1920,
@@ -1725,9 +1699,6 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b116xa01",
 		.data = &auo_b116xak01,
-	}, {
-		.compatible = "auo,b116xw03",
-		.data = &auo_b116xw03,
 	}, {
 		.compatible = "auo,b133han05",
 		.data = &auo_b133han05,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 03196fbfa4d79..e26af5e1299a8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -923,6 +923,38 @@ static const struct panel_desc auo_b101xtn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xw03_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc auo_b116xw03 = {
+	.modes = &auo_b116xw03_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 256,
+		.height = 144,
+	},
+	.delay = {
+		.prepare = 1,
+		.enable = 200,
+		.disable = 200,
+		.unprepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g070vvn01_timings = {
 	.pixelclock = { 33300000, 34209000, 45000000 },
 	.hactive = { 800, 800, 800 },
@@ -4074,6 +4106,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b101xtn01",
 		.data = &auo_b101xtn01,
+	}, {
+		.compatible = "auo,b116xw03",
+		.data = &auo_b116xw03,
 	}, {
 		.compatible = "auo,g070vvn01",
 		.data = &auo_g070vvn01,
-- 
2.42.0



