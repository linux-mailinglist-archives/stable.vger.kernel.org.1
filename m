Return-Path: <stable+bounces-25431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EC86B799
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619371F29F91
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6F71EBD;
	Wed, 28 Feb 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AubeQH2M"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0671EAB
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146033; cv=fail; b=flp8NkcWF+KiCh6BU2zuwJbxmsf9kgmfy6w2Fu2nPt8zQPwqOGJXYzkUbwT0qlEk6j/J4BNSvzMfBGRHRlMD2jAsEavi0db1/xBVur4r1fXy6iIzkWUz+nXjvC6YY9Q11hwM+aSpVVU/N/tjyKZZI2/XZBw+gMUlTGX9U+B5rXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146033; c=relaxed/simple;
	bh=mPvoxpTPlIjo4mv0NR6nFT39ursQnLS2XTPAAz+AKr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNZJou0i+J4+d7IoxEuAPwnzJjKhf/YTF810FVJJ1g2ESrkUJnALxpxQwMkfxxu8Ipd4J4DIIco3TGTMwQOlUmHPy0UyJfADFbRiqaKYU6xZOgkjORNiuIfOTC96Xw2nFyMKI6k88On2y/GTFQiYp2iGGbTEBjhDdcEqlX9y7Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AubeQH2M; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieKwdP6u4TvePUYdeHAKUnE9tuSLGGp2ukCZwL5XgXDxp291z77kTJodv6iT+fCNlgnsstin6lak/rgrERTZTxBTd2GEgdkFeqHO38nezfUd6upOLntcTTtYdOXpXfw4f19++izXMjZzrZ0SOYyVSsTEAAWaINR3BjOz7LnRIjdk5IAxZ4iKogvHJk2y+rKoB8hhp/O6Co5sN6NxaWdPpsrSxOzOMv7TW+DfSM1veCqrQmK9PXYF1Nx5uTk8OS2NMyBZIyfD4z9OYpjDxsTrZJW+6RSNj6ymNwy5ujvxYHosI+TPJzH9fRQbQ0/8BImtdLE5KN+k0Nrb+QzdqieGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVBuSu/9R6gNC1rYvWJ3IgY9zVEqdtnA1LE6lT4skeA=;
 b=cz8c84K6+UyqU1G6Qb/BfBHBrcxCVEiKRspr4aoz0okE6Fhl59KVs41vuFoFRnRO0+giTyzRPiYozgz43pVOUSnpfgNJ+B0MobHo0q72RS+Y8x7M2gXCsElVnyzPbNNy+YhO4qdDMB2rwaz493u1czMhY9mp2VJ4ArMP9AMQGAXQiD3uTKNSVtNrJfLKP9iDJlyqmn+q8LvZRXXGt8sp45UFvrmDs2DE9rX71jFunLqgW8drvOL+8apz948VHh5Dx+LKFLuQ9WFjnWOfkVoVKpjhvEEfchWjnDnJTZ1B+sJrFEL+8Q+U9tq6cnGXx2uDUtk+oxlj/2JaHEAJPjLX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVBuSu/9R6gNC1rYvWJ3IgY9zVEqdtnA1LE6lT4skeA=;
 b=AubeQH2MO59QNcg7owqWvlBbuFfEG2nFBOG1mgwDr1pFZOCv5zP/vhTMpKRa0FzBYNhm11NhCWema1y4sZRJZYO7RHIaWZpkWQunW8BOfw3q1hLc8VpKKG1aVd1UBgMnjh5cIHFdGhMQXvvoATU72EtuYBqm+vAqqF57cJIg6iY=
Received: from SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:47:07 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::7e) by SN7PR04CA0045.outlook.office365.com
 (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:47:07 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 28/34] drm/amd/display: Implement wait_for_odm_update_pending_complete
