Return-Path: <stable+bounces-23636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB008672E2
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A422B257C0
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101BB1F94B;
	Mon, 26 Feb 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mz9xA32T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8663200DB
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942990; cv=none; b=XceSJ5XeAb35bXPpQiWiCK2pwFOBmurf5Bcabvj7yiitMWmyh3gFcjtjK0rOfdT/Zvdj1I1OQIECr2k48WsCl4q0ogRVVN5JonqW80c590IwAYcinnvR/U+E8wLSl68jWI/wUEALMEGFkb/8JK3DP8p67zHxJVLH2kJjb16qizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942990; c=relaxed/simple;
	bh=7UqI/NgA23w9q4+bGAhJtWotfg0SOgFXXBXE4+US1LM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nFMTIOtQyZ/n0cFgrM/DJqRYQDUWABSr+MavtEx7L53WrSPV+hTs688tnHH1YVRrmTr7IPySw/4wgWSxhTPBxV5qdtJDYgcykIoc10CY8vnGmFFG7Duwz7Tj/Qo/y90SQmLIVGX0+aU1DIGoMuU6uGxTLURKtRUnLRt6fvSLstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mz9xA32T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3CFC433F1;
	Mon, 26 Feb 2024 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942990;
	bh=7UqI/NgA23w9q4+bGAhJtWotfg0SOgFXXBXE4+US1LM=;
	h=Subject:To:Cc:From:Date:From;
	b=mz9xA32TRfFdbc6bm1iBjRdszIRakNy4vInnMc9VivKwjuEW7w5/VNEoQ5w6rNyHS
	 Q3GUCWo0TDSjSmJMxitfS3Ns9wuBoIQmZSrol3yfGa4UjCbilckgQXohEPiO/e4m4N
	 Co5EtmcSiup16OR/V3sb1LhSFT2Txf/jT2T4/PP0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Only allow dig mapping to pwrseq in new asic" failed to apply to 6.6-stable tree
To: lewis.huang@amd.com,alexander.deucher@amd.com,anthony.koo@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,rodrigo.siqueira@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:23:02 +0100
Message-ID: <2024022602-handshake-spoiled-e4a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4e73826089ce899357580bbf6e0afe4e6f9900b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022602-handshake-spoiled-e4a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

4e73826089ce ("drm/amd/display: Only allow dig mapping to pwrseq in new asic")
b17ef04bf3a4 ("drm/amd/display: Pass pwrseq inst for backlight and ABM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e73826089ce899357580bbf6e0afe4e6f9900b7 Mon Sep 17 00:00:00 2001
From: Lewis Huang <lewis.huang@amd.com>
Date: Wed, 31 Jan 2024 17:20:17 +0800
Subject: [PATCH] drm/amd/display: Only allow dig mapping to pwrseq in new asic

[Why]
The old asic only have 1 pwrseq hw.
We don't need to map the diginst to pwrseq inst in old asic.

[How]
1. Only mapping dig to pwrseq for new asic.
2. Move mapping function into dcn specific panel control component

Cc: Stable <stable@vger.kernel.org> # v6.6+
Cc: Mario Limonciello <mario.limonciello@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3122
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index e8570060d007..5bca67407c5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -290,4 +290,5 @@ void dce_panel_cntl_construct(
 	dce_panel_cntl->base.funcs = &dce_link_panel_cntl_funcs;
 	dce_panel_cntl->base.ctx = init_data->ctx;
 	dce_panel_cntl->base.inst = init_data->inst;
+	dce_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
index ad0df1a72a90..9e96a3ace207 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
@@ -215,4 +215,5 @@ void dcn301_panel_cntl_construct(
 	dcn301_panel_cntl->base.funcs = &dcn301_link_panel_cntl_funcs;
 	dcn301_panel_cntl->base.ctx = init_data->ctx;
 	dcn301_panel_cntl->base.inst = init_data->inst;
+	dcn301_panel_cntl->base.pwrseq_inst = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 03248422d6ff..281be20b1a10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -154,8 +154,24 @@ void dcn31_panel_cntl_construct(
 	struct dcn31_panel_cntl *dcn31_panel_cntl,
 	const struct panel_cntl_init_data *init_data)
 {
+	uint8_t pwrseq_inst = 0xF;
+
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
-	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
+
+	switch (init_data->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", init_data->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 5dcbaa2db964..e97d964a1791 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -57,7 +57,7 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
-	uint32_t pwrseq_inst;
+	uint32_t eng_id;
 };
 
 struct panel_cntl {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 37d3027c32dc..cf22b8f28ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -370,30 +370,6 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
-static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
-{
-	uint8_t pwrseq_inst = 0xF;
-	struct dc_context *dc_ctx = link->dc->ctx;
-
-	DC_LOGGER_INIT(dc_ctx->logger);
-
-	switch (link->eng_id) {
-	case ENGINE_ID_DIGA:
-		pwrseq_inst = 0;
-		break;
-	case ENGINE_ID_DIGB:
-		pwrseq_inst = 1;
-		break;
-	default:
-		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
-		ASSERT(false);
-		break;
-	}
-
-	return pwrseq_inst;
-}
-
-
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -657,7 +633,7 @@ static bool construct_phy(struct dc_link *link,
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
 		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
-		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		panel_cntl_init_data.eng_id = link->eng_id;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);


