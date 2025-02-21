Return-Path: <stable+bounces-118621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73425A3FA84
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD60441A44
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9F1FBC97;
	Fri, 21 Feb 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EaaY0GTb"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D218ADB
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153751; cv=fail; b=AQVYdwYqCx6jrIZYg2pkXuGQUB+7xH9skwB9KKJ+E7oGjQVAlepoQkzJLzDQTyq7OVlt/gDLjLQUZ1w6Ldx7HQ7LzC27Ot7mIxGLfYM26NUbKriO/MxACB+YIHQdysULY9eZ9peiswm5FA96UMBYcp0gWCjyXb8FjDZ2XrYrQMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153751; c=relaxed/simple;
	bh=NoteaBkDi+g1UwWe/J8AdVnGgz6VN4bej3Z9kIYaTa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1hafk6WRREHwatHGYZkcoZtTLCuqrdqXVnvVv6c58gcKLTOGhxDU1VuVqIvWeJ4/Cn/I0spLbK4mmH6gKeCqRiOy09l1XbSYZl6zrGH5uww6Wj5oATtEX5PxU2dxBN6QmPBosLtiI6YKDQ+6PlHsGHBXDECCpGwPBnxubGFIe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EaaY0GTb; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY/JyFFjwiVt9p/hIHQtru4oNTklXiVssE+7dwCZaq6fGlR67fkdK4jm8iyj0a9cgpn/BUZGHO+YRdO88a9NsKF03YElbdgns9tD+vODO/8sluHYCK3aV84SZWUbfqsUEvIWSsYuRdKtpLny0P95/qCW35V5/e911ewxxtyZQuqyR35TKQQRefnFFTZPlNyhYHLuuVWk1HAwxHpwKP35Nz/ZfG4UKfo7oV2dAB6GRrpajp0SeN6pqqV8n+xBUegkGt2DbG9oIFIjnppV9h7gan/RjxwbfPxy1opZq0G8RjXcXbXs27a9c+pSSbO81ylec1U87F6Jvlak7vccfr60cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=A8MxVytL4w9n0O2zsOW/oZiwh1r2p7VGz3EUrBbM+++P4GABrvjFABu8u9QysI+6VbWQa/ugx5HDX4dLb3QMRUYgKM7jOonrEvWXIpi2B3lOG6clR7wZTH8n8OyT0fZ32EwpyrckXphDrENfCggRort8MWzgykU/oT/fV5mSjLeXzdi4AZCzoXa4rHUcflqpazoAlqHNzTMarD0ZsadjvD0xCfyyThKVsX5f/m0NwvZv8T+ml8KcX0knV0Piz2PELBo6qPr1a3ahldOlo8Pkjclt3lawol6RbBikelWZsZTcYRtOBGYG6o1Ojwsr4nvz4PIv9ua6yFoMNyOZhwDnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xuOTYR4lnbhxymYY1/B0RLYbV3En/sh+h5Jtu5cfwY=;
 b=EaaY0GTb7QeA1vntIb6B59Btkalo9n4+9QlavyG95/ThZ1GTD/u7wWrm6WR2foDRnpJsHB2SY1ZZ+5tASRoxsKOB+qUeFbaYVvvNDBBwfUSP3SRLg/Iq6AbhDB0de6Eb+YnH/793ji0wwW09Vd56OpwLFoJhtLCdBKBtpskzLaU=
