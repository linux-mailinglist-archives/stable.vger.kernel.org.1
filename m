Return-Path: <stable+bounces-71327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514FF961445
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739E71C22BE8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327C1CDFBD;
	Tue, 27 Aug 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YIIMvMLT"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11A1CDFB9
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776872; cv=fail; b=j5hkv0Q2Dal9QIqWzBzsCHxbHzx8Rnzuq6oyidg9tStin/HznRqIh+b3th/x+TDk/db4AMzgISfSqAJulo45ZRPc8ZTVLsZbFTvy8sVmGYs/lgCMw3D6H0LoLgFuWwmBaAGwQm6ag9u20QAeBhnQ2KW0agtFtmc+TIy/W6EjN7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776872; c=relaxed/simple;
	bh=EzL6mvw1FJC0aQaKoXrQ5prbKJvHuNYbHApW6YVCC7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee/L0+lWSdySKzzfCKtd4YoRLSaTBdLqpwxZijNpMhulE993IeGMAAn9b+XE05mayzLgPXXAsGTDm1X598gPFKIB5a8NgVEJRh89ca7iglNMPpeUzOx8MOTT8lWTn+pDC0bUw4XF6T8QoT1F0MtW49dLwQcgwsMHXvencV76B6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YIIMvMLT; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB1OeFd3RXSKZiX00KuenrQuzf7uEHnqz08Pci9iBlj3pdgxmdTjjmUmL9uTPcCzcKQNKl3+LZ2N2ONNm+KJ7xiawn2XVnxTuLfvqQQvjVfGkaTdD9QytHu6xwF7zu+ZepsOy8Zlb6AGDEdfQ1+Ct7rPkCSx0S4u3637b2UCzIEkhVn5np46nwQvB+I/abWk6FdfAMT9OX3iGOm67hjyt1NsnJjQJkGTs7j4/oxFKhL/u30RUzj0JNBU2VAdCJIsx44dKvGn3h+Fl1h9FEy6llTlJmQnhVj2beKWUV5dVZt56GjhIeFhpbpy0TD4QgyigV+qXFgh14rqOOIpwLYyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnhBMlfRrFD+08b4gBUsEDgqFiu/gzYevcyevu6/vmo=;
 b=LBq5sikEb0u9+YHYTl1FA/MyNw1ep7F6gaFIHYdPNW/a0CWKkfJAgmOGQv/Ii9eMtwvhvUc4ez83pVKeQ1t8usMBxsDuvr1INVCSKR2eabPm5s2lxhx6jA17lGyehNy+F6WRpw5mdXArUt8PLmHlRPFrvBSQny/YC1a07S7+21RqdUDc4hFzR+JtoXSMN+nlPI9mKEmmMyUMeMsA8pK/otvJabdWgwQniWpTOIOuAerfNY0GXNg7T/GLXF2bIvpoI0uNFfXvwpVOMLXfnyg1cunfa+d+8hc9HaQ4eOL18zqTk00KqzKJAHh59YCTtDz1/9R3u0+D8IOzKMjhS0QMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnhBMlfRrFD+08b4gBUsEDgqFiu/gzYevcyevu6/vmo=;
 b=YIIMvMLTvWZzEHNRmWb2lrcrzToEB3eoGwBWv15Q9MvjQwpxZcwrShBxwEHTu1aotq1Sfjjm3Yz4v9mImCVif4QwJrE+4UCWFEDr5i6N7gz/UNYH+lv6UI/Xx+EOwhf7SVswwM7hS3QKWR0SLaoneV24CADqCvShGK5d3k3J/rc=
Received: from BN9PR03CA0636.namprd03.prod.outlook.com (2603:10b6:408:13b::11)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:06 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::3b) by BN9PR03CA0636.outlook.office365.com
 (2603:10b6:408:13b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:06 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:05 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
	<aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
	<roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 03/14] drm/amd/display: Lock DC and exit IPS when changing backlight
