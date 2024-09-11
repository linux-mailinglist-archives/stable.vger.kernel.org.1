Return-Path: <stable+bounces-75858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADD97582F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D6F283392
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D1AB6FC;
	Wed, 11 Sep 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzmmEQBv"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5F224CC
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071731; cv=fail; b=exgmIge4UjIq0lLz86h/bqcS47sYqxjfmE2MlNBOnqJtGkVLua1jbZxHKbYImi/7nkOypDYdXhu71WgCPTNnwaju4eyBOS02vpl9WR7k+s1gCbW/nXqWD268OtuDv3NaIQUGWhuMkBJ7hIlcRu0yWJp7wGFGa2aa8TiMLFUG4yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071731; c=relaxed/simple;
	bh=xFS7A6f/JhMLl/YJEMXDeHaDkAA8jlpG2WnAxMjzvJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxP0o/jgpkBCsg2pw8cOwNzFfTu1W59McwyWKou1ST+/JJvIgwUsPQJNd2dpUXMa3cf5YN8pBS0mH6qdSsBi5uZuffK3e0FfUHGGN2pN4XzDis+NcvISBz33ctNDC9LLz0MsxJtN2hYsEOT0BqED68ELnWHqDejqLMSdAWCa65Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzmmEQBv; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOkVWr7wjXVQyavx5rJMsQXzJCDYkTxLnlkSUs8Xp8RQv/E4RYs99KHChyAeMC+/R/Mu8tmRwMQ+9tioWfG8y1ylKFR0YRDD0Re/llD6yNUgmfQSvLaEAauxq6Dq3mAozToacVh6AqFtE4Z8tgj+ow5eYqNkL8HOZJ3cekxM29u5QZzT/UHap54RNwWZzzw2JzS2DZYfYR+GGEXdA6iEsagJgBeygzvX6VtHVY84C63lcVp/vME72tCFiEmufdBkujxp/+w5M1tKKk3QBUudaQH/qHnoMs5j+yLDMCwK0zLyoSEZ6Vf9hf9DT0Gu6nqqF7dTgz0ebQMK6ZHBUrvO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUULoh064zAvzCPbF3ox8ZCoy6BwU8KeT4ZIyxWsx9g=;
 b=GiJJ0JlkbMJYiOWSEUS0sUXUu0/YbSQT/OHIbEmCM0w1vcK7ltvQN9pWyAM2jQ/e4BNXqjNJySmV9jdqrn+YotalqfS1B6SmaG+D6+osNtAty1R2x5D7EKsc3Dy6uK0pDlisj9HNCjm/ngEt2ybTxbG6eT6cAeN7aQF5bxlsLs30ChIyYziCqH8BlOQC7p8svhut6TECz8VoDn1oDEMcSp36qAYAqy9hNDMK+OBCADWLy5zJmBEy3ANoXJLyBGCd6gGwP3Rzzd/BwEKgK8a231BJNkZw/reKmfWXA7Bs9hHK6drF8x3+haGAGHs1yY9XUK/hayYOt7NRhKuvbY4Rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUULoh064zAvzCPbF3ox8ZCoy6BwU8KeT4ZIyxWsx9g=;
 b=JzmmEQBv2tpTErEYx0vaiW7SDQDuw02diGwO7B3GMuWAV653FbMkCVy9LUHZ6o6WkPhsDn4FWEJaPym4zKfYGbbl3VHyV3UK4ZI0E9bFTDqmPbKSCgkjGcyLzqaJGRJar3s4W1C0hmcAK1yjSgZf4nBqjJRKHeDFz5aiMAYvIXw=
Received: from MN2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:208:23b::19)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:22:05 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::5e) by MN2PR11CA0014.outlook.office365.com
 (2603:10b6:208:23b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:22:05 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:22:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Jun Lei <jun.lei@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 02/23] drm/amd/display: Use SDR white level to calculate matrix coefficients
