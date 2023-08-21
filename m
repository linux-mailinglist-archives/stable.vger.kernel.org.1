Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7BA7832B1
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHUTx3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHUTx2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E59EE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FB264505
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45938C433C7;
        Mon, 21 Aug 2023 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647605;
        bh=bL8iG0IP0R8Zbp4pP8snhLe49IfvZZTUEAmlbYKDkBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcjRTEnijhrjqZttRyX7JivaUqv9/Cao1JnYmhgQ7eUD+oF5mW+FFW2MHNjQ5pnau
         67iRmIanCBvxTSLUgiKDUhGL+ZQQ+AqNjg4XW2lMNyBtaas/o6VhQl5ndWibmUVcDx
         O7le+PyAKxTkN077KgDNrVDzaK+6ZQ7bTw04WPUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/194] drm/amd/display: phase3 mst hdcp for multiple displays
Date:   Mon, 21 Aug 2023 21:40:53 +0200
Message-ID: <20230821194126.025392686@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: hersen wu <hersenxs.wu@amd.com>

[ Upstream commit e8fd3eeb5e8711af39b00642da06474e52f4780c ]

[Why]
multiple display hdcp are enabled within event_property_validate,
event_property_update by looping all displays on mst hub. when
one of display on mst hub in unplugged or disabled, hdcp are
disabled for all displays on mst hub within hdcp_reset_display
by looping all displays of mst link. for displays still active,
their encryption status are off. kernel driver will not run hdcp
authentication again. therefore, hdcp are not enabled automatically.

[How]
within is_content_protection_different, check drm_crtc_state changes
of all displays on mst hub, if need, triger hdcp_update_display to
re-run hdcp authentication.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cdff36a0217a ("drm/amd/display: fix access hdcp_workqueue assert")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 183 ++++++++++++++----
 1 file changed, 141 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdc6f90b3adb5..aa0ea28a86f02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7397,27 +7397,55 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-static bool is_content_protection_different(struct drm_connector_state *state,
-					    const struct drm_connector_state *old_state,
-					    const struct drm_connector *connector, struct hdcp_workqueue *hdcp_w)
+static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+					    struct drm_crtc_state *old_crtc_state,
+					    struct drm_connector_state *new_conn_state,
+					    struct drm_connector_state *old_conn_state,
+					    const struct drm_connector *connector,
+					    struct hdcp_workqueue *hdcp_w)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 
-	/* Handle: Type0/1 change */
-	if (old_state->hdcp_content_type != state->hdcp_content_type &&
-	    state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+		connector->index, connector->status, connector->dpms);
+	pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+		old_conn_state->content_protection, new_conn_state->content_protection);
+
+	if (old_crtc_state)
+		pr_debug("[HDCP_DM] old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		old_crtc_state->enable,
+		old_crtc_state->active,
+		old_crtc_state->mode_changed,
+		old_crtc_state->active_changed,
+		old_crtc_state->connectors_changed);
+
+	if (new_crtc_state)
+		pr_debug("[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		new_crtc_state->enable,
+		new_crtc_state->active,
+		new_crtc_state->mode_changed,
+		new_crtc_state->active_changed,
+		new_crtc_state->connectors_changed);
+
+	/* hdcp content type change */
+	if (old_conn_state->hdcp_content_type != new_conn_state->hdcp_content_type &&
+	    new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		pr_debug("[HDCP_DM] Type0/1 change %s :true\n", __func__);
 		return true;
 	}
 
-	/* CP is being re enabled, ignore this
-	 *
-	 * Handles:	ENABLED -> DESIRED
-	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	/* CP is being re enabled, ignore this */
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+		if (new_crtc_state && new_crtc_state->mode_changed) {
+			new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+			pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_changed %s :true\n", __func__);
+			return true;
+		};
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __func__);
 		return false;
 	}
 
