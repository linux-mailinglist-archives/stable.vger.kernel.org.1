Return-Path: <stable+bounces-25424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620F86B77B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5020E1C216C6
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114E71EB6;
	Wed, 28 Feb 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Jb7MFwP"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C371EB0
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145881; cv=fail; b=eyeVYSqQoztRCOAS+G/C2thrSArrbnkKbpeNjysXtB89HUbHVCcy5Myd5mMa38PQijAEHfTHRn4tmqSnhj7CQVdQTCmv7+bTsKy1OTkI4XHsGsUXZm8RwA+M6Cg3VCvcVYZ2ubh3YDH/11LCCOourP+7g9vgvOxDYsAZApQLqI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145881; c=relaxed/simple;
	bh=n/Rek7F+jDSfJBdg6tBjjeWiYNFMttCukrpKE0gIGb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agjmhEq7scFy4np/ga71oLi7SKVozCWRfH1/1x6WOwb+tEAezjpUcxZksWa9qcXjO1n2/JdarQ7CmqMswv1hJXvpjOEPq6FAOGdonQASuyJk1g5s6LrKweRCAirFVYEUk1TEt8Zw4WKkHUjkb6j8hgYWGjQrcycRACSrWL4MTfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Jb7MFwP; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbK4AnXGmKDT/fS9rfC3AsKay/6T4pk5yEzTOeTeeuQqm4O5m9kSXlGJ53BfOtSCUSjjzt94WX4iJ4n7XWbQSQ1zkcbAstZy3+g3gABwyXDczDplfm4U6IFm6+VRXu0l3d6M8O+3Pkv1YXNCgEVKEIqa372FfbXDTtax8w01zTWWd8klMBPRNpslHsYNRI/wJOVnRB8o1kMN3ZQvI49823SB+A+zsUBy+04ds/mTd5GSxph92iFn+SDNcxJ1krW0Rr3nWIBRq4eGRQjrl1VcOkzu3VM2z122bJYA8xqzg4+8nX46wqF9O3P69hkLjfuphZc4Z8GZRkRCqxiBqk1sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G/THHXY1+vHhCvSpASnlbFaDosqxHqvQse1vkQFQqE=;
 b=CcifWk2Lbr7b3fOfvsMSpvCC+wlqwD1LpLi/WKOq830ydkDTI8pH+tUpocUb1P+5D1uPGNaPZTGYZGkk5dcmpQgfTJBLU6znFZ5FzQDHZs2ATjFVd6DiXAIcE7x1t609U3YUaD+qhOJevTwexNwmqp0YdNG2Pd+uW63U1mLYHlvRxtE7PUVhpCAViTlqauN3dkv6qt5/68+6DCMZTiQYznh+Do5c0LAkSyRQlDiOlkkG0AX5egqkI4ueeXnH0PKs+iwc8W/cXx81c/9nhtC/usgwf3o5gtsCsjG+d5hDnxeREXzAlM1NVYCQ8fGuWirsMgsfMbKyOv1ZQajV29fVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G/THHXY1+vHhCvSpASnlbFaDosqxHqvQse1vkQFQqE=;
 b=4Jb7MFwPP8nJ+bdKzYm6ocZ6vDx7Htzc1g2A2/OjvHDfTnN1AFvl1kMklF0iCGV9lMR71dnQniL5MdJSy35cYx4sP+nID4o0boMf8xUwjPiOVjflo9xFinqgaJKNVIRpVKk8mQAh3E92OhWD40LsPhYxvssYlDVy/lTdkiQwt3g=
Received: from CY8PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:4f::22)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:44:37 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::7a) by CY8PR10CA0005.outlook.office365.com
 (2603:10b6:930:4f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:44:36 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:44:34 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Dillon Varone
	<dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 17/34] drm/amd/display: Update odm when ODM combine is changed on an otg master pipe with no plane
