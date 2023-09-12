Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8679B7A1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbjIKW2m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjIKOmf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:42:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216D12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:42:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95F6C433C8;
        Mon, 11 Sep 2023 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443350;
        bh=Btc7kPy5dser70DY2gpK8srfkZG7i2oMoeqee4M/Jhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYjY+PnRtdsZLW+z+3iDxgEbtZJ9fqZ+77ADoAb8r6L9HN8nhXFY9rqqJ7ml83o1k
         1JX5U0LmEH0gV/WLI574RfPzE5b+Sc2fJ1tBQDYlSji0r1ejoT0BPXjaDNFvfzt+00
         t1GcujljEifMPpSaqGrU0GFKbtfb3xWu0d6WJnYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jocelyn Falempe <jfalempe@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 347/737] drm/ast: report connection status on Display Port.
Date:   Mon, 11 Sep 2023 15:43:26 +0200
Message-ID: <20230911134700.217316031@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jocelyn Falempe <jfalempe@redhat.com>

[ Upstream commit f81bb0ac7872893241319ea82504956676ef02fd ]

Aspeed always report the display port as "connected", because it
doesn't set a .detect_ctx callback.
Fix this by providing the proper detect callback for astdp and dp501.

This also fixes the following regression:
Since commit fae7d186403e ("drm/probe-helper: Default to 640x480 if no
EDID on DP") The default resolution is now 640x480 when no monitor is
connected. But Aspeed graphics is mostly used in servers, where no monitor
is attached. This also affects the remote BMC resolution to 640x480, which
is inconvenient, and breaks the anaconda installer.

v2: Add .detect callback to the dp/dp501 connector (Jani Nikula)
v3: Use .detect_ctx callback, and refactors (Thomas Zimmermann)
    Add a BMC virtual connector
v4: Better indent detect_ctx() functions (Thomas Zimmermann)
v5: Enable polling of the dp and dp501 connector status
    (Thomas Zimmermann)
v6: Change check order in ast_astdp_is_connected (Jammy Huang)

Fixes: fae7d186403e ("drm/probe-helper: Default to 640x480 if no EDID on DP")
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230713134316.332502-2-jfalempe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_dp.c    | 11 ++++++++++
 drivers/gpu/drm/ast/ast_dp501.c | 37 ++++++++++++++++++++++-----------
 drivers/gpu/drm/ast/ast_drv.h   |  2 ++
 drivers/gpu/drm/ast/ast_mode.c  | 30 ++++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 6dc1a09504e13..fdd9a493aa9c0 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -7,6 +7,17 @@
 #include <drm/drm_print.h>
 #include "ast_drv.h"
 
+bool ast_astdp_is_connected(struct ast_device *ast)
+{
+	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1, ASTDP_MCU_FW_EXECUTING))
+		return false;
+	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDF, ASTDP_HPD))
+		return false;
+	if (!ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xDC, ASTDP_LINK_SUCCESS))
+		return false;
+	return true;
+}
+
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 {
 	struct ast_device *ast = to_ast_device(dev);
diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 1bc35a992369d..fa7442b0c2612 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -272,11 +272,9 @@ static bool ast_launch_m68k(struct drm_device *dev)
 	return true;
 }
 
-bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
+bool ast_dp501_is_connected(struct ast_device *ast)
 {
-	struct ast_device *ast = to_ast_device(dev);
-	u32 i, boot_address, offset, data;
-	u32 *pEDIDidx;
+	u32 boot_address, offset, data;
 
 	if (ast->config_mode == ast_use_p2a) {
 		boot_address = get_fw_base(ast);
@@ -292,14 +290,6 @@ bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
 		data = ast_mindwm(ast, boot_address + offset);
 		if (!(data & AST_DP501_PNP_CONNECTED))
 			return false;
-
-		/* Read EDID */
-		offset = AST_DP501_EDID_DATA;
-		for (i = 0; i < 128; i += 4) {
-			data = ast_mindwm(ast, boot_address + offset + i);
-			pEDIDidx = (u32 *)(ediddata + i);
-			*pEDIDidx = data;
-		}
 	} else {
 		if (!ast->dp501_fw_buf)
 			return false;
@@ -319,7 +309,30 @@ bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
 		data = readl(ast->dp501_fw_buf + offset);
 		if (!(data & AST_DP501_PNP_CONNECTED))
 			return false;
+	}
+	return true;
+}
+
+bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata)
+{
+	struct ast_device *ast = to_ast_device(dev);
+	u32 i, boot_address, offset, data;
+	u32 *pEDIDidx;
+
+	if (!ast_dp501_is_connected(ast))
+		return false;
+
+	if (ast->config_mode == ast_use_p2a) {
+		boot_address = get_fw_base(ast);
 
+		/* Read EDID */
+		offset = AST_DP501_EDID_DATA;
+		for (i = 0; i < 128; i += 4) {
+			data = ast_mindwm(ast, boot_address + offset + i);
+			pEDIDidx = (u32 *)(ediddata + i);
+			*pEDIDidx = data;
+		}
+	} else {
 		/* Read EDID */
 		offset = AST_DP501_EDID_DATA;
 		for (i = 0; i < 128; i += 4) {
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 5498a6676f2e8..8a0ffa8b5939b 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -468,6 +468,7 @@ void ast_patch_ahb_2500(struct ast_device *ast);
 /* ast dp501 */
 void ast_set_dp501_video_output(struct drm_device *dev, u8 mode);
 bool ast_backup_fw(struct drm_device *dev, u8 *addr, u32 size);
+bool ast_dp501_is_connected(struct ast_device *ast);
 bool ast_dp501_read_edid(struct drm_device *dev, u8 *ediddata);
 u8 ast_get_dp501_max_clk(struct drm_device *dev);
 void ast_init_3rdtx(struct drm_device *dev);
@@ -476,6 +477,7 @@ void ast_init_3rdtx(struct drm_device *dev);
 struct ast_i2c_chan *ast_i2c_create(struct drm_device *dev);
 
 /* aspeed DP */
+bool ast_astdp_is_connected(struct ast_device *ast);
 int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
 void ast_dp_launch(struct drm_device *dev);
 void ast_dp_power_on_off(struct drm_device *dev, bool no);
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index b3c670af6ef2b..0724516f29737 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1585,8 +1585,20 @@ static int ast_dp501_connector_helper_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static int ast_dp501_connector_helper_detect_ctx(struct drm_connector *connector,
+						 struct drm_modeset_acquire_ctx *ctx,
+						 bool force)
+{
+	struct ast_device *ast = to_ast_device(connector->dev);
+
+	if (ast_dp501_is_connected(ast))
+		return connector_status_connected;
+	return connector_status_disconnected;
+}
+
 static const struct drm_connector_helper_funcs ast_dp501_connector_helper_funcs = {
 	.get_modes = ast_dp501_connector_helper_get_modes,
+	.detect_ctx = ast_dp501_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_dp501_connector_funcs = {
@@ -1611,7 +1623,7 @@ static int ast_dp501_connector_init(struct drm_device *dev, struct drm_connector
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
 	return 0;
 }
@@ -1683,8 +1695,20 @@ static int ast_astdp_connector_helper_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
+static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector,
+						 struct drm_modeset_acquire_ctx *ctx,
+						 bool force)
+{
+	struct ast_device *ast = to_ast_device(connector->dev);
+
+	if (ast_astdp_is_connected(ast))
+		return connector_status_connected;
+	return connector_status_disconnected;
+}
+
 static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {
 	.get_modes = ast_astdp_connector_helper_get_modes,
+	.detect_ctx = ast_astdp_connector_helper_detect_ctx,
 };
 
 static const struct drm_connector_funcs ast_astdp_connector_funcs = {
@@ -1709,7 +1733,7 @@ static int ast_astdp_connector_init(struct drm_device *dev, struct drm_connector
 	connector->interlace_allowed = 0;
 	connector->doublescan_allowed = 0;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT;
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
 	return 0;
 }
@@ -1848,5 +1872,7 @@ int ast_mode_config_init(struct ast_device *ast)
 
 	drm_mode_config_reset(dev);
 
+	drm_kms_helper_poll_init(dev);
+
 	return 0;
 }
-- 
2.40.1



