Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6C76AF08
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjHAJo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjHAJoG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD12D7D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA92C6150B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67F5C433C7;
        Tue,  1 Aug 2023 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882897;
        bh=vvIN/bvJt/7/D6iga7F5HNJzNtLUoCmzqX7pNkWlpME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2qiGIsjcw3jluoVCMDxAQg+0kIUqRgrXOVHIIH1kIjU9fK5So032dL1dAgIvJbiA
         lZlMeND+drrcOzQq6X2jUy+UyH73Q6XzaarcPKQFOTKob70tqf6AQ0E+rA1hYaNlMa
         I4W065zXNR3d06m67GnQVdDoMC47whErbMznUz8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 042/239] drm/amd/display: Add FAMS validation before trying to use it
Date:   Tue,  1 Aug 2023 11:18:26 +0200
Message-ID: <20230801091927.090555991@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit e3416e872f84086667df21daf166506fab97358d ]

To ensure that FAMS can be used, DC must check if there is VRR support.
This commit adds the required configuration to ensure FAMS can be executed in the target system.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 2a9482e55968 ("drm/amd/display: Prevent vtotal from being set to 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h        | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 7 ++++++-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6eace83c9c6f5..7f6bdad57c920 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2626,6 +2626,12 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
+
+		if (stream_update->stream && stream_update->stream->freesync_on_desktop &&
+			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
+				stream_update->vrr_active_variable))
+			su_flags->bits.fams_changed = 1;
+
 		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
 			su_flags->bits.crtc_timing_adjust = 1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 25284006019c3..270282fbda4ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -131,6 +131,7 @@ union stream_update_flags {
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
 		uint32_t crtc_timing_adjust : 1;
+		uint32_t fams_changed : 1;
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index c95f000b63b28..34b08d90dc1da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -301,7 +301,12 @@ static void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *o
 
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
 {
-	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtotal_max);
+	else
+		optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
 }
 
 void optc3_tg_init(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 598fa1de54ce3..1c55d3b01f53e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -360,7 +360,7 @@ union dmub_fw_boot_status {
 		uint32_t optimized_init_done : 1; /**< 1 if optimized init done */
 		uint32_t restore_required : 1; /**< 1 if driver should call restore */
 		uint32_t defer_load : 1; /**< 1 if VBIOS data is deferred programmed */
-		uint32_t reserved : 1;
+		uint32_t fams_enabled : 1; /**< 1 if VBIOS data is deferred programmed */
 		uint32_t detection_required: 1; /**<  if detection need to be triggered by driver */
 		uint32_t hw_power_init_done: 1; /**< 1 if hw power init is completed */
 	} bits; /**< status bits */
-- 
2.39.2



