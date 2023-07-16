Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9307575520C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGPUDM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjGPUDM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57F9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5A660E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC3FC433C7;
        Sun, 16 Jul 2023 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537790;
        bh=h3CBeke6BN2KMMEmGF4X7sLsNn5zhHMuRoUGiMuYAME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr1vd4t7RchWLTKR81aMrP7gyZlky+RPz80xYIPwsBY5EB9j/0ZcSXe4/ASCan5b9
         1225hfq6wQ15j4aeMmoMmMOK5vC8rzIHJQa6YcKDap7AVmfS8ZHZfsrUJjuYZruaaT
         IahyP/LjYVwEB24MrUf1I+o/B7sieMN58zQDyDb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 222/800] drm/imx/lcdc: fix a NULL vs IS_ERR() bug in probe
Date:   Sun, 16 Jul 2023 21:41:15 +0200
Message-ID: <20230716194954.248741691@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit dae2f7b89a8436351a2982d0d96a8a56accca576 ]

The devm_drm_dev_alloc() function returns error pointers.  It never
returns NULL.  Fix the check.

Fixes: c87e859cdeb5 ("drm/imx/lcdc: Implement DRM driver for imx25")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/d0a1fc55-3ef6-444e-b3ef-fdc937d8d57a@kili.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index 8e6d457917daf..277ead6a459a4 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -400,8 +400,8 @@ static int imx_lcdc_probe(struct platform_device *pdev)
 
 	lcdc = devm_drm_dev_alloc(dev, &imx_lcdc_drm_driver,
 				  struct imx_lcdc, drm);
-	if (!lcdc)
-		return -ENOMEM;
+	if (IS_ERR(lcdc))
+		return PTR_ERR(lcdc);
 
 	drm = &lcdc->drm;
 
-- 
2.39.2



