Return-Path: <stable+bounces-151465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A70ACE54C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3807F189AFED
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A82212FB3;
	Wed,  4 Jun 2025 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NozPch+6"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366B1F1306
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066125; cv=fail; b=S3Yz9BLFXPN6Or0Xy+wSqZXzZXsOWIQiy+zyknCS55JnmSc9T8aMJBflDR/zwkjwCf4xq8YoY8PlehxEDOpsnDQ+/v0J2C4ndsTZ1+uWSxQqXYRZ2ng7MGB2cp2iM1rjXD/T/VbZsuKapLYvlzqaQN09uPmASRpxtOR0nEgy0fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066125; c=relaxed/simple;
	bh=MQE+S9JhbQrvvw9Y7gypLE6m9SbDbbJhFdl8NmKQZ5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye3pdE9KJH+kGpLSdXTxfgMOLaVDMVvM0FcZrC2n+W8EhIrlfLaC7XRn+TbmuviO0s/O/NZkOtw7rCUu2BB26nrNmk8YGhRiBLKEIpPw/EWgtmT1f+q/X9HovSAsibMkW9FSRibZCtNLnncuFtqLlZ202IC/E4kpSMIYb8spA30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NozPch+6; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kagA1iDj81tr7+ReNgmPfqwOtq01kP7Qhz2qULia+wp+jPPx++Mx7sqng9wtVQ/Ud0+BDAaZGvuEu2ibH7EyUXqi8X/Wk9sVrDnPu7AEKc6FuUy5lUaGjIS17GvGYv4syfcnHnITUjk7cwbmNY+GZtLfuJcMUWkjNmYIwdmkX63AHmXnZ0/hCpyryPb2jz8TNjfwmIqxoCC4fS7BWNsHvMrmjzNtUivBIO2XhMszz0oeMtswaaVLfg698KWOkNsDqZoL3qe39TzNrMyPeDfV0xsx5NqICVaSNZ1A0mNRjPm+EiZFynUsb/vrNt6M+D6xr6iV+BwVnMVWI4TZn9ukfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t80qzj/qnhqBY7VAS6WdaZKtgIuKC1TxwB/wXKrqoIg=;
 b=Wz8EC2ZJzH83Npec/wIyGRSVz1j7Fx0Yh0yw4hafNQ6dL45aQEV9U1DVxHfpPYMr/XYilnBBIDfeewRN+2UQ3yNA0pxubF5QSyj70eegL1ZNZcY4kLFrsSgueMzXsHaU9FyWnvNnWmXmoYD/PsMkOGiTzsSHdKFXoRULIuSRpx9UQzoIfBeYRtX670ggLIvd78Ctd592vbMmNYlg8NvspMCc8zhRlO5ucvLM5dim/bBj2Zo0FUJrdq8hE50K43+ftxL/qftJyaGY9E2Ro2O3PUlsl3EbF1J7CvbcNg3Fb+X+/nK/QKZhPZ71N4P6tuleyE1OG00hdxwwIN72pRtwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t80qzj/qnhqBY7VAS6WdaZKtgIuKC1TxwB/wXKrqoIg=;
 b=NozPch+6fNxk5mYTiVrFKBVG8lUpcF7zddbKqQJyWTBLdiw3lIpkLWbgDFHxmYAmCiP3Eno1fKv+RefiI6uyA2oG228hYQhByrQUdGBRVVfhYMO3tm/DtJEDHFnnICFLDEvpCntEVO9lSmcwT+rVgYhg1Vryc7tiSrQ2gZofwa0=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:42:00 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f2) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 4 Jun 2025 19:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:42:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:41:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 21/23] drm/amd/display: Export full brightness range to userspace
