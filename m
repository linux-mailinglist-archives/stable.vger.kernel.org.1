Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F6755555
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjGPUjz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjGPUjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42129F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7D860EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35279C433C8;
        Sun, 16 Jul 2023 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539992;
        bh=oXFe6ZLyGfOjlCYG15NYW1B2UwKbMAb3prQgNKNkIxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNyxjOlTMvWcc2Kd9+uhtmUVE7R3YVfnfoNQDXAp9OSjwjVZt78rU7OMUmUtF1dw/
         1fM8qo/awHcX51+KlJLOEMRRg/mYK6AejhiJ7bLNk//DI+p02i3uEDe8AoQ0ZOXMmX
         nhWU0j5gA5aUPvcbop7+GazBcZVP8PWwCI6G3jkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 205/591] drm/bridge: Introduce pre_enable_prev_first to alter bridge init order
Date:   Sun, 16 Jul 2023 21:45:44 +0200
Message-ID: <20230716194929.171698195@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 4fb912e5e19075874379cfcf074d90bd51ebf8ea ]

DSI sink devices typically want the DSI host powered up and configured
before they are powered up. pre_enable is the place this would normally
happen, but they are called in reverse order from panel/connector towards
the encoder, which is the "wrong" order.

Add a new flag pre_enable_prev_first that any bridge can set
to swap the order of pre_enable (and post_disable) for that and the
immediately previous bridge.
Should the immediately previous bridge also set the
pre_enable_prev_first flag, the previous bridge to that will be called
before either of those which requested pre_enable_prev_first.

eg:
- Panel
- Bridge 1
- Bridge 2 pre_enable_prev_first
- Bridge 3
- Bridge 4 pre_enable_prev_first
- Bridge 5 pre_enable_prev_first
- Bridge 6
- Encoder
Would result in pre_enable's being called as Panel, Bridge 1, Bridge 3,
Bridge 2, Bridge 6, Bridge 5, Bridge 4, Encoder.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Link: https://lore.kernel.org/r/20221205173328.1395350-5-dave.stevenson@raspberrypi.com
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Stable-dep-of: dd9e329af723 ("drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 145 +++++++++++++++++++++++++++++------
 include/drm/drm_bridge.h     |   8 ++
 2 files changed, 129 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1545c50fd1c8f..7044e339a82cd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -691,6 +691,25 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
+static void drm_atomic_bridge_call_post_disable(struct drm_bridge *bridge,
+						struct drm_atomic_state *old_state)
+{
+	if (old_state && bridge->funcs->atomic_post_disable) {
+		struct drm_bridge_state *old_bridge_state;
+
+		old_bridge_state =
+			drm_atomic_get_old_bridge_state(old_state,
+							bridge);
+		if (WARN_ON(!old_bridge_state))
+			return;
+
+		bridge->funcs->atomic_post_disable(bridge,
+						   old_bridge_state);
+	} else if (bridge->funcs->post_disable) {
+		bridge->funcs->post_disable(bridge);
+	}
+}
+
 /**
  * drm_atomic_bridge_chain_post_disable - cleans up after disabling all bridges
  *					  in the encoder chain
@@ -702,36 +721,86 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
  * starting from the first bridge to the last. These are called after completing
  * &drm_encoder_helper_funcs.atomic_disable
  *
+ * If a bridge sets @pre_enable_prev_first, then the @post_disable for that
+ * bridge will be called before the previous one to reverse the @pre_enable
+ * calling direction.
+ *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 					  struct drm_atomic_state *old_state)
 {
 	struct drm_encoder *encoder;
+	struct drm_bridge *next, *limit;
 
 	if (!bridge)
 		return;
 
 	encoder = bridge->encoder;
+
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
-		if (bridge->funcs->atomic_post_disable) {
-			struct drm_bridge_state *old_bridge_state;
+		limit = NULL;
+
+		if (!list_is_last(&bridge->chain_node, &encoder->bridge_chain)) {
+			next = list_next_entry(bridge, chain_node);
+
+			if (next->pre_enable_prev_first) {
+				/* next bridge had requested that prev
+				 * was enabled first, so disabled last
+				 */
+				limit = next;
+
+				/* Find the next bridge that has NOT requested
+				 * prev to be enabled first / disabled last
+				 */
+				list_for_each_entry_from(next, &encoder->bridge_chain,
+							 chain_node) {
+					if (next->pre_enable_prev_first) {
+						next = list_prev_entry(next, chain_node);
+						limit = next;
+						break;
+					}
+				}
+
+				/* Call these bridges in reverse order */
+				list_for_each_entry_from_reverse(next, &encoder->bridge_chain,
+								 chain_node) {
+					if (next == bridge)
+						break;
+
+					drm_atomic_bridge_call_post_disable(next,
+									    old_state);
+				}
+			}
+		}
 
