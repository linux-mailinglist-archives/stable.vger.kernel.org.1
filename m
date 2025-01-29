Return-Path: <stable+bounces-111071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A143A21697
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 03:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EED1623D7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 02:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF43187858;
	Wed, 29 Jan 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LGT1OW+w"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB633987
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738119466; cv=fail; b=YAm41Q/rcf6h7BaMEko/nlZA86R16fMgzktfCkEwpPWpR8SrUAdA+Lmp26No9JxQay4fUFNVlKmzLtHiZm8Bd9mzMxLcK8hMMz7VmtVRvRxLzg4OzOQGzxCKbctNmc/8s4QfeaWTmhKVm7NtrrV0aLPQXJ+OCFPIhYlfEUaGW8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738119466; c=relaxed/simple;
	bh=e1yawXAD73CQo1iG9xD32ydbUG3nKepnsusEjLCtR/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lei5E2xOqIjAOjAysaXbGm5fxytx8CmlCIubQTHEEX8hikW2CrJMYMrEsasdbHu87NT0TUJoZMdYSSyRD3rUIRjjggPTfzModRt+xFEaYmYIt0Mr1kp7tXDIw+c29JRB2Uof4NZZ/V6XwhTbypGIlYtILAHkA34zccRi0xuyvf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LGT1OW+w; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYnnkvivaKvE3nruz/y9ApzEepvAsDLDp6roQhGC07zZpp6pBNcfvdiqKPp3dnN8Jbdn3IBQijuoPDRJ+qOkZAd6rsWOCQiK8HMvH9I1TrCVhJ+Hq2DyK+aXNRt9NjQsnRhDkmN7g4BU8BPiJuAzPpNmoaiToDO+/71IPhegmhw7pfwzXlgQUHLzf4gI7VviUoNvTJaWtJ9HPL8KDsz0QiHHsmGm0DEaZAewsQQDa+uGtEY0/2T6pRX0oMnGPstA5tdHgJKovW8MIf/WhNXQ3X0ZD1hoZJzVnnPO/N+egJYKC3hYI/c86yZQWdghQ2dmKDvbDP/qvYPNDiXhm9plUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn9pqXTlhGU4jA3Ai1tvxMOrfGbsGng4BQk+EsiirNE=;
 b=hqu1WyBO00s3qIJLX+k0PlIwzxs/UrHMgTgGIT1vb6iweREySJOV8Md0kTp27qFgvMIWmc/EiajiGUX0mYCmQIZh4W/QYRe++BYV22XUgtt4sWWR1zD6zevDCfKUzefImTiHbIFxuEV6o8Zo6wgUcdyVIhNycFt2cOa9ZyzFXVdy9YoMQmMvNhwSfgQKLCtEvQOm5jkyO3GYlJKd47ziKkSk+VI/41irU4p9mZ56bj6QAOMhytXvMbyQbWDZ0SqcSYTsLdAOrrYmuTE/DLIEwihdm3EYd/2t3FJjc/toWMZ2uHkFZU5qx5xccW8rBPHw6cDqhwHyqQxGw5Njv/uHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn9pqXTlhGU4jA3Ai1tvxMOrfGbsGng4BQk+EsiirNE=;
 b=LGT1OW+wLik8fFrBjq7XrbV9ZTyvwgUBZetyyO+Yk7DSdbccnFqBSjSDSQXhjtsVrRRZwGiPTacJDpuJsOSR85108K09KQS8oBh2vIqtNVXHDSATaf2k9mQZgOyhp6gXZRs6ce++2JnjuDP9i1+vBHY2cUw249/qBPSNse2cqfg=
