Return-Path: <stable+bounces-96141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AA9E09DF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50E72828FF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F21DA112;
	Mon,  2 Dec 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VVJl8vJg"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204D1DA11A
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160537; cv=fail; b=XucBHqWj5uNfKEO2T4MUTm2kX474nw8sO0S+yED265hMtW+xAMFC58BuoqLXal1J5ppLPlQNQOMdoAAyTkFkZJQRw9dZSE/MGArbhOxdRsaISbN89scsTtnMsLR4FeMQuNorXdDksOSTQE24znIGVUwzIqPCWtaO9nqAh2rDrlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160537; c=relaxed/simple;
	bh=R82jYxOKZME9dZCiOmEBGEKaJQYTHn62UCBLqu94pV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrdaQkgau5Klmsmso59gjj29yMthj3Y50SHSXiQLJSAK3XP+sMyyAeIkoimoMJVWILtm7ZqZovU3ojz1GsmWsT3kws+624R+/dfrB55t4KQ1hkTjKwuRuqcehYdtpBWUVhvSGKRXK2RXhpPleMZ5WjpPAYevcGQlb+klrIRD4d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VVJl8vJg; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO8/CBtY2eiCaaO7BEbHlFYGoKatbs+rcA4YoHMDAbouNsOH/LTWPWlVZoK8i8vl+QflFq4r1NS5nKxeGZD8n8vBCbeTAXNi978YNLlZxo3fsrlG20+U2zZ5gwEFAIHobe3CyzXpr5Wmj6wfBen5YnXUPOPlLkAFfiUVrdw/yXxxoZUuCG3k/+2TQusE7ya2pmjEg+RN8awdD1BIohOt1Mqn77wTfkGo2nZR/LI7N0N/5AXlJj51zs61onSuPaMEJJMGlTyob21A85fqofQWFmGy1mxqo1EgPsDWzXOdKz8D2DRQOXQ9miDVVSJ6Gm2r2rAgXgr7q3OQHs3GFYJc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtWdO0Nli+ocVLBKOltomWENlP2yPdN1rZs+2ES7YFQ=;
 b=bSgl98fzo/fd5VlVDGD9Vz6fdDEGu8slG2ePZaRJp81kD0fPMG8IoACk8xZSgjK84L6U6N4yWMY1BJ8LIS3qS6eqEHhvWfe2etQQZc5GeMQd8iGHbP3m7OnpY8h5qilV1iiCdWmWeiNs6OI33lsLAueIc/3cdIJwRxKpRPNRRlO4hEJ2VI4OcUHxL6zodbPMNh9RalshFSjUteXQp6kkHDXT90r/s0BXDHGSgs5JvUyIZ8s+RKKRgWs1WkVmJNVwToDXzJaQobA2FcRF10Y8TH4KXU1/F5wP8NFUXfjsHLAVJapSLnp5uzbhCGU0JIDeBRL5UrGh7kZZFGdrHFDuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtWdO0Nli+ocVLBKOltomWENlP2yPdN1rZs+2ES7YFQ=;
 b=VVJl8vJgRAMPRwERkvfxO/TZCz/lOZbJYur1aUwIjj2+OQMj4sf/TWnpIGSzwmTkec8XQ42fhjii7KLT/a2NBDOXkZnihLWjJ0wO7KtwT/UDiNTg2P5BhSTSe2zwNZvts5aOAmO+CuEtcUoPGoAGysCbBHVy75gCBDVelg0hCxQ=
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:28:52 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::62) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 17:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:28:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:28:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Mon, 2 Dec 2024 12:28:32 -0500
Message-ID: <20241202172833.985253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cacc980-934c-45ab-875f-08dd12f6ca3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DAPVSNL0XZD6gEM2G6BrRpNHc2153JwoeytyTzHWJIMzRh8li/C54rU+mrsD?=
 =?us-ascii?Q?EZj4KHT78x6DjfRSTbtDXTw8IHLG7QBMuujFF8S+lgcWQTk9kEq0sV/fxBJ3?=
 =?us-ascii?Q?XqMuzzNMXaeUWYJ+IPiIX5kvOjrbGzFaCV2L37ZlUu/fhno9q2fBFvPLcczM?=
 =?us-ascii?Q?k4ARpqEC79AJcGfLf25GH3afML7RemxfubAy2iVTjXsJjCNPWIfwTRHNQYMQ?=
 =?us-ascii?Q?gZuLAh+zHK7n9ug7XmqTaI1V3KmCapN+qqV24I7Gv1BVZiGub31sIn2WnggM?=
 =?us-ascii?Q?eS4tYfsQBYYxdX4Mcl12R/ayHUEap0arMrKL0cOq+g7TM4IfRF7MePUN8hgt?=
 =?us-ascii?Q?e9S4STNnUOJcedsW9RdzESM+0/iji867+bxdMSbAM12CFI/X70R4+L1Wv8I4?=
 =?us-ascii?Q?R0iIrhEQxndKIWF16sVHHou+ycywLzh5ET+NOdiZvt+8Z1ecRAbIyZGpgoTj?=
 =?us-ascii?Q?n3v7FqD9cLpsXSm2FHZHbGszpPtDqboWxWlhRRLhtSx6mWl5Zt4zNo8Q/Gvn?=
 =?us-ascii?Q?sWlWz2hxfmQC4NjULYqPuAeYQ4UOlNetqW16KPjE1nUusPLJx0Z2nuAs3pKc?=
 =?us-ascii?Q?6uEahCf1rMhUWeQCKApBdBEvqz76TJzCpwnd/r/zQaGS4zEUL90oWUlKXtUS?=
 =?us-ascii?Q?5UO4LII1uJ6AClJH43YS7bV91Bgc63/fInh8OrxipSmgxLIlwRZUS2PBTQ4x?=
 =?us-ascii?Q?F6ZaEqGS4rg5MGDNpseQICAZc8kzMTE+ngXwUMcMyG+ejBUl1XuWPIBqCaN1?=
 =?us-ascii?Q?o/UzpPgqjk9+kIYzwMS2CPN1hO3Q9zRtsVebEfPV2krV/IxWW3Niu8gApjoP?=
 =?us-ascii?Q?lEs8fMmPNKPsRwIzg4QFDblC4UohoXPYe2qKe2cJ7+9BAlp4jq4rhzhQoQ4Q?=
 =?us-ascii?Q?P4hfOtb5xR/c+dBOZ6XbEUuEF934Itav+xMb1dAZOHXXmfz+K8v8BUbR5vyl?=
 =?us-ascii?Q?Tf2vhMqnjCeYiEpzGGRZUp/c9Tru35DsKXEDACE01l1ttQH2Nh4aumnGsps7?=
 =?us-ascii?Q?a+9+CjZxFETR2wloqVVhCqqNgHrCp5xSqDRF67gN3PVPEb5QV+Nga7ANv/CT?=
 =?us-ascii?Q?ndst/9v4SP/AmrPO/PIBuP+iDCQnHpZk388EMiuMsaEiRTNwZ1xWVU1iUGLE?=
 =?us-ascii?Q?R/GKJO5DZ/U77ZwfwecrolWA2yHrGnuqur7RZXG1PKrqYvBPxMwLBbxny6Tw?=
 =?us-ascii?Q?HLLyalO/zTqcchXKhTLw5Bx1GtqtfKf3uY2xtNVE48j2coBvf1nD9Zyfb7xf?=
 =?us-ascii?Q?eqHwjmvF2HesCiHZt4VOrEuvlwzeSNheyYAOJLQOqir8oe0DRc1wOGkJ8mnG?=
 =?us-ascii?Q?vZli3ocudFBBbAx0+1nFEv89ka1zufx/8+YLcewwbOeymMcEGqUrcELKfJnB?=
 =?us-ascii?Q?uL2uEuQdLAN5KauljkyLbBHuaJ5e0HvBd6FHRcOwcEDWVoOiPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:28:51.9472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cacc980-934c-45ab-875f-08dd12f6ca3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Streams with invalid new connector state should be elimiated from