Date: Wed, 28 Feb 2024 11:39:34 -0700
Message-ID: <20240228183940.1883742-29-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: df6074b0-c137-4104-0470-08dc388daa3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tfLGbO925+erS+fMzlXq+T7jtKxGT0QMA0Q32pdjw4V+F+HUnlYrdMWslmvIQi3MuWKy4SbSUnz1HvIp7pNzzAdQb/9DqYnIAhae6v7bOb6k/qZiLyxciwCOTXFxyWg4aDcp4VnW0UBQ/pooyF4xPhccjRLJdZctUR1SRGs98MhLJMaX5RbHXICkUVr+IFWQiLGY5ds4S0EiAGF5e0L/+8QrtPskZBD08hjeTy0blgk0pmiuyaZPPTM16+ouzSjuMBrGKRJs8B2dorkck//MxEXZWeFkzk+VSCDVE2jDBJS8Zc0jpRAQLbOvCtzsm47ONPAaXergTGfbw2qZDG8oQgBYPuuy9gMr9M14FF447UoJiNObQed0REHZKTNCFKjdMElKQH0NZgqoV9tBDW1LbtumHm+4eSeK6Lh+YFziP8vkgwxBVdOnf7/Gj2SfBfSM3PgeqEl6NG1M8in0yubZiijeaOxasM2k7cqQD6iUfa6irpyZsL5f2X5RLpyRUYJyzhrGkJgeEAB32r3ExrL6pn7Rsl5bIaTH5x89RiT+LCm/pXtSiQCebcGoL20MSwdJz0IcN11e0cvrSVsjRLSqX41/7Oe4BMhd9uZzZbrkYSV+U/faR57/nUvvJRkhp8aRe4lH+EEheiMTa/kABhKMn0lEGwUYyoCnB1CvcCwtc2reA4S6h3o0yw7XbTrDFVvqpm5qBi1aEG9MclcUkFFZsNWeIHRd3pfWZHtPi2DwCGD0LLtEz+5YPXRUMjHP1tCg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:47:07.6747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6074b0-c137-4104-0470-08dc388daa3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY]
Odm update is doubled buffered. We need to wait for ODM update to be
completed before optimizing bandwidth or programming new udpates.

[HOW]
implement wait_for_odm_update_pending_complete function to wait for:
1. odm configuration update is no longer pending in timing generator.
2. no pending dpg pattern update for each active OPP.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 56 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  | 14 +++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |  2 +
 .../drm/amd/display/dc/dcn201/dcn201_opp.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  3 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  8 +++
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  1 +
 11 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e87aad983b40..d8967087335e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1335,6 +1335,54 @@ static void disable_vbios_mode_if_required(
 	}
 }
 
