Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E674F8CA
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGKULx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKULw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6E139
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 915D0615E3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAE7C433C8;
        Tue, 11 Jul 2023 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689106310;
        bh=mPIIsRQGshZA2I2DOCDhMEsBPPaPOunUV0RD3Ousecg=;
        h=Subject:To:Cc:From:Date:From;
        b=mRycx1DpIylvXapkuUgTnV00C6pxe+aEZWhUtreThUbH3DPJmXTO9PUDZ4zZm5p/j
         YguZkX2Mg/Cz9bbac72Q74luX4LwjdM9FKjnbTXjK3E624pWSHPFpFEzLuaClEf1bf
         wx0TqrY1NeN8dLB5Ny9lA7pY6cLHTvYedm53eml8=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: Move DCN314 DOMAIN power control to" failed to apply to 6.4-stable tree
To:     daniel.miess@amd.com, alexander.deucher@amd.com,
        hamza.mahfooz@amd.com, nicholas.kazlauskas@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 11 Jul 2023 22:11:46 +0200
Message-ID: <2023071145-clause-unashamed-1ef2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x bf0097c5c9aec528da75e2b5fcede472165322bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071145-clause-unashamed-1ef2@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf0097c5c9aec528da75e2b5fcede472165322bb Mon Sep 17 00:00:00 2001
From: Daniel Miess <daniel.miess@amd.com>
Date: Wed, 7 Jun 2023 16:24:08 +0800
Subject: [PATCH] Revert "drm/amd/display: Move DCN314 DOMAIN power control to
 DMCUB"

This reverts commit e383b12709e32d6494c948422070c2464b637e44.

Controling hubp power gating using the DMCUB isn't stable so we
are reverting this change to move control back into the driver.

Cc: stable@vger.kernel.org # 6.3+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 7a43f8868500..32a1c3105089 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -424,27 +424,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 			hws->ctx->dc->res_pool->dccg, dpp_inst, clock_on);
 }
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
-{
-	struct dc_context *ctx = hws->ctx;
-	union dmub_rb_cmd cmd;
-
-	if (hws->ctx->dc->debug.disable_hubp_power_gate)
-		return;
-
-	PERF_TRACE();
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.domain_control.header.type = DMUB_CMD__VBIOS;
-	cmd.domain_control.header.sub_type = DMUB_CMD__VBIOS_DOMAIN_CONTROL;
-	cmd.domain_control.header.payload_bytes = sizeof(cmd.domain_control.data);
-	cmd.domain_control.data.inst = hubp_inst;
-	cmd.domain_control.data.power_gate = !power_on;
-
-	dm_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-
-	PERF_TRACE();
-}
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
 	/* There are use cases where SYMCLK is referenced by OTG. For instance
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index 96035c75e0df..3841da67a737 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -43,8 +43,6 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
-void dcn314_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on);
-
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 86d6a514dec0..ca8fe55c33b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -139,7 +139,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.plane_atomic_power_down = dcn10_plane_atomic_power_down,
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
-	.hubp_pg_control = dcn314_hubp_pg_control,
+	.hubp_pg_control = dcn31_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,