Date: Wed, 4 Jun 2025 12:43:32 -0600
Message-ID: <20250604193659.2462225-22-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: c2167103-9602-47b2-61a1-08dda39fdf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQWIHTj/adYfrpE2Zvc0JJfEQmDaYS9hwNyJWQAPB07ejhbn9MjFke9q6vHm?=
 =?us-ascii?Q?54mc7nJubsbU0J+Gc0lwqsf4/kkLymfb/krr7FZCeR7ONdfEjjNtK/EKzJn5?=
 =?us-ascii?Q?fsLD7bxYBZ/nClDxs9Lp0aOR6q33QYOVNoU1n7rNLuUsijDc4Mlvbv/GNaQS?=
 =?us-ascii?Q?eDxEghL1YS6n9HOAmG52AWlwFoJCmvzUC2nRcun2QLX47jtMSWyHctuweYOq?=
 =?us-ascii?Q?hLCb6eBPx1LNMBfvBwHGyPYFFpGKfPCnGvjmFtvnFxa7VOgYYi8zPUkh3w7N?=
 =?us-ascii?Q?dMKSSo/CfhA61F1wX7thKqKNvM/wO4E443cKhjCzeBHJ/EpqDmeExdKeYIF6?=
 =?us-ascii?Q?//cHGKItwJ88vmPG1sMJpES3OBoViw+sVOHaqwmqID4tAZIuViXXu5P33BVI?=
 =?us-ascii?Q?Q/c9fCY2mBo+apvVIP95oCDrb/OrUGdg1oLFoG5IjNd0f0FNGKCuqbOetbc0?=
 =?us-ascii?Q?/6BXb3cR702VqGJrECf66QlzHpKzoaaDaJSno/ls50iSKnTrUFC9ivXBtdTY?=
 =?us-ascii?Q?y+BQvsC1fGSNNSNHS6nptWQJsWBm0CxLhEjKl3J7cWZs+n/4gVGYxrKgO4fP?=
 =?us-ascii?Q?QoKx+Hs3nqpuSxsR/xmbQGh4djajdE04Q9qdPBgBmkfi58i4CpMMho6QEmoA?=
 =?us-ascii?Q?DjJcWbGTfRfirkyhiqUcNKZd2bguDdbECNhrZ53BXWP1xKY1FyXy0ne5y+D/?=
 =?us-ascii?Q?r1XY+dFeYn6K57zluKxUcAE0po/y1/8Er6lW4OYkiSBdwOTr3t52wd6wZiwh?=
 =?us-ascii?Q?kzVtmtSTkdjuCJXlETJ3INhANq2yNwVBWQm/k6IYoqd96kvGvJz3qWP10jJT?=
 =?us-ascii?Q?knrHf8zHAUckL9nj3nMCX2zImYRvhLeUdU/HiLCAMQBiNak/3d13d1Kox0yF?=
 =?us-ascii?Q?Qtedoiz2dqo4NFCC07wEetDMeRh+WwjWCcwITerSp1sEKD1gJXUVDpN+6OZI?=
 =?us-ascii?Q?rHLmOOh0JFyRWMYb3fxfpz6SyFr2TijjcJwPHTeUliKzMulRQ6lAiPgyjcv8?=
 =?us-ascii?Q?5RAygZrPK+aFHBmTouXE++kRLzIpFlxgXjQU5MxIfKrzWxiHrkpQ2zmvpJHB?=
 =?us-ascii?Q?OIcljT2R8nFweURUmUGsfuiYRU9oQM0GpynIZCt91J+nl1pCovDWjeVW+zK2?=
 =?us-ascii?Q?bcY/XR6qeqO47JxLsKle67pLHYigsVi+oauKgZtpFtDEpyHArqItStkHifTL?=
 =?us-ascii?Q?51NwkQuViyJmFqc7GzywtWV/eqpbZcZhxVhYRqiPSvcklW6KOj+wG1nr/AS8?=
 =?us-ascii?Q?oIaAkOpGQfF9ShW7IuDRsH8Jxt1XNk8Duh3g7j2afKDbMgrx6QinuS62Zx7V?=
 =?us-ascii?Q?U207QpFSipMkA/hlqJcOFmW6Tx6Nfybv2a4yuH5KmpgPHQNrQLUJ0NS24hzo?=
 =?us-ascii?Q?g58Jx8yzE6Rx7fDXbszL9261st0gWt/ALZNJDn3fkLtqpS9kfMpjG5fZBISP?=
 =?us-ascii?Q?aLBcNora3Lg5squ6g/kfsXHoe0ZHk/wiqTw3sa/GGH6nrgslzw5FqMTkAK+o?=
 =?us-ascii?Q?mW2kRyU7QKxLWY/GGzfEE7/8bEWfHH7b/0g1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:42:00.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2167103-9602-47b2-61a1-08dda39fdf99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
Userspace currently is offered a range from 0-0xFF but the PWM is
programmed from 0-0xFFFF.  This can be limiting to some software
that wants to apply greater granularity.

[HOW]
Convert internally to firmware values only when mapping custom
brightness curves because these are in 0-0xFF range. Advertise full
PWM range to userspace.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31df545f8c0f..19d38357f508 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4721,9 +4721,23 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
+static inline u32 scale_input_to_fw(int min, int max, u64 input)
+{
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+}
+
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
+static inline u32 scale_fw_to_input(int min, int max, u64 input)
+{
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
+}
+
 static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-				      uint32_t *brightness)
+				      unsigned int min, unsigned int max,
+				      uint32_t *user_brightness)
 {
+	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
 	u8 prev_signal = 0, prev_lum = 0;
 	int i = 0;
 
@@ -4734,7 +4748,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 		return;
 
 	/* choose start to run less interpolation steps */
-	if (caps->luminance_data[caps->data_points/2].input_signal > *brightness)
+	if (caps->luminance_data[caps->data_points/2].input_signal > brightness)
 		i = caps->data_points/2;
 	do {
 		u8 signal = caps->luminance_data[i].input_signal;
@@ -4745,17 +4759,18 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 		 * brightness < signal: interpolate between previous and current luminance numerator
 		 * brightness > signal: find next data point
 		 */
-		if (*brightness > signal) {
+		if (brightness > signal) {
 			prev_signal = signal;
 			prev_lum = lum;
 			i++;
 			continue;
 		}
-		if (*brightness < signal)
+		if (brightness < signal)
 			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
-							   (*brightness - prev_signal),
+							   (brightness - prev_signal),
 							   signal - prev_signal);
-		*brightness = DIV_ROUND_CLOSEST(lum * *brightness, 101);
+		*user_brightness = scale_fw_to_input(min, max,
+						     DIV_ROUND_CLOSEST(lum * brightness, 101));
 		return;
 	} while (i < caps->data_points);
 }
@@ -4768,11 +4783,10 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
 
-	convert_custom_brightness(caps, &brightness);
+	convert_custom_brightness(caps, min, max, &brightness);
 
-	// Rescale 0..255 to min..max
-	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
-				       AMDGPU_MAX_BL_LEVEL);
+	// Rescale 0..max to min..max
+	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
 }
 
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
@@ -4785,8 +4799,8 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 
 	if (brightness < min)
 		return 0;
-	// Rescale min..max to 0..255
-	return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
+	// Rescale min..max to 0..max
+	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
 				 max - min);
 }
 
@@ -4936,11 +4950,10 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = AMDGPU_MAX_BL_LEVEL;
+		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
-	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-- 
2.43.0


