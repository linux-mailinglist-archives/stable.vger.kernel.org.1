Return-Path: <stable+bounces-54751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053A910C0C
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331FC1C23834
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E21B14F3;
	Thu, 20 Jun 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tgVzG0+Q"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E231AED20
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900402; cv=fail; b=ZMRngtdIMMZG5l25Rcual9SJ3l3cYy464sb5cf2DeocIERThhHzhOBHkbfIlbNUfcDlQJsJJ3ULaV5tX4MOYVbBQmK1EYEkK+fOx/7iE3De7A6YwrEeQ203y7wgHJBnI7mSIjHTYO8W73kFM7bUYo+pO2Qfg8Df5ZBc4HzGe0ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900402; c=relaxed/simple;
	bh=GUkoX4r1VYLFBfxrY7T+J172G6SOQhm0VMZU/yndTsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuJlpVvGnyPkbx2ZaLuFbKm8hY9mqGy5rlF6b9670/jCmJGoAkq4jW7OBxdQY8SPcoFOqygjyxqCZAkWT9cFEncqq0PdmtHpAxDaSyq6076J3bngE/X2jA7gcOnfeXQEev0hkv4l3h4DA/CSpdluGir1pE9Pz91PnH1gUmnync8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tgVzG0+Q; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGt1hJDVVrYsOl6Y/n83241MuCTXfxO5acgzpWfw2Ko85+sY9/Zcx8SLyRBPn5YcIMdTlMLqaNejtSagVTfiAUpLaCwgekjmNVeDsuy1ScLDf4Jon2rNhekjz7D3IjdQl6J+SQK2z+BLjyHH3n4+iYozEc0QhWCdDs2uOuUpX2xXu5ye1CugqLYJHwwOW2v1Hre/LqKduOpRS1bg7b/TXBMc0MgcdNk1uduZorvLQ6jhHYdC+32fAbymZcHtzNxtaP7FtHQh3LwZm3uWyfQ50WqYxJYYIraKUX5UBixiO62OBNd4EIS8pXVEqi488zVYh64sffudXCzcY4E0+/ZO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQo4PQtL9LizZMSgS4kwEh2gk4xdhpkabEXRf4UXaU=;
 b=kIVt/y9v5zYzJ2jTjN+1y70aRG8hd+v4SiaAhwUYVqVnaWeNXzwjm3k5ucGBLZc9vBU5bLtEV5RFvakN9bbD46zz/suFM+QUPXg0wbi+mgrtoS/hqvEh0GfbL09KQVlykzC3xtwiYSqE/DlhYsXqVSkfHOih32VQyPx8XUtqYJ0BdZVfTon+ktbprRqcsMcN2DdDOIPa4wGEo39XIN4wxwqckSBbTMZmN6e99zqJVuwfFwPt/1iyC7xY+oypd8TQ0pvNKpIccnwH9wRszmCAXtjuhcIZXwnJOudQFZs1neZv9z/DRR35y5nEB3EJU1UJ//OS7LFdBK0zNLNxCXiLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQo4PQtL9LizZMSgS4kwEh2gk4xdhpkabEXRf4UXaU=;
 b=tgVzG0+Qk7ys3EBl5FTurIoWE95tn2oavR3Fwif64hTReVWBXZzryqx2O4ZLLqAGeIlOXkiy/rE+EvmmIwkGF8q6O3a3CqDSFM9K/YdZ8mAQf9R31iBoJbtYl/5EJnn6R14evkWhYaS2o3+85uP4T3e/bCMBmgldHAD3vnWuK34=
Received: from CH2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:610:51::34)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:19:54 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::ff) by CH2PR15CA0024.outlook.office365.com
 (2603:10b6:610:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:19:51 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:19:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 32/39] drm/amd/display: Use periodic detection for ipx/headless
