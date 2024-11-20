Return-Path: <stable+bounces-94078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1BD9D3179
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 01:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599E32817FF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC804A23;
	Wed, 20 Nov 2024 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mk4gu343"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D0EAF9
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062881; cv=fail; b=lmdi2ch4lSZSg5CbInoaql0Ddi2RHn9pCjKDqFNXfrA4cJLwzjPvYK0LZo0TWbJv2X8BanH7MtV1kjaz1bwXbjoV0G2qyK5gxZhIf+8gSUMuSdwkRLRfiMmHles5+TIOpZj33gIyeY6FpuvEaZPQmLEiSiruJVG4GdErs5e5R2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062881; c=relaxed/simple;
	bh=8xePFwfgPyTf3h1btHu+s/o0iqhwyzKXGbQqzOroIbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZN13/uAvRN4PCW7QBtWfA4zYGiAYQewjefXzHJcZjhEEWjjozGtgKaSzTyS93CJT/DlP2bP48dJVtIVdQeAjsyoSiHH1B8SPgijHvNHFwt3SUvpd0gbAtgh596mVj8c/YSDie7rfq62Xf82QPJ70DmxVTr7mGdo1vB/a4unp0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mk4gu343; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+5wmOOkqLhhSUzePBE6rWPsGPuMH9OdA9rIxRm/N2uiQz7D2KxWlk0HV3wbePZ+W0rUj+tye2aZf2iLrplDpjJsoZ4OjGPufulINc1ykLEoUESr+jwcloIytz6BMWEWen17sjNS+eO4r4vahy0hyIKN5lQ1aoqoqd1Z0eIllZ2mzRYxIYf/razCD+H1otG2/cYjbprez7y3Bp4Z0kZqUjF81caOeKIqmGdNi0oU7JtuFiQjsR5cKZiTwmK/MWSk1996WwLznACO1GssXKhsgcESDOWR/xpk/vhqDFIgKyodlWliMHeh+7kWuMpWp616aNe8LedZR3pe4BvNaitGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtrIWVzYSfrbX+S825mEwL6wvt2MUckUSlH2NNT3BhE=;
 b=xOsmdANm5cOT4AZSuMlw3QQAfVMEUWfHlrNmU+aLAhz6RRGSWGQyadNnIR/U0G7APnWIw2oJhVjUPqbs2dXRK9oX7g8q1gVWQedY3d0v/1Cfd5E1gPLmWOSrWU67pbU4Pb19W0Y6Z4lQdi9fOEriBXj2LO/EqS+yEc36lzEBM9oT5nttKkUFxh0+y82QVpu+qrsFuY3/EZ/HjbQkM9bcwt7Iu+XG7lL5QSzBt+o4rPeLas4bkpjtXF0RbexboRqvGcbSrSZ1QoG3WzEjUg0C3rl5+pUXPoqmfkcdvfdBuc9+FhN1PHEWmtkqWXYc0tjawQIv/KFP/VsLrpGM1KS6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtrIWVzYSfrbX+S825mEwL6wvt2MUckUSlH2NNT3BhE=;
 b=mk4gu343wXbjyuKzWoq0x/zg2ujO6f0SF/4QlYQbAlnOXPk7H2gkZqP5TLPhYQjwio4GSBQWtudEuMMYR2itkG3YFZQZ5gwkbJcaxbPd5YwDo+1NTPYOMS7wzBCl+SCcXm3KXtH1RDIB8/9O9Um/91HRc6pY45NjQjwY+cZ4MCI=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 00:34:35 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::a3) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:34:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:34:23 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Chris Park
	<chris.park@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
	<wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 8/9] drm/amd/display: Add hblank borrowing support
