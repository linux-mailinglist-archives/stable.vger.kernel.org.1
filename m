Return-Path: <stable+bounces-2113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22657F82D4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951BAB229D0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938935F1A;
	Fri, 24 Nov 2023 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r97FbpND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BB35EE6;
	Fri, 24 Nov 2023 19:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31716C433C8;
	Fri, 24 Nov 2023 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853080;
	bh=s9gxo+W4uaK20aVf2EhPMZl5AKUCc9h9xsxXtTVo9Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r97FbpNDaKx2yqDYmRMUMlZLdtSUCE+t4h2iOPDK7t5Zi6AANMWKBlh4j2Yqn0SVW
	 XTmEkAO+sAAUM+VCdIX534g0EGdo5sBSxs32toV8VVy47H57NCZ0zOM2OFC2gCgW7M
	 ElETZZJiEQpuUkJcRW1/5ypDPvfFqRA3WV8yp4gw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jun Lei <jun.lei@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 021/297] drm/amd/display: use full update for clip size increase of large plane source
Date: Fri, 24 Nov 2023 17:51:03 +0000
Message-ID: <20231124172000.840375439@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

[ Upstream commit 05b78277ef0efc1deebc8a22384fffec29a3676e ]

[why]
Clip size increase will increase viewport, which could cause us to
switch  to MPC combine.
If we skip full update, we are not able to change to MPC combine in
fast update. This will cause corruption showing on the video plane.

[how]
treat clip size increase of a surface larger than 5k as a full update.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h      |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ffe7479a047d8..3919e75fec16d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -886,7 +886,8 @@ static bool dc_construct(struct dc *dc,
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
-
+	if (dc->caps.max_optimizable_video_width == 0)
+		dc->caps.max_optimizable_video_width = 5120;
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
@@ -2053,6 +2054,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 }
 
 static enum surface_update_type get_scaling_info_update_type(
+		const struct dc *dc,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
@@ -2087,6 +2089,12 @@ static enum surface_update_type get_scaling_info_update_type(
 			update_flags->bits.clock_change = 1;
 	}
 
+	if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+		(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
+		 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
+		 /* Changing clip size of a large surface may result in MPC slice count change */
+		update_flags->bits.bandwidth_change = 1;
+
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2124,7 +2132,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	type = get_scaling_info_update_type(u);
+	type = get_scaling_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	if (u->flip_addr)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0f58fab5e8ed..09a8726c26399 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -164,6 +164,11 @@ struct dc_caps {
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
+	/*
+	 * max video plane width that can be safely assumed to be always
+	 * supported by single DPP pipe.
+	 */
+	unsigned int max_optimizable_video_width;
 	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
-- 
2.42.0




