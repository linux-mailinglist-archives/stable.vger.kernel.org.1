Return-Path: <stable+bounces-120401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9AA4F677
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 06:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43A516CDE1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 05:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6A19CC2E;
	Wed,  5 Mar 2025 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="33b+R63J"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5161C84D2
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151872; cv=fail; b=Wd2DhmYuUla44+WnQAHQoUF6QjQyrVc4tLgcXl6JGGzxMay9Klcc5c4Mj6b5n6GMaeFfkKRG5xqrybZ1pGx9YIeDVKajYkm9JclS8x4Qo89R4ARp+Nm4bpqv1+shwMzcyHpv1S0P2032YyvSSiHqeku+39P6LyS65zo4TlQyw/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151872; c=relaxed/simple;
	bh=/YclHZGjHzdvl+OBaLH1cI+uOTnIaLmKmkPpjIT+PXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwwdKxhcYQDMZJ4C0RK+gz/TwKMkHwezU8K8sZAZCLj6+hvdCDtHEwPbCbiAlXwMPu8DAjmdVZ3pw2v05UFbnkb6hLYUbcF11Poo8k2I5I5r3kIFv0X+PV1gKdqogILhaiVTrlegwdahuJFCpBHuLTUyeWMtqAaa2D4VSUbbH+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=33b+R63J; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVUgUcFYTTxMqHKufNdg0ZfV5DchJpNAOzLQLfuhdZHxtyInlVRzoOT0boZvwh5Uwpx1Z8UAVV7PIW1eb3Tv5pGqBW/OIDPoROaOmEoR5dy5JxM8IoTpQaB0/VMrssnG/bMtzRqEanrIJuA41xak0dN49PnVIDmWPFlESOo3qT+jpgbqm4jM92QrWOvEz9BIc+/TNoAjd+i7ItXQv7NV8X/snXUIiJTJRWezBDF0yWDE9w7dT/y0TTRMx777rCOy4G6DWP7B7Oruau2Wl77K/XCj+t7zlq1V/s6ncWIGbi4uN81PgSgzBe1gziso64XSNxNpvaFFl0hWutP9tN8mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTF+qS69wgI4Yy1BDuVRNGlwGVrgUtAS2IWiO/J595c=;
 b=MsholNAB6FWzjYN9dqMgv7M+rV8kLnvKRLYBQydFYz+wpr2JLw305m2GjZ4dZFSgvBpNHcpyO8ilkZ/tJqMkhMaaHJf/Ls+XUygaHkwILKh5LNrqCGKpAl4bX2sCgo1G3WzLi2it5qerbeuWVF05Ey90/DJT+hyw6PCBYFfcDcdxGy7Nkiyk0+332NgURvanmVLJ84mV4a/C5tmMBNkxYsNLRyibs3SuE/zkF7c6Z6biPJaPVhr2K97aWr8YvHwh2p3d77h/qPzwFRX/d1C0RZQLWQQ650/D1ePvNhRc1IJCSCV3SCDk1QJwHo/CdfqaFOwuncYtpjW1OiHd7EMx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTF+qS69wgI4Yy1BDuVRNGlwGVrgUtAS2IWiO/J595c=;
 b=33b+R63JiRUziqT575n5TiCVPPf4lPtxLV3cNaM7TUB/GKeVaJzArHoOujRO+K4M7aTnpvoZ8JY41gSTqhlvmjBMlEM3xe+U6+y8gzpcn8V2ZjCS2kCZSsfxyx7dN6kpon7YjtMlBB//yokDXsjTU13lqGoLgcAGjF0yr5k7Rco=
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:44 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::d7) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:10 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:17:06 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 18/22] drm/amd/display: Fix slab-use-after-free on hdcp_work
Date: Wed, 5 Mar 2025 13:13:58 +0800
Message-ID: <20250305051402.1550046-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0723a67e-69f5-4ab5-a8dc-08dd5ba50fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yL2d/RtWS1o5hj4lJeUWBoFLKhYnqwVUWp1zy76K4+armrkXmEb4Lvx3X2hE?=
 =?us-ascii?Q?nx2nlou3ZGbyypQfxUtMptt/Cj+FAoUNqU5pD/+M2EcyNPIlOyOYuQw69VrL?=
 =?us-ascii?Q?6Lo6Ne5yzYIi+kDHoQ8AYXFvdobtZV60X3S9dBGq7BssnleXbh7dFeNUZ89u?=
 =?us-ascii?Q?5sM5AoTut4y6WwprRyo6D+guJKZDP7fL3THq3FY/yvNFD1V3jylukAJRYiFw?=
 =?us-ascii?Q?KbSXVKYosfjE4UifhSlxPKoZxO6ZK/VuvTOGWch8yIVAWeCSG+WFGD2rYzfY?=
 =?us-ascii?Q?qyO4WFp6x8IHTgIwtM6NSXkFgNSx/8fImX4Bo5wCA7McidQn+Y0FtlcSNGln?=
 =?us-ascii?Q?Uj1z8ftgq5rizNSnMgIKM5z843kbikhgEU5yRpeTqfacnauSYnye+fKQ49YW?=
 =?us-ascii?Q?4ursMvbKQaHaqz3ZayLqJb7zl3AxCWGJwDpwzSgQfUhaDRDXTuM3ApDTO3Wd?=
 =?us-ascii?Q?UoksROfhV51KpG0QG7NJHFAmuQhts8wjviSc1lhPEJvw+qFDgLRVofdGo2nh?=
 =?us-ascii?Q?KjDw0ci776hJYOceaeGcNyyg9wygDhNkSLtqTDuBx0cMkp/SZ57i/akfAg8F?=
 =?us-ascii?Q?TPEdiKOjickAam+mTSS1vyXf2ezUYlKoyVfEzJ2tJRBaMXODwu31qVJo+EPo?=
 =?us-ascii?Q?J1IjwJBAz8Bu6Z02hhczNkNVAQtYjgcOjVJZZLHYvYBIJlS1sVkGrFPQtBBT?=
 =?us-ascii?Q?B7NVcss8+i3RS7OG4q0U26EP2/WhtqEhJVrsxx8XZSyBOGqH2RUoJzQrbqDn?=
 =?us-ascii?Q?XRAbjQKtN7NwNEz198F+oRmk5Wu0a5JZigFJ/xgUrDFwSRZ3LpMczjfUCyqr?=
 =?us-ascii?Q?y+0fLi5M0AK1ogWyQh/l0DNuS2uvB5+3rVwieQCAGn6fcXo8DtMEpuvG8VGI?=
 =?us-ascii?Q?JFcpAunEV9zdlmc6uUDNh3hcyTTCINMXtV1odZTAlbupNbQPOOosNmuS4Gdd?=
 =?us-ascii?Q?WkC6cdNdoHU2te5hHINBpJ87c5GyCkNla8+5W6Mmm/7helAtqcVRo0oNEN9Y?=
 =?us-ascii?Q?Y4VbssQXvK4DIA2q+YbiDLKQ/v83umt66Hdwac4dcNTggXKBYBL11fQswmug?=
 =?us-ascii?Q?B0CQgacUDMTv1jhNLKm/jGBEFYlHM+eycSALGDnUScgKapaCtEykJfAi20yy?=
 =?us-ascii?Q?tB+pnVJsqWsIqKGoG01jNaDwicLZSwtGEcaXLzyvaqce7qcr9Xjj3s2ixCfR?=
 =?us-ascii?Q?YI9qgPOYeBV7mV2L8XHaHZKdXznrXo3kaXjAsPCK4jMSRC7cMnyYYDM5jlX+?=
 =?us-ascii?Q?gmxNo3q/hZDcxNrRv3Lvl0+oB5Akhmmw2Y669fL0SfT2vqnPdxJxNn0MPMgf?=
 =?us-ascii?Q?qvQj76/qrAmqnCHUk3LaoSStCRa5OReaTd1UeC8Wa8GschB1nUfrJsQ7Eo+g?=
 =?us-ascii?Q?vdeIB3dxouaEQmv4rHUoAcFYlean39oIHGp9czlHUi+TRULxHXvQ6/jJaAbe?=
 =?us-ascii?Q?/Lkg7tPfJeA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:44.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723a67e-69f5-4ab5-a8dc-08dd5ba50fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
A slab-use-after-free is reported when HDCP is destroyed but the
property_validate_dwork queue is still running.

[How]
Cancel the delayed work when destroying workqueue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4006
Fixes: da3fd7ac0bcf ("drm/amd/display: Update CP property based on HW query")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8238cfd276be..6a4b5f4d8a9d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -455,6 +455,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	for (i = 0; i < hdcp_work->max_link; i++) {
 		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
+		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
 	}
 
 	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
-- 
2.34.1