Received: from PH7P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::20)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:25 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::9) by PH7P220CA0057.outlook.office365.com
 (2603:10b6:510:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:25 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:16 -0600
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
Date: Fri, 21 Feb 2025 11:01:33 -0500
Message-ID: <20250221160145.1730752-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c34aee8-1beb-4ff8-ca14-08dd52912258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OPzk1CMxRjAgYAwsM6fUtn5m+wR05FeOqQYWrJ0YmfAUhyh/ThYnhLF8hD5C?=
 =?us-ascii?Q?A4PIGW2peC/zuvheWqNOul3Z3WgjSyGV2zb0WPCFRBh3/riwJoCI+elykzqf?=
 =?us-ascii?Q?4I9cSB2aGhfpKBRXSx23ciDFKp985rdmQ8Wrba8nSuOkV2q486LtQPMosJJp?=
 =?us-ascii?Q?grpzsHpxUiLUnZsMwN7wZR2UpsQGWIQw3cuphpQwGyY05NkiKHK9Ifu6bH2d?=
 =?us-ascii?Q?197eciC8VWD/b9stilkt80uT7R1uFIfgueW301gMGpulzu9ktGQSxnRo4WKX?=
 =?us-ascii?Q?/xICRn9ukrApgcrLaSRa75keENuxjKmulCNsdFJaTTOy+ZJ6P0pJ+/0V7CWR?=
 =?us-ascii?Q?kTz4UDGmF41aqMQUM7AJH+uhXElgezF+tpE/dt1TcgFZhhlpDAHLMKbxsD8b?=
 =?us-ascii?Q?yDlaeflum7G+Y/aD9k3myIoP77F44P5oeoAs8wiFhoFbU/qxC7pmhelPmgFo?=
 =?us-ascii?Q?vrd6xtdwwZrxvPB7cR2VPhsfqVE0oPloZ2tZfklFK+PE/m/WC7EhA9ojV24f?=
 =?us-ascii?Q?SLzIdqzAATBEj91kjYBVoM2095myhxexYJ1JIkzWgnsfeo6jrd2P/AG9Mvue?=
 =?us-ascii?Q?IqbeNkMF7/tT2bbz0Mmf7n8mj0pk9AUAEMEkWzhblzHYKVydP/9kEhA/Dnxw?=
 =?us-ascii?Q?Cf0xVmnj/olqhI43bF18ch7iKsjRQhG+fXgCsmA3LLTByQ3prroPrrKjlHkm?=
 =?us-ascii?Q?a1Br4jtepbJebv5GlE35x8aeoh3FwFYd0BUoB8F7EUrTGaSkD19fbKVIldw1?=
 =?us-ascii?Q?hkiBugPcS6i0yY44cIjoQDtBBI/mJTB9djXC39i9KCFNs9hgDKXNbhaBc1WX?=
 =?us-ascii?Q?vicztxOiPPRw406m8fEitNEbxyC/EnqCF6lO9Xnoq7W69hvnwRGMydfnEqmX?=
 =?us-ascii?Q?1/miKM/i6XrvnycGTmwdVOJpHUQLG30zpMPLn7VGCdWSxgUGhY0iYDxrIEwB?=
 =?us-ascii?Q?iBeY/TUYwNBu/BwiaOk/xJ9fCslraVenRlvewpLxYie2DNuzYJly5Ixhnvzl?=
 =?us-ascii?Q?Q/Pk2dIMtr+MK2TjQaIz/Xpu2SikVVxjtqwIu4odnhrFvN16vqgap1ei0+sX?=
 =?us-ascii?Q?qmwErmv07Bs+1FSZ//W1TQfRrNvwvcHucVy2jA42x2Pq9tRFmBiAMjnSS+53?=
 =?us-ascii?Q?t4LnQ1hI1owwG3BDcbMbgfqqtXYJEXX6euajuG+DX30YEIZwy5BkdV4d9L99?=
 =?us-ascii?Q?nz4PiQsRlavVswXWZpaXfHPdyub/LSgRJwjCSF0gFLT86ygSe7R/EtgxkknL?=
 =?us-ascii?Q?o+CniL/kbeSkaXkjLpAz6q1uCvcHttAEmQ0dSk0cTPcN8CLOlA0hE3utGQOh?=
 =?us-ascii?Q?jhEiEVA3LzLTclPuA0U93F8/ISf2XeY6+JRLK1I/fGfsL0twerTw6EwrUEvH?=
 =?us-ascii?Q?vFZclWUeqIfqRwNaqZ2dbTDWBzhah+M2UiFsv1vnBkkWGBLlSKtchKMLCvJq?=
 =?us-ascii?Q?zYoj7XYX9TdEaHplgzQJ8YE9gXbdCHDKuYIuLJl5Iu5uIuTi30Itw0RizkiD?=
 =?us-ascii?Q?BUIsv6USqVBmxJk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:25.4739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c34aee8-1beb-4ff8-ca14-08dd52912258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

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


