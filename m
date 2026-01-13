Return-Path: <stable+bounces-208300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB0D1B97C
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 23:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CA0B303504C
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED4226CF6;
	Tue, 13 Jan 2026 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ryKHz2rm"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75EA163
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343438; cv=fail; b=pRnehlXipAdaIJkbx4IXJ8HQP6/FcR4XHOJXyCWngPzmz4GSDtkVmLZTY7IvnfdP02KSyv/yendXOl7g9O5J6zOh32YovMXea7tE2h4d+RbULz9HZs4fdRKTn+e0xzu3URGh986JqmwEIT20B4heyBGgVm6mAVA8ZJ9Bo+1/7kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343438; c=relaxed/simple;
	bh=9u90BG5mOSnxg1Tt7S3OrupJmlAqPn2XCcsm8CJRgG4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yg9qn8ptd/mo7iRykarKqxvbY8PE6Y4pOX6vChQzXQWDrdds1qBcINfJFOwtgJrkVUs47y9toJZA4rSpI0ew9HuUOFIQsru2E6WK92+RxxOyQidM131anrYChHAa8eGj+KvBt5VVsU533R8uuYsCGW7vezdBCAisAqcmY4nenvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ryKHz2rm; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBcHcdYldN4P6iFfD6dLfabgPQoDo0SU4OQ1atwR0rH35fpjGl1VpJjAjNPb0mI6ZOe5lBxs1O5JwRuAp9kdav+mIjss9wiaqdgOhIszrPBrnRFg6K2aSPh6OJqjusUGxhM1bYDg5EfAsxPdJliIaJZU46g0AB0UZD20Jk3SUpKy3gqkOtDV41U6a2ZL6gFEWgSmvQdhK28qtqlsRPWQ3j1F5aTl9I+AJ0mAtW4s2swJqLk4ZwOyMFYrhFoycOgUprWaSUDSgGPV+9oPi5CIH35ZdB89LzW6+AmdekUFlYyaTLxcpLCMaX1aLlwi1tC83FftU7Ry9UWZyRD2hh04hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC2vyGciyHjgQ5f8WbFVBH4Zj9vhhF4e3pIoyaAImdc=;
 b=aMreXNdrIn/hjUdDYMG0tRBoyUwMrenWq26fRtN76B6pI2XLoyGtBtUMaIubTzzx9TsisvLtkKI9tLobGOh/D9faGLP7WunJw4yEifpXP1EwXo7xUzyavEPNkwlFmd2FbbPltR7jpmJxzIsLUQFhKnDhVjydkRWfattwlRMEQ1Po0uCIkmD+sDokI1TdzQt4kw9ocj8eCRKq0OYPoqZ1yHIZXUqGo4bexyR2zupxKdyWNFTOJ2K1zffNTHzoMMXZ3a8XxV2d39ptpL0LchgPV6hidG0OLkcXkH2W3QUXSEPv3OlgsMZO+oEAF7BUIjHpTC5gyhxq4lUDXWDs43hC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC2vyGciyHjgQ5f8WbFVBH4Zj9vhhF4e3pIoyaAImdc=;
 b=ryKHz2rmmx4/JQIdraSG3RCrJ6BNBdbx6w6ai1Sr/mM/rfeP0qHNeruJcWnVN+r3xLj+stZRs2nv3oTCUYWe4B0Un8aTx14fJFmpm2SnnZHs6ONGHQ1qQ2+gnfDrSkpm5xC81OifRcRTv5np8n8V5ofUIdcJGQNdPtzOtW7E+Oo=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 22:30:31 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::61) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 22:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 22:30:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 16:30:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 14:30:30 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 16:30:30 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Ivan Lipski
	<ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module
