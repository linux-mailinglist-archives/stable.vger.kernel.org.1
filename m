Return-Path: <stable+bounces-144189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23587AB59D9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BAA4A60E2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAAF2BEC5F;
	Tue, 13 May 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Jnl/7I9"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FB2BEC5A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153775; cv=fail; b=hHK0dRcvTJ0JDfQDau5zKiqKfCmKgj+jafcQHdisl+XVM4VgBTsmF0YkotBZPq8LQyYKFA5he6dCD5AIIa+4Fn9dAkBUcRMoexT9GtX5Gi3S1euZlgg7n+mR8iNemMdFufhSirZYigjKlu1OZmiXx/lQFZNTEJ1JwXu07UI38AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153775; c=relaxed/simple;
	bh=dnG02mxa16OYPxwpsG8/9iJr6F2qX460fTi8h3Qz5FI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJHySlVrFwOFgQi5lmCclZYbfZwvpvjBTBrBPmrASZOlBDIqc/h3vvGf7NQVoII7O1DbO6Z3QRA0Hbtx2cXzNDCfpDNhsNTOfgpVhZTMmrefBt7sCV0Yi71LDZfG4wtPqDwcUI3qv1u5sicB+ra2UST9D3rglTyTnA7y+Whp1/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Jnl/7I9; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9SIgUm+8eUOjfp1bmcR9u286us1sPkp7hXvXWsjBqen3Uvl8l1g9a7Saam64Q5RIv6BsW61OPmZ56/9B++ZYcq13GIUtSaC7wfIso0yWPDNuwQyOvOGS40/VP1r4Zzv4BV97QcGalwtOQTUxE1jUPTpLiH0UxIAq06vQYBbP9lGzxMk08RYRy1aX13ZFKPPo/mLCFQ7edHyfR/18q/vX7JDXeQfet3tuAfuZl7PkIkf6fpVHsTL/MVGin/iTk4armn/+9epGIFfe5+BXZ3UpGC5P0RtoKii50PfJ6ObPsM7dZBgnYqKKB85PI+PaBvUysRXLTREIuAQUrbez8Rgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s+OUUGZ5HwfJ1v8ruDBrA8NOvPvQtIGI41qEZOkCM8=;
 b=Kwm+/u5WABGnzxbS7WLzkF9F29au2ObSmU/+szzJibGD66Xz/uGpZ4PoNHWF/gck72o1QvtRFNtFaWe/IWddN5odVMYTb/G1wipV7IJknIFj9HdVbsbOlmb0cZ+c/zVZDTGfexphwqHEr588XsWJV8OCzzb53//WNTnUcM+WVknSkl8cxYkKlEAlZrQIqeldM84cqPpV3/OjPZN7llXeZlB81rkQ2pcNpWQNu0EOGkukLpJcv3NYzRNN44/RJys8KFh1BGRjeVvhJML4/rDFHEQAQ1Ul7GQLWztBE89R5JiFZpfChX6QJotkI4njESkEjJ2yARak/3Ly5Sj1CIhENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s+OUUGZ5HwfJ1v8ruDBrA8NOvPvQtIGI41qEZOkCM8=;
 b=1Jnl/7I9EI/iOENvO1+X7whHi151SlxF+7yzd3VPzQXFAMLsBa7Y/ow/hDqkbzk7MnzkANuZF7LiPheG3oU5yg1Z+zYfja5JesAsvFsArwgGyYxkK3/Une4LlhuRMFJu68CzTKPHhmEiv530/XyUeXc4BdYr3hfLiEdcfmml7L0=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 16:29:30 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::25) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 13 May 2025 16:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Tue, 13 May 2025 16:29:30 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 11:29:26 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
	<ruijing.dong@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/amdgpu: read back DB_CTRL register for VCN v4.0.0 and v5.0.0