Date: Wed, 11 Sep 2024 10:20:44 -0600
Message-ID: <20240911162105.3567133-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7c545e-d607-424c-cc4d-08dcd27de064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yUCN8NNVqTZD3c0NlPUMg6rtCQx5Thw/TSkLLajR8NZkzf+PxoG5Mv4E6VF?=
 =?us-ascii?Q?1K4FWUeIrn6K/3PSSWyuhQUqAqyIxh47JuMiBj/6onilOKrQnrGA5gEIiVmT?=
 =?us-ascii?Q?TwxNW9VyIzp5272OYKAT7OCwa+rPMnZbwLVlrj/lz+4RUwIuDn8iW22dHwfH?=
 =?us-ascii?Q?jv0nsFA1YDU8Uq7ydtyHI4oGlihbb3n+h0OOSrZUbHkV+UR1BMiXjItZAIPD?=
 =?us-ascii?Q?hMBA0QJumOx8p2kp2MgQ7Iz6knk8AchH7c7u6voOm5szodILHzeLLmqfcERS?=
 =?us-ascii?Q?CXPTujp8XSXQaaDdzJ3OhA1tmYz1Yu2j1itaIGc+dxoUkWAlSEeOaXQLReLe?=
 =?us-ascii?Q?dZbI6/gq9SeTO/C3UphPyABQIeSLGgpbW6NyOR8GNGCB3x5rcoEg3OuSAjRB?=
 =?us-ascii?Q?ZAyTtWQtRLBy+jkgB2Fz3T0xuO351dBcuHluUeYNW77qNt/vJjPSrAEd/p2N?=
 =?us-ascii?Q?9ots/FmZvhWNiYAO6Ej5eGsCdnoY4PmejeHUIu1W+sKw1Ldd8RSyjhLqyJaE?=
 =?us-ascii?Q?WH+kIsfGOaIkWqj+jyiW7XqiG9IsMP5KMQafBzJoEeeyVnoqhEnfuXJC/5d1?=
 =?us-ascii?Q?rZXbNj6p5eTRTPnySJPpVrebXHMuUh15WxhpWKHs4LB2M2qwk9K3EZuKxprP?=
 =?us-ascii?Q?BPleoT6WlJIF6JUveb0bePKzOGApmAnMcAF6lDRKe4kblw3hN+xUMnY6EDP1?=
 =?us-ascii?Q?OMw0+9XIHEcsVkibmK/m/PRrXmj2Wu9ncMq01iGCvGIoW+zdNdymNaggcg8s?=
 =?us-ascii?Q?uGgl09AEWx4A4r9uyBlww+wHiP8q4I6vTmLPFXthks4/q5boLl5MjZR/DD0A?=
 =?us-ascii?Q?HM4MfULn8aoPabXwDnwsQx200BcGkQGC2+Kh9UimDolWSU7/gTI9Ag4BsRN+?=
 =?us-ascii?Q?6qBkSyhLSvw7QMY4+4+/RX26QXSrtrbhwqA3qxrhDJ33XwMODftZeTmJRl0o?=
 =?us-ascii?Q?8S4CkN4sfszNe11L2qMpTeUVByTIS5/1nWF9BnMRdkH2Nw91tU9xzC3WrrtO?=
 =?us-ascii?Q?ZGqbHNUu1Ti8g7vOHBgJIum4AMKj1YSmuYpWfhWjbr7wH4k0moXvn/GEishP?=
 =?us-ascii?Q?yzJgo+YXaSPLS/6d3S4MFC/GWPssXKd7PIHnKGb7CJHpOsjnB8LQYl9SMiPw?=
 =?us-ascii?Q?28y2MQm54dWHN3E/p1ZKUBl69QsY/l5BivSXH/LiwsxXq3Ku7Dp5vdIA/Ora?=
 =?us-ascii?Q?YkFiX/UzAIBoAvKaZfWIxeEnv89b4KVhcLWJB0GXMLtJ30TKw5LIk3ewdTf4?=
 =?us-ascii?Q?/OoW5cFzNbb53G9pMV2Ql30rMYwZGb+ig52iE0xD/cX9rqRN3vInx30CyHuK?=
 =?us-ascii?Q?BluKwW4Zgz+MvzYP4SZuUZ02Pcobacda4LlDsxq54fFzv6/mDmJ5KRZVdt3h?=
 =?us-ascii?Q?kDsHdkCz+Xmbs7P1CuVjNrKcVrtifld8CmRl8D2xtgeAUvR0AyH1gTgKmP3G?=
 =?us-ascii?Q?BEBIre1p7aop0PTBFTXNhvZ9jBrFFWrK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:22:05.6433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7c545e-d607-424c-cc4d-08dcd27de064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

From: Samson Tam <Samson.Tam@amd.com>

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
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h             |  3 +++
 .../gpu/drm/amd/display/dc/dc_spl_translate.c   |  9 +--------
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c     | 17 +++++++++++------
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h   |  2 +-
 5 files changed, 28 insertions(+), 15 deletions(-)

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
 
-- 
2.34.1


