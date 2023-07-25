Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F676140F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjGYLQH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjGYLPy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214231BD6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4C361691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5118C433C7;
        Tue, 25 Jul 2023 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283724;
        bh=y+Mj1KzqWDFbvtMJOAa0RWD5A1m4kyfI1blAxCTS0mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwyZXlfZ3yn8z0qZ6FeR0KJT0jX7FC3uB5jF3OAxOg+JvmkqWBEHMHmJFT83Z/XiW
         bkkgVRN0OmJ2aENisL3rdpusXTvDQtkXBX832aNzQt3uY2xcsLr/Nr/Rss6gaQW+rP
         IvACvkMkGuX5uz+k6diKkTeQwv8B/jdsfedvBieY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 100/509] drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation
Date:   Tue, 25 Jul 2023 12:40:39 +0200
Message-ID: <20230725104558.273971423@linuxfoundation.org>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit cec5ccef85bd0128cf895612de54a9d21d2015d0 ]

Add atomic_get_input_bus_fmts() implementation, tc358768 has a parallel
RGB input interface with the actual bus format depending on the amount
of parallel input data lines.

Without this change when the tc358768 is used with less than 24bit the
color mapping is completely wrong.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230330095941.428122-7-francesco@dolcini.it
Stable-dep-of: ee18698e212b ("drm/bridge: tc358768: fix TCLK_TRAILCNT computation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index facd4dab433b1..f6c0300090ecd 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -9,6 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -871,6 +872,44 @@ static void tc358768_bridge_enable(struct drm_bridge *bridge)
 	}
 }
 
+#define MAX_INPUT_SEL_FORMATS	1
+
+static u32 *
+tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				   struct drm_bridge_state *bridge_state,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state,
+				   u32 output_fmt,
+				   unsigned int *num_input_fmts)
+{
+	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	switch (priv->pd_lines) {
+	case 16:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	default:
+	case 24:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	};
+
+	*num_input_fmts = MAX_INPUT_SEL_FORMATS;
+
+	return input_fmts;
+}
+
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
@@ -878,6 +917,11 @@ static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.enable = tc358768_bridge_enable,
 	.disable = tc358768_bridge_disable,
 	.post_disable = tc358768_bridge_post_disable,
+
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc358768_atomic_get_input_bus_fmts,
 };
 
 static const struct drm_bridge_timings default_tc358768_timings = {
-- 
2.39.2



