Return-Path: <stable+bounces-111070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD38A2168E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 03:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6939E163ADE
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCE13D638;
	Wed, 29 Jan 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bwm4qTzf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B99179BC
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738118866; cv=fail; b=A3y7i7ECOEuV3qPb1IB2PwW+IaARUZd3BQhjz/vnvhYSPU3XhDqoYiIwIbG73Dy9JVvs9VwhOqKiyrIIfdm2rk0qyXHniCOmnj0otsCKahGo0v9yk9p6eeUGndh/JxXC/Peo9DX/R8t0dIct0CSQKc/XOq16ngg4vtdTnUOqx6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738118866; c=relaxed/simple;
	bh=e1yawXAD73CQo1iG9xD32ydbUG3nKepnsusEjLCtR/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGhvt2AQYCl66td4tM6Swao+p9550SrVTEUQ7lDPqwTLIlXqEMrRyOsevJWTjSmONh2XWBJ+PijBSOOXB8eQpTOBn9vDXAIwgqr6ZrDhgkaoFelVC6/joFIL2HEmzWjBiue2L2kCbxgd5YR9eFpzCwXEbr6HO1AR31CHGVRDRyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bwm4qTzf; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEv017SS7uo7Zfls5MAjbL8IIsp2CckShJ+gg2ntNwrxWqwLAKErrPn0uW6Zcbx6g6UWyowYRHGEGWeChi4UzHGnK7mUwpqe/nFui9N6BrhM2AGGuAPnTrdb84tNrSTdsemnjDgixXHyIwEGOHh7zOV5wSIjrbG319/TFVMz158nJZ7LiJv3phWbscSBmfCD14LKj7Z/abkQ4gA3WYP/vmEdW+M1k4FbDbs3kT2e9ubnRwCZNA+lyKy8GUlDUF+w6aB4BIFtFA1shsId+ViQ1uySsJ3kL2tBx4xWXSKxJqy+mslE1AbgO0PGcOugPAsKDqSl2VuunOyGEDSqZNK8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn9pqXTlhGU4jA3Ai1tvxMOrfGbsGng4BQk+EsiirNE=;
 b=mq1V2F1fdg0GaeLWZYylMxkvL+o+ug5xgnB9+JyXFqPTCcbdACPY2ku+wwtsVcB0mqqYO3WM4NKy/xe/UIjQMVsAcdM462AAtg3Bh4NmdwEHzho5eiXX792Cyw621qwPWbkFWHZu2EsbBqKT8veWrEHtNvaQa2MPjqaf65vbhryAqd9ja101emMApzoibJf8kaV4q6Rj+KcnFGZbyyXRvIw4jTsPmX4JXoCoWAitYUXwMvgeteGU7WbpWS2ETrl/qZFddd/1HNn7IS893iLy1URiroZATSQ91sLWy1fWvmNg9lx/Q69PZScYodjzoSj1DZpRX86NlyAneTwwaZ/ogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn9pqXTlhGU4jA3Ai1tvxMOrfGbsGng4BQk+EsiirNE=;
 b=bwm4qTzfDD6vjvRZH5w2a9Ih4spjZc1I6sUX9+1I45X9POTUChVPI3Dab91fU0cHZD0lGpkLHV55BZRAj3UxEOX3ZuwUYr3dLFJMeTesApdkHiUMXFkY6QCSfllz5nwkY7ix4qL3WZbIoigwm96l5AAWJoMIZhcbIWMbcpxEy2g=
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 02:47:37 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::8) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 29 Jan 2025 02:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:47:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:47:30 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Lo-an Chen
	<lo-an.chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Paul Hsieh <paul.hsieh@amd.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/10] drm/amd/display: Fix seamless boot sequence
