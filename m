Return-Path: <stable+bounces-78385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB998B8EE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434D0283044
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4E1A0723;
	Tue,  1 Oct 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lq+CAhNZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D31A0706
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777111; cv=none; b=ZwCgrVna6bMjOZHIFqDYdK71hkNcf4EWM4Gl/sFekc07e/4LHEcYkl/XipXGfcjrJnI4xkXfiEbRwgNISS0jj+wXRlDH66nGDSU1c74VP2NSiqoyHeRj+1y7EMgMJ6wxFo1f3GkWLeP6k+Kk+bHQRxx0H2aB0nhM2qk+rJ0cgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777111; c=relaxed/simple;
	bh=p00F5JTjiRtwNfFBh3AC08XT8/6Fzn+ElmF6VOZ1fBM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tuagChC0EpJGt9JvxFUYhxzpr+EP2H+3MwQvou7gTKUYSVTCAUo70hlOZVzdbJWuUCwfpk1p3hex9S/xsuW92G502NNmWtD/DK9P288JO+ucRphPnpfBv9+2cHz5WLqL3CH1Y84RaQVziCLRBnyUpC8URK7MrkdOtrvx5xbqtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lq+CAhNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DC7C4CEC6;
	Tue,  1 Oct 2024 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777111;
	bh=p00F5JTjiRtwNfFBh3AC08XT8/6Fzn+ElmF6VOZ1fBM=;
	h=Subject:To:Cc:From:Date:From;
	b=Lq+CAhNZgmr5cLErIdIjlqKNY9AJvaLdifTflDpvUg+iSvVFbo8GR3yOwwIh35eZd
	 jYOE3lkK36j7hRjkZjNbvgi0C//qFd+HcsyHaRXKL7pSTa7ND9gPlpS3/c/mZ/Coex
	 6Rcu11Lq1YtwOAxYQhWdJKEbhO9aA+sqwCZxyEDE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use SDR white level to calculate matrix" failed to apply to 6.1-stable tree
To: Samson.Tam@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jun.lei@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:04:28 +0200
Message-ID: <2024100128-finalize-exceeding-5c9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c2ed7002c0614c5eab6c8f62a7a76be5df5805cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100128-finalize-exceeding-5c9e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c2ed7002c061 ("drm/amd/display: Use SDR white level to calculate matrix coefficients")
8a060e9c17d0 ("drm/amd/display: disable sharpness if HDR Multiplier is too large")
1b0ce903fe74 ("drm/amd/display: add improvements for text display and HDR DWM and MPO")
6efc0ab3b05d ("drm/amd/display: add back quality EASF and ISHARP and dc dependency changes")
85ecfdda063b ("drm/amd/display: Re-order enum in a header file")
f9e675988886 ("drm/amd/display: roll back quality EASF and ISHARP and dc dependency changes")
f82200703434 ("drm/amd/display: remove dc dependencies from SPL library")
5f30ee493044 ("drm/amd/display: quality improvements for EASF and ISHARP")
bbd0d1c942cb ("drm/amd/display: Fix possible overflow in integer multiplication")
a00e85713c37 ("drm/amd/display: Update DML2.1 generated code")
2998bccfa419 ("drm/amd/display: Enable ISHARP support for DCN401")
7a1dd866c5ac ("drm/amd/display: enable EASF support for DCN40")
bd051aa2fcfb ("drm/amd/display: Find max flickerless instant vtotal delta")
bc19b490c00f ("drm/amd/display: Fix spelling various spelling mistakes")
01d6606beca0 ("drm/amd/display: re-indent dpp401_dscl_program_isharp()")
dc2be9c68ffb ("drm/amd/display: Block FPO According to Luminance Delta")
00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
da87132f641e ("drm/amd/display: Add some DCN401 reg name to macro definitions")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
ef319dff5475 ("drm/amd/display: add support for chroma offset")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2ed7002c0614c5eab6c8f62a7a76be5df5805cf Mon Sep 17 00:00:00 2001
From: Samson Tam <Samson.Tam@amd.com>
Date: Fri, 23 Aug 2024 16:57:33 -0400
Subject: [PATCH] drm/amd/display: Use SDR white level to calculate matrix
 coefficients

[WHY]
Certain profiles have higher HDR multiplier than SDR white level max
which is not currently supported.

[HOW]
Use SDR white level when calculating matrix coefficients for HDR RGB MPO
path instead of HDR multiplier.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ae788154896c..243928b0a39f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2596,6 +2596,12 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 			elevate_update_type(&overall_type, UPDATE_TYPE_MED);
 		}
 
