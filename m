Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F406FA587
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjEHKK0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjEHKKZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38137E41
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53152623BC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6587DC433EF;
        Mon,  8 May 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540623;
        bh=Ns4P9xblzuxKQQoBbgAkaeEKgiMPKptOtgYf9HZsURk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWqF7cnYVr+QQZhyuqGQ7a8vpAsOA6Icd1BbO8WrfM9Y7vwiryOotQXyBqqdUAiYg
         8JpYwLG23c9BTeawNN2HL26IVnIZ3dYWqyYDexvUkYSD2MxOAdqXXOz/W9h9VGsO8I
         vXpSA1FL2oQNR+GZfD1Js7i0DLxXp0ggdSZxExT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 435/611] drm/panel: novatek-nt35950: Improve error handling
Date:   Mon,  8 May 2023 11:44:37 +0200
Message-Id: <20230508094436.313427148@linuxfoundation.org>
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



