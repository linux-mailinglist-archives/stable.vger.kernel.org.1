Return-Path: <stable+bounces-75867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C3B97586F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1056CB28BF3
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D641AE038;
	Wed, 11 Sep 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dv9p2rBX"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2C154C03
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071898; cv=fail; b=UcVnoBGoJisKM82INzYfHQgE6QVz2hz6YwuiHPePCH/b7mV8/q3rEqT8zxDyW7G96Fs17U4PkQN5kSNcP+l3VnRSJzb+IiUnPQTBJtwzyk92fyBuXBcP51J/sGQRYpU2ovhT69Sh6cvs9uOtAf/L0BTF4czElBmCrRH3IMGANVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071898; c=relaxed/simple;
	bh=0MtEOPbMB2bg6R88iOQZb8jsSrgObvt+aRs6P4/gCwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzublIGpsofce+kGUcqGPjAYSSvVPraaIf2iR98Rl7mDI+A6uBNA3zABaEuir7wl614ECSR3VwYpShlnvkCm3v8uk5P4f2qQjo8drLqGIDZoGvXvwHm6IYk6wyXCMLpMh4onPsLC+Xnji/jdMDIX6F7gRN4mnGF2rmL2939w6HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dv9p2rBX; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lE1m8ES7qiBEtQYFCMsTmyjE/F69XnTEB0VO5xJRvybm7N68/ag+j0+PIhN1FZDuIbsBnQmn5CY8v9aPO3xgSGysr0nEYMjtoJo8YGYIIioMTvcAygGr3Kq7D1RAXHa5pekiQLkeJRUR0FtE3JxxD/cQ9HZ/8SZVbX08/cQLxWmCQh0QKmVVoGyFq/YjtK2UPGvb7m8edeH1zw0QF4wTNxFFucQChiaE/QHXkfWDKjhzEGyFxRyvGj6J1TLEFILLqOLzYQJim3Twhv4k0WXu8Ai8bMY/OSz0Od+JI8wrLOnnSHNhLLXcsR8U8uNUAjhXN91RkKdtZtEJS0n3+Rc28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uO2ckJZDkSu5lb9nuo5At5j4Ul85eC+QepDAEneydg=;
 b=zJjfflXlPB7SjqHpsThZ68Gxa/esw+SaaHsWg5IJPBCPxtLz48XeWF4kPRImkqKwonbj7NxTXN08f+xD2a0NlCbrmlfVkzOGTfVxVycFJDq3v7zg1fh6fFeAWhGSAHPLZsHvKEyxYU2zvwiFiKV9RfScbERguY6hZFb0GGa4pUWexaCdr0grnBWr8h2adrn3+KwRie8RJmUicRB7IUj3nMzejbrYM1rZz6a6bBspnU0gKRqQeCkcQ6FjRURW0DHqap/8RLy/Xta8NyfdSgRHWIF1APnve5hz7U9K6nwHNSb7YWKa4YuSw9yR14fyWaNi+Y9xyhO9t9aTwDV4eTNLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uO2ckJZDkSu5lb9nuo5At5j4Ul85eC+QepDAEneydg=;
 b=Dv9p2rBX0+KABlGnvbqgMCoNK4N4miBw2kjciLsL3ebTB5nc7tK07su/c7phIbLA/sFd9Vno9wW2Kz2KMmoKhha6+RazG1pXuXtbiXBJeUKfwRI60Iua3O4yaTEtBgg9DEph1BEbnU6ySVWaSRGDlOtiSqlBHJ04ZS01bZyUN1Y=
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 16:24:53 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::16) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 16:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:24:53 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:24:50 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Leo Ma <hanghong.ma@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Chris Park <chris.park@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 14/23] drm/amd/display: Add HDMI DSC native YCbCr422 support
Date: Wed, 11 Sep 2024 10:20:56 -0600
Message-ID: <20240911162105.3567133-15-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afab99c-4550-49d6-46b6-08dcd27e4433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvGgiHYRrtED6LjJbBPXi1tHAT7ezITEZ9GB5Obaeb1DBuKyJzC+muVG4o0+?=
 =?us-ascii?Q?AAMap4QzOZWPTpQQD9YnqJ0a5NUM6/tIwTesTRaSymRwIYgv6iKVq3knWpfp?=
 =?us-ascii?Q?VceNMERkOmvttFj9q0eVxEdCUFz/MOdIPynJx+b0WmflgbTDxQdwiXc4vCRS?=
 =?us-ascii?Q?fUeSuKNrKn0IyuPdh64XYKef5pyfloHFEqkROvqvDeAbIQUJTwFvPfondXQh?=
 =?us-ascii?Q?BFaXNUo6NoEGqWG5Ta8xAsNxLzKa2HCHIB6BEQQaHw5D6UCS6ERu3k5mpoio?=
 =?us-ascii?Q?IyrNRhxntMBzxk0HhpEXa47v9AfAAgUVMx8D6EY3qmg1Sc0+o/R4KbPtCpXd?=
 =?us-ascii?Q?NzgsfBwtF8oEsS+divXOmbKmaD0t3axreboGiYDFFxytaP019Wj7BB/bklLa?=
 =?us-ascii?Q?zxXwe2O9n0s9wBzDpdXITqDckidin2/i9OCU46unv3x4djX0cccPsU0CtcGY?=
 =?us-ascii?Q?MCJmrb7LxfuRPlFFMyn41ts6mb2pv2Pg7L7cuPgDzXP29ZvOX3OKxQ796D04?=
 =?us-ascii?Q?PG+jS2ul++RT42IAb4Ws8Wijx7bf1SHD8I3RmMSraWdAmUZJBO8i7P9heGmK?=
 =?us-ascii?Q?3VShA+Kvc0rcf7cQTrQESddWxoAaCzLSFiFUgcrgawFPJ64TNVH3UllkaW0a?=
 =?us-ascii?Q?aVrzS9czByxqHRMyPuKPzE+X/C/unFoA8Vf0v5T+ZWjHaylIrXmgyWB3jWGX?=
 =?us-ascii?Q?ZJ8XkFq5VIaI/fISikd+423xqQUcNVmvyzLpQxSlEl8wox5AzDPOVGff2CLM?=
 =?us-ascii?Q?Nw6yunFn/u9HxGk+WWUrUD7Hp2CJikpE1cqSrH7pWAEg08EFwwdEqEGp5jfX?=
 =?us-ascii?Q?ldENxbJ1/PXRrnvfqyLJytiD9n0mldt22sC+JvHhR9Mv18PlCOpsYS1rBmpL?=
 =?us-ascii?Q?3wHnCfQmWrxFadrhBnoI1IQHK4h5RoDIgyh3dKImWkuzF7Ao4VhnRImJAOdT?=
 =?us-ascii?Q?/AIzEBvxbwtP5EgbxLHC4WswjlWJmsVxbpw72LMdd2PjDzIGrjRm+t74K8zm?=
 =?us-ascii?Q?wujhsacYomR9fIzPgACPlHwVrmCUspB+3gT2WNB74QGcbaIOGVZA0xu/m09y?=
 =?us-ascii?Q?oOADmlRAk6ZzAdi3ed3qO6+wH0HuI9ysx2C7A/Mr/pC1Q2Qm4oSagFDRbp/h?=
 =?us-ascii?Q?MD/Gj3Mxh7WhNVv39tl6wstFtPduy2CYMYZ7na5L+mV5iutXAzvwtEcGqvcx?=
 =?us-ascii?Q?oUvGGcficBbnlmqJVSQpqOGBQ5isJvvP5E/EFkBPvEsZGGNF1Ddha/jbcJRn?=
 =?us-ascii?Q?8wWrnowxYFN72JZktzr/pS3Y73xDc/kMPmp1oTrRE7OQ+eKDhUyY3ll9uVvi?=
 =?us-ascii?Q?2i52yi1YaV0rgsb/nRAifQpoczcHxLRDn+aGtZbZzIhK9CaNWcsAR65l+OEA?=
 =?us-ascii?Q?kd16+R0vdwAY89hmJYiPXYZWJoptt0poZGsL1wLOIkB+AaYD/1BGm/hs76PT?=
 =?us-ascii?Q?Q79zu7J1lmNbrW1EAzjm2NsyWIf1DdRE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:24:53.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afab99c-4550-49d6-46b6-08dcd27e4433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

