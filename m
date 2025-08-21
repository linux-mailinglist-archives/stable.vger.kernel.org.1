Return-Path: <stable+bounces-172160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C595DB2FD94
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF59A627463
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAE2ED17C;
	Thu, 21 Aug 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMU3SK6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BF2DC322
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787699; cv=none; b=JhCgy5ad8FAk6aNgbh+NlKu4UtZO/dYPaReJtB8nEVIHRkJJTF2gYl+cTEmgigiIXxfwhOacdWWJTSMyQ9UyNca0UWZ2LDYuqTNhRlSg8eda0L1/k7VNujsNsJ5G3gYUMMEBUXzKHNjO+EHiYjZrXu8GQyP0EX+FbJy4reGfahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787699; c=relaxed/simple;
	bh=WpK1FM2A7IzzPfVUyOaG2busKkf24UGIYIHMdLpZXM4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tVopgksK0usYYocN2gyHWrd9cY9w+ZacdjcQZZVv1tYotrmb977xutWgjeTdR4xVfStVZ0WS0OAPp0dBRmEU3nbUHQCVSj8WuQybRyXvoMxdWnRyCaBTl8KJ89ZoyV3zuiyjgvCh21n7WB9/liDiLLCg9C9yGar35Hdv9EW5p/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMU3SK6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0809C4CEED;
	Thu, 21 Aug 2025 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755787699;
	bh=WpK1FM2A7IzzPfVUyOaG2busKkf24UGIYIHMdLpZXM4=;
	h=Subject:To:Cc:From:Date:From;
	b=PMU3SK6txDhDVBFGjLL4GV+I+dqntlwInOa002K64uCmGpQLqFUG54qB+qyuWHxSn
	 TXNgRmnil5yYa4H0ncsIH02V/xhcam02FlS+a2o45+mDtT2hzbPjp1BaEFr4+Jpu5B
	 rMHJrBUO67fo6OGXgQ0/tHFkxSRT+tkcshU/PrzM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix divide by zero when calculating min ODM" failed to apply to 6.16-stable tree
To: dillon.varone@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,wayne.lin@amd.com,wenjing.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:46:18 +0200
Message-ID: <2025082118-unbounded-tarnish-ef1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 3556dac8289456bc8b28670546b969f543967856
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082118-unbounded-tarnish-ef1e@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3556dac8289456bc8b28670546b969f543967856 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Thu, 10 Jul 2025 20:57:37 -0400
Subject: [PATCH] drm/amd/display: Fix divide by zero when calculating min ODM
 factor

[WHY&HOW]
If the debug option is set to disable_dsc the max slice width and/or
dispclk can be zero. This causes a divide by zero when calculating the
min ODM combine factor. Add a check to ensure they are valid first.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index a454d16e6586..1f53a9f0c0ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -152,7 +152,7 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 }
 
 /* Forward Declerations */
-static unsigned int get_min_slice_count_for_odm(
+static unsigned int get_min_dsc_slice_count_for_odm(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_enc_caps *dsc_enc_caps,
 		const struct dc_crtc_timing *timing);
@@ -466,7 +466,7 @@ bool dc_dsc_compute_bandwidth_range(
 		struct dc_dsc_bw_range *range)
 {
 	bool is_dsc_possible = false;
-	unsigned int min_slice_count;
+	unsigned int min_dsc_slice_count;
 	struct dsc_enc_caps dsc_enc_caps;
 	struct dsc_enc_caps dsc_common_caps;
 	struct dc_dsc_config config = {0};
@@ -478,14 +478,14 @@ bool dc_dsc_compute_bandwidth_range(
 
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
-	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+	min_dsc_slice_count = get_min_dsc_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
 
 	is_dsc_possible = intersect_dsc_caps(dsc_sink_caps, &dsc_enc_caps,
 			timing->pixel_encoding, &dsc_common_caps);
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				&options, link_encoding, min_slice_count, &config);
+				&options, link_encoding, min_dsc_slice_count, &config);
 
 	if (is_dsc_possible)
 		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
@@ -593,14 +593,12 @@ static void build_dsc_enc_caps(
 
 	struct dc *dc;
 
-	memset(&single_dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
-
 	if (!dsc || !dsc->ctx || !dsc->ctx->dc || !dsc->funcs->dsc_get_single_enc_caps)
 		return;
 
 	dc = dsc->ctx->dc;
 
-	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_max_clock_khz || !dc->res_pool)
+	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_max_clock_khz || !dc->res_pool || dc->debug.disable_dsc)
 		return;
 
 	/* get max DSCCLK from clk_mgr */
@@ -634,7 +632,7 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
 	return (value + 9) / 10;
 }
 
-static unsigned int get_min_slice_count_for_odm(
+static unsigned int get_min_dsc_slice_count_for_odm(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_enc_caps *dsc_enc_caps,
 		const struct dc_crtc_timing *timing)
@@ -651,6 +649,10 @@ static unsigned int get_min_slice_count_for_odm(
 		}
 	}
 
+	/* validate parameters */
+	if (max_dispclk_khz == 0 || dsc_enc_caps->max_slice_width == 0)
+		return 1;
+
 	/* consider minimum odm slices required due to
 	 * 1) display pipe throughput (dispclk)
 	 * 2) max image width per slice
@@ -669,13 +671,12 @@ static void get_dsc_enc_caps(
 {
 	memset(dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
 
-	if (!dsc)
+	if (!dsc || !dsc->ctx || !dsc->ctx->dc || dsc->ctx->dc->debug.disable_dsc)
 		return;
 
 	/* check if reported cap global or only for a single DCN DSC enc */
 	if (dsc->funcs->dsc_get_enc_caps) {
-		if (!dsc->ctx->dc->debug.disable_dsc)
-			dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
+		dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
 	} else {
 		build_dsc_enc_caps(dsc, dsc_enc_caps);
 	}
@@ -1295,10 +1296,10 @@ bool dc_dsc_compute_config(
 {
 	bool is_dsc_possible = false;
 	struct dsc_enc_caps dsc_enc_caps;
-	unsigned int min_slice_count;
+	unsigned int min_dsc_slice_count;
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
-	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+	min_dsc_slice_count = get_min_dsc_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
 
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 		&dsc_enc_caps,
@@ -1306,7 +1307,7 @@ bool dc_dsc_compute_config(
 		timing,
 		options,
 		link_encoding,
-		min_slice_count,
+		min_dsc_slice_count,
 		dsc_cfg);
 	return is_dsc_possible;
 }


