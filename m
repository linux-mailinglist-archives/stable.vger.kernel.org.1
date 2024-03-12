Return-Path: <stable+bounces-27437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B158790E0
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA11F25AFD
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535878277;
	Tue, 12 Mar 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIjjXYbL"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7D7829C
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235369; cv=fail; b=vGjFwKZ/m/6rWTmJt+/9i+6JWgxnjm6UoHPdD9c8mrIcF6I9Vr9ivTDofr6rd9qln9Nl868NJy+J1Y7GUMZTJ8q49Yj3gOd+L9+wiqV8sT3gCn3W2zb+0dP+yGuaSjaK9EyiryXlJY0PGij/DNvx7DlPnMlXI49US9jkeYtajbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235369; c=relaxed/simple;
	bh=/h1m4IjiPxqKV/8I0zPkrupMNliK6Ul93dUZn12o91I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwnQHKo4K5dTO8RMRb/Tv+K3l7VgpffSRc7LMtMSmBDhNl5BJg8NBldmPGZFlUq5kuWndyXTLdCvJAJKA2/7the9Gta69vgqog8jKjghzIHaHt5Mudtz1blncdsJdn2BHUwYK8kdxnibyxuKXGg0RZYFPLfcWT5Y9YXl4R04Ik4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIjjXYbL; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3GbGdvgXUtXj0MghpHYVnbu+sCmfYXrZOI8u+RqxcvA442YHhAvIHTkyy65vemgM6/KpUUzP5yeGB2gy5X6+SAn/Fupg3nKZlBMV/24hXpZuzhg1FdQRUZCdYdnHPJ14z8HOuX65unr6kLKhjl7j5+oVUhFtjB4t2vwVuQVqpe3npOtSvZ3QYscfsL9JhEpIcqrsn2wX8uDgxPtvdu79OI8NGR5H5lAR0OLwOMWDHFpDCe9L33OQtMef55zMnuxh/9J3gmiRSO4gXqY6uS45+Eq8xpeFuMFhJhUOmBDCDPozh/zeMzJre83j/H7/58yWm2fTbd6IEkKa+3DLszmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/cK2dqW7eG4AiZI2O65isHlrtnM5sPxojsgDXz+rYQ=;
 b=JuFdUZmmIXv/8TPilusMufAkIW/MvBMGeACsxWATlhxmQYIsqNZl1MijanfSR8+Imj4/ghkLpXr7jd9bUh55Qn66QKirRH3muyw9IaZpUz3G5xFp4oBfVKnDVNVHfQrY2uUZ0VczfVys1M33UrxU80wR+U770kGWxJEmZQeImxuMMZKMpO4BKnX8WDM8JYzvKvGMRAt/lChoPHQFEy0A1ROU0tlF0cVcuWvbNMxxSWgQ7WlQkz3c/ejZRF3JzTTCuSwBoskBCubNE1p7tg9zYPWU/R1EFHObTs7HJFW+0Ie/2Unnq93uw5d2xh8t/G8dkYCXWoaXCV0xzDs/rGjBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/cK2dqW7eG4AiZI2O65isHlrtnM5sPxojsgDXz+rYQ=;
 b=JIjjXYbLoDdVB+PTqFL3FBZBiUf4kJX4iQKpGROophTdy3MBmtgOlww/XYaH1+7l8XA4CSOjBbIf/aXZkGcKjeIe67RlhAjLHdoTY6HtJHdUpekQbxiimWht4pgHz0aMwfbAHuEXzx/TbBBy60fVgy6W6bLCKy6rYQ9IZOJ8o7E=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:22:44 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::74) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Gabe Teeger
	<gabe.teeger@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, George Shen
	<george.shen@amd.com>, Charlene Liu <charlene.liu@amd.com>, Jun Lei
	<jun.lei@amd.com>
Subject: [PATCH 17/43] drm/amd/display: Revert Add left edge pixel + ODM pipe split
Date: Tue, 12 Mar 2024 17:20:10 +0800
Message-ID: <20240312092036.3283319-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: a7be0163-490a-478c-a1d7-08dc4275f980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ocLqCtKpnfZGDWiyKEVhRusR7EMgvwgKfA7NYgnH/QXbXwHFseuk9yu+HNzPmfOMSOAMy5u7f3ZRM8T1IDUR22HCmkUJkbFMvIgHZoL7RQER2BWTswg8SMRdITk9HSVnvzuo+cBgAh5mwutakDnmfWclOTpzOXJNWYkYNkEQVdhAH3cY/BjqdTnNdmgCuVZkXzQ29A95IvE4ARr6DGYQnldpUesyCxDgGA/s+iF/iW5yjxm/DJjQIdJTmoPx+KUxUT/ZMKD3MeCMHZ2aWbWLq2ZDmp4iNhnE0Q0rGtErMyn5EzATNDcFpN7fPWybeyNkvhj15fP4fo9nxe1vD4tKUTT1GsjxZpNntpaDjiGNDj57jRp7yOTMXAnme9KWt6PY5jzUXu77qbQNrfPiB4C4EnDbhgEPZnQby3EUczj2Xjh4ggAj8NeOchoaId5S1XxDh6zQVxWrYt1RpmoKNsrLfhnmHFCc+BsOl+ZxMvHk7oWWArHPTGqmGVErch0JiIxl1mzpio6ET/NrrzOHMQRyN6VihjDDfj/c3Cu++ah+QQCQ9gdVsBrlLIAvVVEcWG6eG+0U8r4srLN/bIC8ot6+/uygKQPVKIZGNZwyXSRsX+Vjk2tcR0IuecXXlydMLs7UR+BVzPvN/3DNxZCXS2r2ubRBMwR1KyK1mW6i34GLS+hK57guOvFNYlVeNhGpu3Tu2FiQJkS3Og82GiNngK/vnf2pP+DUB+B3D03VbHSodYP+BqZUqNW9f1eNwcxzWKhx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:44.2925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be0163-490a-478c-a1d7-08dc4275f980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