+/**
+ * wait_for_blank_complete - wait for all active OPPs to finish pending blank
+ * pattern updates
+ *
+ * @dc: [in] dc reference
+ * @context: [in] hardware context in use
+ */
+static void wait_for_blank_complete(struct dc *dc,
+		struct dc_state *context)
+{
+	struct pipe_ctx *opp_head;
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	if (!hws->funcs.wait_for_blank_complete)
+		return;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		opp_head = &context->res_ctx.pipe_ctx[i];
+
+		if (!resource_is_pipe_type(opp_head, OPP_HEAD) ||
+				dc_state_get_pipe_subvp_type(context, opp_head) == SUBVP_PHANTOM)
+			continue;
+
+		hws->funcs.wait_for_blank_complete(opp_head->stream_res.opp);
+	}
+}
+
+static void wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *context)
+{
+	struct pipe_ctx *otg_master;
+	struct timing_generator *tg;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		otg_master = &context->res_ctx.pipe_ctx[i];
+		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
+				dc_state_get_pipe_subvp_type(context, otg_master) == SUBVP_PHANTOM)
+			continue;
+		tg = otg_master->stream_res.tg;
+		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+	}
+
+	/* ODM update may require to reprogram blank pattern for each OPP */
+	wait_for_blank_complete(dc, context);
+}
+
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -2026,6 +2074,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		context->stream_count == 0) {
 		/* Must wait for no flips to be pending before doing optimize bw */
 		wait_for_no_pipes_pending(dc, context);
+		/*
+		 * optimized dispclk depends on ODM setup. Need to wait for ODM
+		 * update pending complete before optimizing bandwidth.
+		 */
+		wait_for_odm_update_pending_complete(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
 		/* Need to do otg sync again as otg could be out of sync due to otg
@@ -3591,7 +3644,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		top_pipe_to_program->stream->update_flags.raw = 0;
 }
 
-static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state *dc_context)
+static void wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
 {
 /*
  * This function calls HWSS to wait for any potentially double buffered
@@ -3629,6 +3682,7 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
 			}
 		}
 	}
+	wait_for_odm_update_pending_complete(dc, dc_context);
 }
 
 static void commit_planes_for_stream(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index 48a40dcc7050..5838a11efd00 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -384,6 +384,7 @@ static const struct opp_funcs dcn10_opp_funcs = {
 		.opp_set_disp_pattern_generator = NULL,
 		.opp_program_dpg_dimensions = NULL,
 		.dpg_is_blanked = NULL,
+		.dpg_is_pending = NULL,
 		.opp_destroy = opp1_destroy
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
index 0784d0198661..fbf1b6370eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
@@ -337,6 +337,19 @@ bool opp2_dpg_is_blanked(struct output_pixel_processor *opp)
 		(double_buffer_pending == 0);
 }
 
+bool opp2_dpg_is_pending(struct output_pixel_processor *opp)
+{
+	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
+	uint32_t double_buffer_pending;
+	uint32_t dpg_en;
+
+	REG_GET(DPG_CONTROL, DPG_EN, &dpg_en);
+
+	REG_GET(DPG_STATUS, DPG_DOUBLE_BUFFER_PENDING, &double_buffer_pending);
+
+	return (dpg_en == 1 && double_buffer_pending == 1);
+}
+
 void opp2_program_left_edge_extra_pixel (
 		struct output_pixel_processor *opp,
 		bool count)
@@ -363,6 +376,7 @@ static struct opp_funcs dcn20_opp_funcs = {
 		.opp_set_disp_pattern_generator = opp2_set_disp_pattern_generator,
 		.opp_program_dpg_dimensions = opp2_program_dpg_dimensions,
 		.dpg_is_blanked = opp2_dpg_is_blanked,
+		.dpg_is_pending = opp2_dpg_is_pending,
 		.opp_dpg_set_blank_color = opp2_dpg_set_blank_color,
 		.opp_destroy = opp1_destroy,
 		.opp_program_left_edge_extra_pixel = opp2_program_left_edge_extra_pixel,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
index 3ab221bdd27d..8f186abd558d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
@@ -159,6 +159,8 @@ void opp2_program_dpg_dimensions(
 
 bool opp2_dpg_is_blanked(struct output_pixel_processor *opp);
 
+bool opp2_dpg_is_pending(struct output_pixel_processor *opp);
+
 void opp2_dpg_set_blank_color(
 		struct output_pixel_processor *opp,
 		const struct tg_color *color);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
index 8e77db46a409..6a71ba3dfc63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
@@ -50,6 +50,7 @@ static struct opp_funcs dcn201_opp_funcs = {
 		.opp_set_disp_pattern_generator = opp2_set_disp_pattern_generator,
 		.opp_program_dpg_dimensions = opp2_program_dpg_dimensions,
 		.dpg_is_blanked = opp2_dpg_is_blanked,
+		.dpg_is_pending = opp2_dpg_is_pending,
 		.opp_dpg_set_blank_color = opp2_dpg_set_blank_color,
 		.opp_destroy = opp1_destroy,
 		.opp_program_left_edge_extra_pixel = opp2_program_left_edge_extra_pixel,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a698f026198c..4dfc2dff5e01 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2462,7 +2462,7 @@ bool dcn20_wait_for_blank_complete(
 	int counter;
 
 	for (counter = 0; counter < 1000; counter++) {
-		if (opp->funcs->dpg_is_blanked(opp))
+		if (!opp->funcs->dpg_is_pending(opp))
 			break;
 
 		udelay(100);
@@ -2473,7 +2473,7 @@ bool dcn20_wait_for_blank_complete(
 		return false;
 	}
 
-	return true;
+	return opp->funcs->dpg_is_blanked(opp);
 }
 
 bool dcn20_dmdata_status_done(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index aee5372e292c..d89c92370d5b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -337,6 +337,9 @@ struct opp_funcs {
 	bool (*dpg_is_blanked)(
 			struct output_pixel_processor *opp);
 
+	bool (*dpg_is_pending)(struct output_pixel_processor *opp);
+
+
 	void (*opp_dpg_set_blank_color)(
 			struct output_pixel_processor *opp,
 			const struct tg_color *color);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index c5527f68f076..cd68ecc242c1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -338,6 +338,7 @@ struct timing_generator_funcs {
 	void (*init_odm)(struct timing_generator *tg);
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
+	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 4cfd1ed06777..8a45d26b7531 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -559,7 +559,8 @@ struct dcn_optc_registers {
 	type OTG_CRC_DATA_STREAM_SPLIT_MODE;\
 	type OTG_CRC_DATA_FORMAT;\
 	type OTG_V_TOTAL_LAST_USED_BY_DRR;\
-	type OTG_DRR_TIMING_DBUF_UPDATE_PENDING;
+	type OTG_DRR_TIMING_DBUF_UPDATE_PENDING;\
+	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 823493543325..f07a4c7e48bc 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -122,6 +122,13 @@ void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combi
 	}
 }
 
+void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(tg);
+
+	REG_WAIT(OTG_DOUBLE_BUFFER_CONTROL, OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING, 0, 2, 50000);
+}
+
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -345,6 +352,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.set_odm_bypass = optc32_set_odm_bypass,
 		.set_odm_combine = optc32_set_odm_combine,
 		.get_odm_combine_segments = optc32_get_odm_combine_segments,
+		.wait_odm_doublebuffer_pending_clear = optc32_wait_odm_doublebuffer_pending_clear,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 8ce3b178cab0..0c2c14695561 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -183,5 +183,6 @@ void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool man
 void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combine_segments);
 void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
+void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg);
 
 #endif /* __DC_OPTC_DCN32_H__ */
-- 
2.34.1