+	if (u->sdr_white_level_nits)
+		if (u->sdr_white_level_nits != u->surface->sdr_white_level_nits) {
+			update_flags->bits.sdr_white_level_nits = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
+		}
+
 	if (u->cm2_params) {
 		if ((u->cm2_params->component_settings.shaper_3dlut_setting
 					!= u->surface->mcm_shaper_3dlut_setting)
@@ -2876,6 +2882,10 @@ static void copy_surface_update_to_plane(
 		surface->hdr_mult =
 				srf_update->hdr_mult;
 
+	if (srf_update->sdr_white_level_nits)
+		surface->sdr_white_level_nits =
+				srf_update->sdr_white_level_nits;
+
 	if (srf_update->blend_tf)
 		memcpy(&surface->blend_tf, srf_update->blend_tf,
 		sizeof(surface->blend_tf));
@@ -4679,6 +4689,8 @@ static bool full_update_required(struct dc *dc,
 				srf_updates[i].scaling_info ||
 				(srf_updates[i].hdr_mult.value &&
 				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
+				(srf_updates[i].sdr_white_level_nits &&
+				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
 				srf_updates[i].in_transfer_func ||
 				srf_updates[i].func_shaper ||
 				srf_updates[i].lut3d_func ||
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c94dd38be4b..dcf8a90e961d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1269,6 +1269,7 @@ union surface_update_flags {
 		uint32_t tmz_changed:1;
 		uint32_t mcm_transfer_function_enable_change:1; /* disable or enable MCM transfer func */
 		uint32_t full_update:1;
+		uint32_t sdr_white_level_nits:1;
 	} bits;
 
 	uint32_t raw;
@@ -1351,6 +1352,7 @@ struct dc_plane_state {
 	bool adaptive_sharpness_en;
 	int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
+	unsigned int sdr_white_level_nits;
 };
 
 struct dc_plane_info {
@@ -1508,6 +1510,7 @@ struct dc_surface_update {
 	 */
 	struct dc_cm2_parameters *cm2_params;
 	const struct dc_csc_transform *cursor_csc_color_matrix;
+	unsigned int sdr_white_level_nits;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index cd6de93eb91c..f711fc2e3e65 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -191,14 +191,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	 */
 	spl_in->is_fullscreen = dm_helpers_is_fullscreen(pipe_ctx->stream->ctx, pipe_ctx->stream);
 	spl_in->is_hdr_on = dm_helpers_is_hdr_on(pipe_ctx->stream->ctx, pipe_ctx->stream);
-	spl_in->hdr_multx100 = 0;
-	if (spl_in->is_hdr_on) {
-		spl_in->hdr_multx100 = (uint32_t)dc_fixpt_floor(dc_fixpt_mul(plane_state->hdr_mult,
-			dc_fixpt_from_int(100)));
-		/* Disable sharpness for HDR Mult > 6.0 */
-		if (spl_in->hdr_multx100 > 600)
-			spl_in->adaptive_sharpness.enable = false;
-	}
+	spl_in->sdr_white_level_nits = plane_state->sdr_white_level_nits;
 }
 
 /// @brief Translate SPL output parameters to pipe context
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 15f7eda903e6..a59aa6b59687 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -1155,14 +1155,19 @@ static void spl_set_dscl_prog_data(struct spl_in *spl_in, struct spl_scratch *sp
 }
 
 /* Calculate C0-C3 coefficients based on HDR_mult */
-static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint32_t hdr_multx100)
+static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint32_t sdr_white_level_nits)
 {
 	struct spl_fixed31_32 hdr_mult, c0_mult, c1_mult, c2_mult;
 	struct spl_fixed31_32 c0_calc, c1_calc, c2_calc;
 	struct spl_custom_float_format fmt;
+	uint32_t hdr_multx100_int;
 
-	SPL_ASSERT(hdr_multx100);
-	hdr_mult = spl_fixpt_from_fraction((long long)hdr_multx100, 100LL);
+	if ((sdr_white_level_nits >= 80) && (sdr_white_level_nits <= 480))
+		hdr_multx100_int = sdr_white_level_nits * 100 / 80;
+	else
+		hdr_multx100_int = 100; /* default for 80 nits otherwise */
+
+	hdr_mult = spl_fixpt_from_fraction((long long)hdr_multx100_int, 100LL);
 	c0_mult = spl_fixpt_from_fraction(2126LL, 10000LL);
 	c1_mult = spl_fixpt_from_fraction(7152LL, 10000LL);
 	c2_mult = spl_fixpt_from_fraction(722LL, 10000LL);
@@ -1191,7 +1196,7 @@ static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint3
 static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *spl_out, bool enable_easf_v,
 	bool enable_easf_h, enum linear_light_scaling lls_pref,
 	enum spl_pixel_format format, enum system_setup setup,
-	uint32_t hdr_multx100)
+	uint32_t sdr_white_level_nits)
 {
 	struct dscl_prog_data *dscl_prog_data = spl_out->dscl_prog_data;
 	if (enable_easf_v) {
@@ -1499,7 +1504,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 		dscl_prog_data->easf_ltonl_en = 1;	// Linear input
 		if ((setup == HDR_L) && (spl_is_rgb8(format))) {
 			/* Calculate C0-C3 coefficients based on HDR multiplier */
-			spl_calculate_c0_c3_hdr(dscl_prog_data, hdr_multx100);
+			spl_calculate_c0_c3_hdr(dscl_prog_data, sdr_white_level_nits);
 		} else { // HDR_L ( DWM ) and SDR_L
 			dscl_prog_data->easf_matrix_c0 =
 				0x4EF7;	// fp1.5.10, C0 coefficient (LN_rec709:  0.2126 * (2^14)/125 = 27.86590720)
@@ -1750,7 +1755,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 
 	// Set EASF
 	spl_set_easf_data(&spl_scratch, spl_out, enable_easf_v, enable_easf_h, spl_in->lls_pref,
-		spl_in->basic_in.format, setup, spl_in->hdr_multx100);
+		spl_in->basic_in.format, setup, spl_in->sdr_white_level_nits);
 
 	// Set iSHARP
 	vratio = spl_fixpt_ceil(spl_scratch.scl_data.ratios.vert);
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 85b19ebe2c57..74f2a8c42f4f 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -518,7 +518,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
-	int hdr_multx100;
+	int sdr_white_level_nits;
 };
 // end of SPL inputs
 


