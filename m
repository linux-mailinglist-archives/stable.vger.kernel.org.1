Return-Path: <stable+bounces-151464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6533ACE546
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E5A189B3FD
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B81F1306;
	Wed,  4 Jun 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sIL/BLIH"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9E1E7C11
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066112; cv=fail; b=ouFWiz4W38fcZCHu+gVr65X2UflHJvl8J6RC64XF7l1PjUYVH39MFzAyq5XKvSv2qeyfGz/YZztikBV0/gKRilbiYugVRjs7nbO2TsYWi209klAxa/1OCGmA4t52A33rdnr9XYjLFI52D7ary7+PcqihzasfETJ/r0pqmh0QSbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066112; c=relaxed/simple;
	bh=wvvqHgRPaOtfJ0n0tsYVgdTmwzhBtBQMU8QJwpSX+0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saKpAT2utrmDUaLM8TkxDZVld4Ferh+lIn+4vYPVX2/sgLy4fdwMptNBRZ+qefXt90ddxqt4xaG0MHuY7mBIWMe1SLmpaeXAJ7lhjMlAs2xdhFyVl2G26+tpptBe9sOMiJi7yR053XrUDAM3J7yHdSp98UG4NQecehExmPDF0hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sIL/BLIH; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF4tuioGCuEImCvrbAMFdwCwXR/z0LKYfixRrAfMq5pK/mADyRKCYaFKJsImcv1Bpt2pnZifMBwSBGPFNnxGFMZQISGCEaJ9nA92zL0oIUkwTEDa87+GjWm1OxKw7DxdXDDhnkug3l9dN3D3L3cyUimcALPhGc2wUW6KaiRXAkeuS//VSFx9VkUgUoekJlFgKBZRQ1UxDO9O1TNLs/F3qRwH7Zkn4TiQ2lQAj9KLJmQVSy7Pcr3B6euwpvvj4sqRkAHU9Vptzp4Ml6XdeL//LWmZwrvlEAhwa7dNKVBscbHKxA9kDv1PefypR0uR8Hy7Ms8XL7zcijI3JuhtqhJI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tB5Oql9HYTl/QfXytx+HMRVCXX2XtVSyfSAQyIy/Ng=;
 b=QnQqhVZiK75axwjvgoBQZ6Suce/iTxNNEpZqM4LQnBtqaY8BfvL1t0NLiXwrmE/LTF0epBrZgCXgOaVHrAujPK+FxTDJGmiijy2LBsheAQnRe7jc1gUy9IxbjcalOVQdMRDvSCYmAnNqneypfLrdJD80TM3HFOwfvyFy7+HvGHPAj6s3W0Tv0+iyyBPZ85I3Li5GsH7OvtPCqUyzQhfdo2Yq7Zm64jh7xSlbKYBKNEsj8TvgwGW1G4sruRj2BI6WlE2bLPu9zMArJzXD0XJCJ8P+WPgTG9lrt+xsfFDJsp+TAMnD62pOe4IwRT7d5/zx6JHLf3aPx7dI+7LoFMCuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tB5Oql9HYTl/QfXytx+HMRVCXX2XtVSyfSAQyIy/Ng=;
 b=sIL/BLIHq2lR/vpkjYXfSQUhcFdZ4h1o+lEKOxJNjlCJYuuFbQXc6n9Wcjc+QzlU1h0sKe5bLSkG2oKJwWW1m3yJZdJ/6hR7Bxr5GXRJfq8UdXCSrvJlyjFmWqa93CC/JiUP/BF/udHAVuQGZG84KBKvbjjK2w9/7inzpZ1Muy4=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:41:47 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::3c) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.15 via Frontend Transport; Wed,
 4 Jun 2025 19:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:41:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:41:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 20/23] drm/amd/display: Only read ACPI backlight caps once
