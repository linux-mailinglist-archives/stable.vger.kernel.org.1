Return-Path: <stable+bounces-118619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226CA3FA34
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709991891D63
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36AC210F65;
	Fri, 21 Feb 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T0HEmLmL"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CA22257B
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153490; cv=fail; b=BVCgCkArLPf2BoAjV2qnos3aFxE7FRrYFIrIYL6I3r5Nl7jlcR0M4il43ivdKTPqbjIqHmZB/G68xMVs7Xj+2O/v8Ks2b2KShiclFo3s4j8A7RoQ++qLsPAh486q7fSjVVcJ+TOKdgs/uGNGM5R9TPEikjQhGOL5evIt8zijdXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153490; c=relaxed/simple;
	bh=NoteaBkDi+g1UwWe/J8AdVnGgz6VN4bej3Z9kIYaTa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBmMxH+TPC/X3kC3JbBdKkRXHV8U9QMuo3hvMAlMs4UEF9DZePqSrQvQ7ZcWHesapO6ELwOa61gmze3DOpwJDSLC0LS2WpMOYlz0r7t8Vp8nilWIKiFsCFELyqGJVUpTvwTOIB2whsKv5abHBnMj4a/kfmkp1q1mE3kD85JX2WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T0HEmLmL; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbYKrqFLrKA+Q2M8CWWgBxqrXpZYL1SREpaRliRy0mJ/KgIenzkxy6uRPX2ZfpxJu0Q2ab0XhcC3BRODJ5fdNe54Wsh+XpCuW1cfauLHfb8q5ng6l/pc6l0DarttWKw32j0+VEunyx0rpYwex0dswx35qq+nZTNQtKgk9JpyDJdf+GciB295DzvrlIcsxGp5/bc8FAXsDbILXxuf/JRqRHyzmtv8j9iWYkscZeEtCicxZ2DYmWagwTo8slohdrvIAFmuSgLWGlCPD/7x29nXW3ULrmr7Mf9E+KDl3hrgWxB8gxpMO081cZuyGVe2u+x24oh8Z0vas34dEJFq495BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=DwJol1D5tZDBy1GmX179yd5du7n9qe4SXaVMTn/v55Eh+MSib5nRUDqEnxerY3xINmW8QJkqxET+T+fpLbseMyQMACoWVrTDUEu8Ueq/NancRStkqelxaS23iytjlt48p8IVdsLqFcxAY0qwIEMIUZeih6xW/6EZ59PgW2R/sh9ZL2nhe/yzJQAo1MMkmFAAr5kZwVMu6VyjuY0cZvBZxQomw8gFlpH5grygMezW5VH5aZex+O3SG8skO8fH5f6xMmhgPFeCeldHMpoJy5KcymCiU/QjRmnA8JC5GJRVwjiMMMKyp3qTJFb6mtmSfXnZMXZXGfhE7hTva6+ttftKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=T0HEmLmLXRKjbuRJ04pFYBij3jk5nNJvD6AoKYaT9AdW5xLpTLiunWx193bp6j3VdxUi0Tr7BhgwtuCHnHlX3e+OzsNUvS74E6768SymDkKlnjd078XVEpc8l2tTQgOxqRyLjNVTCfkpnoKB3F58ockHlLyaC9UseAf8QRpiRdQ=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:58:04 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::d7) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:58:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:58:00 -0600
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
Date: Fri, 21 Feb 2025 10:57:09 -0500
Message-ID: <20250221155721.1727682-13-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 2860838e-f9e7-4a27-a56c-08dd5290866e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BU74nsfTRn9p3od07Q/O5q4yX3q5xZqOFEonKq7pL0xjw2RE8831SI5vZbfL?=
 =?us-ascii?Q?aBy3oxsqBuTj0biRRuk2f8o+XPyTMVvOTjyGJjk8IqpuYz9W4o7d579lJxLL?=
 =?us-ascii?Q?4qZzEqqRotSedk8pwwlwfndXWXKi8pOOI6wuA8tN5Ng2+AOnKvFQCLxuB8mB?=
 =?us-ascii?Q?54TQ9z+oR72XNKVa588bBOjQKs2nqmA1hzcFRsHpwDrpFQLkxQtvxNYvQsjt?=
 =?us-ascii?Q?NWy4ncMivSkO9kFX1TddIj6XTH4LKIwi+jLMwxw8fQ4g87yDWzIO1dY9aL6h?=
 =?us-ascii?Q?wUO4zqSSsn9ZPo6WR9Q4dPCc5WSSHqBSDw21yZy7xhwJHvCQBaE8j1LhbfI+?=
 =?us-ascii?Q?RiFCXZUzk9qXlyncOEvWZfsd4eMantsaxDnJe04logMILUWmx9jRWThc8Kr8?=
 =?us-ascii?Q?cc390exkwIyqSVTz6swEBgAKafy6stgGN5FFw2cwE3k6hz7oq2+sO43iHb9U?=
 =?us-ascii?Q?KZpCgz4up4IXLfjwFR6Lf60n0UDrRNz0FShWAeb16oJoIMdh/QfsnnA/hKQZ?=
 =?us-ascii?Q?1w8YZMzYCJIka1xd29JK1I4TMM0U+mV0VlZWo8Gd7rO/1rTQfPlGjpd3OiR8?=
 =?us-ascii?Q?T5aI7z2beJoT6h+jHMGIm/w71BbM3yAob2wvx8692oMPAxWbr5P/NrWNd7Jw?=
 =?us-ascii?Q?4oDa19b6olqKzgKDtXEq8FBdEgwGMi1hdSlesL7wFPJc2+Y7v4WFTgGcEuP+?=
 =?us-ascii?Q?ZfzpB13Szboy294gCjjTwJo8FaOOEu6jPahZ8mo7KtFNldkx4VkkgYepMWAA?=
 =?us-ascii?Q?F6xDsJqEnA01O70I5j6oCurBZ9ZGOwZAJ12fytXCR70LwoJVM8tGcM/UQAcb?=
 =?us-ascii?Q?UsT2XOAcsjcUN35DQ2CJkEX+o9KyWS8V4dHPNuRbXGd0pzJ65N4/GjOLjjWF?=
 =?us-ascii?Q?bnRRshRHuFlFb3e7qQtusbysHGqSDTk2IvixkeHvfBFQNPvCWkPy8nCLhiDe?=
 =?us-ascii?Q?pBfvewyW1wzRhhrDvD/PEZsUhMFeSCyIhSJUSbqQ0aPJFPcFtJRg88ZZ1Yoa?=
 =?us-ascii?Q?BHJ/gASUXQaN9dpBRvb9Uca6Rupfd72ifNWN4Im/NnM/+RKwDnnq/iyeBEBT?=
 =?us-ascii?Q?Mis+iylsIwbRmq6Ns1oDdtxKqmpe701Wy3OdIJptJmbO261J4SaPxS3J0IcR?=
 =?us-ascii?Q?xeqpYMAVY2ha+mbm0k5HhGkZiqu6gsLI1Znysfs6tjVn2FZGvHR8gaCLwWR+?=
 =?us-ascii?Q?+L19oloF1FIPu0m1HGKPYsF+w6xs7Wu2GFvuymDUBnDFT1hEKz9CDr/jsjSj?=
 =?us-ascii?Q?5G0/5vwD2otJMYO4xOl0ddpgwVKrzr7N8z+jJ4jM0kPLdx+4IMSINerz8rWY?=
 =?us-ascii?Q?kUvHcnheH3mJJ5lEvzlvap4VyGUyBE0rRt5n1X2jFGy+K2ZilEKCAcF6Rmtm?=
 =?us-ascii?Q?wP8pi/jVGg/QWU0JmRKl+T+Mf4qZmb9oIxzQ/G7W6tMZ5HT06zNEJbxqtOZb?=
 =?us-ascii?Q?nAOEHq8QGthLtVh3MNzXdw3X20kjBToE9BUOZNJpWEoWfyrGVcdPuaLisvoX?=
 =?us-ascii?Q?jH7N/aRyTGK42D4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:58:03.9707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2860838e-f9e7-4a27-a56c-08dd5290866e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

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


