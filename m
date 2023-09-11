Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC379B516
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbjIKV26 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjIKOFL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F6E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE1C433C8;
        Mon, 11 Sep 2023 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441106;
        bh=gKEuVuuVE7Ub/2E+Xn5fjoJ/9+CbWSPEIZiKuxLKQH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nut4AzeeaSINqHK4DtEKzFUBAh8CcFUryJNwTLRhQT09g+C7MWjChOe7KqkfmXwH6
         TtPe2kGcSJI8kgbH/s+ejdKMhx26IfomHnXPJgaNpHyqOYAONi+is9ykeoH8q6Zf7q
         YK+mJKDtc2Ri61Ez3esR2AU//X2TFHiMf2xBloP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 298/739] drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
Date:   Mon, 11 Sep 2023 15:41:37 +0200
Message-ID: <20230911134659.453421179@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 7a675a8fa598edb29a664a91adb80f0340649f6f ]

The connector type and pixel format are missing for this panel,
add them to prevent various drivers from failing to determine
either of those parameters.

Fixes: 7ee933a1d5c4 ("drm/panel: simple: Add support for AUO T215HVN01")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230709134914.449328-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b38d0e95cd542..03196fbfa4d79 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1189,7 +1189,9 @@ static const struct panel_desc auo_t215hvn01 = {
 	.delay = {
 		.disable = 5,
 		.unprepare = 1000,
-	}
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct drm_display_mode avic_tm070ddh03_mode = {
-- 
2.40.1



