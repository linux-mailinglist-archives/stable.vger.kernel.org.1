Return-Path: <stable+bounces-210062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C986FD33111
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D7793034A77
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F0338921;
	Fri, 16 Jan 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hwyfjXFa"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23323370E2
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575863; cv=fail; b=Kj+Am22txUTGon5ggzUWY0Xpb6cJXCQyvr3g0KqzRHI2wRu3JSc9PaCzOLb9AODKSEJFheV3MEo6y+uNJa3e4TxI2a16nhb3ftSIMcY8UlwSAdDZmzhYzZda2U2WOY/BuvK2uhx/fcaW1k+lYihdl5KtsmYwzw0jzZzCizpZebk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575863; c=relaxed/simple;
	bh=0ec462SXDHcINsAIxNiy0OL63r+v8oN/nlvYw7G81V8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQeOvKaPDd4YBN7m38180RJj0j6sHgQ0mQdLOmfU4+l6ZBFSLXAiXTfMvzj2I2FKDBdG/od/fsux+PQQMivykpG0z5b5CxxkbaKwtOHA1jVvv3xtzFGsNDQAQ2lUcrEKWS/JJYgSJz3z4zaBn88aYofcM7K/0Knn3ghQfFH1ukk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hwyfjXFa; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1ayPMlaBvf7A/ONJB43Zd4tXrsEBAK4f0x4BzArUlHLTxn4hWtHFkur3dv5o97jPbcflP+IHnIzdHDs8by3yArdX9HxxEad4QzwVb4aFSzh1rNZg7W9e+qgp/d42v1nPes7stPJsjT9CFeSjvcq39sx4nTo0mMyl26h7GVdoYCHA5fv8aWp2NsrHSwG2A9Ok+M8+EYq4D9DYyMQ5JoG8PXDisPQUJvBNbS7Wq8+VsnyvNqK1Jyf3dC4otWGz0WStPOU5PZUE0HOqiLCpX/vZRLsYmj9X02RtG+MgXZZwUd+t5cLwtWlinHc42pkqOwCvx8F65jPVzUU6FT28ThvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdESTbIUEBJKRdwWI3bDraV3JDNVOCB5LIOXuloOx4E=;
 b=HfT7ejWOtOuO9cniceNsuhrnM5B9n5+9vssCkNyN7+MJgdfr167jpI/UbxZPGpn6yzzU/2x1USFNGVTk2BG6th7DMGlE97VpevUT+2yKkGV1KUFDkCNsDdH/r8BMzHpx+LGTNq8x3IoEZsVprIKbZOWhQgzhJsSNfUs66pFfYDSHFEJRFlHCljTqvG9NZM41Abw11YiV4rG8s7AQmiLG+A6g8cLiVpwSM+Lgnhx7Tn3TZ/GeU3wyIM2nuc0msOrt/JXtE2xeWyfvXijlQWD47NW7G4zA6cvLfyKgpZgMSLM+AIUy6eXyQq262XXK2Pv7EnkQoN2yoBm38E2vRLs0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdESTbIUEBJKRdwWI3bDraV3JDNVOCB5LIOXuloOx4E=;
 b=hwyfjXFa/FpylFNd/y8x6QkAYg2vFPyr7gPW3jlLzpBdai3pP5KM1fJ+7+VU7K2eLK6t5W+LbCzU4xEX9HDrFCY5/cXZozsWRxHGwe8dvit3F8ruTE4RVWW+LHMcUuHsxJXcYPrj94J73VLSucW0JqJePr51m4iLvRaufotMWxg=
