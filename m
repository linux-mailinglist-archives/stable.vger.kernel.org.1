Return-Path: <stable+bounces-141959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70CAAD37B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 04:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B2B1BC880A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838351482F5;
	Wed,  7 May 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Do2tERx9"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3C2AE97
	for <stable@vger.kernel.org>; Wed,  7 May 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585810; cv=fail; b=i9TjyVRROEbpx5dsG9+bvD2q5hPUYo3aNZrsVjJzz1ep0BXWfmMRlEfQT3tdLuNXRVEAE9Kr/y05L+dTLANuuugCZvD8WGAN03qgTLGe37PlOudEP3njrVXEh13Zykchopy8utT7wIsSj2sLNG7puJ38sWQ1ABGiQQgcbNdDhas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585810; c=relaxed/simple;
	bh=aDWrzPbyJWtwWNbGiRAyxBzW2CoSRgnng9QscE0wIW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avpWeUgDYRvj4aVSXtoy5d1NSV8BQ+9/Z8aQPvLlEpbQ3pYRtYaKuyGmeic+Ybr3YHTNyOkqbr6hef6F0QNbDYs7OYzrX7jtMaHBr2Y7N092+IRYaVigPqNixrKH7G32UUUjoKQ21tNsSpa0L1zxUkV+90wwQsYoPwuGJG1fdig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Do2tERx9; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM+xTpE7EmimhTxWTUbZnCfvN9aRMrPTJy422Iz3ji1Z9f/jjiH3H+tztoFh2uGtMuzqi80lpPniQVS07av04LBKZXjsvDH/u00WqgOnTAxqaGVIcSMnq1CNWM3935htPSmFRvsPXgyeAxy1IAFdjR0joivY2psJylXMJh2e99rbS3SX1eiXuA/ZQa5JrGxW+nPRE+yuKfeV6XxtTmhz+tqOz0v+C/HDZ3V2ZVPfsRe0U301EHSTpunD3quCWH3rk/GY6sm1/8GaFlwC81weZ0JRYUmE9zf7yvko5whZsqgh+f8hFSr3dpdH1x7cg/trGcn/z+r2qPQx9UteDKXNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISK3WO35HhgIKCJz/rOPLbtP/YipBZe3haWFcxtyrxM=;
 b=okPjnocwtxHRAEjU6tJbcQYZujh5JQIf7YJTKIwZr/ay1Jqk67HzRBKVrodTa7+1ArC1pAPQib8arKC0YDtR8vdSFSyL38ixWH+szClQABgomYcnLIWwvE44ka6EkGTkWIcQUCOzFemyiTMVXniH+gHoIaxulacORSx0pNneb9lHpvQeiIbBfpOtJjoJAgFls9sZhK1Z36euWgdvhnaV14Kql/HYSov6Kdd0sJYd80fnkDLpE4uR0de/XFC+1kzDmh5AjnMw4+VTQf+UNz+gEbz4lmUkeuKi+6bjz/FulEuaJOhctsyS3KCCPTwrQMDnu6SG4abNSGQs5+OdXR7PBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISK3WO35HhgIKCJz/rOPLbtP/YipBZe3haWFcxtyrxM=;
 b=Do2tERx9mAENR3/Tnz0EQIDMwQWJadskcQwJdzZzCuoo3MiYhfyDoFOGDKYGq6vC5zBm6icauAbS003ku+zRz83BSnnal7GwOWsPwfi0O8FJ/3RS4U+Z6Q5MJAnH2tU83vPJz8lF4HQ7fVD7KqdBFeXQf1KB5tpJEpDZRUjuL9k=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 7 May
 2025 02:43:22 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::c9) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via Frontend Transport; Wed,
 7 May 2025 02:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:20 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:12 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Ray Wu
	<ray.wu@amd.com>
