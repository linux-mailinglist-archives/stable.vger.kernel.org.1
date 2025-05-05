Return-Path: <stable+bounces-140072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E5AAA4C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BE53ACC5F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACF303975;
	Mon,  5 May 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8K4GXmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84561289E0B;
	Mon,  5 May 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484038; cv=none; b=Cw2j9fsqMxX9N59jE+/528W/SRSOYxwMc03CUr1x3dQDUEvW5sn5LfJd3Zlmxp3kcmflfmB1NzN9YVUQtfRoH6Gy1BfaT1+NZfU3pufxBPSCu0RVwGoE7QwucfTuP7ABAtj0R6DdenOaudQRShjoocbEsJrHmPxZD7BA2Imkacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484038; c=relaxed/simple;
	bh=m2/PJjh1QCAn9cGbRJLgIHUb5nnR/VXZwqN4ZHSxASw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScCoaf5CrGJwQ6ixT1Fy57m5YBkiZDphdS2/H3Y1kFotCtodTczLe6qA84QLHrCqpV6ECmFqplqS6hf4eEh/Kf7wMUZr4GzCRqTCDSINg/45hqprLkuFq0v9+3g3h9RFJOEf9M9RYTBKsksf/nUcsfEQJZ3oqkeix89Gwpb9Vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8K4GXmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598DAC4CEE4;
	Mon,  5 May 2025 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484038;
	bh=m2/PJjh1QCAn9cGbRJLgIHUb5nnR/VXZwqN4ZHSxASw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8K4GXmDbzCtOpfqPnFCtsguQ4dQKqNykdzb6zt4QNcR7lmN/Lv7fNqcACj1w2rfn
	 W93DQi56wvXJE0qvMvEF+30oPYvsvuI4OddQo0fWZaEm0Z4EGtqgB+u+rWzdGkBFdM
	 +23jrmuwv9oFvY0mw9uvmMsabp//f7WWKJ1+X+tVcG2YYwSHVqG/lULng9+YuAoKVR
	 tl2+C6PLJXD6Tgnpjw5HS/DgEUALaqXksaFqhOriVDnhhNB+wVlUTjkgDraZO1mzzP
	 KrIes3/lkMU/CDN+5d/zCsEfpn1JUowunj+g4C4s0pnjwXZirZJDCDFIvihmuN8lQp
	 JQTK+oI1B5cnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Assadian <Navid.Assadian@amd.com>,
	Samson Tam <Samson.Tam@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jun.lei@amd.com,
	alex.hung@amd.com,
	navid.assadian@amd.com,
	Relja.Vojvodic@amd.com,
	wenjing.liu@amd.com,
	rodrigo.siqueira@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 325/642] drm/amd/display: Add opp recout adjustment
Date: Mon,  5 May 2025 18:09:01 -0400
Message-Id: <20250505221419.2672473-325-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Navid Assadian <Navid.Assadian@amd.com>

[ Upstream commit fba4d19f3731483ee8565f9e9bb7ed9fc89479e8 ]

[Why]
For subsampled YUV output formats, more pixels can get fetched and be
used for scaling.

[How]
Add the adjustment to the calculated recout, so the viewport covers the
corresponding pixels on the source plane.

Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 31 +++++++++++++++----
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 10 ++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 22602f088553d..153b7a8904e1e 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -76,6 +76,21 @@ static struct spl_rect shift_rec(const struct spl_rect *rec_in, int x, int y)
 	return rec_out;
 }
 
+static void spl_opp_adjust_rect(struct spl_rect *rec, const struct spl_opp_adjust *adjust)
+{
+	if ((rec->x + adjust->x) >= 0)
+		rec->x += adjust->x;
+
+	if ((rec->y + adjust->y) >= 0)
+		rec->y += adjust->y;
+
+	if ((rec->width + adjust->width) >= 1)
+		rec->width += adjust->width;
+
+	if ((rec->height + adjust->height) >= 1)
+		rec->height += adjust->height;
+}
+
 static struct spl_rect calculate_plane_rec_in_timing_active(
 		struct spl_in *spl_in,
 		const struct spl_rect *rec_in)
@@ -723,13 +738,15 @@ static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
 	}
 }
 
-static void spl_clamp_viewport(struct spl_rect *viewport)
+static void spl_clamp_viewport(struct spl_rect *viewport, int min_viewport_size)
 {
+	if (min_viewport_size == 0)
+		min_viewport_size = MIN_VIEWPORT_SIZE;
 	/* Clamp minimum viewport size */
-	if (viewport->height < MIN_VIEWPORT_SIZE)
-		viewport->height = MIN_VIEWPORT_SIZE;
-	if (viewport->width < MIN_VIEWPORT_SIZE)
-		viewport->width = MIN_VIEWPORT_SIZE;
+	if (viewport->height < min_viewport_size)
+		viewport->height = min_viewport_size;
+	if (viewport->width < min_viewport_size)
+		viewport->width = min_viewport_size;
 }
 
 static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
@@ -1800,6 +1817,8 @@ static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scrat
 	spl_calculate_recout(spl_in, spl_scratch, spl_out);
 	/* depends on pixel format */
 	spl_calculate_scaling_ratios(spl_in, spl_scratch, spl_out);
+	/* Adjust recout for opp if needed */
+	spl_opp_adjust_rect(&spl_scratch->scl_data.recout, &spl_in->basic_in.opp_recout_adjust);
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	spl_calculate_viewport_size(spl_in, spl_scratch);
 
@@ -1836,7 +1855,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	// Handle 3d recout
 	spl_handle_3d_recout(spl_in, &spl_scratch.scl_data.recout);
 	// Clamp
-	spl_clamp_viewport(&spl_scratch.scl_data.viewport);
+	spl_clamp_viewport(&spl_scratch.scl_data.viewport, spl_in->min_viewport_size);
 
 	// Save all calculated parameters in dscl_prog_data structure to program hw registers
 	spl_set_dscl_prog_data(spl_in, &spl_scratch, spl_out, enable_easf_v, enable_easf_h, enable_isharp);
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 5d139cf51e89b..1c3949b24611f 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -427,6 +427,14 @@ struct spl_out	{
 
 // SPL inputs
 
+// opp extra adjustment for rect
+struct spl_opp_adjust {
+	int x;
+	int y;
+	int width;
+	int height;
+};
+
 // Basic input information
 struct basic_in	{
 	enum spl_pixel_format format; // Pixel Format
@@ -444,6 +452,7 @@ struct basic_in	{
 		} num_slices_recout_width;
 	} num_h_slices_recout_width_align;
 	int mpc_h_slice_index; // previous mpc_combine_v - split_idx
+	struct spl_opp_adjust opp_recout_adjust;
 	// Inputs for adaptive scaler - TODO
 	enum spl_transfer_func_type tf_type; /* Transfer function type */
 	enum spl_transfer_func_predefined tf_predefined_type; /* Transfer function predefined type */
@@ -535,6 +544,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
+	int min_viewport_size;
 	int sdr_white_level_nits;
 	enum sharpen_policy sharpen_policy;
 };
-- 
2.39.5


