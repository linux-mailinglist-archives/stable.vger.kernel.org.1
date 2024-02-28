Return-Path: <stable+bounces-25418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092EE86B75A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4931F21790
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C271EAE;
	Wed, 28 Feb 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqsOKsZe"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDC71EA8
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145732; cv=fail; b=NtknfOpIysF5ZBhuhj4ETd1qh1rxTOSZHLSI2fwUq2JBJk2qpXy8wfvLqJLpdENhlCOVbHuzsh+u4MGOB81BGR2x7QVxGUJRQFiL8mKU8G0hwKFs/LNhvRYVCdY7AS6334bTeGacOaqSgzdy01kXs2evVd8j91TMJCPl0x2tsqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145732; c=relaxed/simple;
	bh=UtvcjCcXKsCoPI3VoczX7b5Qs7DFfE4GTR7sqG7QKBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZXv2NC0T/Pow/oaFbvog0K+h8yriExuHtPydenWAx6F3wc1ClFzQErxQGgooCFKtPFlfEId2jVb9rH8OsQgEN+k5IBDd58LLGYsvFNl5C5hmsq8SsFqkQcR/foXJzMkjQUJAiHC7AJ8RcXeJ4rfdi0DgVhqWGkRGcWDi3lCQ4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqsOKsZe; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvUohBovf4apuoAxZyzz8FOVhgXeEzbHoYO2hTPwkUR2VwH8TzgNcQz5DvGrUpXSVaso0a08L6YEN4vzYD/YNPhcg0lFdnY5OxKmKhxCTcl41b0pWga/0CZ82swRLU5QAYC3/2YssJbyzdsrdlZn6iB+ds9OTJpoO9x8HJFEnCjX771EAZQRRwb4tkQzjzJmtI0CxSGEi2/QG4qhun4Xy05WrO4wgeR6TCZjd1ZImOBnp3AnmDBKaGVcVlgstAD7xDaq11VV/Jtp+jzB9jsrflVM7xcEmCNotnpg8FG6bxxtPxVXCMn7r24G7QMSFykdehDv04QpipynnkttVPChJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNY59A65VtWMRD24QYznut0bNxTyxtVwBzvc/SVaJzY=;
 b=htNfJz6EqywlOukW2LI7Harb+NnqFH1vu17KjupXEsRXFcJjAbEln1N+h1EaOXbXg750WiBgjSweZJI+VhUzEcZzIB/EBXchjYvAFrE7kG5nhgyted32VltTmqvboyyePKLgV+3udCEAYWomtZiyIgflOA3OAIVnigO4/YV7UPfyxZxbuQRPCmiChO4FKBjjhXaM0nLsnDa7IHk/rrMyiP4kWFfAxNIrBbkKxUDO5Qz4P8lv25HQ941lTX679401jlSgG3gthI+SJHWFgLRLLZfoK51S81oYMPE5INL8n3UQB2+BjSNvrfmzLTcKKLl4U/BvX9k7YEdtcx5XaKYcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNY59A65VtWMRD24QYznut0bNxTyxtVwBzvc/SVaJzY=;
 b=tqsOKsZe4RFlcG50F8LgTVbZLrYfiW5NwEXkkCrDp50tE2R0qGSA2+Jtf7QBcrHlNasW2nomHJn+9DSGjE9XpVs1H/BR+Eo0b2Rg3+q3VxzBm8eK1rPreqIcybprAltWaSWPI0r35XY2T/ZgJ08/gez96j6cNlOdRjEJdEYWMcU=
Received: from CY5PR15CA0106.namprd15.prod.outlook.com (2603:10b6:930:7::8) by
 BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:42:08 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::cf) by CY5PR15CA0106.outlook.office365.com
 (2603:10b6:930:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:42:08 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:42:05 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sohaib Nadeem
	<sohaib.nadeem@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/34] drm/amd/display: Override min required DCFCLK in dml1_validate
Date: Wed, 28 Feb 2024 11:39:12 -0700
Message-ID: <20240228183940.1883742-7-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d06fde-ebbc-40bf-20dd-08dc388cf7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U7+9sr88S/uHpiOLcT9E38WQ+dQ0zUxbIfaiQ7rf1nC9dryGU7dr3oDzFCx8MCtyWCSeISA0i/DBE3z4mNKFMxorsmG+yOwsfEwzSuR/K3pw+nh2jaKuvsaB39JIDdBBQ4fNxldYd/gHJnATukE1DltivdDbl/zaHPnUnS31l46IIffmxzYys77cx3gqA2R2Sj6S1kgr/A5JDzV9jnyA5q/vid+AxK5L1gzQwrCZ7qew53tGlmc9sVvVT26p6Jlxb+7GNdrVre0HtORSZGDLecN6w35GhVx42C5pOQ3BtRgZUmVcmKAaumFjgZVOr+mRcuQ1eoietKeuXdn1XJ1KwU8n698KOGPotx9cJmHdpB4cwJECqDHr8axCg3h6sz1aeAw+/x5OkSR2oJpzeqqVP2FgqjMmdR4nh3BGjMeJ5tMeqUb4BSW4GwEmPqXBXKwnlKVngj9s64Ob2fTsl+SROxhMi5H/kZjqbU6DqabZko2lKxB7UgKjaQqNB5wZDM+zBCgt7MHmVGu5tD7wpxSMnOc2TTfc+rPaPnOH4fDBxUZCTHu35CynRuKwZV0QrWNBTj0ftCVTx/x+nmYX9AjyvpI2JqYIt6OWObzoy0amRig6LboKBm7qWpLDQFCKLeEqdJOExecq7UNE6vog5CadrKI4NjmORRY1iu+kyGdg1Osr4xxBfiRwr4pbidaybY9n/kACJvMEXR4sLdxh6N5Cazxr2SAfEknMI2IIzJnjrE2nNhXq/ljCkDDF8uNbCTqZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:42:08.1814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d06fde-ebbc-40bf-20dd-08dc388cf7c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[WHY]:
Increasing min DCFCLK addresses underflow issues that occur when phantom
pipe is turned on for some Sub-Viewport configs

[HOW]:
dcn32_override_min_req_dcfclk is added to override DCFCLK value in
dml1_validate when subviewport is being used.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c   | 6 ++++++
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h  | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 87760600e154..f98def6c8c2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -782,3 +782,9 @@ void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc
 		pipe_cnt++;
 	}
 }
+
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context)
+{
+	if (dcn32_subvp_in_use(dc, context) && context->bw_ctx.bw.dcn.clk.dcfclk_khz <= MIN_SUBVP_DCFCLK_KHZ)
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = MIN_SUBVP_DCFCLK_KHZ;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3f3951f3ba98..f844f57ecc49 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1771,6 +1771,7 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	dcn32_override_min_req_memclk(dc, context);
+	dcn32_override_min_req_dcfclk(dc, context);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 0c87b0fabba7..2258c5c7212d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -42,6 +42,7 @@
 #define SUBVP_ACTIVE_MARGIN_LIST_LEN 2
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
+#define MIN_SUBVP_DCFCLK_KHZ 400000
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
@@ -181,6 +182,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
 
+void dcn32_override_min_req_dcfclk(struct dc *dc, struct dc_state *context);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
-- 
2.34.1


