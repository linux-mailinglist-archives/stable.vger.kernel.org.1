Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBD761450
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjGYLSI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjGYLR5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898019BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74802615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BC8C433C8;
        Tue, 25 Jul 2023 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283871;
        bh=oOmeoYRZa6SSf2DFD8GCAMCcvk58fyaLv2b+ZhHvPlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrOHG4FxI1owQVzb55DwPX+RCB0xoW+mahF0bsmesDuHtm4h9VdORFtKrmkVdwiUc
         ERm53PH8T9RUfMDhc6kq3Ju9czloBF9az2TqJyjt1qfDG3VU7AhAXXYEXmIciGyvRn
         MFUP+JzARmXA72757IloTgqtgDTiQumKqs4lWWO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/509] drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
Date:   Tue, 25 Jul 2023 12:41:02 +0200
Message-ID: <20230725104559.318883833@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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
index 1a87cc445b5e1..b0b92f436879a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -704,8 +704,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
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



