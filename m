Return-Path: <stable+bounces-118612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64760A3F944
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C0A16C25F
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434D1DA612;
	Fri, 21 Feb 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZSmNX3Xy"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628C1D5166
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152642; cv=fail; b=pDkEky9MjF0qLRJpZd9UdXyiZpkN0dPRn84J3VhEXZltMFJC190a+7TzzKUY2ZQR44jejPEttvo/DANAtxhwNQ0ggIEgmK3E6UgUMJ0Av1rPSldnQWqXaNKoEAVa2/wsRP9eGJxFW8B3/ft0/1y36oRsSsXqH0JJVnx9SVu/I6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152642; c=relaxed/simple;
	bh=NoteaBkDi+g1UwWe/J8AdVnGgz6VN4bej3Z9kIYaTa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJlFxJL56ZOesrPuOup3RFVq/NLKJnhqq0zszwUtFrMf3qMJ9x8uBcIIxcPJL2EyZwyu7BpgPZ7azeUIlWqr5ww+Ofb2kTtIniPz1wyJkOsuE7X+5LjkVsQiABLe0+yfOxbr+kxrwNDyJycRaLx+WEWSY2uQt1fCwRDHi0H1FR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZSmNX3Xy; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFTJBNlD+JmXEpYRu1rJCiW04fcsDxt6bZGSw02OvZrbEYSiNwm1dQP3ErnK3s4zAq5QyNAbtdG9myRJz+7n5GzkuSwEKlicQwqKr/iSscjn3M9BSZAznILY8U4S+2RIg0UIuZD1qfbZmKnNKxDyyi26kLBUrgtflAJmqTHIbjzfgbIortWkyGWdZKF6h5J3Z55arNeV8N/y6X/gK7jxmLC2Tq9GWUGq5mLPXwbuk5dfUZHdejwC0nTo7LqrNMt/O6juVdgQGJFPA8wWb91hzxEY/VYfIM7yR5zMD6EqaxoNC3hKGFBxpumQxCQLNSWbqy+pXGG7gKiW8tXLdn7uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=F+HlHIyh+8/AhSbfqXIeDkwFiaxZLZnKmjAuCtaFxNZN+QYG5gCKxkeleLe2xa5hFBbFVo2pba9Q+GSA3Ffa5vaR3I1yKotwitxoih9pIPn/5mZ0m+giks3IinrgguHoj6T7yEnH0lZotl8RIttjk3aSrli7znIgv11L2Axgm3V8ZzvVJDyrEpoQn8iI89HiagvJUZEl6fvcRHo/0ThP5Cf8ouEo4RfB1cGJW2QGwX4KEqgS1fVrJejbhu5QiNfvI2v4tESR2UhsuLgG9CPuR0KSiZN2G8Nx+TPq1GXNEBsFBUlJpKPoKqRmH93EzqZz6ZSxIfevMS+uzYOlNsbAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=ZSmNX3XyN1OCctrATxgFHsvkNgK93Wtr/Az1mZOq9GRvbObpC5GdWBHorYjJpaCB8YwnuUYK7oMgyzsJWIU+ZsEDx4jehmI9XrFJZ9akoxkWs99lUc05ceL4dlIIaz4Mor4/aF0kteZ5YQAP+G/aVZS9eu75Ho+FnQIh0/Cq+is=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:43:54 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::45) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:49 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Yilin Chen <Yilin.Chen@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/24] drm/amd/display: add a quirk to enable eDP0 on DP1
