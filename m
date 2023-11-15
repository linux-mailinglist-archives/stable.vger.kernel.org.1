Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0427ED080
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjKOT4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbjKOTz5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D141738
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5758CC433CA;
        Wed, 15 Nov 2023 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078149;
        bh=NJim0n8Ws99lbvtwPGuoPCYtFELYB+WLQImzmRc/tkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKnHIoRlv0DfL0xcQ8PzhfS/nD6Zo1VkejfpNNuXatP45rMO6o6VWAYcNlY9HnSnn
         2gfj0SECNFExpfEI16OUKnv6tlOg3SSLyHnEPUWhrMamY8YM4EQiyJ0KpXjA9egHcf
         5wInzPSFwDbe2W+cZyvFk1lQH4/Tqzqve/eFZkRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/379] drm/rockchip: vop: Fix call to crtc reset helper
Date:   Wed, 15 Nov 2023 14:23:11 -0500
Message-ID: <20231115192651.986744518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 5aacd290837828c089a83ac9795c74c4c9e2c923 ]

Allocation of crtc_state may fail in vop_crtc_reset, causing an invalid
pointer to be passed to __drm_atomic_helper_crtc_reset.

Fix this by adding a NULL check of crtc_state, similar to other drivers.

Fixes: 01e2eaf40c9d ("drm/rockchip: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230621223311.2239547-4-jonas@kwiboo.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 071ba60eea99f..ae8c532f7fc84 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1632,7 +1632,10 @@ static void vop_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		vop_crtc_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	if (crtc_state)
+		__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
-- 
2.42.0



