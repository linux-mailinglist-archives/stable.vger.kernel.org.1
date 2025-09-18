Return-Path: <stable+bounces-173585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A6B35D66
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC07C5FF4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D602FAC1C;
	Tue, 26 Aug 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdozRsXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D36239573;
	Tue, 26 Aug 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208630; cv=none; b=Z7R5ZP9yLeEJOacvhjpMZn+m4MwV/jPCOrjLz9NrkFu0AjSko3hrjGQUCQXcul6EpL3WW1mKEXFh3vXgIR7tXYNI8txop5eegJrxwPIhsVp9QVik1/kI3OJ/8S4Ajc2edC2nRIj23V7An2sVlBQbBKXHCtoSJJeWFkjwK9D2NGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208630; c=relaxed/simple;
	bh=U1Op4bu00VgBMva69ghd/7r6Dgvywx2d6SMvWa7y54I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rANje6/OLpi5DUWBZLmfJoUQDRtHVYtoYLTr0SYA1sWTVi9mXScRzLNszNyaaPxNYzxXPvMLI+SU43hD8csWUY9ON/oxsvOqt/SvC1FRX7YBnh16xx4vMt9+E8RMyk+ET0/kRm6C56VJjaJaJdmIam+yqmPkiX59SCiTUX7xEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdozRsXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C73AC4CEF1;
	Tue, 26 Aug 2025 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208630;
	bh=U1Op4bu00VgBMva69ghd/7r6Dgvywx2d6SMvWa7y54I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdozRsXzJal6JDdMsmY2/+ajLAznk4u+v51+2M0jXx9Tbkf0LWpTzCGdoAj0Ae329
	 TW2ACUxZLNzD6UdgpToM72+evgt8YCH+7SYFhDfm1KQK/2hPVLAl+27y531/dFfkUd
	 luX0+YopiBglUJMgocI/Kcm8h/+OJXadIaqqIvjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6.12 186/322] drm/amd/display: Find first CRTC and its line time in dce110_fill_display_configs
Date: Tue, 26 Aug 2025 13:10:01 +0200
Message-ID: <20250826110920.457569178@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

commit 669f73a26f6112eedbadac53a2f2707ac6d0b9c8 upstream.

dce110_fill_display_configs is shared between DCE 6-11, and
finding the first CRTC and its line time is relevant to DCE 6 too.
Move the code to find it from DCE 11 specific code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4ab09785f8d5d03df052827af073d5c508ff5f63)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |   30 ++++++----
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -120,9 +120,12 @@ void dce110_fill_display_configs(
 	const struct dc_state *context,
 	struct dm_pp_display_configuration *pp_display_cfg)
 {
+	struct dc *dc = context->clk_mgr->ctx->dc;
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
 
@@ -164,6 +167,23 @@ void dce110_fill_display_configs(
 		cfg->v_refresh /= stream->timing.h_total;
 		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
 							/ stream->timing.v_total;
+
+		/* Find first CRTC index and calculate its line time.
+		 * This is necessary for DPM on SI GPUs.
+		 */
+		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
+			const struct dc_crtc_timing *timing =
+				&context->streams[0]->timing;
+
+			pp_display_cfg->crtc_index = cfg->pipe_idx;
+			pp_display_cfg->line_time_in_us =
+				timing->h_total * 10000 / timing->pix_clk_100hz;
+		}
+	}
+
+	if (!num_cfgs) {
+		pp_display_cfg->crtc_index = 0;
+		pp_display_cfg->line_time_in_us = 0;
 	}
 
 	pp_display_cfg->display_count = num_cfgs;
@@ -232,16 +252,6 @@ void dce11_pplib_apply_display_requireme
 
 	dce110_fill_display_configs(context, pp_display_cfg);
 
-	/* TODO: is this still applicable?*/
-	if (pp_display_cfg->display_count == 1) {
-		const struct dc_crtc_timing *timing =
-			&context->streams[0]->timing;
-
-		pp_display_cfg->crtc_index =
-			pp_display_cfg->disp_configs[0].pipe_idx;
-		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
-	}
-
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
 }



