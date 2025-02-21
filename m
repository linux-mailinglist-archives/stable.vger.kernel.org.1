Return-Path: <stable+bounces-118611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A30A3F952
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5035618887BF
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579D1D8A10;
	Fri, 21 Feb 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yeba7wOa"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2B1D6DB9
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152623; cv=fail; b=aj3FUyPiXTvS2REVuNOlwx9j0cjUqNHVvlAUmhE6av8+vdYb+cypOx/ZzQubgDDr19KCPQ/RHoKAd+EqK88nnkgX8nuzX1k8FiPgkenG95NNBmD62i0yLG7J6NCmsdiCnqrqMCZb3lNN9v2K6H4ldhhuEemC6rLYGWnp5RQuS3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152623; c=relaxed/simple;
	bh=NTmtifc2geJUpHgl9oLfPoMW7dP1hXOaVVqUbmLfLu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/D4SbzJ8x9tislUqzyAjy74vQR7IbRFOZp+AVVfpJuGLO8Yo+4QAYfFc8nRcv4C/t9GcPDP8RhwY1wYDpbQkkUGkR0ZvqiPgHwXpButUd5mrSe4lwQB3jgEJXDDY54LqHs7Mb/irc2pqVVHJPKfWlHMr8L+TZ1amQDvsku7ip8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yeba7wOa; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXI+i6vYL9eVgHUJCLNu4ZMhuYMLYrIAl125zOrXmINbh5TXqbcppsPD/Xk42oApZzQEeYa3ev6xvGg8tHbNgHHMaitCV1Pc2MGrc+xke1zs75vNzbl/yRthjoPwfFMtVAUAd1F4qip8Fns2szOV1yPnQIo4yVERxVHxX4C3x0B8Yyuzv9Bt6Hbq3J+lL4JAenWKVG9dqcTM2a3iW1K6mstvBm20jUsySFSSyTav+skujLDwR8baSwNKX6kVYOK1k8E6V86MZC0WYyHXVcgJHA7VLen2P6O0JNAy9lEme+wIcn0fjKrLwxnPPLbPl4IWYyL5Jv2UIfpnVMELxQRlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=An0dYgQgXjGbbuFFtNx+5EyO5LROGOoGL3pvvacxY4oTwaUU8EcwCTv9RPbFUWdUIrORVoC1S0mrnYZjtTzyqfpQ8vzednAqaO29ErTziJxmfyljaU+NWVeHCEb1dSrWEs06ekKspgCqvJFfFS5eTDwnD2bhmk7+40aSob+aqZoK3Qdpp2y3zSkg5n2FigooKIn+M/kNNXhSQLhgLuGs+qzHErlp2kX9aJ46u6UiUKzYvF/hAx3zaSWS6yhzNQzRxvEOLfEreOYDSocQ+BGo38NRF9oGVrj3R0hSJ+XQZSpzHz3mrfFrmf+kDP1QS/ZpdP8gxohNWnDlvOJnDFBIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=yeba7wOausBU2ohVIEZFXOiDfEK9pnXg8hwg22hQHPtMIO1IAwXhuOvBEvamyfTUrL0WIN9JIMUOnlhnLjje7D+2+IodVDLDsSVMeqX4Sz2FmLp+kZJU5zQgg33kbt9S34o++Euv5eGL7jUfSgQXyjVlmy4yilr2O5MxkFfsPhU=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:43:36 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::55) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:36 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:34 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 02/24] drm/amd/display: Disable PSR-SU on eDP panels
