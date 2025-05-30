Return-Path: <stable+bounces-148327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466ABAC9663
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 22:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99B9A210EB
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD264280A2B;
	Fri, 30 May 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jj2ILDvO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6007280CE5
	for <stable@vger.kernel.org>; Fri, 30 May 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635770; cv=fail; b=VvqogaW0U7jzsF/7G878nGUNWK20DqX3GIlJMjdHw8p6Bf/+Qzw2XDrlSq5ZY2SJffwz/8fHCQyxHAHCPRcfEjwtF23byetxhaL6qe7I4sMo0S9UiefDLg6lW+oPUU8cb4cAFCxtxZu3/yEgDEyBIj4i59pCyaEA/NDZDf0InJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635770; c=relaxed/simple;
	bh=VLT8lg+BUIMsclFggqDo+whDs+KLr1Pj+5nnX1YG0QM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YqiVkGR+/3EKigNFFBor1CJC9kvIk9gODNrMYlRjaIglhwu0tDUa7Q3zizuOpMLaUWgbJTnAMBuc1FIwlFxTh/EoS4zKm2ZMukW25+0qV9Rr8r5EYsd2lyxkXVBInAC4K6bG9ZPsmtGK9kGzZMzh8riQZdedCQWcd5SIuEYdzq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jj2ILDvO; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyicSwUD4m1oW7hZZiGhFE1iedRd8g+XtajK4n9AiEIBARMOpsAfwbyXXyAGKVQRJFEex0rnG3D3iE7mQIeh4fNLvC2/UH4mHBAlGeFK0CKzdtd4FaTmPcO5jAzvBxPYH5RtL2YxSc9M0PSHvdIn2hogCxvT0ow0xCc0lT7UjLryOlXfTXaiUdluM5cAgQSvRntv5P3YcbXy6PtMuES8Fp+TfpoE9L5p1KGu3rhFm6opalBcRIPQed2/Zxp3CvwPDV3FLJnpsq3WFQBQlPZj03W/VeA6msHoeEEiENLJDQtaYrxya/y9isbS98lrMMzo4SCT8Iupd+dCe3D0+Y8USA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpHISegPQy182S02YG/cVLMGp50d/AM/dxnyQD2NxbE=;
 b=oxvrm1fl8RB59QQUDBCrQE6cXyOC/nQ/H6IkZVp+Fb3fNjRJncCnup0oIaUQh+qNyiOzMGcBiQRat8OBl4rXBC1ZVEw0t7xbM0Ia7X+Ix7UNW2tIBc2N6g9cBCiapjtv/GX15+MFwEnlyMmBCi7WAXRQsWvTLT8a+bGdPt19cYTO4ZLjLSztlNsDmYtUVzTVBSgZrfuKzw6M+UaT+6aPDtLaB68zC6zYP+oQWSqDH3PmY7/EeGG57C4AL5TOVQKiUSdLa4zhoT0tJqxCWZwnCWs410+Pymp+p4J3G2/xHNhipxsDYw+7P8zzF48V2lXDs1olCfafMsMQnJR4lADrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpHISegPQy182S02YG/cVLMGp50d/AM/dxnyQD2NxbE=;
 b=jj2ILDvOxC3RNsDVd7fXasG9mkUnRvgtsHc6fVmX2gcPvQQ+tNQx1aIiD79jEsdZ3NEE2Rmgan6K6+jcKVFeAjwEf15RnxA8/lgRyvoBPUgmvdw1ibYb2wF8tHt4SXNO1Cf1hI00/Fpcl2TICzBIB42ddmowZJLA8YaZ6qwtGak=