Subject: [PATCH 02/14] drm/amd/display: Correct the reply value when AUX write incomplete
Date: Wed, 7 May 2025 10:34:46 +0800
Message-ID: <20250507024242.1928299-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0382ea23-e8b5-4034-eca0-08dd8d10eec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmBZ9zF1uW9TbgrS1gikJRVGV1ZSSl/cCO6JrFeR7baEJoiLdDlr2BWg8FT0?=
 =?us-ascii?Q?1vFLJtVNdwbWxsJb8g3yI7TlJzD2UwpZf3YhJ+2gJ7t+ggyIRB5QVyQNEyDv?=
 =?us-ascii?Q?Qy3dYJ9MM0CPxDTrKgIYR5tm0ha9oSUuXVNKvFujPm6QanJZEMt5Y5giVG1D?=
 =?us-ascii?Q?jV9wbQsWlIBy0SSZZQOat2EhNVGrhknVMJvNGUY4n8GlnHA5QRGfwivE2BJw?=
 =?us-ascii?Q?Kzl+GV61i7Yxz8jIHSY5eNr1a6l24RL2XmSg7/jm9LnDZCE17dfANtndnQT0?=
 =?us-ascii?Q?TgC1ElNinPWPtLdR3W94h7GfK6+g+T5YqT/6yJgHrLgE/6LvF5TgTQcaXlFX?=
 =?us-ascii?Q?v42QnnJShuZ89xWUjDFiUX8dGnsNvV0/73loy2pDa7/T2p7QU8jtLUhVwiZ6?=
 =?us-ascii?Q?RmjKEoYzSlUsdzsOThjM4UFeTuclXOT6LfK3+weN0uXRtd+kciaTDsikGrpu?=
 =?us-ascii?Q?5jb1f59kXR+6aMns0NztKIsaTUruwLSqFnge8gUQ6s6eiOAzHJR4RyIMUHHK?=
 =?us-ascii?Q?9Wyh7x5KGIlymjo1L37nNWVl9CW8E6mnTu38NWOnQGqBMAM3MNmQ4CUwTPV6?=
 =?us-ascii?Q?xe9EqpnZHSrDnqVmZI663h6jPgLe2a0EarlNTFBhkIhOHXA0ty7RoWyN3rvt?=
 =?us-ascii?Q?N73Lgis4MesblxpUgRVkl2xt4y9feBKetOehxOdm45jxKPiMWvs3zAqN1HXD?=
 =?us-ascii?Q?Der/nETnVZwJxzkTIBxaoNRDuOok9us5lKvPvPkBq4wAHZ35i0tj+QnSdmzx?=
 =?us-ascii?Q?lCWULOKxIwPgHL73A1Hexn6c+b/YoOADHhMjr/9pKepeELASX4iQb7IwxUia?=
 =?us-ascii?Q?Ww5U7o05M1VVzq5V7IHuRr1PTdCXElqtrtd4jUzFJcwiKx58oJaHYg1RloKD?=
 =?us-ascii?Q?2kcFjokIvXCPIi9nIYUJiuWkI5mpmdHv0XWZpBFMdUROlH7YrCXWDldt+B/U?=
 =?us-ascii?Q?CvpFN03Ys3Jkqb0KVnkY7PPJbbjscKHQi6hZBLYfLGHuJcqhoi9XEh1JiRAx?=
 =?us-ascii?Q?QOTgREQi1n8LipRiC0hXuigM0zVqLoDBeMEcP+ySZHV2IyG+Jx+jvdbv3ZxI?=
 =?us-ascii?Q?uofIw8B4BCoho8APXx5EmST8zqTSY1p6ayeVMlTxCZV7DcNX3VzCh2446NS+?=
 =?us-ascii?Q?tEPXz7CnNLAgxINMhIOBp2UO56WLjhUB/2xLOPWCeqUxGMPZx9cQ8AS1pVbQ?=
 =?us-ascii?Q?g/2rHGshrkVvquqNqVpl47HpVXGfAbKSHGE1kCrtFmZmFjuSe60I3xgxImF2?=
 =?us-ascii?Q?xmnvzBCL8IYqihq6NooZ41DT2ch25vd573j6qkR30w4RhMeeDO2M5e5xpLEG?=
 =?us-ascii?Q?O/XLwke+ppNisWOI33eiU07mi35eNcO+BuqQ0y1GKiClACANniRvcduRhLXW?=
 =?us-ascii?Q?9vOIN27mWJO8WJl9FQwtCHiCTvPqRetA2w3vcBAabW3jvr2/ovloCJKgzZLl?=
 =?us-ascii?Q?axmg+cBAiqaWx/zDRFidv9DhrrfOlEBj0iUdYOJ9XMkxRIh8TE7xitO0jwMN?=
 =?us-ascii?Q?68JyYmYAMbXVSV00xOw1xyg1MXzFaseOp10M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:21.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0382ea23-e8b5-4034-eca0-08dd8d10eec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Now forcing aux->transfer to return 0 when incomplete AUX write is
inappropriate. It should return bytes have been transferred.

[How]
aux->transfer is asked not to change original msg except reply field of
drm_dp_aux_msg structure. Copy the msg->buffer when it's write request,
and overwrite the first byte when sink reply 1 byte indicating partially
written byte number. Then we can return the correct value without
changing the original msg.

Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  3 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8984e211dd1c..36c16030fca9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12853,7 +12853,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length)
+	/*write req may receive a byte indicating partially written number as well*/
+	if (p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d19aea595722..0d7b72c75802 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -62,6 +62,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	enum aux_return_code_type operation_result;
 	struct amdgpu_device *adev;
 	struct ddc_service *ddc;
+	uint8_t copy[16];
 
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
@@ -77,6 +78,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 	payload.defer_delay = 0;
 
+	if (payload.write) {
+		memcpy(copy, msg->buffer, msg->size);
+		payload.data = copy;
+	}
+
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
@@ -100,9 +106,9 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	 */
 	if (payload.write && result >= 0) {
 		if (result) {
-			/*one byte indicating partially written bytes. Force 0 to retry*/
+			/*one byte indicating partially written bytes*/
 			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
-			result = 0;
+			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
 			result = msg->size;
-- 
2.43.0