-			old_bridge_state =
-				drm_atomic_get_old_bridge_state(old_state,
-								bridge);
-			if (WARN_ON(!old_bridge_state))
-				return;
+		drm_atomic_bridge_call_post_disable(bridge, old_state);
 
-			bridge->funcs->atomic_post_disable(bridge,
-							   old_bridge_state);
-		} else if (bridge->funcs->post_disable) {
-			bridge->funcs->post_disable(bridge);
-		}
+		if (limit)
+			/* Jump all bridges that we have already post_disabled */
+			bridge = limit;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
+static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
+					      struct drm_atomic_state *old_state)
+{
+	if (old_state && bridge->funcs->atomic_pre_enable) {
+		struct drm_bridge_state *old_bridge_state;
+
+		old_bridge_state =
+			drm_atomic_get_old_bridge_state(old_state,
+							bridge);
+		if (WARN_ON(!old_bridge_state))
+			return;
+
+		bridge->funcs->atomic_pre_enable(bridge, old_bridge_state);
+	} else if (bridge->funcs->pre_enable) {
+		bridge->funcs->pre_enable(bridge);
+	}
+}
+
 /**
  * drm_atomic_bridge_chain_pre_enable - prepares for enabling all bridges in
  *					the encoder chain
@@ -743,32 +812,60 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
  * starting from the last bridge to the first. These are called before calling
  * &drm_encoder_helper_funcs.atomic_enable
  *
+ * If a bridge sets @pre_enable_prev_first, then the pre_enable for the
+ * prev bridge will be called before pre_enable of this bridge.
+ *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 					struct drm_atomic_state *old_state)
 {
 	struct drm_encoder *encoder;
-	struct drm_bridge *iter;
+	struct drm_bridge *iter, *next, *limit;
 
 	if (!bridge)
 		return;
 
 	encoder = bridge->encoder;
+
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
-		if (iter->funcs->atomic_pre_enable) {
-			struct drm_bridge_state *old_bridge_state;
+		if (iter->pre_enable_prev_first) {
+			next = iter;
+			limit = bridge;
+			list_for_each_entry_from_reverse(next,
+							 &encoder->bridge_chain,
+							 chain_node) {
+				if (next == bridge)
+					break;
+
+				if (!next->pre_enable_prev_first) {
+					/* Found first bridge that does NOT
+					 * request prev to be enabled first
+					 */
+					limit = list_prev_entry(next, chain_node);
+					break;
+				}
+			}
+
+			list_for_each_entry_from(next, &encoder->bridge_chain, chain_node) {
+				/* Call requested prev bridge pre_enable
+				 * in order.
+				 */
+				if (next == iter)
+					/* At the first bridge to request prev
+					 * bridges called first.
+					 */
+					break;
+
+				drm_atomic_bridge_call_pre_enable(next, old_state);
+			}
+		}
 
-			old_bridge_state =
-				drm_atomic_get_old_bridge_state(old_state,
-								iter);
-			if (WARN_ON(!old_bridge_state))
-				return;
+		drm_atomic_bridge_call_pre_enable(iter, old_state);
 
-			iter->funcs->atomic_pre_enable(iter, old_bridge_state);
-		} else if (iter->funcs->pre_enable) {
-			iter->funcs->pre_enable(iter);
-		}
+		if (iter->pre_enable_prev_first)
+			/* Jump all bridges that we have already pre_enabled */
+			iter = limit;
 
 		if (iter == bridge)
 			break;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 288c6feda5de2..6b656ea23b964 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -768,6 +768,14 @@ struct drm_bridge {
 	 * modes.
 	 */
 	bool interlace_allowed;
+	/**
+	 * @pre_enable_prev_first: The bridge requires that the prev
+	 * bridge @pre_enable function is called before its @pre_enable,
+	 * and conversely for post_disable. This is most frequently a
+	 * requirement for DSI devices which need the host to be initialised
+	 * before the peripheral.
+	 */
+	bool pre_enable_prev_first;
 	/**
 	 * @ddc: Associated I2C adapter for DDC access, if any.
 	 */
-- 
2.39.2