Date: Thu, 20 Jun 2024 10:11:38 -0600
Message-ID: <20240620161145.2489774-33-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 98216778-9a8e-455c-5dbb-08dc9144d06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN6SiZSiPrDpBegU7AJoTCkSyPJ5CyG47OP9MpGT5vk2qAMwyXmWvSRhEfBC?=
 =?us-ascii?Q?gju6nwpUaiZGgyJrFMMipZI3tRE+I/Kjy0wFadE6mo786wbrP/8snkLZXHdm?=
 =?us-ascii?Q?RNY5w33e4k05uZuisgFxLeXDMhrP4/VkyauKbzYZiQR761RBWmpRTLO7Zn2C?=
 =?us-ascii?Q?XjXs+wP+Op0SQaYRYVWQD11xHbc8QXdhIpT0DpY5kOT3RJqHgO8A1AemAU5W?=
 =?us-ascii?Q?H/2FeN5u9T7AHlx2h+SJwEpXRwgPpSSYbY8KS15G2NmdIJ9LwZMXAIXY8uav?=
 =?us-ascii?Q?nF0Vcf4SpKeUTPTlsIVbLHwafquHNRMcPVq+00HQQJll1oFE6w2dv3nsfO/l?=
 =?us-ascii?Q?4HBGPg4mSG7yunUHDrI5hxFcq6xfj5JOi/HS2ZV+NJq9IBZFgmxunweeXJA9?=
 =?us-ascii?Q?rkwA5IKl2ZPKxUVi7xPJe8/rNlEGXV9dStQjsWMwCkKVVJDhmt52Zu2qrzqL?=
 =?us-ascii?Q?qZ7Wb4hi0saEljOl4PHHJIeXUqqe4H5VCMgTTb1lIuF2y+a2VApTRwY+vREm?=
 =?us-ascii?Q?Cldr3me1d3uNEUcB0Iaa7JPKMTTUAAhDsPaGggZdsXXbvE9W6ZsP6Rntx0GR?=
 =?us-ascii?Q?53ZyxCThfpVrdXJvCeigRZH1zmLO3VONH9GjmBeO4kU62S0uys9zlShxj4ip?=
 =?us-ascii?Q?xJ/hMugKhpOumAqdGpZPy0if+ALnZhlGvW5M+Vot7JOIDU5TT9QDBy650tVv?=
 =?us-ascii?Q?vkyJ1EM/NpDwq7Q29xCyMSrI14Q7vH9X0SldBLEr71iRolQkwMn+7lq75qf0?=
 =?us-ascii?Q?d2Lu69Nzr/e3FvzJoTv+os0dH6Mk1diXPTGfouP5IxeSHBJdni9s4EK3zsJi?=
 =?us-ascii?Q?862vchRnTnKKD0prJeYj2n3Rr8rhr3iuHT5k/B9s6WHZ50alCyDW/i8Ay5R7?=
 =?us-ascii?Q?ClDNlOr7+kvfr/jTVGm6aAtldrKDIq7U69jVap5vNcomFkjYw0y+DYoV46hm?=
 =?us-ascii?Q?iJFWx3A+iPpvlkrRK1lsuHBOk2RC4yjtUsOhEIYRdwwmb+Zuq0C+X71CR5Ra?=
 =?us-ascii?Q?3Yf1xXIMDCl34X0fWiKnPMF2Z+5QuH6zSlu5mAEsa9iYxiSdnXbNEao/sCVe?=
 =?us-ascii?Q?iqRcL1e7cSBrMvRZCx/+7FdubFha5mU0cv7h+GA/BH2wjJvrSa8afjs8YH16?=
 =?us-ascii?Q?KFurreobSnFnoUauAA8d5cFvlu2dF/xxaEZ62jpLuAFtTdcumkzmqLLESEQn?=
 =?us-ascii?Q?r/RELqr7u6CQKPzV1FXNSggbsCuWVk0BZQBiwQkO7IREFf9zdDZpPXDqFVxN?=
 =?us-ascii?Q?pwL8PO8tsG5c3ZbHkBMTG4hKHMnqLA1KrXDDYfapw3PLrrKadp0aMdDkxRT6?=
 =?us-ascii?Q?Mgl6a/hrSPHtYV/2Ltz6wjkAECLAF4VpArlHkcs/zI0SBhtnIStsQVGmDXAA?=
 =?us-ascii?Q?a90UPQYykRr7wnTa8LyQGzK7tNZhxfAO9JoxQrMQzUWDd//CJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:19:51.9553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98216778-9a8e-455c-5dbb-08dc9144d06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176

