Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90C75D225
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGUS40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGUS4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF530E4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B0061D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C17C433C7;
        Fri, 21 Jul 2023 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965783;
        bh=wzWOvDXoVcgwIxVVMEln0iHRIxEkjIzlMvsrjrqld18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COI3d+nTmNxdOvbYW1g+yqmxhtv5dEzftDU4MIJq4JlhSXYjqQu/VM6qt90IOsX6m
         BFDetwzZrGShnC41EOS/kPu/Fha6MhkNGE4Fwqeq7u31h87cxW+cofn1qESIJ+afjP
         bmX8DY15Bm7XbZ/UNmHnbK6QJZk2lp6QkV4g5KwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/532] drm/panel: sharp-ls043t1le01: adjust mode settings
Date:   Fri, 21 Jul 2023 18:00:17 +0200
Message-ID: <20230721160620.683650676@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit dee23b2c9e3ff46d59c5d45e1436eceb878e7c9a ]

Using current settings causes panel flickering on APQ8074 dragonboard.
Adjust panel settings to follow the vendor-provided mode. This also
enables MIPI_DSI_MODE_VIDEO_SYNC_PULSE, which is also specified by the
vendor dtsi for the mentioned dragonboard.

Fixes: ee0172383190 ("drm/panel: Add Sharp LS043T1LE01 MIPI DSI panel")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230507172639.2320934-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 25829a0a8e801..e2f1e983ef7eb 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -192,15 +192,15 @@ static int sharp_nt_panel_enable(struct drm_panel *panel)
 }
 
 static const struct drm_display_mode default_mode = {
-	.clock = 41118,
+	.clock = (540 + 48 + 32 + 80) * (960 + 3 + 10 + 15) * 60 / 1000,
 	.hdisplay = 540,
 	.hsync_start = 540 + 48,
-	.hsync_end = 540 + 48 + 80,
-	.htotal = 540 + 48 + 80 + 32,
+	.hsync_end = 540 + 48 + 32,
+	.htotal = 540 + 48 + 32 + 80,
 	.vdisplay = 960,
 	.vsync_start = 960 + 3,
-	.vsync_end = 960 + 3 + 15,
-	.vtotal = 960 + 3 + 15 + 1,
+	.vsync_end = 960 + 3 + 10,
+	.vtotal = 960 + 3 + 10 + 15,
 };
 
 static int sharp_nt_panel_get_modes(struct drm_panel *panel,
@@ -280,6 +280,7 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = 2;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+			MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			MIPI_DSI_MODE_VIDEO_HSE |
 			MIPI_DSI_CLOCK_NON_CONTINUOUS |
 			MIPI_DSI_MODE_NO_EOT_PACKET;
-- 
2.39.2



