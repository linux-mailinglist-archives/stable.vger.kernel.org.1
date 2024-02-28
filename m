Return-Path: <stable+bounces-25423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530BA86B77A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB451F290C7
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138E71EC2;
	Wed, 28 Feb 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YC9TmJOw"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33C15CD64
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145868; cv=fail; b=M5UMRuNAQKN2MlBl5n4blzyaeOMEI1r1n+VpQBrGZ1h7uYJg3BTqP/EXqsq0VxGXIFQqWQRiS5+YOW/I9Rm4k5BI73KU1ogzMlKdzVJe5F/9RnI8xcH/yi5pyknfkh9jqgx19tcKpzMkS6j/mabzEOnGrkJjdYdUmV4IBaDhX8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145868; c=relaxed/simple;
	bh=VVbG22oblxbxS8a4WH0gp4GgppVhfLwKCDaig4+R0Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAtRmcnvPL632xXIe7SI7Tlo85vo41CDN3efkoZpNv8NfSkPV2nuBRxbcmUTZ009utJYDw5evtTJ6dSH5RV+2MpUs7Nv5f1eSfvbI3hYQR3cR3vlo2vKfxijRT24yfxdgmv9UqbAsn2Kq/74Q2LX447+UL0ELB1TPLgB08OjYjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YC9TmJOw; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYfvzdzVrP4twIiaZAfanht9aqtghzTWVEjaRDI6gY2Jnn269VN4oqi5SPHQ1EJHXAI8eQ+g8xkUAvDJlAfqq+Km9xiNGqjjH+jo+YW7DuwCEe5bQ6UBY8K17051V8l699DcgtB41s/8a1A0UDdECwH8egZikWwbl9BsfZ8k87f2kuW7gV1B/teD+3GTGsmpqJUH4wc3QfrPefPMEL7xw/vnNLxti0ipmtY3N8rF0KwyHLDnRPU8HrxLdc2bFJKMpmrjh4PYsD5GDJJ325AOvxG5cbwaBedzKq2zHWF+lqZMFwqnb71i2aXdGik5CnHI3rD7Ef1egmf5/VNiRe5SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7wx8Z2aod8MTUhKV1yBBsVbS5F9xH7tnUmPfqaSvE4=;
 b=j79SDYUM5PYZyWRwVvNWkwzrEgLUS93yGeliuEIXAC9OcLswPt86uesPnpZsUvapOCZPHeOpHXXwhuVjzTLb51rceRBPqbtPUVDfA6btQXN+DaCdonOqF4KOQvZPJfN+BEb2rgn6uxUeq0NH2C6xsnpkEAA6lJwDre/uOISZc72jm8fwaOsoUajCMsxzn04k2raL7JO7M3eS7enFcDcA+Ei5L8ciVX4qmbXeNkPyCv6X+mTuGBW/9nqjoP61SzltTTav1pfMQsO5TFhPAM0BVs1AMqoDAtBCD8Eok7Lcp5p2vjKwTJZOB50Di16S2/cVAEeVHYiG8VmYNzwkS6p0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7wx8Z2aod8MTUhKV1yBBsVbS5F9xH7tnUmPfqaSvE4=;
 b=YC9TmJOwz6PhBRh1mKM6YaZCDDAhTiovV4HdnacZIQzI8PioY+++srnNNa8Z71D5G4Zqq+La2HT+XNMREowEeYahHt1d+NNbnUXDGi1T/Irxzcu2uGoEo5fSA73dXMgLasc+gfcuw7K22Vsk27xdrDaRlWIURD0Kc0jFO+w4Xr4=
