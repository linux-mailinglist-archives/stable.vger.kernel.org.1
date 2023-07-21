Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D475D35C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGUTJs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGUTJq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DED1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6846461D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AE2C433C8;
        Fri, 21 Jul 2023 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966581;
        bh=HFJkboNVScMIer6GJwhPiugsKjD1S612PvTeEmdS/YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2gVMGz0MGumm/tkS+vdbJD/dwrQF9Sl8/jNgJCZlyL1GhjDpj2ZdTVfP6VGBOD/y
         0umPCKYluYITH/nFgsK6ivB66MS/HHoJsNvxe0nyx7lNGibu1foVnzcFpYLoUNYSD5
         NHuQzAJj8nDyk+gPL2b9IpeZ51NiPfP7oVyqu5vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 395/532] drm/panel: simple: Add connector_type for innolux_at043tn24
Date:   Fri, 21 Jul 2023 18:04:59 +0200
Message-ID: <20230721160635.899665170@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2c56a751845ddfd3078ebe79981aaaa182629163 ]

The innolux at043tn24 display is a parallel LCD. Pass the 'connector_type'
information to avoid the following warning:

panel-simple panel: Specify missing connector_type

Signed-off-by: Fabio Estevam <festevam@denx.de>
Fixes: 41bcceb4de9c ("drm/panel: simple: Add support for Innolux AT043TN24")
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230620112202.654981-1-festevam@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2f85266cdb2e3..2b628b6be08f3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2469,6 +2469,7 @@ static const struct panel_desc innolux_at043tn24 = {
 		.height = 54,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
-- 
2.39.2