Date: Tue, 28 Jan 2025 19:41:41 -0700
Message-ID: <20250129024432.2107937-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 897b162d-4371-4e6c-bee5-08dd400f49a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HW+XEBlniV7HFgvtkx30+eiGJsXEYO5xww68buGnSafttR36L400GLrAMP8j?=
 =?us-ascii?Q?6qYG+ZH1EP0RkdY127GRE15OS0MJI1SDarLrqjHDSmCFJ/ezATEtEt13WleC?=
 =?us-ascii?Q?9zuqFdv5596Bd/46Elr+QK9kSDqPzg/BrssXdoCPRLB8rc9Hvqwji+yf2Zvf?=
 =?us-ascii?Q?9WKVPVL2gZtAUEGQW1NujctX8+a7Ed598cnVD43fMkBnpr8ZL+2OcR205tbS?=
 =?us-ascii?Q?51Rh5CvwMMQ8qhzh7uSY/fhx5BLMtnERNDBgGfesxFPJoP7/qFynbPIxLWpI?=
 =?us-ascii?Q?D4kxxbuC84SXFS4Su/NxKG5nbeOm/6+PwcZeEhcpM5CzW6idDPTgPDf93p6r?=
 =?us-ascii?Q?o2ShzYVGGO6c7jeIvADymwX/OwHSjbLTRP34Ipx1N6Hsfye3C3nakMIJKClK?=
 =?us-ascii?Q?HBh/9l3hivqSLil3Ae4XUMwuZydpqmvCdL7dw2r7kUMuw3cKfTaC/hQFBGF9?=
 =?us-ascii?Q?mo1m1Rswf0a8WvhgzNDUxFbZDy2RrDYNw+W7K2HJOIQexN1sU1sRwlUziuQc?=
 =?us-ascii?Q?P9XdDd0/qkUHzgC5pbCIUjmPprqk3KRBHBgfP/bRQ4LTyDswjmD+jLd5yPdB?=
 =?us-ascii?Q?9EnM8Inbn7+mB4s6cQsEyTC1UjuRrUt/FGgdYLr0OiOcK2ZLoxcKuUkQBGqR?=
 =?us-ascii?Q?uRwf5JXYM7f1jgVttaXM4xla9kL6mFyvseVCJY/+JyaSEDnyEb4z2nSv3/mm?=
 =?us-ascii?Q?gcpj5YM5DMHuLPWTopYJyTapfBxHOB6qm6qhUWsCuuZbxS5MsQgQWzSR2mE0?=
 =?us-ascii?Q?1+5/IgkT6rQ8Aw+8EDzbC2nj2gs3U/59VGMWNa6ujAm6J9/fsjHOSbsX7ikL?=
 =?us-ascii?Q?jwP4DBf4NF/PVNoWTELGYJn6LVBRK57Sojz0rl+2Z5aO5nYre+uUl4yrmvYm?=
 =?us-ascii?Q?RzW6DkHcB+qH8c7vEqfdAyhyietyuKPYTy4h+Fbypk2KwG56K+ll7BhcGYWk?=
 =?us-ascii?Q?bIk4eXTnu8rRAXe3B0fVYsi9OEIgUvHP9BZ8v7OjjFgIVrD3v3swOCM0WGcp?=
 =?us-ascii?Q?MV95YRvi4GRiR1OeOM90ijm4ijX2AYRF5RQTbRUwG1VaWnklzTGikTVut0rO?=
 =?us-ascii?Q?t43YV7myr7pGVyYH8e5D7l09jT4GD6lAtAM2XE7w0sx/GllN+Pps3sv9ntGK?=
 =?us-ascii?Q?WLPaQKSTvL7rm/9WHjS81FwKgTETpxSidx1gKTTP5BuD+JBOKslcCZNixGP3?=
 =?us-ascii?Q?lVwydBqW9cPnUbMVoeMP8b9TobsQbrbOR6zwMITW/wGm18PranNBq2UDiBGE?=
 =?us-ascii?Q?iLOaC+v+dETrWV6qTtlY6WbB/5vLx6BUwHPPEqQ0OQvuLyFB1h6N7vtfpM1w?=
 =?us-ascii?Q?AOkDz3fOA7l2yutkhgMzEsg8mndAq3vshyd2DONvHyz2dRF5cyetmFCOPdi+?=
 =?us-ascii?Q?LG8eKwMxe4rhbG5B244P4Bv0vmW/uCC+dkuY/h/SRsBn42uAyrbZ46enAQ3m?=
 =?us-ascii?Q?nxkfIZDILZjbdnxzI22lh2wu/ROSWopF7xsxF4HYq1c7Vdw3+4+8lvAGCpq7?=
 =?us-ascii?Q?dR7K8gTiBJD3jF4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:47:36.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897b162d-4371-4e6c-bee5-08dd400f49a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

From: Lo-an Chen <lo-an.chen@amd.com>

[WHY]
When the system powers up eDP with external monitors in seamless boot
sequence, stutter get enabled before TTU and HUBP registers being
programmed, which resulting in underflow.

[HOW]
Enable TTU in hubp_init.
Change the sequence that do not perpare_bandwidth and optimize_bandwidth
while having seamless boot streams.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Lo-an Chen <lo-an.chen@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 2 +-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 3 ++-
 8 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a5f511da1faa..a2b0331ef579 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2192,7 +2192,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_enable_stereo(dc, context, dc_streams, context->stream_count);
 
-	if (context->stream_count > get_seamless_boot_stream_count(context) ||
+	if (get_seamless_boot_stream_count(context) == 0 ||
 		context->stream_count == 0) {
 		/* Must wait for no flips to be pending before doing optimize bw */
 		hwss_wait_for_no_pipes_pending(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index fe741100c0f8..d347bb06577a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -129,7 +129,8 @@ bool hubbub3_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
 
 	return wm_pending;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 7fb5523f9722..b98505b240a7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -750,7 +750,8 @@ static bool hubbub31_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
 	return wm_pending;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 5264dc26cce1..32a6be543105 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -786,7 +786,8 @@ static bool hubbub32_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
 
 	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 5eb3da8d5206..dce7269959ce 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -326,7 +326,8 @@ static bool hubbub35_program_watermarks(
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, 0xA);/*hw delta*/
 	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, 0xF);
 
-	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
+		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
 
 	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index be0ac613675a..0da70b50e86d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -500,6 +500,8 @@ void hubp3_init(struct hubp *hubp)
 	//hubp[i].HUBPREQ_DEBUG.HUBPREQ_DEBUG[26] = 1;
 	REG_WRITE(HUBPREQ_DEBUG, 1 << 26);
 
+	REG_UPDATE(DCHUBP_CNTL, HUBP_TTU_DISABLE, 0);
+
 	hubp_reset(hubp);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index edd37898d550..f3a21c623f44 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -168,6 +168,8 @@ void hubp32_init(struct hubp *hubp)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	REG_WRITE(HUBPREQ_DEBUG_DB, 1 << 8);
+
+	REG_UPDATE(DCHUBP_CNTL, HUBP_TTU_DISABLE, 0);
 }
 static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 623cde76debf..b907ad1acedd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -236,7 +236,8 @@ void dcn35_init_hw(struct dc *dc)
 		}
 
 		hws->funcs.init_pipes(dc, dc->current_state);
-		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
+		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control &&
+			!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
-- 
2.43.0


