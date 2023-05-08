Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E496FA8B8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjEHKov (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjEHKoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B32A86A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1697A6286E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A2C433A0;
        Mon,  8 May 2023 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542578;
        bh=Ns4P9xblzuxKQQoBbgAkaeEKgiMPKptOtgYf9HZsURk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qw/fosVoe5h5RVkaI0r/04o0Cb2C7olFZ6T7PUR6eXnuY0YoYjjFIdDSAyFR2jLNZ
         g13TzVpW/mHflMt9Zpp9J4067DSPJQmc9Qd+Ffpox6wCyog1x2fKymtl/uHwMzfvuW
         7mT4zwkWwXnSFWya6uPrp4L+HfEhyD8Mpv0FaKp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 480/663] drm/panel: novatek-nt35950: Improve error handling
Date:   Mon,  8 May 2023 11:45:06 +0200
Message-Id: <20230508094443.902405310@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 5dd45b66742a1f3cfa9a92dc0ac8714c7708ee6c ]

In a very peculiar case when probing and registering with the secondary
DSI host succeeds, but the OF backlight or DSI attachment fails, the
primary DSI device is automatically cleaned up, but the secondary one
is not, leading to -EEXIST when the driver core tries to handle
-EPROBE_DEFER.

Unregister the DSI1 device manually on failure to prevent that.

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 3a844917da075..4359b02754aac 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -593,8 +593,11 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ret = drm_panel_of_backlight(&nt->panel);
-	if (ret)
+	if (ret) {
+		mipi_dsi_device_unregister(nt->dsi[1]);
+
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+	}
 
 	drm_panel_add(&nt->panel);
 
@@ -610,6 +613,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
+			/* If we fail to attach to either host, we're done */
+			mipi_dsi_device_unregister(nt->dsi[1]);
+
 			return dev_err_probe(dev, ret,
 					     "Cannot attach to DSI%d host.\n", i);
 		}
-- 
2.39.2



