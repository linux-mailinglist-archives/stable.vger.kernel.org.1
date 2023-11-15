Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD577ECDF9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjKOTje (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjKOTjd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3297B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E4EC433C8;
        Wed, 15 Nov 2023 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077168;
        bh=0G6ZySSTCtWthgmsELYD9Nnrcw0KsgaCtK05bJZ+tEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gah+w2rD50azqDl2E7Wc3KUv+/AIkyMJpWvWvS8c/JHRW5y3tIhA4ZzBr7ihuE0bA
         wTmEgw/oRmiwgyz1bs5fci0py32jBEGXk4mi1kdrPocrky9AJrwquI1uBoOK0fOrC5
         1fobJMzWbF82zrxR1h6wDGJ/3EokSRbJeaX2Odjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 543/550] Revert "drm/ast: report connection status on Display Port."
Date:   Wed, 15 Nov 2023 14:18:47 -0500
Message-ID: <20231115191638.562823305@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit f81bb0ac7872893241319ea82504956676ef02fd.

The commit depends on e329cb53b45d ("drm/ast: Add BMC virtual
connector") and will cause hangs on boot without that dependency.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_dp.c    | 11 ----------
 drivers/gpu/drm/ast/ast_dp501.c | 37 +++++++++++----------------------
 drivers/gpu/drm/ast/ast_drv.h   |  2 --
 drivers/gpu/drm/ast/ast_mode.c  | 30 ++------------------------
 4 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index fdd9a493aa9c0..6dc1a09504e13 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -7,17 +7,6 @@
 #include <drm/drm_print.h>
 #include "ast_drv.h"
 
-bool ast_astdp_is_connected(struct ast_device *ast)
-{
-	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, ASTDP_MCU_FW_EXECUTING))
-		return false;
-	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDF, ASTDP_HPD))
-		return false;
-	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDC, ASTDP_LINK_SUCCESS))
-		return false;
-	return true;
-}
-
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 {
 	struct ast_device *ast = to_ast_device(dev);
diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index fa7442b0c2612..1bc35a992369d 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -272,9 +272,11 @@ static bool ast_launch_m68k(struct drm_device *dev)
 	return true;
 }
 
-bool ast_dp501_is_connected(struct ast_device *ast)
+bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
 {
-	u32 boot_address, offset, data;
+	struct ast_device *ast = to_ast_device(dev);
+	u32 i, boot_address, offset, data;
+	u32 *pEDIDidx;
 
 	if (ast->config_mode == ast_use_p2a) {
 		boot_address = get_fw_base(ast);
@@ -290,6 +292,14 @@ bool ast_dp501_is_connected(struct ast_device *ast)
 		data = ast_mindwm(ast, boot_address + offset);
 		if (!(data & AST_DP501_PNP_CONNECTED))
 			return false;
+
+		/* Read EDID */
+		offset = AST_DP501_EDID_DATA;
+		for (i = 0; i < 128; i += 4) {
+			data = ast_mindwm(ast, boot_address + offset + i);
+			pEDIDidx = (u32 *)(ediddata + i);
+			*pEDIDidx = data;
+		}
 	} else {
 		if (!ast->dp501_fw_buf)
 			return false;
@@ -309,30 +319,7 @@ bool ast_dp501_is_connected(struct ast_device *ast)
 		data = readl(ast->dp501_fw_buf + offset);
 		if (!(data & AST_DP501_PNP_CONNECTED))
 			return false;
-	}
-	return true;
-}
-
-bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
-{
-	struct ast_device *ast = to_ast_device(dev);
-	u32 i, boot_address, offset, data;
-	u32 *pEDIDidx;
-
-	if (!ast_dp501_is_connected(ast))
-		return false;
-
-	if (ast->config_mode == ast_use_p2a) {
-		boot_address = get_fw_base(ast);
 
-		/* Read EDID */
-		offset = AST_DP501_EDID_DATA;
-		for (i = 0; i < 128; i += 4) {
-			data = ast_mindwm(ast, boot_address + offset + i);
-			pEDIDidx = (u32 *)(ediddata + i);
-			*pEDIDidx = data;
-		}
-	} else {
 		/* Read EDID */
 		offset = AST_DP501_EDID_DATA;
 		for (i = 0; i < 128; i += 4) {
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 8a0ffa8b5939b..5498a6676f2e8 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -468,7 +468,6 @@ void ast_patch_ahb_2500(struct ast_device *ast);
 /* ast dp501 */
 void ast_set_dp501_video_output(struct drm_device *dev, u8 mode);
 bool ast_backup_fw(struct drm_device *dev, u8 *addr, u32 size);
-bool ast_dp501_is_connected(struct ast_device *ast);
 bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata);
 u8 ast_get_dp501_max_clk(struct drm_device *dev);
 void ast_init_3rdtx(struct drm_device *dev);
@@ -477,7 +476,6 @@ void ast_init_3rdtx(struct drm_device *dev);
 struct ast_i2c_chan *ast_i2c_create(struct drm_device *dev);
 
 /* aspeed DP */
-bool ast_astdp_is_connected(struct ast_device *ast);
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
 void ast_dp_launch(struct drm_device *dev);
 void ast_dp_power_on_off(struct drm_device *dev, bool no);
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 0724516f29737..b3c670af6ef2b 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1585,20 +1585,8 @@ static int ast_dp501_connector_helper_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int ast_dp501_connector_helper_detect_ctx(struct drm_connector *connector,
-						 struct drm_modeset_acquire_ctx *ctx,
-						 bool force)
-{
-	struct ast_device *ast = to_ast_device(connector->dev);
-
-	if (ast_dp501_is_connected(ast))
-		return connector_status_connected;
-	return connector_status_disconnected;
-}
-
 static const struct drm_connector_helper_funcs ast_dp501_connector_helper_funcs = {
 	.get_modes = ast_dp501_connector_helper_get_modes,
-	.detect_ctx = ast_dp501_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_dp501_connector_funcs = {
@@ -1623,7 +1611,7 @@ static int ast_dp501_connector_init(struct drm_device *dev, struct drm_connector
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
 
 	return 0;
 }
@@ -1695,20 +1683,8 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector,
-						 struct drm_modeset_acquire_ctx *ctx,
-						 bool force)
-{
-	struct ast_device *ast = to_ast_device(connector->dev);
-
-	if (ast_astdp_is_connected(ast))
-		return connector_status_connected;
-	return connector_status_disconnected;
-}
-
 static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {
 	.get_modes = ast_astdp_connector_helper_get_modes,
-	.detect_ctx = ast_astdp_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_astdp_connector_funcs = {
@@ -1733,7 +1709,7 @@ static int ast_astdp_connector_init(struct drm_device *dev, struct drm_connector
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
 
 	return 0;
 }
@@ -1872,7 +1848,5 @@ int ast_mode_config_init(struct ast_device *ast)
 
 	drm_mode_config_reset(dev);
 
-	drm_kms_helper_poll_init(dev);
-
 	return 0;
 }
-- 
2.42.0