Date: Wed, 4 Jun 2025 12:43:31 -0600
Message-ID: <20250604193659.2462225-21-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bfd7d2-801e-449e-a5d8-08dda39fd7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzbcO4hlsa6RfiHL33VRBqgCEI+QzU4ePWWg/p6IXytHMNt2+IbWud0G5kgj?=
 =?us-ascii?Q?OA2j1VS4K5C//sfxbM33rQ/FVwJdiQNHKK9VypNm9dk2680sfwJYDKZ3l5Rn?=
 =?us-ascii?Q?1CzYjr6e2AEK3fQtmfe+AqNihcT7E2W+7X+GU361ipBfhaa3lmM37AAqh+hG?=
 =?us-ascii?Q?UjptiN/Gs55XUcbhrllwTqvUxst6tk77E0Ik6XQjZy2UrJE0fT+YyvTYhcdG?=
 =?us-ascii?Q?xP3uBiluEWygagUKPlVKsr4HC8pO/Nd+H303rx9z/3TyMAPB0ql+WdZqeAzk?=
 =?us-ascii?Q?Zz8Gv87ameZm6datimH2EKee2EQJLk0HqDTXE8jiDHp3M4hUGrBkkNgpSrkH?=
 =?us-ascii?Q?PLy1oM3JHMKXD5O03siQo6gyy9NP2ivCDHD/OY7RQ7RP0Sz269SW23pb+P1R?=
 =?us-ascii?Q?+1Mhoz60wndOD/rcoCzPHf3aTSYJ6wqzIq1evttz/xzLnz0PiEv7sNWGBVwr?=
 =?us-ascii?Q?Rj6AzKatRemtzbxan70aPRNdFNw21anl58pBqxvcFG6cicnmV1cB6G6AXJyg?=
 =?us-ascii?Q?D4ipu6tQsTlB2PdgTm6+1R7fveVCFp20FToy0A94pomCi2Mv7ub9F2zEwNs/?=
 =?us-ascii?Q?Fa0etGEMr/U/YjIrHNGClJqYLDKm6bAVQ08JUgvO1H0rYciMZSL3reLX14q5?=
 =?us-ascii?Q?fpoyhOjNXnPuMjmuXjq9n+OnJO/ITv/otjuddgfMyi8AvxMhGqwus6xeRuqK?=
 =?us-ascii?Q?bY4optDyZgk4t1oT8oA3dKISZnr1HMULpEC3DpOhEQwa+KQ8Gu9MOISKZ3ND?=
 =?us-ascii?Q?Fh2lRxWw/HuSSaX3QStXnySt9xVq39LZjmr5D1cQZavWqzjmV4JP3ILYnUvy?=
 =?us-ascii?Q?LhtkUZW6eKBRp9KgaeKSWYfU8WfqVD48NLFOATGBSAY0vR07JUhf62BS6mZk?=
 =?us-ascii?Q?N/dngM1gpkMhUwkkbj5MQAfU30Gbn5til4dVv/nc2JvYa9IvPtR0Se6fEx6B?=
 =?us-ascii?Q?x/271Vk3Xloi0RBUDc7saF0xNODlr9547XoScRaIIhbee/c8Yy30KOiRaQCQ?=
 =?us-ascii?Q?O+W8Jwb1H79EnZ7XrZOauulgE52CetZKiYEN4OzVkUyz+ENtjrjXsB6C0bvi?=
 =?us-ascii?Q?epn27c7bWreAleJmOM8HFtjhbovBjzq/HmyaahgT8h5CJwDMFKt6OAqxWQKX?=
 =?us-ascii?Q?296gfFpo8Dyqzi8rKPJ1pmf/vDTA+UiSmbyR6zRfuB+SH5L+kloF3Q0+8tDY?=
 =?us-ascii?Q?0+vuTlGHV8/0DAzluoj3EQdY9aVyXwz+Ord32T9VGOkG3P1ATisScU1e3VEo?=
 =?us-ascii?Q?fcRf24CCeyTsW3ZSmRVJ/OSJgKATwkZ3bIdVAeHn1jQfhVFBfRPaLRYKMfo8?=
 =?us-ascii?Q?B6GWIbhUxBaXY4Ch494hUacQ5opZXkzMXfZyTqsOhA1oaCp05jenPvCLmIag?=
 =?us-ascii?Q?p5nOgmkNLO4XnCedgvU3XBMYxMxuK8LK0yUXzoYI6v30exOllOgXtxaqgLkG?=
 =?us-ascii?Q?VXghHTT1wV6/ZeNPEOf+PRdqqAFCSCSrQy9ogY7DbenrIHTkHYQHtcCIpUMZ?=
 =?us-ascii?Q?ao9a7YOkl/T8p/HQl+5c3uOEp2cMS2+58Fhz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:41:47.1965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bfd7d2-801e-449e-a5d8-08dda39fd7de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
Backlight caps are read already in amdgpu_dm_update_backlight_caps().
They may be updated by update_connector_ext_caps(). Reading again when
registering backlight device may cause wrong values to be used.

[HOW]
Use backlight caps already registered to the dm.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6c23aec44295..31df545f8c0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4911,7 +4911,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *drm = aconnector->base.dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
 	struct backlight_properties props = { 0 };
-	struct amdgpu_dm_backlight_caps caps = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
 	int min, max;
 
@@ -4925,20 +4925,20 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
-	amdgpu_acpi_get_backlight_caps(&caps);
-	if (caps.caps_valid && get_brightness_range(&caps, &min, &max)) {
+	caps = &dm->backlight_caps[aconnector->bl_idx];
+	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.ac_level, 100);
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
 		else
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps.dc_level, 100);
+			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-			caps.ac_level, caps.dc_level);
+			caps->ac_level, caps->dc_level);
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
 
-	if (caps.data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
+	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
-- 
2.43.0