Date: Fri, 21 Feb 2025 10:42:50 -0500
Message-ID: <20250221154312.1720736-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6b4c2e-3a23-4cdb-143f-08dd528e8150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iSsjHvd7E48GzzxqFHfsNKCh1wwVObJdoQNUYRQUz3x6gG78CxUKJRs0Jjvl?=
 =?us-ascii?Q?Q0xBKlyUfwunZVk+v/PfFWQQHa3RWKya0qVH/+h9lV2Th3VmuFfnYpk7B1FA?=
 =?us-ascii?Q?iN6W5NhDdQeVIhwDoMFK1sSMD2t9jaB3MlA2/zEi64VlMap4b5I10+fVSkiY?=
 =?us-ascii?Q?IrPp04EkoZRpFszpiyyHGAWVz7jyC3fao24MFCyP39jPI8oz5/n5LonWRq2Z?=
 =?us-ascii?Q?19j+ilFJQ+IRt6FdOS4spd6k9J+X3GrBcSgDWrK+iHbKiRFHXt0+vqwX6vO4?=
 =?us-ascii?Q?E6XC72BrJDQEff01jbDhGp8hqVopXbO3Rq4lsMtMuIpAHy116hfpYo3TzF9q?=
 =?us-ascii?Q?hvStGPrQiZ7WYRkMUVxGFNEOvweT20JnLb5R8TyIE7ujXPL+0z9tP7xjcvmb?=
 =?us-ascii?Q?J7CMGszNYPfHNiy+m+VyJ0NHzM/Z7QkOoVuIlCzXNUUotOrh9oFL+9aw8E7R?=
 =?us-ascii?Q?2nnP+oQfZdx0ovXTVHptA/Wy14f3NPSSHObp7xJmhqYYTrnZSiadHBE7aBjn?=
 =?us-ascii?Q?F6GjGhbe0Z7gPcdPcs/9q+DAj2m21G/qLUDb3nsQ/G/AyN9a7QtuSl8yGDJz?=
 =?us-ascii?Q?+tY3ovrMswLM+dZPj4Z01twx04n+F0anjSd4+h61PMV2/gioder2cdMSIhBt?=
 =?us-ascii?Q?z5zfMPvH2vYSHsBkYbSdpwRaTbWGy11dF9KSFUHN6IkzdkJHE44j664/sQJ0?=
 =?us-ascii?Q?zUkFLd6Z8PEB5LMBwQ48PzkTCbus6YvFm6ufUnEZrwSp52wiT+6S05MOBV1H?=
 =?us-ascii?Q?J+XVmYtviq+j/WY9k/DKne6wocGmYy4ABuQeBfZOre/zZVwgISemWlZWKY7P?=
 =?us-ascii?Q?nO9jztiQ8X9tezjjmLoiAl0uqfxck7aGQAxse416SOXdQWq4puyGYrrE0qde?=
 =?us-ascii?Q?dKxx5yaH1aLZcJ7f5DtSisjYuTtz2AgEP/75o+zuagWGBfENf1bzNj+KBDoG?=
 =?us-ascii?Q?8d/PcqBpefGg+5aWEUbesaK0p1Cd1iiipYitY6qX+6VEvVKVXlIvMQLOoxRs?=
 =?us-ascii?Q?DwTddy6qJ8t2AtC5X3zQms7mXvgX625GqsLRsL1gMxSjcEbxIlCFcMss7MP5?=
 =?us-ascii?Q?0yQcWqY4Qrk9ZD7UbftDfiJRVe5JnBjiXV9fYMw8G5SEhD7B968QlcWrswZh?=
 =?us-ascii?Q?Ru1Y6ku/V28mQlLPIhaSs1XzuDX8M9v87mYEYHV0q1FRUba3hHL1FSp/AkbH?=
 =?us-ascii?Q?9YnC9P2m+ej5Nuwoch/T/venjZWrOihidki1vwFVYJT6ZP+aTI895ZhKJh7C?=
 =?us-ascii?Q?+I9TMx4ipGxT7203u6AP2Xa3BJDoaS98kHtNuLd03U8BFU4vChszMFbQ6km6?=
 =?us-ascii?Q?iLWdVUccyXrE/mLe9qzigDDIQ8l95En/dJ5PRyaOnO5a7QTNG6WfM2Vbff96?=
 =?us-ascii?Q?+eVQFsNVDwqvnZaf5t2r7IyWrS4GH1w70j0RW7XsCZGtaovqNEn9eLQtTira?=
 =?us-ascii?Q?0vgS2jpPr1c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:36.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6b4c2e-3a23-4cdb-143f-08dd528e8150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
PSR-SU may cause some glitching randomly on several panels.

[How]
Temporarily disable the PSR-SU and fallback to PSR1 for
all eDP panels.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3388
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 45858bf1523d..e140b7a04d72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -54,7 +54,8 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_PSR_SU)
 		return false;
 
-	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
+	/* Temporarily disable PSR-SU to avoid glitches */
+	return false;
 }
 
 /*
-- 
2.34.1


