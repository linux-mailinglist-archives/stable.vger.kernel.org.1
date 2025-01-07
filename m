Return-Path: <stable+bounces-107864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA334A0447B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08E51884FF2
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8DD1F2C50;
	Tue,  7 Jan 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctAylwUS"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34B86330
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263797; cv=fail; b=QsWgI11potnEqutwgiZdjZfwi2D23fEK40z9ccuqLelMr45iuEAYlY0RVbmIvF049SbUbMU3ig+bfIylEA1x3k/H+212AR6l/1MiXEHPQCgIEeKoToqTRl/6tiPKvQ48Vx+mV7jc3nel9OHolDWCb9C6pru+TF/zLGTb+olvnG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263797; c=relaxed/simple;
	bh=ZaPtSYLT2sslTamXlvg+QDhSZjEUbWiR2qy4Kbp5dTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UR/oug0yWqyvYKFv+9OVTPzpkqQDeCuE4Sm3kBPpoAcChlqxuURIJ+rRlcptY3m/yZ8Ke+cqGTL8Qc8NTNlkdRvrlDw1jcgLLU8mn+DKik1GCYwNKlswXo5qEw189WcwPrc8vwwQ4bf6J7fSU7BOKSXByUofVuAWF3vJCJZqF80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctAylwUS; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRYJHFjFG+U5REWdhLZHWKYc3AVOUNsxgom5kCTaxHI7zxIXb5Qz53QgEofr6+yQMm2x/krE8H2TljoH2alSzyF+/hZ+rO88cR4MZJYF1uQDCL8ojkWJuLtFeC+ZOFxjsDZtfvEvPPcND3CYYDqQEmiU2QZiwNXGSMwg9etWfT9HhjP6dEGsDetB77iDSIUWy15a9hU32D0pDi6bZ61dAB+pwQavfrYhEIcV16Gi1mV2hHlm8cqV5PGssHYoRssyKP7/Ptm0J/pW6HCjr1fLo234ZE46IpeatDea5NkIXO+G/MG1AoXN+5YqA9y2tyHJww3gZgyfRw56QReQve7BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=894d8/YoTnXiixowWdBgTCWKogn+VIkkmyi+ItxsVzI=;
 b=BfGYuEFP+kKMWJd4iTZvda2OU8dN+7Ua0Ir/eld7NOpoIVrVnF4X/0xp0gSpdaX8zfcvpEfIFSESZL4ivDagfe5GYAFXDJn0sKDdI9wgMiqbdMCbXDUQhzbqS4lc6nR4LRdSY7oUQmP7rn1fFjw1KnPAHSChov4o74fDxroUIO/1+C/BOxTtUneIN4BcQ1QlyG5vevXSQUFW5NM/nLB+4ew56PR+NQMFEE6vx18SGyFg/3V5Gal9jE0GqGztaTy82skQEGvZt702ybYEXzafPWUBe2YVtbsjl4063/+Y2FxAV9wg8PjiCoixCDEc0dSBPHIqa04icjXQF8OAaOdIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=894d8/YoTnXiixowWdBgTCWKogn+VIkkmyi+ItxsVzI=;
 b=ctAylwUSFHwqj0nONkFgz9k5NFoyTOyC6CI7mmb6zp8njxRtnpC506HJRfynegX7b+rcDv7wHplwbwHfoSH/Vbake/I789wCqq8THIpaeRsdlcz84+ur93eKH6UrROyUjuD/2JrHo8y0lnmP9aOwUTLG9RAsj+8qf0CtxNZFXUE=
Received: from MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::27)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:29:46 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::8) by MN0P220CA0023.outlook.office365.com
 (2603:10b6:208:52e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 15:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:44 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:36 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 08/24] drm/amd/display: Reduce accessing remote DPCD overhead
