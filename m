Return-Path: <stable+bounces-85106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAF99E0C3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202151C20BC0
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B61C9B81;
	Tue, 15 Oct 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RgjgJwBg"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902C1C879E
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980294; cv=fail; b=haVF9XCD4yflhSl1X/ynl1f3gypJtSSP5jboR9OBJi5P0V9do+68SjE+9ipViT3vsVFPgs6+A1FakX+ptxXJo8d3enkspEruGckypsAkgK5gPl4UsTS1plKZWqeF9AHdwRB9sARbOv5TOKOigKHNFZd9v21UPJa5RQbMWoIGHbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980294; c=relaxed/simple;
	bh=H3Rnw9VE8ttpa7Hwq3nAZaZlwxfQmxYcZRwkzmmtyFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suNr6WWaSWjllsczOpwrc3rlzVoV2dkyWc8IcZ2u0RnBeAS1t96bML80ZiSDQ9omXpoteILJ5elAbNwYx/+ZTMxsKCP88BuEQKq0AENkhp31R05qcuUUK7jb8ptr+yMVx2/U3KfTrO6ffcY2O51jg6Ryw98LbrBI0hNG6SLIymQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RgjgJwBg; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2Mtpjv/18O11uETUuF1fvn58cAWHfJWztQgHOA3hYK+xU3uTNg4nv1oSEEXMpVVYP7C2c3wrJYhPVi3YAX9+nSHC5TpkKhFjHM3m3LL5xk3B9MerEqii8p5fPqto3aTmcIZepJyTQx8XeQZDap9Kh9HJbYUAWv2zSPGQMou77vJkK7d3E7xb2c23k8FzpN7k7rPohBDDkjAn2wxo5ddaMymtImLJuuigcaIw+Rf3e3TqCNI9YUXqdqH+YyVHjEtnOjJimuYG+knliRcgAxT7yahPHCWYFCwLDpDYZp430mmVCPgd3Mp5Xuq6fxRMpfBFj38Ukap1FVxyW0kskC0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL2l2zIfLJ2B02GJPgkXX1kS2F9ZYhpulPUH6nKitE4=;
 b=C7WX5FUw2UVnHabEKaSVfb0Np5H808WfSngbDPdS35QVVGJcIFC7guJNaJFaRIIFDLnTbXD+kWIypwnPmodyOuOHuYCmjuzdbAeSphNn2ya5Cs3jsE6t+sCLQ0z4p6F5OaKsn+klmFPuRHcllKuDdjRstB1ERmBK2NuJQL8NLVn+yC1Vv63djWHC5hjGmSl0/2+7qeoI9j6eJ4I7z1gGOuWf20FqCDolrdXK6iUBRHX2gCNUu+H/FXnCSZntuIBuWQ2ac1wGDHhLYUgrLcb1B/spFM3uBgldFnFmGuEPNfwlspTuF0WEocKegswv+6W/Cvk3IVOufNJTNhOWi2mjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL2l2zIfLJ2B02GJPgkXX1kS2F9ZYhpulPUH6nKitE4=;
 b=RgjgJwBgE40VLKe5TteG9o/ThN3m8B5hri75aNZVlFbxDS99emrYc7aHnmp98LzCD+7LPMycRqU7IziGADSY9bovGENIJAGbp1b+yOhi/niQAFp4F/uQabvkyWHJ6UMguvdjRBfEFgeNQ7cgauFzK72h8UTvl++DPCNNwcwUEEs=
Received: from PH8PR05CA0004.namprd05.prod.outlook.com (2603:10b6:510:2cc::23)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 08:18:09 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::73) by PH8PR05CA0004.outlook.office365.com
 (2603:10b6:510:2cc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:06 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:00 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 05/10] drm/amd/display: temp w/a for DP Link Layer compliance
