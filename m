Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195367ECBE0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjKOTZE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKOTZD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE519F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34D0C433C9;
        Wed, 15 Nov 2023 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076299;
        bh=wuvroDY4uGQp/fl+OaaERphePNKLexf/N7P9HUYf1ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGd+GqL/glku8IRX5DBlii1e1UKxvHRX6pExFom3F9FRGQRBCKlwNyrgyHjXQPgcL
         ll9xYSLhKiBNHDB49kozAKgAKIYDtbGsBslugo5aBFHFFYzXp6HREjz9cuYi/bW1GJ
         giVHwJEbS+v5PIXNfjM0twZsNib24qJqf7EMqB80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Adam Ford <aford173@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 203/550] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY
Date:   Wed, 15 Nov 2023 14:13:07 -0500
Message-ID: <20231115191614.844160896@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 96413b355a49fd684430a230479bd231d977894f ]

Three DRM bridge drivers select GENERIC_PHY_MIPI_DPHY when GENERIC_PHY
might not be set.  This causes Kconfig warnings and a build error.

WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
  Depends on [n]: GENERIC_PHY [=n]
  Selected by [y]:
  - DRM_NWL_MIPI_DSI [=y] && DRM_BRIDGE [=y] && DRM [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
  - DRM_SAMSUNG_DSIM [=y] && DRM [=y] && DRM_BRIDGE [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]

(drm/bridge/cadence/Kconfig was found by inspection.)

aarch64-linux-ld: drivers/gpu/drm/bridge/samsung-dsim.o: in function `samsung_dsim_set_phy_ctrl':
drivers/gpu/drm/bridge/samsung-dsim.c:731: undefined reference to `phy_mipi_dphy_get_default_config_for_hsclk'

Prevent these warnings and build error by also selecting GENERIC_PHY
whenever selecting GENERIC_PHY_MIPI_DPHY.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Fixes: 171b3b1e0f8b ("drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Aleksandr Nogikh <nogikh@google.com>
Link: lore.kernel.org/r/20230803144227.2187749-1-nogikh@google.com
Cc: Adam Ford <aford173@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Robert Foss <rfoss@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Adam Ford <aford173@gmail.com>
Tested-by: Aleksandr Nogikh <nogikh@google.com>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804030140.21395-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/Kconfig         | 2 ++
 drivers/gpu/drm/bridge/cadence/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 82c68b0424443..42d05a247511a 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -181,6 +181,7 @@ config DRM_NWL_MIPI_DSI
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	select MFD_SYSCON
 	select MULTIPLEXER
@@ -227,6 +228,7 @@ config DRM_SAMSUNG_DSIM
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
 	  The Samsung MIPI DSIM bridge controller driver.
diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index ec35215a20034..cced81633ddcd 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -4,6 +4,7 @@ config DRM_CDNS_DSI
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	depends on OF
 	help
-- 
2.42.0