Date: Tue, 19 Nov 2024 17:28:36 -0700
Message-ID: <20241120003044.2160289-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 520f0bc7-da72-4a14-b840-08dd08fb179c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9O9iIzWrAe6432Xg5abKYHUiFh11TQpxrINae0BFXJ8jeS/SmF6ogobHmqu?=
 =?us-ascii?Q?5nC+z/SXhYjxWSd0uYtonKPLF6bstZONW9u3sidpzmCFRXteTGBhxlzgyIWZ?=
 =?us-ascii?Q?8u/MguSKn73QSpaL5T2x5fHD0Kxnbpg1W7kizYj8qu4yDdqa2mKbQIrC9qWp?=
 =?us-ascii?Q?r4hXsLswpemH6GJmwEapxRSRnHz7LMJ2yMs9nZ/tC3AREScur9Pdv2aHNYJo?=
 =?us-ascii?Q?n5BY77Lyo11QPBvqn3UX74/e4RZGA31zOO7+SkTtjmaJTIxU+MOlesb9qL8c?=
 =?us-ascii?Q?lvr+F2Yc7S7+KKk37VztJHDmAKHN2vVlvQb/KdZDeedt7M40jLZlLIM7waMR?=
 =?us-ascii?Q?IhhG8PmnSCdpyZ4jHj9CdiJdxKsEotOJR3PB8KyLUMkBtDd9KwOmr5kv9Giv?=
 =?us-ascii?Q?E2/mxSMNMfSehrExIfW5pE4997D0dS2VSXj4lV2Vb4Rf4oAs/b2hkRvAnG1Y?=
 =?us-ascii?Q?n9jBheSyKQnCI/YcQiFQY8UcAa+Zey8A8Ncmd1k7wDXzK17ZxZHVw1pbHKXu?=
 =?us-ascii?Q?aEK1MfXAiGbS+rYV21RfMURKlyhSGIhN99fSbIWFRSDY9A/AIndOH59qSUoE?=
 =?us-ascii?Q?PTvQG4KRq06jDCGTVNDLCn6xwuTkHjWji/7AK83enOVxyAAdSETRVneZuwH8?=
 =?us-ascii?Q?utDb6MfeFO4XtCb4q0nSyPb0Hnw9sTNygmK1QW4TbyYCb6ty6fLZ/MyxQYpx?=
 =?us-ascii?Q?tBiClMzlD1XiQs3fW+YBjsXeiBliXDOeje9oWJjuGO2jyZnLhkPqRI1uXUwg?=
 =?us-ascii?Q?NqLbP4gatGlZ0Uj089TKs9w48cyt0fd9jImmb4zcFL35vf6c+L5ODndyELCb?=
 =?us-ascii?Q?r8gqiISbUM3/TIUTfI0NWQWJbufROczByDnGbTiDIyVg3gNYEEJFQoKlioCr?=
 =?us-ascii?Q?5aYo5PXUB4KQ5yg0jntvxuojnWdnFJA5Lj71zROhMQHHue3+uezQ70bOHBRm?=
 =?us-ascii?Q?mzLcuoWKMGu2pk9cyJqnhmebbz7YucqBYLA2Ef1ApeZx80aBdL5WomG9CWOC?=
 =?us-ascii?Q?jOSgJJaa4xsQL2Okq6Uwt2mHGg/hzSw+/+8wWuC+KjPb/TzjnJoEp+Z6hi9D?=
 =?us-ascii?Q?gP2tjJEIbkODk036xpqd95EbbNmF+2wtbTGvIzm1pLpLn+u1MppvmGEZwc2k?=
 =?us-ascii?Q?o5jCkrtzVNcX/wiQ3Du5P3YAqmS1GGUdwwSFkwBgJ93OZI8C0d0OgWuDKLnU?=
 =?us-ascii?Q?NHGV34Zb1dtV6GyIU4xTIekjcklMfWASS/7rhJiywcqOQ8cvce7Xeg/b5DRp?=
 =?us-ascii?Q?1x7chN7fnF/BQou7sN2xu9rkcI6dnCUxljCGtkP+LOli74g/HkHlWQnnhDa0?=
 =?us-ascii?Q?2FybNSIUn/xK4SgQuSv4tDzXMjP5hQ6R7IdR18586hVKBcJ1jEG9WfKE+h3+?=
 =?us-ascii?Q?BZPTTEUL6P/2cErFD23JLxsLTG4gRBn9LQUhdwWE/aYaSTqOYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:34:28.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 520f0bc7-da72-4a14-b840-08dd08fb179c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003