Date: Wed, 28 Feb 2024 11:39:23 -0700
Message-ID: <20240228183940.1883742-18-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: fe14ef59-3224-4c77-02d9-08dc388d505f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7aNiOnW4rrXJf+K5XrfrV5sbjhkWu7hSWKbAI1G8QdTh3wcV9rWt7eCzRWODQlUpWvabrU69c8xSOkzzKvwC9j8mrql4MU87kZRNYJkLxyOg+X5OEG+Y5Di+ReVbTo09ykCmlqWgnFUyIDS5hMF9dEZxelOpSwzYfxrnDIgTjeI+K9g39a5Uwo8uw9y80shDhY9ehLl6bxAXsYIDNzUic1ndEBsmrg1f7b+6urnlOGh+wBByiD8KLaMUhP+laRvLv+/4BP6Cey4T7vaScoSHaGccVgOqiDaibS7KUH6lFEyJJhfIrXKPiL/vQiJEAJH20CV+BpEpCCIcTSKuD1qnqGufFR50FSGeQ81xKASGpMcAwRVTTRlGIK6ukj7YKGJyQVcBSdthaRP+AuWzANdnG32qZbTNVoU04ExKufyYtvtWFRvxgPBccwcI8QUYKf2dxNszbGNLTuSjKyDR6qr86RlNtrYgQhfX7diF9XPHeE8XG54JWQXj1QKcHg0jAcktXzpji+DLmtzHgMluya60u7xRUfIwG8ULa1eexuuV8LHmRcEONHk90V7HTkMz7H9SB6b3OG3hbreIABXD8zEEIqrNt8O4P3kF5Lu1yyBnUWC60sPXesj7k4bVyUoAbse2pA5c37TIC8QLppLMEKHDYeerF8LTA7orXKzG2l6h+ub7utCak9VApmby5ch1nwqx1lI7i1KL5qDnPbkNB/dseVhH/F/fr3l5mNeOBcjrOt7HiZUgbfJo1sg1EK2uCYpY
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:44:36.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14ef59-3224-4c77-02d9-08dc388d505f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY]
When committing an update with ODM combine change when the plane is
removing or already removed, we fail to detect odm change in pipe
update flags. This has caused mismatch between new dc state and the
actual hardware state, because we missed odm programming.

[HOW]
- Detect odm change even for otg master pipe without a plane.
- Update odm config before calling program pipes for pipe with planes.

The commit also updates blank pattern programming when odm is changed
without plane. This is because number of OPP is changed when ODM
combine is changed. Blank pattern is per OPP so we will need to
reprogram OPP based on the new pipe topology.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 41 ++++++++++---------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  7 ++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c55d5155ecb9..40098d9f70cb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1498,6 +1498,11 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 		return;
 	}
 
+	if (resource_is_pipe_type(new_pipe, OTG_MASTER) &&
+			resource_is_odm_topology_changed(new_pipe, old_pipe))
+		/* Detect odm changes */
+		new_pipe->update_flags.bits.odm = 1;
+
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
@@ -1551,10 +1556,6 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 
 	/* Detect top pipe only changes */
 	if (resource_is_pipe_type(new_pipe, OTG_MASTER)) {
-		/* Detect odm changes */
-		if (resource_is_odm_topology_changed(new_pipe, old_pipe))
-			new_pipe->update_flags.bits.odm = 1;
-
 		/* Detect global sync changes */
 		if (old_pipe->pipe_dlg_param.vready_offset != new_pipe->pipe_dlg_param.vready_offset
 				|| old_pipe->pipe_dlg_param.vstartup_start != new_pipe->pipe_dlg_param.vstartup_start
@@ -1999,19 +2000,20 @@ void dcn20_program_front_end_for_ctx(
 	DC_LOGGER_INIT(dc->ctx->logger);
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
+	struct pipe_ctx *pipe;
 
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			pipe = &context->res_ctx.pipe_ctx[i];
 
-			if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
-				ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
+			if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->plane_state) {
+				ASSERT(!pipe->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+						dc, pipe, pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
@@ -2085,12 +2087,22 @@ void dcn20_program_front_end_for_ctx(
 			DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
 		}
 
+	/* update ODM for blanked OTG master pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				!resource_is_pipe_type(pipe, DPP_PIPE) &&
+				pipe->update_flags.bits.odm &&
+				hws->funcs.update_odm)
+			hws->funcs.update_odm(dc, context, pipe);
+	}
+
 	/*
 	 * Program all updated pipes, order matters for mpcc setup. Start with
 	 * top pipe and program all pipes that follow in order
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->plane_state && !pipe->top_pipe) {
 			while (pipe) {
@@ -2129,17 +2141,6 @@ void dcn20_program_front_end_for_ctx(
 			context->stream_status[0].plane_count > 1) {
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
-
-		/* when dynamic ODM is active, pipes must be reconfigured when all planes are
-		 * disabled, as some transitions will leave software and hardware state
-		 * mismatched.
-		 */
-		if (dc->debug.enable_single_display_2to1_odm_policy &&
-			pipe->stream &&
-			pipe->update_flags.bits.disable &&
-			!pipe->prev_odm_pipe &&
-			hws->funcs.update_odm)
-			hws->funcs.update_odm(dc, context, pipe);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index aa36d7a56ca8..b890db0bfc46 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1156,6 +1156,13 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 			dsc->funcs->dsc_disconnect(dsc);
 		}
 	}
+
+	if (!resource_is_pipe_type(pipe_ctx, DPP_PIPE))
+		/*
+		 * blank pattern is generated by OPP, reprogram blank pattern
+		 * due to OPP count change
+		 */
+		dc->hwseq->funcs.blank_pixel_data(dc, pipe_ctx, true);
 }
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
-- 
2.34.1