From: Leo Ma <hanghong.ma@amd.com>

[WHY && HOW]
For some HDMI OVT timing, YCbCr422 encoding fails at the DSC
bandwidth check. The root cause is our DSC policy for timing
doesn't account for HDMI YCbCr422 native support.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dsc.h                     | 3 ++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c                 | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 658584819d6e..358c4bff1c40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1146,7 +1146,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
-		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy);
+		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
@@ -1680,7 +1680,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 {
 	struct dc_dsc_policy dsc_policy = {0};
 
-	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy);
+	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
 	dc_dsc_compute_bandwidth_range(stream->sink->ctx->dc->res_pool->dscs[0],
 				       stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
 				       dsc_policy.min_target_bpp * 16,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 2a5120ecf48b..9014c2409817 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -101,7 +101,8 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
  */
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
-		struct dc_dsc_policy *policy);
+		struct dc_dsc_policy *policy,
+		const enum dc_link_encoding_format link_encoding);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 79c426425911..ebd5df1a36e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -883,7 +883,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy);
+	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy, link_encoding);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -1173,7 +1173,8 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
-		struct dc_dsc_policy *policy)
+		struct dc_dsc_policy *policy,
+		const enum dc_link_encoding_format link_encoding)
 {
 	uint32_t bpc = 0;
 
-- 
2.34.1