From: Roman Li <roman.li@amd.com>

[WHY]
Hotplug is not detected in headless (no eDP) mode on dcn35x.
With no display dcn35x goes to IPS2 powersaving state where HPD interrupt
is not handled.

[HOW]
Use idle worker thread for periodic detection of HPD in headless mode.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 48 +++++++++++++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  5 +-
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index dfcbc1970fe6..5fd1b6b44577 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -989,4 +989,7 @@ void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
 						  enum dc_gpu_mem_alloc_type type,
 						  size_t size,
 						  long long *addr);
+
+bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e16eecb146fd..99014339aaa3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -162,33 +162,63 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 	}
 }
 
+bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct drm_device *dev;
+	bool is_headless = true;
+
+	if (adev == NULL)
+		return true;
+
+	dev = adev->dm.ddev;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		if (connector->status == connector_status_connected) {
+			is_headless = false;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+	return is_headless;
+}
+
 static void amdgpu_dm_idle_worker(struct work_struct *work)
 {
 	struct idle_workqueue *idle_work;
 
 	idle_work = container_of(work, struct idle_workqueue, work);
 	idle_work->dm->idle_workqueue->running = true;
-	fsleep(HPD_DETECTION_PERIOD_uS);
-	mutex_lock(&idle_work->dm->dc_lock);
+
 	while (idle_work->enable) {
-		if (!idle_work->dm->dc->idle_optimizations_allowed)
+		fsleep(HPD_DETECTION_PERIOD_uS);
+		mutex_lock(&idle_work->dm->dc_lock);
+		if (!idle_work->dm->dc->idle_optimizations_allowed) {
+			mutex_unlock(&idle_work->dm->dc_lock);
 			break;
-
+		}
 		dc_allow_idle_optimizations(idle_work->dm->dc, false);
 
 		mutex_unlock(&idle_work->dm->dc_lock);
 		fsleep(HPD_DETECTION_TIME_uS);
 		mutex_lock(&idle_work->dm->dc_lock);
 
-		if (!amdgpu_dm_psr_is_active_allowed(idle_work->dm))
+		if (!amdgpu_dm_is_headless(idle_work->dm->adev) &&
+		    !amdgpu_dm_psr_is_active_allowed(idle_work->dm)) {
+			mutex_unlock(&idle_work->dm->dc_lock);
 			break;
+		}
 
-		dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		if (idle_work->enable)
+			dc_allow_idle_optimizations(idle_work->dm->dc, true);
 		mutex_unlock(&idle_work->dm->dc_lock);
-		fsleep(HPD_DETECTION_PERIOD_uS);
-		mutex_lock(&idle_work->dm->dc_lock);
 	}
-	mutex_unlock(&idle_work->dm->dc_lock);
 	idle_work->dm->idle_workqueue->running = false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 659dd67be1ba..f5e1f2d1c5f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1239,8 +1239,11 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 
-	if (adev->dm.idle_workqueue)
+	if (adev->dm.idle_workqueue) {
 		adev->dm.idle_workqueue->enable = enable;
+		if (enable && !adev->dm.idle_workqueue->running && amdgpu_dm_is_headless(adev))
+			schedule_work(&adev->dm.idle_workqueue->work);
+	}
 }
 
 void dm_helpers_dp_mst_update_branch_bandwidth(
-- 
2.34.1


