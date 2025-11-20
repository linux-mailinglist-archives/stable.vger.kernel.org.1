Return-Path: <stable+bounces-195387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65990C75E94
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405E74E023F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C00352FA2;
	Thu, 20 Nov 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zrExUG/V"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187033D6E6
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662963; cv=fail; b=bfj61UswqmeU6OAnaQ8ntBLPqwNPNy2PzmaJhndIJ62Bt2SfXX4xF0KVLSbQ9EfDA2XQRB/uIaCLnZZANy9NcnVUcia0IpYPXq6+l6iwxtxnHkZhO0Jj83XBwFdJNaoi4AJr3hLcKI2Li3TdITmmzwR5UA0zaTyxxy0xp8hhI9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662963; c=relaxed/simple;
	bh=O4t+m5fRE1LklHiWX7EIC5DtGVgjZHmQVECax4EocdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJFn2YIuYuyjyRBQ75qugI+a3WjUjII3CFmlxYLDk/q8mTnrchx08em/t/mS3WLTwBWVf7qTjg4Mb0SuiQ6k5LQw/g8BbPdvz62yDks+H8lo0HXdkgCpbQTdpPdHPu6VPzDDon7hxFrD9U3k/bxN+3wxAlIOTSWv9oSlD63Qpwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zrExUG/V; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEOQBBeUsegKOnumCzksfLWfus92oiuBzju8WthMFhXCVnKKghntjgFqLZJwLPjQGk9VL/YW+yFdCGGHYXsiQcMTLHAtId7LhMLFAgRXz5kIkGPbiPiK6hancEiiFibtxMN2eySsTLKwLOw3i4kcqqAGphJK6Wg+8Smk3TGivB6MvPJTHhRhVcTesjHB8Iji74wO8G/SduIjAYOyNZiGDzmSGA2Pec6KE9R6jvIw1qMx6SgBwFAlCVztpsgp5DHhfBj7YCekfRojqVH7tAOBuSptpSq+MU0ANU2Yd31faNW/+r6UWG3+YCPoiGS1fhJtBAZk8WKGabEbOYQDQrj8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVE7UTHWUvhPmb02FPN0Yqu/4i3mtISoEaiH7ETO6nQ=;
 b=Nwanu8FbIQsvCCPeMmDZdbHaYlFEoflqT8GKx/Y3oPJbnzkHmzRWBWrd0ZwSk35eHTQO1GR/Pi1p1T00KMH30OdlkBRY+R/IhwjHpONLPocw6y6zAUDlU+ZmvJwPY8PBlcQn++DYA0d54vKVcqw0ZVELqUYs0MpN2v+QBI9EOvdhgjbb/hm6mjUE82Ntqpt2VgPc1Fi91T94m5jv8r2HgxgM6MFQmYNtksS8D6yPch5amcPutCoTlrSd7l0P0qJSXC+hoIWN8H8Tu2qAFDT8qTTZFMHOEEdN/a7gNkvhn0tfCOpOX2yft6qXxnJb+jrYG+scBZ9LP4alS4hfSIlogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVE7UTHWUvhPmb02FPN0Yqu/4i3mtISoEaiH7ETO6nQ=;
 b=zrExUG/VrHYvd8UsZ3gRADwbQzCGG623pGsnt/o6kol09D8X2PBlEZpidPp+qFKmtlIrl8nBGKqO1P5M5JdY9OSgNg3RRwlGpINlgb66Lhrt/KPJL1ghMCCElgH83mUN8nDiNxnK99YqhLW+3NCn8XEjzLDgJ+/Rpj1weFa3oSg=
