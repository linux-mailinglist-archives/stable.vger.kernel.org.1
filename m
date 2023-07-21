Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3543475BFB8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGUH31 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUH30 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:29:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECAB189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09A0610A6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93155C433C8;
        Fri, 21 Jul 2023 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924564;
        bh=9MQ8ixXMPQsep0hGuaN61HXiPH57AsIVGnZBYki+wjY=;
        h=Subject:To:Cc:From:Date:From;
        b=fCTY2c4VrPlpm+ETERJOpbimLLK2wCx0TNNOqh7ea50Oh46Ii8zTbtcVXvxdPlL78
         me3IMUNQj+KThvL/xOr1DcCbpXLBTvnzUBSPFF8QKnCWQWuyY5vo2Aa5zBNGOroJXA
         XjyVENDCZhY8PxO5GgFNoZSMNzJ2KsoJ4Ohl5aBo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set minimum requirement for using PSR-SU on" failed to apply to 6.1-stable tree
To:     mario.limonciello@amd.com, Hamza.Mahfooz@amd.com,
        Marc.Rossi@amd.com, Tsung-hua.Lin@amd.com,
        alexander.deucher@amd.com, sean.ns.wang@amd.com, sunpeng.li@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:29:21 +0200
Message-ID: <2023072121-defective-shucking-1c34@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c35b6ea8f2ecfa9d775530b70d4e727869099a9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072121-defective-shucking-1c34@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c35b6ea8f2ec ("drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt")
268182606f26 ("drm/amd/display: Update correct DCN314 register header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c35b6ea8f2ecfa9d775530b70d4e727869099a9c Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 23 Jun 2023 10:05:20 -0500
Subject: [PATCH] drm/amd/display: Set minimum requirement for using PSR-SU on
 Rembrandt

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

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index d647f68fd563..4f61d4f257cd 100644
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
index c52c40b16387..c753c6f30dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1011,3 +1011,10 @@ void dc_send_update_cursor_info_to_dmu(
 		dm_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
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
index a5196a9292b3..099f94b6107c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -86,4 +86,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_check_min_version(struct dmub_srv *srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 2a66a305679a..4585e0419da6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -367,6 +367,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_supported)(struct dmub_srv *dmub);
 
+	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
+
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index ebf7aeec4029..5e952541e72d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -302,6 +302,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
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
index 7d5c10ee539b..89c5a948b67d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -221,6 +221,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9e9a6a44a7ac..7a31e3e27bab 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -226,14 +226,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
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