Date: Tue, 13 Jan 2026 17:29:59 -0500
Message-ID: <20260113223012.494982-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 79afcf78-93c9-4ec0-7cf6-08de52f35c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGmLt9+8bGQ+qHP9/gzG33co/ldZzcZR84OMd7JckfL5ixSaTa7ctHT3Pv5C?=
 =?us-ascii?Q?FTdbzIT3BAQounjoWeb8r9ozWtWl0iPLOCpOBcMco09MhtrFrEC/Bw+0eScv?=
 =?us-ascii?Q?gcX72BWm0k9Vob8NEGZVjh55QfexpgWZ8TS4vgCiAhk1G/dloBD8XzaZkQ7E?=
 =?us-ascii?Q?7yGRpBUb5bnG0BTMVdEbsPrWirtT+CVUuaDdf3150O4JiSgYXSAqlzO5SnHv?=
 =?us-ascii?Q?LeMdF0dbMWrvx7EC4gb65EhgcQpMN+apYXJTpGW7EVtFRYL5HyfS0wpi7tFb?=
 =?us-ascii?Q?5RZPTz/5b0SHRgb1as0zb2mFApNXtWwQReOiuWIDwS+TlUiXf/CVA/frkkjR?=
 =?us-ascii?Q?ZS3vj5a8JErOx3yi+jZ40hYN51h8BFIhXYiYakmdSFBBlKgUaVx1qJe5Cx6P?=
 =?us-ascii?Q?246Usn81LGGkAyl1yVpCbt1QhS7NiDhYipPeI1uqw/E+GUF730dfj4ucQzlS?=
 =?us-ascii?Q?bNo2EB1rjoCsO3R71plxpu2B/0RYT2QjMVw85lYkOmBeDXSzmQuPB6OYehNe?=
 =?us-ascii?Q?NzL/enw2ZcNS/K8VGE2ewIPY8RzkHqRkqCVFo2NdMI45ObUyJ8C1IwYUEOwE?=
 =?us-ascii?Q?VYxAZxlklZHVIjHmcAsogFkSfGhJGBJjlW9YH1qjRdhUACqmCx+CLDhhYA7S?=
 =?us-ascii?Q?G2nu+ku3ICMzfCguPjPq0fCXyFwwjsC4bKqaDobsTUZuQ9/qcL5dWK6LDnJe?=
 =?us-ascii?Q?w7kr9Z3DyhGP9JHxBa5CyNkiTR3PyQzgHbwtDwVcI68DEIlkQunSvbSKG8dJ?=
 =?us-ascii?Q?nLOQB5c5YpjSozHJ6aH/AWTRWQC+bIUAe8+pz9R50KUhUsWrRTE9GGDVtsY3?=
 =?us-ascii?Q?F4GA+Wm7Aotjt07XPDpwFmuLuwTeLZxzbVtnZHcVhih7F8qMd5ETsTHivzF1?=
 =?us-ascii?Q?ZJSx3KQIFIC9F+FZ7MmxwvsxzwSjm5itSF8NQTkpO5TelI2M7/Df2yN+Wdti?=
 =?us-ascii?Q?ihoMrW5Nwp8cR4VLwqViJtUE+tXfrOlCPNxQw7swYqwzfXHJwXZRzjgnPSp6?=
 =?us-ascii?Q?s03rIY/s+izPYOWDZySV71eTroXhneWcSmQGLuS7NVGZLcqLhBpUX/l4DtSE?=
 =?us-ascii?Q?h9N1h4UCRhJXDsd2rlMEpn4uix2e0w/kYdap+4rtdrAHZBUG4gkvJeK9rt01?=
 =?us-ascii?Q?hYtjZtew1tGMdaca3uWovPvMg++c07Mw1r0ZfQ5vabSL04bjQtLW02FnWeGp?=
 =?us-ascii?Q?8fvGNRRKI+n+mElf/cESGJ1Se+XdEOUHcNXWEgrcShDUBSsXS9rXiAT6M4Ml?=
 =?us-ascii?Q?OeDWwxr7qIaxlvfPp2P3T55Kp0k5Pyl9JEy2BcBNQIRq0tJk18CKZ41LVLET?=
 =?us-ascii?Q?hFm6DqImp1wqjjcG/pPqUNv+AxmX1wjv/jivAKkZVRs9mtZqLaReTBHOA1eg?=
 =?us-ascii?Q?RuEW9TK/LPQX/e6CeFHFiimYYhjEyuEXNrMe8qF7zGus99jHLbJl+EPy8AKw?=
 =?us-ascii?Q?da7d5dQWxPjNO2rJoCuFO4XwdUChSACebyEEF0kYXtLhrvsYO4NBMSpYdlnk?=
 =?us-ascii?Q?W1Yq28fax8ryi3DIteH3XcdWDstq9BdUTfp8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:30:31.2991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79afcf78-93c9-4ec0-7cf6-08de52f35c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Right now, the HDMI HPD filter is enabled by default at 1500ms.

We want to disable it by default, as most modern displays with HDMI do
not require it for DPMS mode.

The HPD can instead be enabled as a driver parameter with a custom delay
value in ms (up to 5000ms).

Fixes: c97da4785b3b ("drm/amd/display: Add an HPD filter for HDMI")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4859

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 11a36c132905..9903da2d28b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -269,6 +269,8 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 
+extern int amdgpu_hdmi_hpd_debounce_delay_ms;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d67bbaa8ce02..771c89c84608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -247,6 +247,7 @@ int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
+uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1123,6 +1124,16 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
 MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
+/*
+ * DOC: hdmi_hpd_debounce_delay_ms (uint)
+ * HDMI HPD disconnect debounce delay in milliseconds.
+ *
+ * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
+ * generate while entering/leaving power save. Set to 0 to disable by default.
+ */
+MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
+module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 354e359c4507..ba7e1f72fde1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8918,9 +8918,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	mutex_init(&aconnector->hpd_lock);
 	mutex_init(&aconnector->handle_mst_msg_ready);
 
-	aconnector->hdmi_hpd_debounce_delay_ms = AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS;
-	INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
-	aconnector->hdmi_prev_sink = NULL;
+	/*
+	 * If HDMI HPD debounce delay is set, use the minimum between selected
+	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
+	 */
+	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
+		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
+							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
+		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
+		aconnector->hdmi_prev_sink = NULL;
+	} else {
+		aconnector->hdmi_hpd_debounce_delay_ms = 0;
+	}
 
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7065b20aa2e6..6fe7f78b66c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -59,7 +59,10 @@
 
 #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
 
-#define AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS 1500
+/*
+ * Maximum HDMI HPD debounce delay in milliseconds
+ */
+#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
-- 
2.43.0