Received: from BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 02:57:39 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::79) by BYAPR02CA0042.outlook.office365.com
 (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 02:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:57:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:57:35 -0600
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
Date: Tue, 28 Jan 2025 19:53:49 -0700
Message-ID: <20250129025458.2120268-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129025458.2120268-1-alex.hung@amd.com>
References: <20250129025458.2120268-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: eabe8c83-b462-4552-2370-08dd4010b0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Km6AZTsb9NXUUzddDmcLIFBbJrFSfBnPi1XOvZ1pEeYq27I/msK0hu6UEGUG?=
 =?us-ascii?Q?cC/c29xOuZmTZ5XzXyChgJzdcKUa6lNjIU5xv+Ip03j/xUVaYXBwkA1GnNEc?=
 =?us-ascii?Q?uQaX9K3tepyU7ua5am0SAubuPe6bSWd2+ZS93HgFwc+ECi1OkOCtxUsMwO+d?=
 =?us-ascii?Q?UBBL4nKQQ1rmhEgIJdN4ALT6I7WR9CSHpETd0GrRTUbpGU/vdts5IZciNGkw?=
 =?us-ascii?Q?Uhq334iIBCkSXS6cpAokoT4ElaQkunfB5uerA97G/nJH9r4CjaRfFCQiBA8A?=
 =?us-ascii?Q?c13qdOC8UHr9DM0bJqjq5K55/PZbcOgtJ/yVGkuPXoAvXJQnuHcNN2xlj5VG?=
 =?us-ascii?Q?REaePmm6yikuJpcaSN47CgBBWNBQBuumZu1skk9G0SCxB8x48AdRXeI41Qbi?=
 =?us-ascii?Q?/QnHuGVJXEAMpHTFJeKhUtXaM84Lh0GaF5q99gOLv4W2iePwHHVRcXmxEC3c?=
 =?us-ascii?Q?QOohlbuq3ste1lt37f2PB+TnfOJVJQPcD/CmW+2eySW1MFXq7YSKFoyt+p8K?=
 =?us-ascii?Q?65/7L0eY4Qvi+9h+r8lfH+vH0CGLZm0z2BW5B2WZp+9Vux13n2dQEgJeA2y7?=
 =?us-ascii?Q?CV7q52Bba2ISW8thm3ktr8Pu1wJg8Og9JlD2xP7I0yVK3U2XAdNe4Pwppuvq?=
 =?us-ascii?Q?whYJz+qMbzmySz0KIkMDESPdWHSoBngzSo01BUqh1wJVdAOUclOlTNPUNWwR?=
 =?us-ascii?Q?RPmu1W6G5OVvqNvLT1340q3J03YSQ8NxFQwwfDFGQWmZSoDSvyzMxfRfpOQW?=
 =?us-ascii?Q?VGYu77mb46O6/og0c+D4XBwxd1u1qQUmYk7njBHQp0HQBL9EoevzXYwADNy3?=
 =?us-ascii?Q?FZvnkj/PfAs0p7OQOayEqi7N3bT0jlcTenfFz4CrTIP2w1CI1uNjHjDli+FE?=
 =?us-ascii?Q?TfeJP0ma6LHVs47+jAA4kejC49AWD6iUDw2/YV2n48G9C2aq0JvtHi+TipdY?=
 =?us-ascii?Q?t8ABCt63ZJL+RgVOnunMURPudFJ8leuql37HlHydqoeHMtcUdOeplVobkIpV?=
 =?us-ascii?Q?4/dIRzGtbPKE0kW/Dn18fSs+e/qoyamqWmbl4hdSx30tWbiFtPZrqygb5+kg?=
 =?us-ascii?Q?AZKKMDOveP8qEB5rMalYP9aY7Mk3FSnb8AyFEpGx9N6lQP0Z0lL+0te0sPCl?=
 =?us-ascii?Q?Iyh0n1NXX4TWzG5ctIG35cC/4XsUu9dA+c5FpOIj0Rnhe+g5GzgwmqO1bz0X?=
 =?us-ascii?Q?sMGCRgsFR9iIiw3QXONk/erCgtOEnn0m8xHWkg2fjIn0RHy/fuiLydDZtK4v?=
 =?us-ascii?Q?m3ih+Ru0xbqI3bqCx7Pj3z5gZiaDi/IF6rKWjzmJnH+xbTNR5i++RXAhIGDA?=
 =?us-ascii?Q?tpxpfGNVX+M6BChvL3+1aif/hGLoX+J3EPO5ICVpBm2Hg+g0AKJkpRsu5HE+?=
 =?us-ascii?Q?KnnpjPGDzcnchP5hFkJdIMxnrNbsnscDxVqDi1oHCk/f+7YwkH/QXF8tZYiK?=
 =?us-ascii?Q?lQYnnAbi3pFsUzjneaBHMPZizL52r1M8a+Yy2Tv4MbhxRoFrayJN3nHcoe9D?=
 =?us-ascii?Q?czpbjuS1a2/TIzA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:57:38.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabe8c83-b462-4552-2370-08dd4010b0bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

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