Received: from MN2PR20CA0038.namprd20.prod.outlook.com (2603:10b6:208:235::7)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Fri, 30 May
 2025 20:09:19 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::c2) by MN2PR20CA0038.outlook.office365.com
 (2603:10b6:208:235::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.35 via Frontend Transport; Fri,
 30 May 2025 20:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 20:09:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 15:09:18 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 15:09:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <stable@vger.kernel.org>
CC: <aurabindo.pillai@amd.com>, <alexdeucher@gmail.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update for freesync"
Date: Fri, 30 May 2025 16:09:18 -0400
Message-ID: <20250530200918.391912-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3666e4f0-066f-40c0-6fee-08dd9fb5dc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mQwGI6MLnbKPa4PKVTJmZmnvhdLCsPGvCJfOwR8lbPSZmwiuywBrsSQmVGX?=
 =?us-ascii?Q?UNbZTMSO6e6qUfx3NO48CFWSvl0Upqp22k39r94BbOD7tqIbsw7HN4SD/Syq?=
 =?us-ascii?Q?VKrylB7sScmwdNmO6CJwe2GmfMLrsIAtNxfoRAi56mmd8uCCSkpThTWF/W4Z?=
 =?us-ascii?Q?spZIu5YxggTEjYjJIhzqiYVtsSuQ7rWoEUIxDcE8aGpj+iaUv0uz8LTpVuqv?=
 =?us-ascii?Q?+OmBgXeq9oJInwJREZhCLxScWdZGhHRb9gCXSZVM0pjuLycR3Q+iTcEuWTY5?=
 =?us-ascii?Q?RY5396/tQvEf70ywr5SIVkV2ET9cOCpsup4kqfsdIP4aHXHupov2pYVAAlci?=
 =?us-ascii?Q?61KY2wL2PuaNkPuKQtWTVKGFxWzM/bScdo90n7buP3ilI+42xJaEISXifHZL?=
 =?us-ascii?Q?ri69xJYOAqCTlJ1QkxY3E8wRQc9ntWuWptcdPD2NZyTHShT3ieZJhw6/zkEn?=
 =?us-ascii?Q?byLw8jpN0n+d3x6uxM33Q7vRPia8vpA+g8/Xbm5ve9kQX5PgQ+9KZVHSQbPN?=
 =?us-ascii?Q?XkORf0pYoVJfP0URFwue0l0b9MODLgmZhfvkojS/f3dr4pqzCf1yLsAEi7YM?=
 =?us-ascii?Q?nEEhDC63TypHc9D9G+FCl08XwXeX+hZbBwFUiw+Lf9VeVYjUDZieVK6b0TN8?=
 =?us-ascii?Q?xeN5bCAX3NikV0eq61ICiUZk9Ym+43JNVdvO8/GYmUkFG1+yaX//bsgkS/Fk?=
 =?us-ascii?Q?rP8C5Bz0L8r2begjduCUSnTPVfClU9Fx6OuIqfc2pd0uCq75O8b+ZTSx/LKg?=
 =?us-ascii?Q?yevpzavAN/cYvbPH+TZmRDTM9EdalrRta9dGgDc4M0PTjUoChHIwFafglRkO?=
 =?us-ascii?Q?wnWOcsCPelSH+MgPlL356XlqngD81Q0LnC8HG/hDdyl5qESJIxBSw+WTsiU5?=
 =?us-ascii?Q?8rLyqyMedkfVvJskldXh/LdNAZ3tZvhTUP7MC1vQkl7CFsUM5Fea1XW+sXw6?=
 =?us-ascii?Q?BXwyHIc25DzDBE98OhwE7xUzEJVR6IKvCwmeTaRPRlF66r+NsE3+JiOgaf9N?=
 =?us-ascii?Q?8IKyXlYNT8ILXLM/gYG2cA/SwHkcHP0+v3xMxoIMymcFgawub3GzAbQxPG+d?=
 =?us-ascii?Q?7DVMVA5/mJxSz57zPfVHwu/lbqt5GTu6s4fWiXjmJwBuDhWVYdCkN9kvfwfu?=
 =?us-ascii?Q?Y1m+ktocyLZFy01dO00x6jH8reLpZ5uXX6D4wxCGxOcnNd7HG+wlnwvvqrqg?=
 =?us-ascii?Q?YUb8z9q3WhBkxnj1IYqNHibJGzCYFcOIZfGZ8YHoV+P+bZQKv6r5T6kIWwFn?=
 =?us-ascii?Q?xTleEeOrYuXGJRcgj9x1tCN3xFtdQW1qZ6x6n75V75y+Ai+lwpfuXE5osFzx?=
 =?us-ascii?Q?qXV5Hstl2REbBwC2HQ3k9bNtgBdYwF8Sthz9uY6IFHY3S+7Yo4RWUlJr8WLS?=
 =?us-ascii?Q?7wFCGxuUU9l3rJJ+7aQJd5PN62odWXGB8UGHSHP51yvrao5ZV1CvB8glhSZq?=
 =?us-ascii?Q?4XxMcu4FjfPe0EzZXikLbGtkjqwDkZml7Pe0+4uvAUUmnmFv9NJ0Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 20:09:19.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3666e4f0-066f-40c0-6fee-08dd9fb5dc7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
causes regressions on certain configs. Revert until the issue can be
isolated and debugged.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 90889f6867aad..9f2e26336cccf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -676,21 +676,15 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-		acrtc->dm_irq_params.vrr_params.supported) {
-		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
-
+	    acrtc->dm_irq_params.vrr_params.supported &&
+	    acrtc->dm_irq_params.freesync_config.state ==
+		    VRR_STATE_ACTIVE_VARIABLE) {
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
-		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-			dc_stream_adjust_vmin_vmax(adev->dm.dc,
-					acrtc->dm_irq_params.stream,
-					&acrtc->dm_irq_params.vrr_params.adjust);
-		}
+		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
+					   &acrtc->dm_irq_params.vrr_params.adjust);
 	}
 
 	/*
-- 
2.49.0


