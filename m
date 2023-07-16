Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07C755271
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGPUIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjGPUH4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8212E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E25A60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB1C433C8;
        Sun, 16 Jul 2023 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538074;
        bh=b9eSyAaVaRMbZPe4fX3nY4OoTlpZuiJPnDBeL1XXFvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkqj4z9CtSMp8TlDCAW+d1Oga7mOiE7/YTNASnGPWeZkz8OtGtxXP/wwtrtaDmei6
         6IGYAqsO8+mLjnctdFqPXzExd5rRJyBV7XsjfeIzn8EPH6fAnoQFF+pmQ7BWb8pqS5
         ftC2RiLHk0D6aogO9ONa5L6542YgrzoS6UsgtFDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 322/800] drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
Date:   Sun, 16 Jul 2023 21:42:55 +0200
Message-ID: <20230716194956.551092891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit f24b49550814fdee4a98b9552e35e243ccafd4a8 ]

The previous setting was related to the overall dimension and not to the
active display area.
In the "PHYSICAL SPECIFICATIONS" section, the datasheet shows the
following parameters:

 ----------------------------------------------------------
|       Item        |         Specifications        | unit |
 ----------------------------------------------------------
| Display area      | 98.7 (W) x 57.5 (H)           |  mm  |
 ----------------------------------------------------------
| Overall dimension | 105.5(W) x 67.2(H) x 4.96(D)  |  mm  |
 ----------------------------------------------------------

Fixes: 966fea78adf2 ("drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
[narmstrong: fixed Fixes commit id length]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230516085039.3797303-1-dario.binacchi@amarulasolutions.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d2..d8efbcee9bc12 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -759,8 +759,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 105,
-		.height = 67,
+		.width = 99,
+		.height = 58,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
-- 
2.39.2