Date: Tue, 13 May 2025 12:29:12 -0400
Message-ID: <20250513162912.634716-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513162912.634716-1-David.Wu3@amd.com>
References: <20250513162912.634716-1-David.Wu3@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: b499bd28-d4b4-41d7-cd58-08dd923b562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xtdBVZadBV3qXLc9ymMzNG8WUq+NPqJK/qZde3deT4b52mfrqQ2SkwC0A3wY?=
 =?us-ascii?Q?VrL8VQ7d7nYSj3gYZrrpof/CMA6Kp+QMtAzbybYHvroAnnEI0dLZQfGvbnph?=
 =?us-ascii?Q?RSdhBNNvZ/8gc0uU/ee55agvV7bLtbGf1Q2EY1ZZ/lI/BgQdLayCDUI2K9Yt?=
 =?us-ascii?Q?ho3U4tJxAcnPEFYEhLbt/nUkzmDoecMs/eDRPP6TOMQ5m66eWNDcvUVkquQl?=
 =?us-ascii?Q?EwDBGcFDwZQdYtMjOVqHXJ6X0xctdvb7fT75H7+mlIV7xvCe+3gnzOYadxVk?=
 =?us-ascii?Q?zUy5bOtHZt8UJKsa7ug5Na+NF/if1q7N6KjvrzbCut1CbXwtXZKPhF1qzTN8?=
 =?us-ascii?Q?YCR+h6p9KZVq0VH6n3Up4zgCMMDDfV6yrzsiPXE604q5ak+JSieVKyzE8VyU?=
 =?us-ascii?Q?KqOhrntYY8NFm3HoLwjPl4HAmi/bX9BOwUkhrRcXfh45YoX/K1ZNMVWkYpNl?=
 =?us-ascii?Q?a2owqXZbAo27/Dr+9w5F7W4A6gHQYMBKSumpDseTSRNsr7xs32x8W+UkL8Uk?=
 =?us-ascii?Q?9Y2X1H5siLRV5Oz3ZTcCwFLHIbzY80v4eGZmo4e1PrX88ZVQW+6ostOk+d4Q?=
 =?us-ascii?Q?DsvfkJnssy350SkckoOkPeW1d94XMfeDE3yjJDcKrV94AVhMswpcTo0gGc2c?=
 =?us-ascii?Q?RR4r5tAfA/Ax/wFbMgSgwmdPTcPmliE8vKCvDUsqlhuom8UIolsgWrFxrZor?=
 =?us-ascii?Q?kj9wpDIUr9MBl3aQ2AYY02tEMVmZEdagrXfxBHkkEmEdvFFWTeKGnbiDCsDH?=
 =?us-ascii?Q?S4Y/h0ogMSVRPqUXpH3wTnaHnJhsOIVJuGXj5PnNssUOXSbuXXhYsa2y/zRe?=
 =?us-ascii?Q?TKSNiquSLUhG9Bg05AwOOiS90WA7/A0shbogNa9qo+42CMa3tF5BacwNz5DY?=
 =?us-ascii?Q?IVenkRa40F+h4ZTMp5JrKsYOWnaeEGfWHEy+oXgJEFh7C2njZg/4eP2dni2B?=
 =?us-ascii?Q?O2RqOQ1lrGqmlY4bFIocnlRy8hbU5OpcmPBcA/NceQYNPotOrF0f1g7hUI7Y?=
 =?us-ascii?Q?3b7sVj81jNerMjJxttHb7dkUa64Mo7t7KGr43GceP/GevM71OwM8gnFRS2QS?=
 =?us-ascii?Q?Rm0H+nuPTzW9DwboiL5mqdlAJVUYHnGvXBAZOqLjYuL4Xg0gfjLAfX2ERljV?=
 =?us-ascii?Q?PB0rxfZOs5ZKePTbVhm4ZWvqUDIhfiWno/Kev0DQV9kkm6weN4xcnLneHQlM?=
 =?us-ascii?Q?zsfiS3GrMzreA0rCyCPIHLSaLIbuiiUFYRHRGFUaheGNb7dzGVGlHGsldI4K?=
 =?us-ascii?Q?wwlomDhXrdMNPSm39zJwWeNufew2SeyJk8sIAxJ1HHI/6/sImTOQ07nWnLq4?=
 =?us-ascii?Q?0bl+TsV/g91rpqr6x50gyZ3UX/3SoF+KKenMxO9as/rgzvDri6cU8tyAPC78?=
 =?us-ascii?Q?jQdsxU7gq0n+Lg90J+kw2ZY+c5mMC3bkTGJJ5Y7YMVSByW5k3hKuVILjywIY?=
 =?us-ascii?Q?JkSse/rXT2grkMoy5/1sY3tL2xwyMuUZ/qOMg/4kGy6xCwLeydTuy3ShAjJy?=
 =?us-ascii?Q?RhOfQ7XHtpNTfmuWlg3F5MGnnUfbAgHGcSjo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:29:30.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b499bd28-d4b4-41d7-cd58-08dd923b562b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

Similar to the previous changes made for VCN v4.0.5, the addition of
register read-back support in VCN v4.0.0 and v5.0.0 is intended to
prevent potential race conditions, even though such issues have not
been observed yet. This change ensures consistency across different
VCN variants and helps avoid similar issues on newer or closely
related GPUs. The overhead introduced by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce87..24d4077254df 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1121,6 +1121,8 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
 
 	return 0;
 }
@@ -1282,6 +1284,8 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
 		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		     VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
 
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a73..d873128862e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -793,6 +793,8 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
 
 	return 0;
 }
@@ -925,6 +927,8 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
 		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		     VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
 
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
 	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-- 
2.49.0


