Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5675D40C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjGUTRP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGUTRO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841A30E3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A92DB61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B988BC433C9;
        Fri, 21 Jul 2023 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967032;
        bh=rxaSJbEhLR3kfz6t+Bg6N3f+C+i8nScxRPNis1D7JGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU551Y1QPShm3bSMTZ3P2U4GgdVNjnn6JlfHX4KkaZiiPjzXS0+NDMK3IaGa3Z92W
         9vhi9uEOGXTfmssV7gebgefvk0ZPjSDniR4UCuG75oe5XZn4lIyd4OVPXqOoO1/De1
         NESdTzwDnAuLoFur3VWjsPnK62zXkLGaS3rW4mFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/223] drm/panel: simple: Add connector_type for innolux_at043tn24
Date:   Fri, 21 Jul 2023 18:04:21 +0200
Message-ID: <20230721160521.230063340@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index 7ca00b0323362..e49d352339ff8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2117,6 +2117,7 @@ static const struct panel_desc innolux_at043tn24 = {
 		.height = 54,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
-- 
2.39.2



