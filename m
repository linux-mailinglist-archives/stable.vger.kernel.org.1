Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1576ADD6
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjHAJdx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjHAJdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AA4EE6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85481614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739FC433C7;
        Tue,  1 Aug 2023 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882273;
        bh=PIw9NpGW+ek33rXPYR37p8x8G7v8qErLRZFSjssiGzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmAFDpdyxvLMU3CIzW1KUbUWO8qJwOm6HpX+Gb+Y2k0D6Wnnq3nYITP5nKAx7X6VK
         iYrejRFHH2BZmmAL9OX9KJNBpl4QFrOwypib9XmIdX49ko5V/QwoAl4TalEvDqjZnT
         2wuMat/Sw2lVtNSjaT6fh7skthJrLbfvPbLWqtjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Wang <sean.ns.wang@amd.com>,
        Marc Rossi <Marc.Rossi@amd.com>,
        Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
        "Tsung-hua (Ryan) Lin" <Tsung-hua.Lin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/228] drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt
Date:   Tue,  1 Aug 2023 11:18:24 +0200
Message-ID: <20230801091924.566787523@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit c35b6ea8f2ecfa9d775530b70d4e727869099a9c ]

A number of parade TCONs are causing system hangs when utilized with
older DMUB firmware and PSR-SU. Some changes have been introduced into
DMUB firmware to add resilience against these failures.

Don't allow running PSR-SU unless on the newer firmware.

Cc: stable@vger.kernel.org
Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cd2e31a9ab93 ("drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 10 ++++++----
 7 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 872d06fe14364..3eb8794807d2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -24,6 +24,7 @@
  */
 
 #include "amdgpu_dm_psr.h"
+#include "dc_dmub_srv.h"
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
@@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
-	return true;
+	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index a461e9463534b..31bb7e782c6b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1026,3 +1026,10 @@ void dc_send_update_cursor_info_to_dmu(
 		dc_send_cmd_to_dmu(pCtx->stream->ctx->dmub_srv, &cmd);
 	}
 }
+
+bool dc_dmub_check_min_version(struct dmub_srv *srv)
+{
+	if (!srv->hw_funcs.is_psrsu_supported)
+		return true;
+	return srv->hw_funcs.is_psrsu_supported(srv);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index d34f5563df2ec..9a248ced03b9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -89,4 +89,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_check_min_version(struct dmub_srv *srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index b53468aca4a9b..5f17b252e9be4 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -350,6 +350,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_supported)(struct dmub_srv *dmub);
 
+	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
+
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	bool (*is_phy_init)(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index c90b9ee42e126..89d24fb7024e2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -297,6 +297,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
 	return supported;
 }
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 59);
+}
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index f6db6f89d45dc..eb62410941473 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -219,6 +219,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 6d76ce327d69f..0f43a05a41874 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -227,14 +227,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN314)
+		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
-		else if (asic == DMUB_ASIC_DCN315)
+		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
-		else if (asic == DMUB_ASIC_DCN316)
+		} else if (asic == DMUB_ASIC_DCN316) {
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-		else
+		} else {
 			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+			funcs->is_psrsu_supported = dmub_dcn31_is_psrsu_supported;
+		}
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
-- 
2.39.2