Received: from BYAPR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:e0::32)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:22:37 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::8e) by BYAPR05CA0091.outlook.office365.com
 (2603:10b6:a03:e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:22:36 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:22:33 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Relja Vojvodic <rvojvodi@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Chris Park <chris.park@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>
Subject: [PATCH 23/26] drm/amd/display: Correct DSC padding accounting
Date: Thu, 20 Nov 2025 11:03:19 -0700
Message-ID: <20251120181527.317107-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3360e5-79ca-4b08-82b9-08de2861c7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pT+n4kehzCZfj4iMfG9uD6Ze8xlNAUHJ6tVDtqUWoMvSz79KZURt8R/LnVjy?=
 =?us-ascii?Q?8lhqT/paBXVUDqjHnOJBIR5mB85LQqdPs6f/jC7UYHcvdrHSX47hwUuvAeIs?=
 =?us-ascii?Q?G0rPOfwSumRKh08ED3m/geCbvHy6K6D3hwKpGeMra+m2U7DEiBQUPh4St/Nj?=
 =?us-ascii?Q?UPg5xFn/Xtfhf1NJ6BXYKctYdR11lbZ4iN7cT6AWm7NDE3qq7IO9QHVXDCTn?=
 =?us-ascii?Q?elsqAnPOZ+yezOnrtIFdby3OYQ4rTrvcHEvqRlq6EbbgITPC3ZhSzyugEFcJ?=
 =?us-ascii?Q?5BrwnUkuoXt1RjEMya18PhcQ3xzfZdaPSYyNGWMqSkSmyn9EpaCyxSnzcgEA?=
 =?us-ascii?Q?XCLqkztKob89oOe2EXNvhA8HzaRcFTqvBJt7/MgSnGFxP5eamTEIBBM2jRDN?=
 =?us-ascii?Q?F9PzV2cX8kXwUMVgSDv42v4Uf+SR48S4tLBMNTGfidBw/FmrqOCSuCVH+NnK?=
 =?us-ascii?Q?2wzvAYlmllpJglcZ3P125QYFPGVCOIcqtTfB9ET98OaYtwC5vNwkeQgDaH0Y?=
 =?us-ascii?Q?IlJ7/9s1gn48P6/TOD+ym5BuZdPKgKDRnkcWN/5kGHr12eEZ1cZz9l5AmeCH?=
 =?us-ascii?Q?F6xRKIP4tQyTKonn0swfaAgkbrieyU8IUhsasPH7KCHc1P8L60rj9ejfa0ED?=
 =?us-ascii?Q?U8TsDwTCvJI/YmoOilpqyRZClV6m0Oi6Df9g1fj7BV08/Nt9JKKruehLFm81?=
 =?us-ascii?Q?/h13phQwdf8hv9iEXpyRLlYYst1xrREl79JadwYLb6F/et9uDF1iTLjgZOv4?=
 =?us-ascii?Q?ZxmiTn4urFpnA+Xn63TRqcnILMvnapWYpmovUYrMIK3h8w4iGQ6/YFDz4/jb?=
 =?us-ascii?Q?9VkgkRPvTIHpbiUnM5TUkbAh6z/3944WuHkyqVTXKEj6mq5j98Q/yEv5kMDq?=
 =?us-ascii?Q?Th7H4M8L1xf9Hyfw2+SJGPW6rq/Ncgz07QZmfInJ7abQIZ4MBKZWFFuN3Q6M?=
 =?us-ascii?Q?RGe6jrJ1DRLLQ81G96GA7z7niPxfxIC+b9BHR7vxVmzgWP4nCiwwI96PIlEl?=
 =?us-ascii?Q?VnzkwTooYMcD+NDBqH4oaNWYgY80pMVsH3fSQXq1DgWDnM5IzDuN6S0hJyKM?=
 =?us-ascii?Q?E+0OfEzCuLZLhUur0lVNSAhygIoNlzNpPmWnAdfbO8QF4/uH8gFrwHVZayQW?=
 =?us-ascii?Q?opoTuEALlLZEcS08ngXhQyResE9sIO5cKzRpFV51xcyRaPKIsFpwr9i5SoBy?=
 =?us-ascii?Q?24DDlrzpCifP02RwPcdW5W+vk1WgIUkYNR/PgVOYZtw6Q1GW0KU6cbc3LV+I?=
 =?us-ascii?Q?pJZWHFhsRjH7u+wS95GkvI3hdA48OVvtZKnZMPZtRftgZGUV8kDf89gLrsUC?=
 =?us-ascii?Q?0ExtkCCW2RVcAz8kyJxqCZ9AMFkjefcpqnwQec3ryWeH/h1aXRKB3IknFbRE?=
 =?us-ascii?Q?UpFBDLakC/9cBozB4wlie8CZ5qtEVVztk5ITMCBgBo916XdFt6fq7419iXDK?=
 =?us-ascii?Q?P/djgIqIOv/4MNjJA+UIXKbWwxK7sgf0M8btTYoE/pzQpLnP1MS9QmjWu+UD?=
 =?us-ascii?Q?PQbQiFzbYDasIHa695N3zkji1G/fkGYHVmgtuej+0JrAHhhIDoNsKEln+ryg?=
 =?us-ascii?Q?yp8iFOUAxBZpbzFVzRY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:22:36.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3360e5-79ca-4b08-82b9-08de2861c7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

From: Relja Vojvodic <rvojvodi@amd.com>

[WHY]
- After the addition of all OVT patches, DSC padding was being accounted
  for multiple times, effectively doubling the padding
- This caused compliance failures or corruption

[HOW]
- Add padding to DSC pic width when required by HW, and do not re-add
  when calculating reg values
- Do not add padding when computing PPS values, and instead track padding
  separately to add when calculating slice width values

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c             | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 6 +++---
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 4ee6ed610de0..3e239124c17d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -108,7 +108,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index bf19ba65d09a..b213a2ac827a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1061,7 +1061,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 7aa0f452e8f7..cb2dfd34b5e2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -364,7 +364,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 1b1ce3839922..77e049917c4d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -841,7 +841,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
@@ -857,6 +857,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 6679c1a14f2f..8d10aac9c510 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1660,8 +1660,8 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 		if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe || !stream || !stream->timing.flags.DSC)
 			continue;
 
-		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left
-				+ stream->timing.h_border_right) / opp_cnt;
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding
+				+ stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top
 				+ stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
@@ -1669,7 +1669,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		dsc_cfg.dsc_padding = 0;
 
 		if (!pipe_ctx->stream_res.dsc->funcs->dsc_validate_stream(pipe_ctx->stream_res.dsc, &dsc_cfg))
 			return false;
-- 
2.43.0


