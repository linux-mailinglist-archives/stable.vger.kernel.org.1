Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73F7ED2C1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjKOUnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjKOTzy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D6172D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB26C433C9;
        Wed, 15 Nov 2023 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078147;
        bh=5Y/bTl753xUyppby+/8eFmzHyFlCr08XPcBDHU/EdZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmwoD92UoGmf2BQ23qMeZDyF6mIPdgr8DTXG2Mn28FtGGbAVZGbrxca2K5E7W1Uj8
         iihFDOEUW2oEf/kIsHIdHvbfggiZcd8WbBHAWI234Pf63N7eXmP72fpSutfnQpX3Qj
         QFx1vYqQ8lTMkusPK52Hh6yhky5FNmIILnMPmzBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/379] drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
Date:   Wed, 15 Nov 2023 14:23:10 -0500
Message-ID: <20231115192651.926561939@linuxfoundation.org>
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

[ Upstream commit 13fc28804bf10ca0b7bce3efbba95c534836d7ca ]

struct rockchip_crtc_state members such as output_type, output_bpc and
enable_afbc is always reset to zero in the atomic_duplicate_state crtc
funcs.

Fix this by using kmemdup on the subclass rockchip_crtc_state struct.

Fixes: 4e257d9eee23 ("drm/rockchip: get rid of rockchip_drm_crtc_mode_config")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230621223311.2239547-2-jonas@kwiboo.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 2e2e08f4359a8..071ba60eea99f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1606,7 +1606,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
+				 sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
-- 
2.42.0