From: Chris Park <chris.park@amd.com>

[WHY]
Some DSC timing failed at bandwidth validation due to hactive
can't be evenly divided on each ODM segment.

[HOW]
Borrow from hblank to increase hactive to support these timing.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 42 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 21 +++++++++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  7 +++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 9 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 619fad17de55..626f75b6ad00 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2094,7 +2094,8 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 	count = resource_get_odm_slice_count(otg_master);
 	h_active = timing->h_addressable +
 			timing->h_border_left +
-			timing->h_border_right;
+			timing->h_border_right +
+			otg_master->hblank_borrow;
 	width = h_active / count;
 
 	if (otg_master->stream_res.tg)
@@ -4026,6 +4027,41 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	return res;
 }
 
+/**
+ * decide_hblank_borrow - Decides the horizontal blanking borrow value for a given pipe context.
+ * @pipe_ctx: Pointer to the pipe context structure.
+ *
+ * This function calculates the horizontal blanking borrow value for a given pipe context based on the
+ * display stream compression (DSC) configuration. If the horizontal active pixels (hactive) are less
+ * than the total width of the DSC slices, it sets the hblank_borrow value to the difference. If the
+ * total horizontal timing minus the hblank_borrow value is less than 32, it resets the hblank_borrow
+ * value to 0.
+ */
+static void decide_hblank_borrow(struct pipe_ctx *pipe_ctx)
+{
+	uint32_t hactive;
+	uint32_t ceil_slice_width;
+	struct dc_stream_state *stream = NULL;
+
+	if (!pipe_ctx)
+		return;
+
+	stream = pipe_ctx->stream;
+
+	if (stream->timing.flags.DSC) {
+		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+
+		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
+		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
+			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
+			pipe_ctx->hblank_borrow = ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive;
+
+			if (stream->timing.h_total - hactive - pipe_ctx->hblank_borrow < 32)
+				pipe_ctx->hblank_borrow = 0;
+		}
+	}
+}
+
 /**
  * dc_validate_global_state() - Determine if hardware can support a given state
  *
@@ -4064,6 +4100,10 @@ enum dc_status dc_validate_global_state(
 			if (pipe_ctx->stream != stream)
 				continue;
 
+			/* Decide whether hblank borrow is needed and save it in pipe_ctx */
+			if (dc->debug.enable_hblank_borrow)
+				decide_hblank_borrow(pipe_ctx);
+
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
 					pipe_ctx->plane_state->tiling_info.gfx9.swizzle == DC_SW_UNKNOWN) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5f1b3ce67cd1..ec64061080fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1070,6 +1070,7 @@ struct dc_debug_options {
 	unsigned int scale_to_sharpness_policy;
 	bool skip_full_updated_if_possible;
 	unsigned int enable_oled_edp_power_up_opt;
+	bool enable_hblank_borrow;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 2fee0b92f1f5..a4907cfe3f08 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -122,7 +122,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->odm_slice_index = resource_get_odm_slice_index(pipe_ctx);
 	// Make spl input basic out info output_size width point to stream h active
 	spl_in->basic_out.output_size.width =
-		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->hblank_borrow;
 	// Make spl input basic out info output_size height point to v active
 	spl_in->basic_out.output_size.height =
 		stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index f66493528f42..c6a5a8614679 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -445,6 +445,21 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->vblank_nom = timing->v_total - timing->v_active;
 }
 
