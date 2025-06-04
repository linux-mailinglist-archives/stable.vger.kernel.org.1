Return-Path: <stable+bounces-151460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0519ACE51F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5A3A3AE2
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788B213E74;
	Wed,  4 Jun 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c0J4LQbX"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAC20E018
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065915; cv=fail; b=PtT0Za7m7C6AXtAuD+dz8Ix2w3lrwVOSRy7Zw0IaFW1OotEi6FcGCytO2T/UTIJWUAkYUFBzxqTTuQyfYIen1tiuLRMs/x3LwihZRl0RFywVS1i5zjnFloVlTvsGbEJtVQm24B+7lrXDJvUIEk6wxzGYlIBF6t7kxRevav/F6sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065915; c=relaxed/simple;
	bh=hZk+JNLgHMqcLb3xpzvhzAkxrMmCRQm2Z7uJXNFwpEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7M691hmrZpHUBfPWXqb2nJ+jBoagJrt0G/aPwE6Vf8gGJ1eDh0gOq5AmlnrK1Z2hQk1Jn8rqFIBtbPk6CBZ4xX47RriM/WhG8lxHiDH6rH547pNYNVl6Dk5JzvfJ7GCkzh4eKqBUZNajh09OgEhwwYyGdTCAlaIdpv5JftdTEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c0J4LQbX; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4T27zOLAAEDrn/qOgK0dvD/VsYoVkO8fDBUT/lSu2t5DYEs5i+jRBudi347VyjxdIYbHrmtKnD44z5OtDrWouzit0FaJuhCRdfcZJNpOuupQe8dtff08BFH71xSMs41sSx9/+Yy3OnPBCCp9TzoyIuqLS3AqpDjWTFhL8TX8VkUqsyxTi578CnIKcc08RVo2c4ZGPcQ8RPAONperKVJCBzOShGvevoj42h/kupdsEHhf60i+zzR4SLAiZgmK+qtoqmzwQrpkBHIa6xpVg9jEH05znGuwCR0iI0uEJR5368gzSjI7vqiBue1ETszuZSGptIPGiAB8ImmYZfACPMuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC0BzCuhIFddkyPv3PmtbW0rhDQuuePMwf/J4VMtZPc=;
 b=Ql0W02egQW5hMirpCThNqq1Oql1CFbAA753U1dZ/bpbgn8a2/LlnetzkgUPrsgnIhu/y8Y5vEX0Q1U8Nt0qn/uSUb93jNANphkG2poh9eBwwydR+JNH06RmaH03jF6oMRt1uQc9KvZkVUVWd5CdyoNIsHXWIcUK6NeF2Fq8qyoVVur8LBU74UV80icvN4MldEWePOu84hMMo5Y62gsOxUU3foPL4jIdePW35ohV/vxjneKmr+xvAAKY12rchlg+/azKkx/VmGdIGXR/qdNVDOA4xHT0H7Xl6YqEy0XKpIQ8XNxaXpjqeJxgABxwfsqUQLm1e8LZhkMg2pacWjBcgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0BzCuhIFddkyPv3PmtbW0rhDQuuePMwf/J4VMtZPc=;
 b=c0J4LQbXixYwJlQpaTRV/CAiwaIeI3UWQYl4rTNw7LXI38q5QBOSbRz3QJcxQneOSa7F8SH7lSqYfdG6JZXHAzIXOm5kFkuYVKs5XfmSx9NqUO0R/ueQfGBSxkFLwhNX6cyqcggscm3EtiwW8ZVejb1Cd2VHBLulH34xCJTzz5g=