@@ -7425,9 +7453,9 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	UNDESIRED -> ENABLED
 	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
 	/* Stream removed and re-enabled
 	 *
@@ -7437,10 +7465,12 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (!(old_state->crtc && old_state->crtc->enabled) &&
-		state->crtc && state->crtc->enabled &&
+	if (!(old_conn_state->crtc && old_conn_state->crtc->enabled) &&
+		new_conn_state->crtc && new_conn_state->crtc->enabled &&
 		connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Stream removed and re-enabled) %s :true\n",
+			__func__);
 		return true;
 	}
 
@@ -7452,35 +7482,42 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
-	    connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
+	if (dm_con_state->update_hdcp &&
+	new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Hot-plug, headless s3, dpms) %s :true\n",
+			__func__);
 		return true;
 	}
 
-	/*
-	 * Handles:	UNDESIRED -> UNDESIRED
-	 *		DESIRED -> DESIRED
-	 *		ENABLED -> ENABLED
-	 */
-	if (old_state->content_protection == state->content_protection)
+	if (old_conn_state->content_protection == new_conn_state->content_protection) {
+		if (new_conn_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+			if (new_crtc_state && new_crtc_state->mode_changed) {
+				pr_debug("[HDCP_DM] DESIRED->DESIRED or ENABLE->ENABLE mode_change %s :true\n",
+					__func__);
+				return true;
+			};
+			pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->ENABLE %s :false\n",
+				__func__);
+			return false;
+		};
+
+		pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __func__);
 		return false;
+	}
 
-	/*
-	 * Handles:	UNDESIRED -> DESIRED
-	 *		DESIRED -> UNDESIRED
-	 *		ENABLED -> UNDESIRED
-	 */
-	if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
+	if (new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+		pr_debug("[HDCP_DM] UNDESIRED->DESIRED or DESIRED->UNDESIRED or ENABLED->UNDESIRED %s :true\n",
+			__func__);
 		return true;
+	}
 
-	/*
-	 * Handles:	DESIRED -> ENABLED
-	 */
+	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
-
 #endif
+
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
 			  struct dc_stream_state *stream)
@@ -8330,15 +8367,66 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
+
+		if (!connector)
+			continue;
+
+		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+			connector->index, connector->status, connector->dpms);
+		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+			old_con_state->content_protection, new_con_state->content_protection);
+
+		if (aconnector->dc_sink) {
+			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
+				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
+				aconnector->dc_sink->edid_caps.display_name);
+			}
+		}
+
+		new_crtc_state = NULL;
+		old_crtc_state = NULL;
+
+		if (acrtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
+
+		if (old_crtc_state)
+			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			old_crtc_state->enable,
+			old_crtc_state->active,
+			old_crtc_state->mode_changed,
+			old_crtc_state->active_changed,
+			old_crtc_state->connectors_changed);
+
+		if (new_crtc_state)
+			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			new_crtc_state->enable,
+			new_crtc_state->active,
+			new_crtc_state->mode_changed,
+			new_crtc_state->active_changed,
+			new_crtc_state->connectors_changed);
+	}
+
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 		new_crtc_state = NULL;
+		old_crtc_state = NULL;
 
-		if (acrtc)
+		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -8350,7 +8438,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue)) {
+		if (is_content_protection_different(new_crtc_state, old_crtc_state, new_con_state,
+											old_con_state, connector, adev->dm.hdcp_workqueue)) {
 			/* when display is unplugged from mst hub, connctor will
 			 * be destroyed within dm_dp_mst_connector_destroy. connector
 			 * hdcp perperties, like type, undesired, desired, enabled,
@@ -8360,6 +8449,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
 			 */
 
+			bool enable_encryption = false;
+
+			if (new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
 			if (aconnector->dc_link && aconnector->dc_sink &&
 				aconnector->dc_link->type == dc_connection_mst_branch) {
 				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
@@ -8372,11 +8466,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					new_con_state->content_protection;
 			}
 
+			if (new_crtc_state && new_crtc_state->mode_changed &&
+				new_con_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
+			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
+
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type,
-				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
-    }
+				new_con_state->hdcp_content_type, enable_encryption);
+		}
 	}
 #endif
 
-- 
2.40.1