dsc policy.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
Cc: stable@vger.kernel.org
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a08e8a0b696c..f756640048fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1120,6 +1120,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int i, k, ret;
 	bool debugfs_overwrite = false;
 	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
+	struct drm_connector_state *new_conn_state;
 
 	memset(params, 0, sizeof(params));
 
@@ -1127,7 +1128,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return PTR_ERR(mst_state);
 
 	/* Set up params */
-	DRM_DEBUG_DRIVER("%s: MST_DSC Set up params for %d streams\n", __func__, dc_state->stream_count);
+	DRM_DEBUG_DRIVER("%s: MST_DSC Try to set up params from %d streams\n", __func__, dc_state->stream_count);
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct dc_dsc_policy dsc_policy = {0};
 
@@ -1143,6 +1144,14 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (!aconnector->mst_output_port)
 			continue;
 
+		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
+
+		if (!new_conn_state) {
+			DRM_DEBUG_DRIVER("%s:%d MST_DSC Skip the stream 0x%p with invalid new_conn_state\n",
+					__func__, __LINE__, stream);
+			continue;
+		}
+
 		stream->timing.flags.DSC = 0;
 
 		params[count].timing = &stream->timing;
@@ -1175,6 +1184,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		count++;
 	}
 
+	DRM_DEBUG_DRIVER("%s: MST_DSC Params set up for %d streams\n", __func__, count);
+
 	if (count == 0) {
 		ASSERT(0);
 		return 0;
-- 
2.47.0