Received: from CY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:930:8::12)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:44:23 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:8:cafe::9d) by CY5PR03CA0005.outlook.office365.com
 (2603:10b6:930:8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 18:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:44:23 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:44:20 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Chaitanya
 Dhere" <chaitanya.dhere@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 16/34] drm/amd/display: Init DPPCLK from SMU on dcn32
Date: Wed, 28 Feb 2024 11:39:22 -0700
Message-ID: <20240228183940.1883742-17-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: c7276dd3-321e-448e-4409-08dc388d483c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oZUROA/NPuPk0n/lmR7CD3x34jLOX38/QnuchuOa81JjZkGEFGjsd/xLqxDK2t92ERYnNXSbcWjyhgkn2SWAilucb11eR+DlqVByJcQeaQYbJ0Hy5p4fp5qqUkndEts8dCUXZvkHdVtL6rAYjhQN4y6AMJHcAqqN8zK7LjK+MYMUZxBOJ3Z6rSlYjhrGAoGLxPBq4LbKd/r2TzAE3CiF19nTdpDrduuvwRPrOc2IpY7usrQTLTTna+hTeSoV/CFfcZeoe+0WsJoSBXsTVucbAQxwWJ6R6XNd2U3eByAjQrhxdMV8vlVU8UU28M8ari3IEbeFMnITcaDmjaw3xZxIuF5UxZ9PDX0jRTij38DJl6f1p6LcMVz8FTtO3Z8pFGMEATyByqDZX907RpbLYXqshWNw+3brdSB+zF3chQWE6tV4jxt8m+3Ji3smGaW5AHbDWib+WYl9eD8GjP0ren1bBZOa7HGeLDlkElKjlfbRj+qeDDyNuthHtOjwdKPnIX/poIb3mnB+NoAhFQDmIxf+lfDXgPY4dAkYMlI4x3Ew+hcraPcpSahmlRfK9teoRMSZsTHIZ2wLNhPrOV1sUpcDthIOMDa8Q6zNZrAWN9MtuoEWJlPy7oG0kLtregQkP/PlZpBDKWNDkl8NczdwJMnn0qsJ1RZHxQO7qkzSUlPE5lgBSfOKzVQlpenRgyhwzDkYFDmqAzbxRvKduJXPEUwywL+Fn9QLmEiom2r5xST+X5vbatrqCPGRJyVr8FIbFSUL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:44:23.2283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7276dd3-321e-448e-4409-08dc388d483c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
DPPCLK ranges should be obtained from the SMU when available.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 14 ++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 28 +++++++++++++------
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 ++
 .../dc/resource/dcn321/dcn321_resource.c      |  2 ++
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 668f05c8654e..bec252e1dd27 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -216,6 +216,16 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz > 1950)
 		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 1950;
 
+	/* DPPCLK */
+	dcn32_init_single_clock(clk_mgr, PPCLK_DPPCLK,
+			&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
+			&num_entries_per_clk->num_dppclk_levels);
+	num_levels = num_entries_per_clk->num_dppclk_levels;
+	clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DPPCLK);
+	//HW recommends limit of 1950 MHz in display clock for all DCN3.2.x
+	if (clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz > 1950)
+		clk_mgr_base->bw_params->dc_mode_limit.dppclk_mhz = 1950;
+
 	if (num_entries_per_clk->num_dcfclk_levels &&
 			num_entries_per_clk->num_dtbclk_levels &&
 			num_entries_per_clk->num_dispclk_levels)
@@ -240,6 +250,10 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
 	}
 
+	for (i = 0; i < num_levels; i++)
+		if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz > 1950)
+			clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz = 1950;
+
 	/* Get UCLK, update bounding box */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 2a58a7687bdb..72cca367062e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -703,13 +703,8 @@ static inline struct dml2_context *dml2_allocate_memory(void)
 	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
 }
 
-bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
-	// Allocate Mode Lib Ctx
-	*dml2 = dml2_allocate_memory();
-
-	if (!(*dml2))
-		return false;
 
 	// Store config options
 	(*dml2)->config = *config;
@@ -737,9 +732,18 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+}
+
+bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
+{
+	// Allocate Mode Lib Ctx
+	*dml2 = dml2_allocate_memory();
+
+	if (!(*dml2))
+		return false;
+
+	dml2_init(in_dc, config, dml2);
 
-	/*Initialize DML20 instance which calls dml2_core_create, and core_dcn3_populate_informative*/
-	//dml2_initialize_instance(&(*dml_ctx)->v20.dml_init);
 	return true;
 }
 
@@ -779,3 +783,11 @@ bool dml2_create_copy(struct dml2_context **dst_dml2,
 
 	return true;
 }
+
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2)
+{
+
+	dml2_init(in_dc, config, dml2);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index ee0eb184eb6d..cc662d682fd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -214,6 +214,9 @@ void dml2_copy(struct dml2_context *dst_dml2,
 	struct dml2_context *src_dml2);
 bool dml2_create_copy(struct dml2_context **dst_dml2,
 	struct dml2_context *src_dml2);
+void dml2_reinit(const struct dc *in_dc,
+				 const struct dml2_configuration_options *config,
+				 struct dml2_context **dml2);
 
 /*
  * dml2_validate - Determines if a display configuration is supported or not.
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index f844f57ecc49..ce1754cc1f46 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1931,6 +1931,8 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 {
 	DC_FP_START();
 	dcn32_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index b356fed1726d..296a0a8e7145 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,6 +1581,8 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 {
 	DC_FP_START();
 	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
+	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 	DC_FP_END();
 }
 
-- 
2.34.1


