Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8369D79B0A2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbjIKWps (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbjIKPOo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EC5C433C7;
        Mon, 11 Sep 2023 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445280;
        bh=wR+ejTXTcvGOkcI78mvlFxqT1wovclZXzrIIiWBcBrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oI3Mt8ep+0HdIdg8272+UInP5T0DWPCvUhX73+XjqpiZA6awHuIKIKNdBKHEjR8vK
         N/eXJB9h8mY4OGZ59mHYFsWfQhJMQwBxp7fnbZ9HkAqiTrQ9/DEihfcs1RmXGtTh3F
         +jvXXMZGnBool9JKZsYy4lQkPjMSu2v2KYran9dE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 289/600] drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
Date:   Mon, 11 Sep 2023 15:45:22 +0200
Message-ID: <20230911134642.139595598@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 5e067ba7e5fba..0e8622ccd3a0f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1159,7 +1159,9 @@ static const struct panel_desc auo_t215hvn01 = {
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



