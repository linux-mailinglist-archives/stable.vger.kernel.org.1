Return-Path: <stable+bounces-147906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44999AC5FBF
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B3417D0E0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00017C219;
	Wed, 28 May 2025 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DI95wTj3"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97228E0F
	for <stable@vger.kernel.org>; Wed, 28 May 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748400795; cv=fail; b=R9gGq1D4NI7DQ1AWWoj6UEn8mDJ4AvmGPH/+tBkVsalB2FbrKZg0ReLHo5FfbVISScMO2ZyVTyUz9JjZnbRMayzqZyot0AQSDtyqGwN9iF0o0xrgjJBryDRGongHFVlLCego+GKm6kB6e7UdfqI/Fce64e8xeMWvyKip7FsgOzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748400795; c=relaxed/simple;
	bh=WGJwta1WUREWjxRI+cWplWxqPnzMMoKP88c1cqnX9Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcTyqWhlW/RoYCkSY284GxfRsthgQKRe5rkWVdfo2SwSbIEdnAoTk4QSxeELxYeHfE23AIoyPswKZZ9M8r8mc+SrnOHUNe/i4y39fRYkerdZCNAPr0RYFnXFRbqe20kAbj2uPwMplBrBqalgFfXfROFO/qPrgmRZZGkBSqpNSUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DI95wTj3; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRHBRkL5ABgc3br95LdWboCfIWvpMsS2R1smul2urowIHQIBPPRK8jYcajiF1+RWT9ruJfoP7Dfdh/FsII8P5Hkt3YcAF5GYl8WbZHM7l+Xp/NlP/zvgN6XvOYBPZ2tjbrH+aJ9Jf43SEFhWeK3CRpiWKs0HHwv+qhbQ+Zh2NH0EUr8x6Uny9X8sTSaSTsYlQYzRGjGkwEx+54qBu6Mw0bYj6VXtiqRd99our5ulquLwmTrz84vbnwkL4dr//IkAvbyQsiSUSovuKIIg2mLK/ezRfoi2z0/+58p7HyYZ8qt8E/JN1iGpe38frfw1qtqe5ypMas1XEW4U5E1M6tPBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH0SH7se/XvegF/MjGlUrDtXZu5Q97mWOnqX8nbbapE=;
 b=JD3XTfuODV8PhYxzzyCVRs4cONv57G5lubyafVWhijyAV0/nYcEbk2DwOiAZ3epYdwDXrj85B4O7sMmI++799vNgZ98v+fbOCFcvNgMIXxoGY0M+jAclC07mbkVNxgMv7sCCZ32nLWvSy7I9dGhE/n2eWeGFOAqR8ojbPPmoipP6c8rfcH0cy5ihRotrn4DxItTPxBWyc14168SsEsu52ZwVQG+GEz3WgCjIyD0xrsvZIVI86r2Ld8naEHjewGSKI3nEWJ3+v+kRP72COeNvjdFLQguSJT/TTBW6DKZVSSWSFHZ+Re7G8ByyHGtsEayS2111b/e+5GU5HOQEMgft3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH0SH7se/XvegF/MjGlUrDtXZu5Q97mWOnqX8nbbapE=;
 b=DI95wTj3/wlSum3CizZ6P6Y/FGpC+S8KsEaNLhvyx+V/w6s6WE9ZGFFKcTnYbk657NdCcbrYjy91PB5ZqegS/xib28T/CgMTCckWup6psmFfZYph00r0U8P0D+BYOZrhfUJoDwQksnNUmPYugTMWSdZITSnQf3N1SLzs6eJsmO4=