Date: Tue, 27 Aug 2024 12:37:23 -0400
Message-ID: <20240827164045.167557-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0b8a52-27f8-434c-4fa7-08dcc6b70c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eG3SH43CUe/B0AzzLfKmxAe3twvnjceFMOZLFN2f2dK1yLbFOCrpH3YMOl8M?=
 =?us-ascii?Q?USgd0KEotgOhUXl8Uh5M3hr8X+633ltq8/s0DApNUsLzNXX2ST024Eq2bA49?=
 =?us-ascii?Q?2JXk1s9C5SZCsHniKDoNGnaxCb9Pjnd56YrdIRHpv9dPrMOC1Dps0fuhCTIy?=
 =?us-ascii?Q?ztI6P2hYGU+qBcCtB7Exe2733/sAgn6Vbb09k8HoJaIx9NndPWi7le6u9gUH?=
 =?us-ascii?Q?JsqQuzSL34tPzIVfTGneB5rFKuoDiY91Mx/szmbcfmxMj0Uh3V/H5aBzIFhj?=
 =?us-ascii?Q?NCSVhE9xTvEkWfgr9RDq90IXUUKLlQe2QVkb/IHeM7AR74neDd5eEwchkZTw?=
 =?us-ascii?Q?4T1dxEn/OeBoxTu6ikVr6huy4RktReg0NO4VyNJpqI+6Zi8aKCSYql/MfEMt?=
 =?us-ascii?Q?lRL8viLMO97LrzofevpI1RNT96mYilY3H3znE1ia31PM/LUWI8k55XlmyL2i?=
 =?us-ascii?Q?emKXCwnjcM46zzbjTTCOHQ/PPMrq25v4K6QFRBTj6smdrVkM1BgdO/poiJol?=
 =?us-ascii?Q?HACz8kcf8NvRyYMhnoA5TPZvYExydQeJzTfeXviQODDmd4ti/qfcTdb6I1/P?=
 =?us-ascii?Q?DLFb3LRvKPSnwcnH6m3zn7HyU2ESkvToCyfuI5J4JU/6k3mB0gh1Np6sqwlF?=
 =?us-ascii?Q?9oXmufZME3q8ANpMuNVn1tvHCQb7PgPeiKtMkyjGFLGbx3HEATvAsKXxectd?=
 =?us-ascii?Q?XbneN9q6WkMpPWAH348rs2d3uDTVlgTPXQm4d3VBrMMtPlmlKsyI9e8PoJTX?=
 =?us-ascii?Q?HR4mqL9PEE0RlOwlnAXbW71zLLcc1vzXN2a2K2n0j2yi99Bj6tBGxC11+/gt?=
 =?us-ascii?Q?fJcK817CF/efkgrmV4ZtGyrYoRVR0y+GMcwXj9Mbokydsjt7Slp1ukZk4YDE?=
 =?us-ascii?Q?9dhn8enhvtrJHZhEFuRNftXnxB8VxGhQ4ZMok8UA8zvpQduSRCEgx37EG5Uf?=
 =?us-ascii?Q?mR5n+eR4E9bEaE6bObPOYEVEW04R5feP+jaguTUlR0ZRYpnHgY9EcFZLzor6?=
 =?us-ascii?Q?KzTquYRjTvnTzN451UvtYwXCmkdpsjbJkSaIyVC2iJ0kfhxts6IUY3MtACtq?=
 =?us-ascii?Q?3FgfvYV9XCNYCkr41gEftW+qJIeR+MBNfGH8L4ha0kPn+wrZ/9JbBQJTrHCc?=
 =?us-ascii?Q?9+KldSeFDADCcwqGsjraBJpG5i234F3rZ3GodXYG0455fyJhsC5gIjPrqBiN?=
 =?us-ascii?Q?DmjTTZwW4vsKfuBpmNyehwe5Z2Q667q7+K/xoH9gdeI/EjKs+N+8XlZOx5bS?=
 =?us-ascii?Q?P2n4M2JlfrgqH9rafAjgqZZPiZRsg06242N9+eONIzlw1o/pcyrl3ue7SNLY?=
 =?us-ascii?Q?2jvq9GB1fq2BTBPpJQ6E7S2MNwGm7hTdQjqAd4dIjDKWyzi/UOVsRSNN8VgC?=
 =?us-ascii?Q?enU/kBIHOPPSbNqd9tGnq/2uUtspVZxItWQvrazkSxAAgF489mppRZUXVlVp?=
 =?us-ascii?Q?Sh+e/rqqMLcd9dyAIvT5DXznunU6XOJs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:06.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0b8a52-27f8-434c-4fa7-08dcc6b70c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

From: Leo Li <sunpeng.li@amd.com>

Backlight updates require aux and/or register access. Therefore, driver
needs to disallow IPS beforehand.

So, acquire the dc lock before calling into dc to update backlight - we
should be doing this regardless of IPS. Then, while the lock is held,
disallow IPS before calling into dc, then allow IPS afterwards (if it
was previously allowed).

Cc: stable@vger.kernel.org # 6.10+
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 351f8b0fe7a1..fa26b8d59f23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4512,7 +4512,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	struct amdgpu_dm_backlight_caps caps;
 	struct dc_link *link;
 	u32 brightness;
-	bool rc;
+	bool rc, reallow_idle = false;
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
 	caps = dm->backlight_caps[bl_idx];
@@ -4525,6 +4525,12 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Change brightness based on AUX property */
+	mutex_lock(&dm->dc_lock);
+	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
+		dc_allow_idle_optimizations(dm->dc, false);
+		reallow_idle = true;
+	}
+
 	if (caps.aux_support) {
 		rc = dc_link_set_backlight_level_nits(link, true, brightness,
 						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
@@ -4536,6 +4542,11 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
 
+	if (dm->dc->caps.ips_support && reallow_idle)
+		dc_allow_idle_optimizations(dm->dc, true);
+
+	mutex_unlock(&dm->dc_lock);
+
 	if (rc)
 		dm->actual_brightness[bl_idx] = user_brightness;
 }
-- 
2.46.0