Received: from PH7P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::14)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 15:04:17 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::8d) by PH7P221CA0004.outlook.office365.com
 (2603:10b6:510:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 15:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 15:04:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 09:04:16 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 09:04:16 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 09:04:16 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Ivan Lipski
	<ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Clear HDMI HPD pending work only if it is enabled
Date: Fri, 16 Jan 2026 10:03:54 -0500
Message-ID: <20260116150411.1110886-1-IVAN.LIPSKI@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: cc064c50-c2ab-4519-6406-08de55108507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67FrC9GoKsEkbDZzEI1n55L4DVBNjBzpbwJgRmNkgU3cnUjn4g2NuexPK5kk?=
 =?us-ascii?Q?yp7q7Tl9J5WKAoByMiqO2M8RZkajbNWMvl3j3U7zNRZShy8oDJfmd5tf9hyH?=
 =?us-ascii?Q?jkPzrax8DBHaRZ3yyabeESrk/1PgAvS7UW4Oo0fRJzpHK+wald5w87+W/ewl?=
 =?us-ascii?Q?MJ+KygxnK+SbMtjxRWxHTTM3Ym9kpLdLDltWQ2cFOjZ2W4tkm1mu9IrP1nVh?=
 =?us-ascii?Q?McmrurezAi6rF89wpzVq7pnJ5lsQ/DqlahoHgbEY97SBhVseXPhbWGYcN6oS?=
 =?us-ascii?Q?TrEkoW4e+4w6i2O6jIhTzIqA/l30JRJ9oXol7S4EZSHq879Yhm+MjAFsiJgP?=
 =?us-ascii?Q?eOfhizr0n1CcvgmvsksA9tGDABmHQcyVtcp4lJXIqC+ZdvLsB1cVC3cUY7mV?=
 =?us-ascii?Q?JCajZZ2esWCJ96zaa4v8g19FiAWtriU6GkPvxbDqDgoLppT+XSpC9gKXOZ/g?=
 =?us-ascii?Q?D2SnzFJsY1VsohI1IVYyHKGAiddK2N9yMA5cI/nJSAUq1c4Ainkke39wzgdH?=
 =?us-ascii?Q?Djh8UdWEWB85rdRsNZEHUZWGy8a3hf20EchSuqGczrnZW0LADoJTLVAlrKdq?=
 =?us-ascii?Q?iRrJlb+c05IxvC1MUjvF6HRuj9oDmtEEx3fZJcwsRcfQ7LLi1EYc4ZyQyCno?=
 =?us-ascii?Q?i6magBuu4sYQYjQ4zqQd9kpaY2gDMWkF2YOwDOs1esP4t6jcqDj5YmPco4cF?=
 =?us-ascii?Q?d50odvKHfMYSkw6OoJEhtbzJpFgDSTy0FTus6wToBDpRCtap+aje8dugW4d1?=
 =?us-ascii?Q?0Nas2YVhdZoBNDeFvFzjz2GPc+Vr+Q8RMmdxWFizBinu0wfzeLwn5QDIgBv3?=
 =?us-ascii?Q?OdsUJe3CKjrp+xWIt/lyyUoxIqv+YLAcGRoFE0ImIyQQaC3n07z51jhp0XZi?=
 =?us-ascii?Q?LueDe9XgBTT1CraZxQnQQUBG6OLsavXxUVZS3OE2v7X5P9ULwg+e5dwNIDVT?=
 =?us-ascii?Q?YPEb/vRFtF4oYOHMqn2Eyax49sxylAqBk/JH/PZvRQCH08jJtNKAAZWDoZeI?=
 =?us-ascii?Q?r4mEYPoac2aMUrtRN1YpavJ8rajY+8WuYhcw84Af9vh9VJ++6g9dSVA7ayip?=
 =?us-ascii?Q?J2rqvzSfPChMhM4gB3mjMg6aDBe78uaxSBawN10o5cXTrIvkMZwwjBBUwXOQ?=
 =?us-ascii?Q?jWMCxwq83C7UFvCghc/DeL3hP5B6moQTNcW41X+cFJ2Cl673IArx00kR+W7q?=
 =?us-ascii?Q?l4XFeWI5k2x6PilAT2pcTUjTja+N+b5FyHpxisiVML3v/2SH3FziRqX2mbiM?=
 =?us-ascii?Q?ddQVWfTi41xCWfFxMv+NTgolIKPKF5Vczm/JGEImYex1X/6OP5zeas4Uh4BD?=
 =?us-ascii?Q?SNryDur52jGAWtZN6AkAdO+573zJc3ZOjNYxbUAS2r5ihX3e9IjhFn7zs407?=
 =?us-ascii?Q?Zx4SbQD+1qUrsEuY+tN23uJ35YuJlrvR9ufhvzIAwZYIu2rH+HF+chUuEZN5?=
 =?us-ascii?Q?eVJWHaKXsamOEI5wBgZIImsTL+FeMzI1l9F51CTJsMtx1ptEClKXDA6pTb53?=
 =?us-ascii?Q?1XRjdDu/gQnhxRtSizmqU8m+qnl87EObf49uauHdKGR4/RrLoydsDJa2hMkh?=
 =?us-ascii?Q?14tQpWCGSW7myGO+h1xEPmMRw8xUITz3CHKoQXmkbtYrUjV12wCGYK49A7sG?=
 =?us-ascii?Q?mSTbg/xN45pd01tKE/8rFoeswkp2hiqNAyelTXeZ6L5L3S0jD2h3j9hxohq2?=
 =?us-ascii?Q?OFbOBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:04:17.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc064c50-c2ab-4519-6406-08de55108507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
On amdgpu_dm_connector_destroy(), the driver attempts to cancel pending
HDMI HPD work without checking if the HDMI HPD is enabled.

Added a check that it is enabled before clearing it.

Fixes: d98e9c0497ae ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module")

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 655c9fcb078a..cba7546d3f95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7743,10 +7743,12 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
 	/* Cancel and flush any pending HDMI HPD debounce work */
-	cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
-	if (aconnector->hdmi_prev_sink) {
-		dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = NULL;
+	if (aconnector->hdmi_hpd_debounce_delay_ms) {
+		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
+		if (aconnector->hdmi_prev_sink) {
+			dc_sink_release(aconnector->hdmi_prev_sink);
+			aconnector->hdmi_prev_sink = NULL;
+		}
 	}
 
 	if (aconnector->bl_idx != -1) {
-- 
2.43.0