From: Gabe Teeger <gabe.teeger@amd.com>

This reverts commit 97c109f498da ("drm/amd/display: Add left edge pixel for
YCbCr422/420 + ODM pipe split")

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: George Shen <george.shen@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 --
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 -------------------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 10 -----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  4 --
 5 files changed, 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad969e1dd427..a372c4965adf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3258,10 +3258,6 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
-
-			if (otg_master && (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-					otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420))
-				resource_build_subsampling_params(&context->res_ctx, otg_master);
 		}
 	}
 	update_seamless_boot_flags(dc, context, surface_count, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 945ee57f1721..96b4f68ec374 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -828,16 +828,6 @@ static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ct
 			stream->timing.v_border_bottom +
 			stream->timing.v_border_top;
 
-	/* Recout for ODM slices after the first slice need one extra left edge pixel
-	 * for 3-tap chroma subsampling.
-	 */
-	if (odm_slice_idx > 0 &&
-			(pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-				pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
-		odm_rec.x -= 1;
-		odm_rec.width += 1;
-	}
-
 	return odm_rec;
 }
 
@@ -1454,7 +1444,6 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum controller_dp_color_space controller_color_space;
 	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
-	enum dc_pixel_encoding pixel_encoding = otg_master->stream->timing.pixel_encoding;
 	int h_active = otg_master->stream->timing.h_addressable +
 		otg_master->stream->timing.h_border_left +
 		otg_master->stream->timing.h_border_right;
@@ -1486,36 +1475,10 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 		else
 			params->width = last_odm_slice_width;
 
-		/* Extra left edge pixel is required for 3-tap chroma subsampling. */
-		if (i != 0 && (pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-				pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
-			params->offset -= 1;
-			params->width += 1;
-		}
-
 		offset += odm_slice_width;
 	}
 }
 
-void resource_build_subsampling_params(struct resource_context *res_ctx,
-	struct pipe_ctx *otg_master)
-{
-	struct pipe_ctx *opp_heads[MAX_PIPES];
-	int odm_cnt = 1;
-	int i;
-
-	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
-
-	/* For ODM slices after the first slice, extra left edge pixel is required
-	 * for 3-tap chroma subsampling.
-	 */
-	if (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-			otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
-		for (i = 0; i < odm_cnt; i++)
-			opp_heads[i]->stream_res.left_edge_extra_pixel = (i == 0) ? false : true;
-	}
-}
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4dfc2dff5e01..8b3536c380b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1579,11 +1579,6 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 	if (old_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		new_pipe->update_flags.bits.tg_changed = 1;
 
-	if (resource_is_pipe_type(new_pipe, OPP_HEAD)) {
-		if (old_pipe->stream_res.left_edge_extra_pixel != new_pipe->stream_res.left_edge_extra_pixel)
-			new_pipe->update_flags.bits.opp_changed = 1;
-	}
-
 	/*
 	 * Detect mpcc blending changes, only dpp inst and opp matter here,
 	 * mpccs getting removed/inserted update connected ones during their own
@@ -1967,11 +1962,6 @@ static void dcn20_program_pipe(
 			pipe_ctx->stream_res.opp,
 			&pipe_ctx->stream->bit_depth_params,
 			&pipe_ctx->stream->clamping);
-
-		if (resource_is_pipe_type(pipe_ctx, OPP_HEAD))
-			pipe_ctx->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
-				pipe_ctx->stream_res.opp,
-				pipe_ctx->stream_res.left_edge_extra_pixel);
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b5b090197ad7..34764094f546 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -333,8 +333,6 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
-
-	bool left_edge_extra_pixel;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index b14d52e52fa2..77a60aa9f27b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -107,10 +107,6 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
-void resource_build_subsampling_params(
-		struct resource_context *res_ctx,
-		struct pipe_ctx *pipe_ctx);
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
 enum dc_status resource_build_scaling_params_for_context(
-- 
2.37.3