Received: from BN0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:e8::14)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 28 May
 2025 02:53:08 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::46) by BN0PR04CA0039.outlook.office365.com
 (2603:10b6:408:e8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 28 May 2025 02:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:01 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Zhongwei Zhang
	<Zhongwei.Zhang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
	<charlene.liu@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Correct non-OLED pre_T11_delay.
Date: Wed, 28 May 2025 10:49:04 +0800
Message-ID: <20250528025204.79578-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f3c9e7-d1fb-417e-30c6-08dd9d92c60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zggscvQXaXrLTatAXru3Dv+oAS2x1hdwm0byI3cQm5GHtaj3FGvtlApHKzKe?=
 =?us-ascii?Q?xKVmNMsDh/PClUYTcLl6MW7ovRZgMt8TgmpirQbXgSrO60hQiY2nxKv0WYne?=
 =?us-ascii?Q?sIjWPxEgOZQ9CC1pyAD/QEUo9hPF71njNUFFhDzkeSrQ6iw8mru5wm5kv3ak?=
 =?us-ascii?Q?CeMWu7rIzKascrIeT69gsgW4M3y9vCspuJkEs2ZrS/hzgnszrqANkaZqu4tq?=
 =?us-ascii?Q?zjT1GkqTC5ihL1x30AvmJ8pN2RcsEiNh6WfrL+HDWyI5GQHjzuLaPyXzYM5f?=
 =?us-ascii?Q?SdI9xcT8euLXK8uIUvzhypa2eWT2qhSRcjB2Q7Tzx6xUhbeqXEaTjudOOp8+?=
 =?us-ascii?Q?hj3gnwMI3OwTB6KTKWo4y1reyxIwdf/qCQ2sGchvM0PN7BGbct1uD/veWDdn?=
 =?us-ascii?Q?PzQ15dYg8ndmsf//WUZyF6CAmpBUa48boS7rEsaSe5M7ktp+xtis+ksCRdOD?=
 =?us-ascii?Q?pGYMjMCaIjoDRr5X7sXyjUb0oTu+MWQ+W4vriUWN7NQuKuUJ/uYdqsMrmR/h?=
 =?us-ascii?Q?lFKMWc1MiJJfHozXj30NFcFx03IGvtBS9ah3J5hMU7IBAIeCFKEbXPnzmxw+?=
 =?us-ascii?Q?CZk1Kq62DyVLHrKVGKkQuOw3j2IIGHJPbR5fAxxXBO8s2/gPUEhMFd6ioEfJ?=
 =?us-ascii?Q?8p38vr9TyjR6LNnoWcHDjnI3o0ZS0gPMS1Qd5+dWkS1wu/3pNWn3NiBbioog?=
 =?us-ascii?Q?xuUrkCi97jma9+R5OjbUnBJ/+FHXMQPKsd6iP0QRCFWpU0obPLgKwCqEI3GE?=
 =?us-ascii?Q?uX0fWCrUyjN8O4GZv3F6LcEjhNpB74R4BbQsLXykWj/uDkwKSkuvLOjQB/L/?=
 =?us-ascii?Q?7OTMZVRI2SMLOxLolEFhoFGNJMbjgCfoT36XZkBBUd11H2SvKFAgr0CMnTw6?=
 =?us-ascii?Q?4DQ51qnALsYxgenmc+d6NjyghVcd/wfZkVeG+0zG64NsKV3HEwN9/psyrDjI?=
 =?us-ascii?Q?NSk3POk0P8upO93UXTg7fj4EBGnUuzCpAPQZzuMX0vp9UP9lKzSH7x/D7T3W?=
 =?us-ascii?Q?PsOeUjpG285OtmQhGTIx6LFoYvGckvbczO0wMR+oPw49vozDTmgbcgqPrfzI?=
 =?us-ascii?Q?+LYk2optheOwhwuzgEYOMv8po5IMjQBBeo/MUE4zwEeVgUtAwZi+esbxT+k6?=
 =?us-ascii?Q?vwFBpKsq8Zc3tTitxDUEyrqCkNSKRZl5kUc1j6u8jqPcEIkeZAQpMtKvrh7U?=
 =?us-ascii?Q?5q7gDCvCoIQY2di35JPx5wjYaDoHnjWmCtWKicYh+I62P1Dm8G30Brp+8LVc?=
 =?us-ascii?Q?pYyK2zOvbe3m1a/2+RERXsDTr55U3NVKcRXfwlyKEX1Fkso136WVA24Lax5n?=
 =?us-ascii?Q?v4EEidYJhIGJWnGVzL8ITQbF6wQc9GkpHhM9mwiVkaMK3WFxp/B6G3s4ECDI?=
 =?us-ascii?Q?cRXac98FEt9iJrD7AeBFRQQuCUopSVtPcDGefuYd+d9w+z3tW/Buysa2LxZQ?=
 =?us-ascii?Q?cZ+Pa/MI+gRylE9IF26Gchw9WqWJcaLAOvff+pRmsrJ03w//Tuh14yUqVRDE?=
 =?us-ascii?Q?pn84HakyLIbeffXekJMF7ZQWfnbIcHjKlB9g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:06.9649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f3c9e7-d1fb-417e-30c6-08dd9d92c60e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>

[Why]
Only OLED panels require non-zero pre_T11_delay defaultly.
Others should be controlled by power sequence.

[How]
For non OLED, pre_T11_delay delay in code should be zero.
Also post_T7_delay.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 28f37437176e..a8174669bc49 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -953,8 +953,8 @@ void dce110_edp_backlight_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	uint8_t pwrseq_instance = 0;
-	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
-	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
+	unsigned int pre_T11_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_PRE_T11_DELAY : 0);
+	unsigned int post_T7_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_POST_T7_DELAY : 0);
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
@@ -1070,7 +1070,8 @@ void dce110_edp_backlight_control(
 	if (!enable) {
 		/*follow oem panel config's requirement*/
 		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
-		msleep(pre_T11_delay);
+		if (pre_T11_delay)
+			msleep(pre_T11_delay);
 	}
 }
 
-- 
2.43.0