+/**
+ * adjust_dml21_hblank_timing_config_from_pipe_ctx - Adjusts the horizontal blanking timing configuration
+ *                                                   based on the pipe context.
+ * @timing: Pointer to the dml2_timing_cfg structure to be adjusted.
+ * @pipe: Pointer to the pipe_ctx structure containing the horizontal blanking borrow value.
+ *
+ * This function modifies the horizontal active and blank end timings by adding and subtracting
+ * the horizontal blanking borrow value from the pipe context, respectively.
+ */
+static void adjust_dml21_hblank_timing_config_from_pipe_ctx(struct dml2_timing_cfg *timing, struct pipe_ctx *pipe)
+{
+	timing->h_active += pipe->hblank_borrow;
+	timing->h_blank_end -= pipe->hblank_borrow;
+}
+
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
 		struct dc_stream_state *stream, const struct pipe_ctx *pipe)
 {
@@ -732,6 +747,7 @@ static const struct scaler_data *get_scaler_data_for_plane(
 			temp_pipe->plane_state = pipe->plane_state;
 			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
 			temp_pipe->stream_res = pipe->stream_res;
+			temp_pipe->hblank_borrow = pipe->hblank_borrow;
 			dml_ctx->config.callbacks.build_scaling_params(temp_pipe);
 			break;
 		}
@@ -996,6 +1012,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
+		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index]);
 
@@ -1134,12 +1151,12 @@ void dml21_populate_pipe_ctx_dlg_params(struct dml2_context *dml_ctx, struct dc_
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	union dml2_global_sync_programming *global_sync = &stream_programming->global_sync;
 
-	hactive = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	hactive = timing->h_addressable + timing->h_border_left + timing->h_border_right + pipe_ctx->hblank_borrow;
 	vactive = timing->v_addressable + timing->v_border_bottom + timing->v_border_top;
 	hblank_start = pipe_ctx->stream->timing.h_total - pipe_ctx->stream->timing.h_front_porch;
 	vblank_start = pipe_ctx->stream->timing.v_total - pipe_ctx->stream->timing.v_front_porch;
 
-	hblank_end = hblank_start - timing->h_addressable - timing->h_border_left - timing->h_border_right;
+	hblank_end = hblank_start - timing->h_addressable - timing->h_border_left - timing->h_border_right - pipe_ctx->hblank_borrow;
 	vblank_end = vblank_start - timing->v_addressable - timing->v_border_top - timing->v_border_bottom;
 
 	if (dml_ctx->config.svp_pstate.callbacks.get_pipe_subvp_type(context, pipe_ctx) == SUBVP_PHANTOM) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index d7f8b2dcaa6b..fa11f075d1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1049,7 +1049,8 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5de11e2837c0..307782592789 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -820,6 +820,7 @@ enum dc_status dcn401_enable_stream_timing(
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = {0};
 	struct pipe_ctx *opp_heads[MAX_PIPES] = {0};
+	struct dc_crtc_timing patched_crtc_timing = stream->timing;
 	bool manual_mode;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
@@ -874,9 +875,13 @@ enum dc_status dcn401_enable_stream_timing(
 	if (dc->hwseq->funcs.PLAT_58856_wa && (!dc_is_dp_signal(stream->signal)))
 		dc->hwseq->funcs.PLAT_58856_wa(context, pipe_ctx);
 
+	/* if we are borrowing from hblank, h_addressable needs to be adjusted */
+	if (dc->debug.enable_hblank_borrow)
+		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->hblank_borrow;
+
 	pipe_ctx->stream_res.tg->funcs->program_timing(
 			pipe_ctx->stream_res.tg,
-			&stream->timing,
+			&patched_crtc_timing,
 			pipe_ctx->pipe_dlg_param.vready_offset,
 			pipe_ctx->pipe_dlg_param.vstartup_start,
 			pipe_ctx->pipe_dlg_param.vupdate_offset,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3061dca47dd2..2edd5b38ce4f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -478,6 +478,8 @@ struct pipe_ctx {
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
 	struct pixel_rate_divider pixel_rate_divider;
+	/* pixels borrowed from hblank to hactive */
+	uint8_t hblank_borrow;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 41cab9ad6885..5d66bfc7fe6e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -808,7 +808,8 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 984d23bcbc27..12d247a7ec45 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2804,6 +2804,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
 		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
+		free_pipe->hblank_borrow = otg_master->hblank_borrow;
 		if (free_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
 					&new_ctx->res_ctx,
-- 
2.43.0


