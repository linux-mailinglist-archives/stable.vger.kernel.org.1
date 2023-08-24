Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F7787292
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbjHXOzK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbjHXOys (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3019B3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5959366F50
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E79C433C8;
        Thu, 24 Aug 2023 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888884;
        bh=atUlay1FdAgJVtZw3uUJ3T7SdKN3u15P7y65vi8LfZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcZQUKq7wMrYDChL2n9pmjCvj2Jm9+HFVOAKeJIfTZjfr1uosbAQEzw8vFUcRthaN
         bwR2M3UdREfRM4BVBozqDNl+0Odd2R7qCAhm/sdT9IejL4jxxf0zEr8oOAiY/Bp+qr
         w6GCbJiC5Pp5nbJ5RzF0wZ33safLneZVPFEtlpVA=
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
Subject: [PATCH 5.15 048/139] drm/amd/display: save restore hdcp state when display is unplugged from mst hub
Date:   Thu, 24 Aug 2023 16:49:31 +0200
Message-ID: <20230824145025.692586202@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
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

[ Upstream commit 82986fd631fa04bcedaefe11a6b3767601cbe84f ]

[Why]
connector hdcp properties are lost after display is
unplgged from mst hub. connector is destroyed with
dm_dp_mst_connector_destroy. when display is plugged
back, hdcp is not desired and it wouldnt be enabled.

[How]
save hdcp properties into hdcp_work within
amdgpu_dm_atomic_commit_tail. If the same display is
plugged back with same display index, its hdcp
properties will be retrieved from hdcp_work within
dm_dp_mst_get_modes.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cdff36a0217a ("drm/amd/display: fix access hdcp_workqueue assert")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    | 14 ++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 26 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7bd38d927b18c..41be9606726e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9612,11 +9612,33 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue))
+		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue)) {
+			/* when display is unplugged from mst hub, connctor will
+			 * be destroyed within dm_dp_mst_connector_destroy. connector
+			 * hdcp perperties, like type, undesired, desired, enabled,
+			 * will be lost. So, save hdcp properties into hdcp_work within
+			 * amdgpu_dm_atomic_commit_tail. if the same display is
+			 * plugged back with same display index, its hdcp properties
+			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+			 */
+
+			if (aconnector->dc_link && aconnector->dc_sink &&
+				aconnector->dc_link->type == dc_connection_mst_branch) {
+				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+				struct hdcp_workqueue *hdcp_w =
+					&hdcp_work[aconnector->dc_link->link_index];
+
+				hdcp_w->hdcp_content_type[connector->index] =
+					new_con_state->hdcp_content_type;
+				hdcp_w->content_protection[connector->index] =
+					new_con_state->content_protection;
+			}
+
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
 				new_con_state->hdcp_content_type,
 				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
+    }
 	}
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 09294ff122fea..bbbf7d0eff82f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -52,6 +52,20 @@ struct hdcp_workqueue {
 	struct mod_hdcp_link link;
 
 	enum mod_hdcp_encryption_status encryption_status;
+
+	/* when display is unplugged from mst hub, connctor will be
+	 * destroyed within dm_dp_mst_connector_destroy. connector
+	 * hdcp perperties, like type, undesired, desired, enabled,
+	 * will be lost. So, save hdcp properties into hdcp_work within
+	 * amdgpu_dm_atomic_commit_tail. if the same display is
+	 * plugged back with same display index, its hdcp properties
+	 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+	 */
+	/* un-desired, desired, enabled */
+	unsigned int content_protection[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	/* hdcp1.x, hdcp2.x */
+	unsigned int hdcp_content_type[AMDGPU_DM_MAX_DISPLAY_INDEX];
+
 	uint8_t max_link;
 
 	uint8_t *srm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7a3fee71a867a..e1e0be6dd22ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -32,6 +32,10 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+#include "amdgpu_dm_hdcp.h"
+#endif
+
 #include "dc.h"
 #include "dm_helpers.h"
 
@@ -315,6 +319,28 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		/* dc_link_add_remote_sink returns a new reference */
 		aconnector->dc_sink = dc_sink;
 
+		/* when display is unplugged from mst hub, connctor will be
+		 * destroyed within dm_dp_mst_connector_destroy. connector
+		 * hdcp perperties, like type, undesired, desired, enabled,
+		 * will be lost. So, save hdcp properties into hdcp_work within
+		 * amdgpu_dm_atomic_commit_tail. if the same display is
+		 * plugged back with same display index, its hdcp properties
+		 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+		 */
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (aconnector->dc_sink && connector->state) {
+			struct drm_device *dev = connector->dev;
+			struct amdgpu_device *adev = drm_to_adev(dev);
+			struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+			struct hdcp_workqueue *hdcp_w = &hdcp_work[aconnector->dc_link->link_index];
+
+			connector->state->hdcp_content_type =
+			hdcp_w->hdcp_content_type[connector->index];
+			connector->state->content_protection =
+			hdcp_w->content_protection[connector->index];
+		}
+#endif
+
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->edid);
-- 
2.40.1



