Return-Path: <stable+bounces-118618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766EA3FA6F
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D3D8662A2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F42222D1;
	Fri, 21 Feb 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPUJtpVQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA4221DA9
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153480; cv=fail; b=lu5CZ0GdEpWPaYQ3vgLaJIYNBlI+EG9X0JmVk2imR/lN7GMDCS+mkfw3wn037+LbqY2e5iDGuExyxgWpI6nwnU5q/e4fuavVjOQTb4KbALAzpAejS9WwmS12i/70yqYUIgYKDe+CVQ+/arlmgArzoac8FiJ+xN4BAV6HCSPR0bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153480; c=relaxed/simple;
	bh=NTmtifc2geJUpHgl9oLfPoMW7dP1hXOaVVqUbmLfLu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr+nSeEQMNxZemdZcvcNYoHb9WW5r6zxXD3Tck23F1WRa6FqkQI6DC3/LxBSL6bIiovVMsZo0+IGoITDlCri1RvyVVWCqwAUZX42LLxf+XELzn9Zt7mZM/EUpMLDtNrbfK7TX+mNkM5720PPHLTQqkimmfYpVJHAJL1UCIGxyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FPUJtpVQ; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIWWYCrT/YI3dnt/fXmXX6oMfxMCaMOEBrn5BcUEPdbYc+fLW3PN5Inh6gYPMsmIgb0oPr+ZtLLC/Q9T608M5Hqu3xABdg43hLYag6T+JFcp78wAMfgy3qD388JdBMPggSbW8ABrf1k25cqXbOA+9E8tl4DQYB6ggFMf18awMaBH2idtKwrF1ieRlL1AdpeJhR0mXVJXas6xMHIJDckWatg5VZ9o2PYRErZmVSMrOi621lAap8/FXHn+5XkmNTIrSrkNvTKptfSMF47A2bCD0W60BAnR+W4G12Ra0VGBvN3AL3dYNSE/pIzMwiH17Ezv9sh7ocFhzJtwDH8C+mcoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=v1fr3hHslWwxmi0z5q3iOKa9rZZynT87YMck7Ccl/KmK2D2oCrGESMt5p6K5OHB9Hm5isFsCiXBdqusVkxDFksSzZ9LQwgYRDq3veztusYqbzpa5YpBvDFc+mWP5MMzy/kEho5seRpsD4Lvf8u2BhJPwFu5DxI8740QlGHBMJsKlr4V0RbfCjrkhKe+/B1uOS2pOig/aeucXd/94PG0jTqKuNiVOSJjWuSM8TG5rXzdjTYdAoLcxUcu6Ojdnxgx3tmuaJ7uVunj9+ujmpU/s120m7h19/yKDAvX4ogPDQiNEF/tUJyRtVckNoyBwXEl3fxZn9ntu6hCuJaoNBUixOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=FPUJtpVQ/4lUUBirb/VSKN6xPbZBzl8bonk+SFFhhiayUDNZc4onEJk6xGXcilzPhS1Z4nO9DbZWBmpOT83DKC2/LanjJFIHcLcBLtfRBdTQbtwKh06u1L9XEZ+lDfESJCy8ld0dJ9/5/v47/cavW5BfTy6Q4Sf0Rn557pfwP+g=
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:57:49 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::6c) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:45 -0600
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
Date: Fri, 21 Feb 2025 10:56:59 -0500
Message-ID: <20250221155721.1727682-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: ce488867-de5e-4d44-c070-08dd52907d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nmcf1gCIFlmsIl3O57DNVH/Kn1JrNG/Y7Ho9Q2DNcoXnY08In2c8+4Ylsq/f?=
 =?us-ascii?Q?5zA/ZWO7sG7AV4glGhv+/9cYlUA4LRp5ZCrb6CuLnWvCbYcOtfpZmmn4UvGu?=
 =?us-ascii?Q?YUvfM4qMzGHkqksgRtptnRJle5kXqET58vUqA0Q1b4RaRWyS/CTwt1w2xZgg?=
 =?us-ascii?Q?nzxFHuZgZdJmNiP1TcpTPnq3HbFMeuvt7ZM2WUn6auFQx66ZEwvGLReVrLhG?=
 =?us-ascii?Q?Ur6rqX6Pftr9yJlbAorZP+fI3eeTcVFg1vUJ+FDSZBdds6FtQRwbPTUhC9i5?=
 =?us-ascii?Q?MhT1GCs9Ad8E/C1xBmi1iIasXYjhIKQ6lKaCBaFD8kBrDCkD3z7G0PbIjiBQ?=
 =?us-ascii?Q?qRGfo5Q/MvLeJfrZ3nIumo80rP5IKOP8hBssQLS9ARvC+ej9U3ICKJlHrZ8A?=
 =?us-ascii?Q?60RmMwLYur0LhT7s04FmsAfPrEPOxa6TCU6s4vovDyO5uNG+PJYeTiqiAiMl?=
 =?us-ascii?Q?VWOcTkggtej4DyGXPgpqa9smKQVHB8abg+qMkJsPejBDeetbyYAV9BJSw/g6?=
 =?us-ascii?Q?zmiFh/jlmE43LienTV2k0MtcLc5NUFyQgph+Mo96A3GurKlYzv7KkxXGFE/f?=
 =?us-ascii?Q?FrVqBAO/5kvysHVpm0Zn4NQOgN5J8ZZt98+OzjD3SobWY6X+fdvc1AYYL8Yy?=
 =?us-ascii?Q?rtyWDfhuX3RTp5myzdozMjsVwDN4nx/jKqXtP4zIMSfAbBRcVFH3SHWCDlXE?=
 =?us-ascii?Q?K3kbHokJ8so4n/0xDAIcjUhIxjYBA8PEFG0AMAby/C/Or3sdD8dY3M8LXGsI?=
 =?us-ascii?Q?duNHaL4m2cv3c36oO4s37k6X36+xFnRcMzTZSrle/7j1ZCCrfvr2CdOT97ux?=
 =?us-ascii?Q?n7ydFCwFjlAAy3JwFH7fNJIrzt46ogZvB9LWbQhhvpQqHwC+C0v70/8Avz9O?=
 =?us-ascii?Q?i7vpw9yEatQYcpfs3FUEhnqmTrPIq3YzWTMgfaK7rGNbk3Ii+i8x97rRHcqv?=
 =?us-ascii?Q?XXP8OHVDrnGy6l3hq28r4t7UgcbYh7iZT1qc09tk3PH1KzhYMiYW7HPGfJLm?=
 =?us-ascii?Q?GIQoN6T5rmcSwDm+7UsvCOKahMG4a7mkEVoBsRSrRIj5sd9qtvymjQIjSDVE?=
 =?us-ascii?Q?hfV9ti0E8sEDWe7pTNrnY7W/LIgorrMD887DJ06g7ptvuYc2hnSKIOv/NbJJ?=
 =?us-ascii?Q?mGUn8QowvqF9oebGZpMOVQOjxZUNsZPnb4FBFku32djDFIR5qcQt1tItTCiX?=
 =?us-ascii?Q?PtFai6HJyH/K3BCX7NSpwUNHvtNJdoY+XYD8ylNS1/0KjdpC/wXN46prPs/h?=
 =?us-ascii?Q?ke/rvv4QuVRwu+RHNur8EobyGlJKfrqajDkEqkmXuVtzbGoOVl5uybIK/s06?=
 =?us-ascii?Q?zJZ/hPMsSDOYtwIs4cxfj88AcMeuB7s4GziQBsvSmn9M1/lPh5O8zsG0akYd?=
 =?us-ascii?Q?mqJ6P4HOFxnJduWsnuuSZ6t7KeoJTrhyIQqpfhNGf349JW8RmwD3GVd9rhCw?=
 =?us-ascii?Q?3G6vDIX6u8A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:48.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce488867-de5e-4d44-c070-08dd52907d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

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