Received: from CH0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:610:e5::18)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 19:38:31 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d1) by CH0PR03CA0253.outlook.office365.com
 (2603:10b6:610:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:38:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:38:28 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
	<michael.strauss@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Wenjing
 Liu" <wenjing.liu@amd.com>
Subject: [PATCH 05/23] drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest LTTPR To Host
Date: Wed, 4 Jun 2025 12:43:16 -0600
Message-ID: <20250604193659.2462225-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: cc947590-e207-4968-3d68-08dda39f6304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZR7Pkl3c3hA07+UpwCoImf8zOYTTFlJ0finVpu8GChQ41KyxydyAPNTyRbW?=
 =?us-ascii?Q?gO4w7eClTVp/ZS3lJuxQ4TKZSd5aJrA6TLs6aZL805fY5sOjbkJZAPfq5gD/?=
 =?us-ascii?Q?7vAHaN/2ZiKetLvePv02/SOBLHJILTOEYfJxUClas4IZUNA4V1VZFnJPqXl5?=
 =?us-ascii?Q?9Qp46XXZn7gwmOZV06hUakUasyMkUKCuXjwF/WRwz+yEmHD2pa0xvbFst6ze?=
 =?us-ascii?Q?bEbNe6yjZo0lNF8XMWwYCUWi2u7P3yqkasNCLfGLirhCF6o9+aA2WcLp7lZb?=
 =?us-ascii?Q?T/YZK3RSFkrz67Tt110ugjYjh4OO9JYp9u2RjMprhydFrmw8R+YYIUMlw45K?=
 =?us-ascii?Q?nxeTDPPWeAU4Pkj6NUZdE0CTF6ao/JNiE/wuM9z3w5TEY5Z/3J4DNv5YaZ6H?=
 =?us-ascii?Q?jYTtU5+zv4zSMdtRmO1HCgZIBrzzE6aaWMR1eM1g06mC8YAwC7gR+CKKTfZw?=
 =?us-ascii?Q?6t6/UCz8AFlYSuwgC9hO4ywzG5FzP24OqY11eryJCiSzviCzSXRCvgIAe1nu?=
 =?us-ascii?Q?OCvalYgePZsdplo9vuQBksNDQFs8q/2laf7E9GeZw1PB/6duuGBYK3vcqJwv?=
 =?us-ascii?Q?yNI4mN2f1ZXbLUjTLtcyGNg4srMWtVn4/waLFbC2Lvw9mnFsHeXLg31Mj5FK?=
 =?us-ascii?Q?YlETnZ6/VCF8ZLPMwWvB/Oe7u2H/M3CYMYP5CCtyzryqWF3xO6Fw2nAQdJWa?=
 =?us-ascii?Q?ispK6GN9vcouxP4K5SY13da9kUPfh4vOryzXIlnYB2Q3QbpmeRvfKdD43Fn8?=
 =?us-ascii?Q?JDcrmca7QVmkka1UpkeYgxcDItCLFKndfGLalCf+VRD3AGUYk2oO+KEQRso0?=
 =?us-ascii?Q?3y4cm9NUja+0CC3KFTllu6vY6zNhL4bx5fg890Uu3EfHT9bA+uFEfHZeSUak?=
 =?us-ascii?Q?7GBHvSyTbLxzS6wgVSS5ftpeZ4Bs27iXNIEjBfVEs+kVXPtbt5zQnwF73ERr?=
 =?us-ascii?Q?fO73+lbwiDTxk2yX9BhKxw98FNr4gUvpblW8AktJ+SdTPMh/S968ERAEVHQ8?=
 =?us-ascii?Q?PEZtPARiTX4Q52d7QsjNAGwQPV+pR7CoZMSicQHvD344zjRG1MOGV33eakzM?=
 =?us-ascii?Q?xm+Ay5e6j9nxiFnrwcctpssrhn2m7aZ59An8z0/b9+vbx0HrWhzGVBs/04FQ?=
 =?us-ascii?Q?sCifSLNWSXuhEtHi9mioU5dN5gYvY+0scioVo3+VWy2QfUhmhyiakyILi7zx?=
 =?us-ascii?Q?5TMh6Aqm3esAEv+JXloCoNEC8gx9SOEM2+nOWPRE2wtLjUFadjTyIUh63L9s?=
 =?us-ascii?Q?6z5ybuGK2+2j0UfKyMG1VDQbBYK6bFlp8mk4uEOYGCi20+sjB1x0JnRGpNJQ?=
 =?us-ascii?Q?HVtP2mp+VPyEDChUlizB2LiAePx+CmGXIgFzYRbQIfJ6087Ps+1MxjvWKFPh?=
 =?us-ascii?Q?WPmv0SQtwe3Bg6uoXC7/+mayp6zhSHjcjTcjbwSo87ZJCdxyji/qGCE6LPJP?=
 =?us-ascii?Q?g96H6P4g6gE6+gRin+OyBlozgHAee/Dak4VMzbJm5pUYaMPrgHRR/LOHxH4p?=
 =?us-ascii?Q?HHIeeGSjjcrCH6xQPB5ibYMK3H59nPJA15qk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:38:31.2018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc947590-e207-4968-3d68-08dda39f6304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
These fields are read for the explicit purpose of detecting embedded LTTPRs
(i.e. between host ASIC and the user-facing port), and thus need to
calculate the correct DPCD address offset based on LTTPR count to target
the appropriate LTTPR's DPCD register space with these queries.

[HOW]
Cascaded LTTPRs in a link each snoop and increment LTTPR count when queried
via DPCD read, so an LTTPR embedded in a source device (e.g. USB4 port on a
laptop) will always be addressible using the max LTTPR count seen by the
host. Therefore we simply need to use a recently added helper function to
calculate the correct DPCD address to target potentially embedded LTTPRs
based on the received LTTPR count.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  4 +-
 .../dc/link/protocols/link_dp_capability.c    | 38 +++++++++++++++----
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 0bad8304ccf6..d346f8ae1634 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1172,8 +1172,8 @@ struct dc_lttpr_caps {
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	union dp_alpm_lttpr_cap alpm;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
-	uint8_t lttpr_ieee_oui[3];
-	uint8_t lttpr_device_id[6];
+	uint8_t lttpr_ieee_oui[3]; // Always read from closest LTTPR to host
+	uint8_t lttpr_device_id[6]; // Always read from closest LTTPR to host
 };
 
 struct dc_dongle_dfp_cap_ext {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index a5127c2d47ef..0f965380a9b4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -385,9 +385,15 @@ bool dp_is_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 bool dp_is_lttpr_present(struct dc_link *link)
 {
 	/* Some sink devices report invalid LTTPR revision, so don't validate against that cap */
-	return (dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
+	uint32_t lttpr_count = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	bool is_lttpr_present = (lttpr_count > 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count <= 4);
+
+	if (lttpr_count > 0 && !is_lttpr_present)
+		DC_LOG_ERROR("LTTPR count is nonzero but invalid lane count reported. Assuming no LTTPR present.\n");
+
+	return is_lttpr_present;
 }
 
 /* in DP compliance test, DPR-120 may have
@@ -1551,6 +1557,8 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	uint8_t lttpr_dpcd_data[10] = {0};
 	enum dc_status status;
 	bool is_lttpr_present;
+	uint32_t lttpr_count;
+	uint32_t closest_lttpr_offset;
 
 	/* Logic to determine LTTPR support*/
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
@@ -1602,20 +1610,22 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 			lttpr_dpcd_data[DP_LTTPR_ALPM_CAPABILITIES -
 							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+	lttpr_count = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			(dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
+			lttpr_count == 0) {
 		/* If you see this message consistently, either the host platform has FIXED_VS flag
 		 * incorrectly configured or the sink device is returning an invalid count.
 		 */
 		DC_LOG_ERROR("lttpr_caps phy_repeater_cnt is 0x%x, forcing it to 0x80.",
 			     link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 		link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
+		lttpr_count = 1;
 		DC_LOG_DC("lttpr_caps forced phy_repeater_cnt = %d\n", link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	}
 
-	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 	is_lttpr_present = dp_is_lttpr_present(link);
 
 	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
@@ -1623,11 +1633,25 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	if (is_lttpr_present) {
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
-		core_link_read_dpcd(link, DP_LTTPR_IEEE_OUI, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
-		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui), "LTTPR IEEE OUI: ");
+		// Identify closest LTTPR to determine if workarounds required for known embedded LTTPR
+		closest_lttpr_offset = dp_get_closest_lttpr_offset(lttpr_count);
 
-		core_link_read_dpcd(link, DP_LTTPR_DEVICE_ID, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
-		CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id), "LTTPR Device ID: ");
+		core_link_read_dpcd(link, (DP_LTTPR_IEEE_OUI + closest_lttpr_offset),
+				link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
+		core_link_read_dpcd(link, (DP_LTTPR_DEVICE_ID + closest_lttpr_offset),
+				link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id));
+
+		if (lttpr_count > 1) {
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui),
+					"Closest LTTPR To Host's IEEE OUI: ");
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id),
+					"Closest LTTPR To Host's LTTPR Device ID: ");
+		} else {
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui),
+					"LTTPR IEEE OUI: ");
+			CONN_DATA_DETECT(link, link->dpcd_caps.lttpr_caps.lttpr_device_id, sizeof(link->dpcd_caps.lttpr_caps.lttpr_device_id),
+					"LTTPR Device ID: ");
+		}
 	}
 
 	return status;
-- 
2.43.0