Date: Tue, 7 Jan 2025 23:28:39 +0800
Message-ID: <20250107152855.2953302-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d54107f-8ecd-44c0-e9f7-08dd2f301dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jB7i0i/c+8aRu8N7hjw040ysW2hBDWWFp9KhWmEXovxU95dhTT2godWfkWo?=
 =?us-ascii?Q?Qd1noQ5r2QwEYEv6IboZg6knTHAD0AQ9FDmM+37Dic5JOAce1tFtlL7pe4Uu?=
 =?us-ascii?Q?x306iG4V+2xK2unpUbYFkYM/mZWZBvsgb2ukYl03SWoUySW9kHUnT3CfEqtI?=
 =?us-ascii?Q?N3IImvgAmeeNvG+riYi/ppv42ED8I6bxksXtw1Oh/gExLYAV1n7vXJCFFKFV?=
 =?us-ascii?Q?8qlOzVjLlgPY7okuSJpEq8szRQFH6vKxmf/J6d5AGYgQP9U6ZiksBoukkFNI?=
 =?us-ascii?Q?2kxT7foJdtpivK8urCQ/CEJUPhPuUIYJVusqCeWhx9HnBeu6qQeFJzTuKEc6?=
 =?us-ascii?Q?4PdTs6KNIP0Zk7+uCKfXlwQ4IsyN7InNu3RRgSLi27j2/KKtgPHtwuLW1KGc?=
 =?us-ascii?Q?5HrsJ//JPg0r1+cGLABfs4coAaG4y0BqDYdrVeJQWbNe9vSzoYKi42vs/5CO?=
 =?us-ascii?Q?Vw4dli80I7Dlo1bH9zcMvyV+cnh/6DzSp1/eIyK2fKTS/iSLP1lxdd/dNCJO?=
 =?us-ascii?Q?yYfjrKwQKo7+/c3aUD5LgoO0GBLCrQCPlX57qVqJX7tPbGpvHj2Y4ryH4Uwp?=
 =?us-ascii?Q?bYZvOniO64O7ynzsOjI+vNfgm0JilSnzzaHa0RAJhGYgd4m3GNqEVdG+H5In?=
 =?us-ascii?Q?cwwvCpSRkAENeh9XN71squjCqly8c3d8smwz4zP0CZTvm7LdjaEBpMlHcdyq?=
 =?us-ascii?Q?784c0Xvo/kW52e5s/TMajpkvZzshMxZrq0XBGLH0uy+tdfw3nN5oB4Z516j1?=
 =?us-ascii?Q?7rgXleWnLBB6Q9jsHVj9maIwCeBxzxX8CZMTEayWOjFKCqs6golV48Kkw0By?=
 =?us-ascii?Q?jtVZma7jINv/ejDTgZ2pPfutbze915E9+6j8BRTcs/eN/VFDYN6VWlCY91qM?=
 =?us-ascii?Q?SZaGwOfDT1BqhX70hSs1rjFR/Ryj2/hgTWr2IKglBB7ItJ0Ukl0zH0bmJZHM?=
 =?us-ascii?Q?FmmNqxz/EwmTpQV17284vZMjL/0NZ4QtjnkCFVbzSBhLMA3hVQRC3ZLJArXW?=
 =?us-ascii?Q?yHWNB1PpCYWSuwChFokgMRYhU0N+yz8xtrbAMdgnRWs2m/aetVZ7/KGzoEaO?=
 =?us-ascii?Q?oEOvZxIXCyuu6BdicTYPnxwDEeSGG+ID0V45O1EIZyisOmInbLvM9Sacwph6?=
 =?us-ascii?Q?WoWQAZzHMKFZbIq4JgJxu7dE6HbCVWczCcZvh1/shX1P0bO2LiKvXECeI92L?=
 =?us-ascii?Q?2ZQJCSHff70QldXH65xDhf38e71Ochf54EzbP3tNSLggdytUItxCUb61HmWR?=
 =?us-ascii?Q?5unJ1s4l9GgEkuO/DGjvp7wI04iE7mw+C2byz1Z1g/rhKMcBO712oK4T0bzA?=
 =?us-ascii?Q?yYSiEVhvzhF/r9PxShCLURNnEjcV3Czki6gpP4mGOwCMfkSC9MYrb5Cgp2CK?=
 =?us-ascii?Q?JPyu/uDXXgvzVW51NMpJgCaE9hsZY55OxAtlHvAf8uL5zCQRE7RyU+Kmfn84?=
 =?us-ascii?Q?btNvnFBHxVI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:45.8595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d54107f-8ecd-44c0-e9f7-08dd2f301dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Observed frame rate get dropped by tool like glxgear. Even though the
output to monitor is 60Hz, the rendered frame rate drops to 30Hz lower.

It's due to code path in some cases will trigger
dm_dp_mst_is_port_support_mode() to read out remote Link status to
assess the available bandwidth for dsc maniplation. Overhead of keep
reading remote DPCD is considerable.

[How]
Store the remote link BW in mst_local_bw and use end-to-end full_pbn
as an indicator to decide whether update the remote link bw or not.

Whenever we need the info to assess the BW, visit the stored one first.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3720
Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 34 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e46e1365fe91..e7963158a147 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -697,6 +697,8 @@ struct amdgpu_dm_connector {
 	struct drm_dp_mst_port *mst_output_port;
 	struct amdgpu_dm_connector *mst_root;
 	struct drm_dp_aux *dsc_aux;
+	uint32_t mst_local_bw;
+	uint16_t vc_full_pbn;
 	struct mutex handle_mst_msg_ready;
 
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a504aa1243e9..e096fb562122 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -155,6 +155,17 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 	return 0;
 }
 
+
+static inline void
+amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
+{
+	aconnector->drm_edid = NULL;
+	aconnector->dsc_aux = NULL;
+	aconnector->mst_output_port->passthrough_aux = NULL;
+	aconnector->mst_local_bw = 0;
+	aconnector->vc_full_pbn = 0;
+}
+
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
@@ -182,9 +193,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->drm_edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 	}
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
@@ -504,9 +513,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
-		aconnector->drm_edid = NULL;
-		aconnector->dsc_aux = NULL;
-		port->passthrough_aux = NULL;
+		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
 
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
@@ -1819,9 +1826,18 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			struct drm_dp_mst_port *immediate_upstream_port = NULL;
 			uint32_t end_link_bw = 0;
 
-			/*Get last DP link BW capability*/
-			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
-				if (stream_kbps > end_link_bw) {
+			/*Get last DP link BW capability. Mode shall be supported by Legacy peer*/
+			if (aconnector->mst_output_port->pdt != DP_PEER_DEVICE_DP_LEGACY_CONV &&
+				aconnector->mst_output_port->pdt != DP_PEER_DEVICE_NONE) {
+				if (aconnector->vc_full_pbn != aconnector->mst_output_port->full_pbn) {
+					dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw);
+					aconnector->vc_full_pbn = aconnector->mst_output_port->full_pbn;
+					aconnector->mst_local_bw = end_link_bw;
+				} else {
+					end_link_bw = aconnector->mst_local_bw;
+				}
+
+				if (end_link_bw > 0 && stream_kbps > end_link_bw) {
 					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
 							 "Mode required bw can't fit into last link\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
-- 
2.34.1