Date: Tue, 15 Oct 2024 16:17:08 +0800
Message-ID: <20241015081713.3042665-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: e419ea11-d569-42d6-0d4a-08dcecf1e6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HFwtzOb7PrmnRf2oEqLEyFGpZR8YdYJJ57kWJnCNxiA+KX/rYBKnbls3ez89?=
 =?us-ascii?Q?pmFLKWWmYpigjYuooMZi2B2lqh4OBhCFoHngIpzxdoscxpTZqH6wI+yMvIT9?=
 =?us-ascii?Q?9QT73zkXIEgFZzZZkqFuX5HGkdfdj/OgF6hpMtVk1J3NCbkTnQomhfd8d7hm?=
 =?us-ascii?Q?tuHBWBOm1kjhxKR3DFgSnQ4/6a1f6MFv5uTeOUTb4tKbwANiCEqWblvopWz7?=
 =?us-ascii?Q?B3rg/9Aiv8xiCfRSNxCfqvUKy4gFsXKl31ODoKX0mfnwzL99HXk3aABBzW3Y?=
 =?us-ascii?Q?NlFpTKFLqo56vQNAxjkn5fVGl7PZGw3+dEvr8U988t/a6B5kjW4bRP3JBWwA?=
 =?us-ascii?Q?YC5J00P5t4EyRKVUL1JRLJSPJi50onX7I9UOJA52lQlhw3kQdrP4XuTA5bYV?=
 =?us-ascii?Q?9nRwOJpgQhgSAwzFu05rKGWPcCii1zzsLQcMz9kIJt73cH6szbx7wpeoegs2?=
 =?us-ascii?Q?ToNFGniLqwKNQ31gXVlTps+7tcaBn/WjOAfA+VhhHlolSiFIJ845b/Vu8RyL?=
 =?us-ascii?Q?AOMmOpv5EO7Lx83esRmwAfAt0Ajil06lAzjBURWUPI9+B/JgFSlu4PDECYuV?=
 =?us-ascii?Q?BYp6/iI08kWrA7nO22bj9+fe5kvu6srSn7JoWjBn0Bv4rc6z0fh0zzDgKt2Y?=
 =?us-ascii?Q?PR/WE8hgG1MK8W4/w6yxKLDH4p+rEtx1QMii6QxLrdYFhIfwB0rQpCJdcAm4?=
 =?us-ascii?Q?0UHGIz8L6F4jCgFSw58PSrOxKJSwPFWz+OIgWQrsnM0cL3TMgYcxzeqaqowP?=
 =?us-ascii?Q?/OYnufPFw9Z+JnjxUbuCRX2f7LxR0qSEilbMv+3B9pPAzxX5rcNPmDDjNqcH?=
 =?us-ascii?Q?pTulj1m87OihtpgIQN9JJWqltEYwqnV+1PkvrunPVr1bI6mH83k3MEUTYE07?=
 =?us-ascii?Q?nkWGApCRZ03xRIDd9gN46B5JQx7pEr05vccgPJi9wkjF+uHnD4bc4BcrwzLs?=
 =?us-ascii?Q?w+dAffsETPnfEsL0MWBE4EzdF1OWda8cfcgIjmfiPujzV14kBtbHpmkF0ZoS?=
 =?us-ascii?Q?1zDcbExtEbx0B8BE38/qYbJbC8UIlQJKU/owX1mJHHxZILs2mwuGU3xeupep?=
 =?us-ascii?Q?XCi4Ac5x1K+3edpi22qJEyAUxRLMFU5UUjyEBAsYDqTerTGCnZzs8/3uEWE7?=
 =?us-ascii?Q?ia5eAEj85RBOIjadEhf54b3E8A7htfB+Ka2oOvnznPoFW6xrGCIlnZrCmkgQ?=
 =?us-ascii?Q?1oxlKAAziVG5EG43F9XyKY+SDi6kK7gJyN8SQeKCi4SpG9A98BN1xkoX95dx?=
 =?us-ascii?Q?vetG/uJo9cT/AvOddEXqDiPYrVuB0vBgHr6RI20eN/wSte4vy6bmhwVexrp0?=
 =?us-ascii?Q?w8jSa8rFoRFKwxVUGp9jHYT086Z7c6pkUEXzQX5bpDoYTKMKMdxjr3JDYI8M?=
 =?us-ascii?Q?Wih5L3A5ZWi342ppotiaqlo4xLkW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:08.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e419ea11-d569-42d6-0d4a-08dcecf1e6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Disabling P-State support on full updates for DCN401 results in
introducing additional communication with SMU. A UCLK hard min message
to SMU takes 4 seconds to go through, which was due to DCN not allowing
pstate switch, which was caused by incorrect value for TTU watermark
before blanking the HUBP prior to DPG on for servicing the test request.

Fix the issue temporarily by disallowing pstate changes for compliance
test while test request handler is reworked for a proper fix.

Fixes: 67ea53a4bd9d ("drm/amd/display: Disable DCN401 UCLK P-State support on full updates")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 8eaf292bc4eb..b0fea0856866 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -46,6 +46,7 @@
 
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
+#include "clk_mgr.h"
 
 static u32 edid_extract_panel_id(struct edid *edid)
 {
@@ -1181,6 +1182,8 @@ bool dm_helpers_dp_handle_test_pattern_request(
 	struct pipe_ctx *pipe_ctx = NULL;
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_device *dev = aconnector->base.dev;
+	struct dc_state *dc_state = ctx->dc->current_state;
+	struct clk_mgr *clk_mgr = ctx->dc->clk_mgr;
 	int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -1281,6 +1284,16 @@ bool dm_helpers_dp_handle_test_pattern_request(
 	pipe_ctx->stream->test_pattern.type = test_pattern;
 	pipe_ctx->stream->test_pattern.color_space = test_pattern_color_space;
 
+	/* Temp W/A for compliance test failure */
+	dc_state->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	dc_state->bw_ctx.bw.dcn.clk.dramclk_khz = clk_mgr->dc_mode_softmax_enabled ?
+		clk_mgr->bw_params->dc_mode_softmax_memclk : clk_mgr->bw_params->max_memclk_mhz;
+	dc_state->bw_ctx.bw.dcn.clk.idle_dramclk_khz = dc_state->bw_ctx.bw.dcn.clk.dramclk_khz;
+	ctx->dc->clk_mgr->funcs->update_clocks(
+			ctx->dc->clk_mgr,
+			dc_state,
+			false);
+
 	dc_link_dp_set_test_pattern(
 		(struct dc_link *) link,
 		test_pattern,
-- 
2.37.3