Date: Fri, 21 Feb 2025 10:43:00 -0500
Message-ID: <20250221154312.1720736-13-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: f690a7e7-016c-49f4-3594-08dd528e8bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhUCBh3130sKd32aCm7DtJCP/MBBhnXvaE/pcTBp1lmURYB+RzcxdDwtbruY?=
 =?us-ascii?Q?bqR8w61naFRxUlizbo4TCFJNiu//QwyPu1d3tnBPBvP+Y4Hf5eYvB2yyZww9?=
 =?us-ascii?Q?RcL0BEV7/1mG6CT36mGN1hR+C/NRd+ch2bG4rcJ6E/Ykh5typ35t36PyGA7O?=
 =?us-ascii?Q?wE0hDTHfMSbxQixTIQidz+DsxVFyn0oPS6rPgO5B5p6I0XRLwGnh+1fvJv2L?=
 =?us-ascii?Q?nV1EmTvddkddGjup2CBomFHHjbhZ7uEgGJahSOMgqAWwP5mIgtPGEiUJzwpA?=
 =?us-ascii?Q?/oSnGqJsIA5wCRA7WYfBok+098d7FCvO7l1UW65clEm+FeJeg5fv5XVOM6ZX?=
 =?us-ascii?Q?gYXJeL9Za6roxwCveQLiz83cAXaBJUjqWtK7Z3AudIOBdAFI1CJHrs2rrQCc?=
 =?us-ascii?Q?J+yF4QL5EMJorPJH8Es7E+5mMIkMeRg5XeaUcLcTFLGnYuFQ+OhC6NuOgxUH?=
 =?us-ascii?Q?m1v+rO/DVt4thwEWnt3IKRUS55QmoDHiccCsK9oPhcQcpA96/FLU6tfrA8SP?=
 =?us-ascii?Q?XALlOMTUz+fwpukqvuVcautFqfnIfUOP5s7ks7UqhbRCVU65UFDmszKLb10e?=
 =?us-ascii?Q?YBamAGQp9rRM57onD2bqo6mFSHz+uWo+DqN8W51/H9I/aZgHLzgGFJlDf45h?=
 =?us-ascii?Q?JG47PP/GEFfraTuYNckLmIJqiaMC/SyFdX0Rto1zfwDexUwIKulaJuRDEwwC?=
 =?us-ascii?Q?pobN1CjBEkLoK5ShnhHyNdrUgRiav47E0IDGWRYtEGtlur4P5W5WE77uVqDb?=
 =?us-ascii?Q?XLaBMkwGeWc7OcdBQEVqRj4EpyJc9EoJmEQXa4zinxfBQeKLIBB+1fhPnNf8?=
 =?us-ascii?Q?Dthr3/jvQmIMNWLjtmE/rfty34L9XM3b7Ud7GsTdBTS7ARrujas4YV0IKl3d?=
 =?us-ascii?Q?MV2GYy94Z9deIEtmPSEZViX/J6CRK2flUB4XCeC2RX8pGpl4r14oIyPSZS8v?=
 =?us-ascii?Q?2NsKwxPvOgFTs7BuOeVk1jGufXBafaZNIn2YTlfAU/c6s2ORAKE4bW2L5CPz?=
 =?us-ascii?Q?ehiGQuUTcPwpLcqiVUWUs/hU+hMqezbN5x0IXxgll49n3P/xhajCK2sypBg8?=
 =?us-ascii?Q?aYE2VXAWvT5MoN6G8DxDxqmL6BCCZuejh1+ByrU/xIXMobTrGSu2axJD7T/o?=
 =?us-ascii?Q?6ALt5IQvix6lh9sMItp3kGW35ZC6jtYNMwBVQKti3Smz57lGpaJHfyhFnTP0?=
 =?us-ascii?Q?nZXDOBEQgeRsxnE1HAE3CooTjXHdr+qJ/wGJgKReqVaYj+Th4DO6d1y7vBo3?=
 =?us-ascii?Q?aRpUSEVwp0HbBCqvYKREPTSfYUkS5QE8u1Y/IE1A/Xo1O8hNQIpUNkGngvo3?=
 =?us-ascii?Q?IkpCI4v5Tfez4mdgcS3MlxYwA/4VXAmFPB5+hTnNzeroJ4ncJkpq9RziXXbw?=
 =?us-ascii?Q?4Df20fXuKGqtRwJ7FqziqmmLSsq2xwBflyjHeELo6Tc6BBJq43bNYTcj5pxm?=
 =?us-ascii?Q?Z5Vnp8OtMcn23O9nWTCni5kAXkebAT4+Eus7eh3XrbEj9YziP9kKbNIx5Al6?=
 =?us-ascii?Q?b+xjTL6ntVdlnZs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:53.9362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f690a7e7-016c-49f4-3594-08dd528e8bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

From: Yilin Chen <Yilin.Chen@amd.com>

[why]
some board designs have eDP0 connected to DP1, need a way to enable
support_edp0_on_dp1 flag, otherwise edp related features cannot work

[how]
do a dmi check during dm initialization to identify systems that
require support_edp0_on_dp1. Optimize quirk table with callback
functions to set quirk entries, retrieve_dmi_info can set quirks
according to quirk entries

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yilin Chen <Yilin.Chen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 69 +++++++++++++++++--
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d21448ea700..9f53d88ad7ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1622,75 +1622,130 @@ static bool dm_should_disable_stutter(struct pci_dev *pdev)
 	return false;
 }
 
-static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
+struct amdgpu_dm_quirks {
+	bool aux_hpd_discon;
+	bool support_edp0_on_dp1;
+};
+
+static struct amdgpu_dm_quirks quirk_entries = {
+	.aux_hpd_discon = false,
+	.support_edp0_on_dp1 = false
+};
+
+static int edp0_on_dp1_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.support_edp0_on_dp1 = true;
+	return 0;
+}
+
+static int aux_hpd_discon_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.aux_hpd_discon = true;
+	return 0;
+}
+
+static const struct dmi_system_id dmi_quirk_table[] = {
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro Plus 7010"),
 		},
 	},
 	{
+		.callback = aux_hpd_discon_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro 7010"),
 		},
 	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite mt645 G8 Mobile Thin Client"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
+		},
+	},
 	{}
 	/* TODO: refactor this from a fixed table to a dynamic option */
 };
 
-static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
+static void retrieve_dmi_info(struct amdgpu_display_manager *dm, struct dc_init_data *init_data)
 {
-	const struct dmi_system_id *dmi_id;
+	int dmi_id;
+	struct drm_device *dev = dm->ddev;
 
 	dm->aux_hpd_discon_quirk = false;
+	init_data->flags.support_edp0_on_dp1 = false;
+
+	dmi_id = dmi_check_system(dmi_quirk_table);
 
-	dmi_id = dmi_first_match(hpd_disconnect_quirk_table);
-	if (dmi_id) {
+	if (!dmi_id)
+		return;
+
+	if (quirk_entries.aux_hpd_discon) {
 		dm->aux_hpd_discon_quirk = true;
-		DRM_INFO("aux_hpd_discon_quirk attached\n");
+		drm_info(dev, "aux_hpd_discon_quirk attached\n");
+	}
+	if (quirk_entries.support_edp0_on_dp1) {
+		init_data->flags.support_edp0_on_dp1 = true;
+		drm_info(dev, "aux_hpd_discon_quirk attached\n");
 	}
 }
 
@@ -1999,7 +2054,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
-	retrieve_dmi_info(&adev->dm);
+	retrieve_dmi_info(&adev->dm, &init_data);
 
 	if (adev->dm.bb_from_dmub)
 		init_data.bb_from_dmub = adev->dm.bb_from_dmub;
-- 
2.34.1


