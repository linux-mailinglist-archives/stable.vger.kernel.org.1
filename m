Return-Path: <stable+bounces-75871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237597585E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1051281FF1
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50151AE872;
	Wed, 11 Sep 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cxqrUruT"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF51AE865
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071991; cv=fail; b=BRlhhulfhKENtXnKRZlHkGPk9RHnc0NiEX025y95IqJ+TJDrvIUprI+vmKUxDaim27Zye8e2JJfKxTI0BDq6SU9BJqo4/kYLqVSTDoGWnIEnCO7I/Wq6e/in0YD1+Cap2Lw3MRrotkT04BC89ZgFve9l6XF37C+RwDebHDvAgcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071991; c=relaxed/simple;
	bh=33znUgipqWjgTyd1v+3Y8XRNwIcXRQF/GlAlOBgOB8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH1xoxVS7yW5C4bOeGxUohYYDnK3QT0UCaWKjUcZ7uEbUAwEvZ8fUMAYHsRAPq3g+4Gk1bKbxdHx/rbVC7a/wsifdx2qxv0tCEb0fry7eEOBiR40IapU0kY7DRDTPOyeKD+9pASptaxWEg0QudOF3Fmxz/81GdyTUJLZ1cJ8pE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cxqrUruT; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyIlfje6PY+Icc74goqa5qnJ+CDSE4nbI6Nll6u6EquMdKayvYLaogHK3kRRmJzVRRqIgAd1KBtnI/49QFxSTsm38+qjrPy+Vegb9QS34/iwfkuh/nq+3+dKJ7SAGtFmaQ/nNNSEgQVwtFsdydL15tvpm1PDJElwsGgRZjz6PZYbaUrAmGF7l1h5CmqqRIfWn5qzhSI9/XUp76Q/yFq8kO6PkIls4BsRtrT313xe9pvrX8qWMRSkh5f8pnikIAxlPsy2UgiNHepRboayrXjDXn4+fLwTtSVAriNuKbZpxRVo4a7S0Kuxvke8TZg5IdVS95bCEBXStnwbcWQXUDC3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXbdG4+Z2/2Xk+RTT+GN2J7wNY+No9XHFaenDPXDF/0=;
 b=UzjyvCeEthl1lRXYjyA4upzD1tdKjL0CCVVQFxk15kaClTGAGrHt9fQ3tQWwA71zbF3GvSDz45N2vOfNQ7ELWkcbGTiKyxMmg/IXI+BRTSILbsPEIDCk3SfHmDLhHjU/yTmBuV42ssvEDUiWftEmru4nGjaxPveHOyK+UVI4kncWkj9uTAqQsPd5uAi5JgwhRUARSJAdzBqmWGjCXkUBEmPVrRdKpDU4/fuOc5rwiJC0eBLH6EPKCjeWSNBqDfEpGnYP4UuP97Gme9gekBHlKvfEzzHl9WSvRpmOh1u0Tf9rrGiLOBVeEomO2y+13wk8QH4JX3ljyjximhNWbLNvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXbdG4+Z2/2Xk+RTT+GN2J7wNY+No9XHFaenDPXDF/0=;
 b=cxqrUruTZIgD6/kx/bk6YVXFA8+bFyAs+rSXjNrjC3iAei0NMzieyDz+y4lmqzgDaqzhSBT0S5FyUxfmQCdQ+UDxZ901+isA6QMwBVHeCHVpXeN/5yuYpgRgHViLrrhcv+0LrGVCWI5R2TxfsdUMI2dkzxANG5YC6stO+jdLXNM=
Received: from CH2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:610:5b::27)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 11 Sep
 2024 16:26:17 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::fe) by CH2PR07CA0053.outlook.office365.com
 (2603:10b6:610:5b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:26:16 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:26:13 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Chris Park
	<chris.park@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 20/23] drm/amd/display: Use full update for swizzle mode change
Date: Wed, 11 Sep 2024 10:21:02 -0600
Message-ID: <20240911162105.3567133-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 781021aa-6bc4-407d-6ede-08dcd27e761d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q01UTctJ7ciX250ef9ilrvd5XsNcGuo9RByPbYFTtd2EC3JZbSrXNqk3mt49?=
 =?us-ascii?Q?gW55qn7SOWV7Gs2NUHGASlSgKrLLn3MAXEedmrst6/LOL9SMM7aKhgLy9ebZ?=
 =?us-ascii?Q?KSWGpDRjzHvlOl/fICF3+7h3LCJldl043s73iS5joilGgL8VgJ9bdUmN6eHn?=
 =?us-ascii?Q?ZNHNhyz4ohI2WFHtX1j/xiYCZ7JY3QXclqjNvVRO5wIBzZ5cDZH/3V9mKfJj?=
 =?us-ascii?Q?RMB5KSetduNz7qHzN/6FvqG/oZlBLJ/ottkiddUjVzpD3QVzHx9f3kqK6yf4?=
 =?us-ascii?Q?b3OB87mOcWj53+B0S6a+trcuEez9gQnshwg+YZpJrw++ULw/Hv+x3tzjvB3M?=
 =?us-ascii?Q?/NjzL4ZuMLNhJa5qi3cEdTx1EuUkkbWpAhqhvHPcn06d/EyixMwwBZMzTsiy?=
 =?us-ascii?Q?lr6z1lcDZsGqSHLa5tnrNPuOO+sGvBD2nINoh/FdXPHEmtV+hAVTzzQQsdOJ?=
 =?us-ascii?Q?wr3bcIK5njeEAOR0EKDr3pw1Uf9wC9RFn92xY4mrqLE1CsR0sPgX8ZVFIxnW?=
 =?us-ascii?Q?HMMsFIiQz4MLgkyqDMKvADSc7x5Ke83ViXr1UfIQEq4js36Q0aBrpeJ05f58?=
 =?us-ascii?Q?ZaAevWqBj5sUo/JWkZr7FZsf/F/s9+hJfDKF4JyxSxGC/hPU25w5l9UyUSCU?=
 =?us-ascii?Q?dOg+BuOtmKMKzwErxVYWH4vDuf9GnHLK6QWuxJ8XZfHehs4IH3VIR7SkZdjB?=
 =?us-ascii?Q?H9kKucZhaYE/b0qyfBQS/eMrcacyXqCqM7xvbDTTrKMiCJg70RRd76UEutVP?=
 =?us-ascii?Q?4Mb4DZlJM+d1MSybqDrRQL2EUs1DyzDOQFa9BCQdCH/JNnEbULvvwMAa08pS?=
 =?us-ascii?Q?02PS6OkeX83cwNtlBTEKfs9M4O+AmhYGxiyBLNGIrlt2Hrkn99Cu2E2gQSR9?=
 =?us-ascii?Q?C7VSeel1pJ5cb3I4G4axbMjLVhysKtrxpRdSiiLbBL1SdRwFyP/5Z6G8MGip?=
 =?us-ascii?Q?BpvqsU4YeiMvMSHRtbTzO9+5174InVGTAakGKUmMHzn0DG1Ujvqq8DceFjGw?=
 =?us-ascii?Q?PH6D/kPAqmCnzzA7p+cU8pHZpEgzX8TDlDkV6BbLc5X5PiM/fLj0DVfK0viA?=
 =?us-ascii?Q?DWtdcmFT52Jb4URmX9iwwmVtm4l4t7i30LKT6H4zT5oGfrpAtRsgc6bOzyLh?=
 =?us-ascii?Q?0GwjqRqXjVOZsVzEzqcoGsott7AB/DKQ9hEHZ+au2f2snVOv5Cri1xDTHUxT?=
 =?us-ascii?Q?SUeKGxuwKh2KmEAefSFCby2SJ2q6u5dZEpURfSbe11njuaB31yQFXoQ3uZqn?=
 =?us-ascii?Q?ZjsSkrd+WyiF7fWrU3aD0VDd3qfAXZfqnS3Oa+M5F8L9PSQkVkuoQhyRkhFK?=
 =?us-ascii?Q?OjDNtAthQuqreCbae5Kmr5QEFQL0r1NfDgFYIU+hKHU9sdExAKqatitqN5l1?=
 =?us-ascii?Q?54HrKLRK/6HFSPNcMCSE8gQ+4WNN9ISISeZLc1G0qPB2Bgylmwy9s98GCHQ/?=
 =?us-ascii?Q?0OvRbguDs0EsNeqcwFsYcMqvsUiaMLgC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:26:16.8339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781021aa-6bc4-407d-6ede-08dcd27e761d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

From: Charlene Liu <Charlene.Liu@amd.com>

[WHY & HOW]
1) We did linear/non linear transition properly long ago
2) We used that path to handle SystemDisplayEnable
3) We fixed a SystemDisplayEnable inability to fallback to passive by
   impacting the transition flow generically
4) AFMF later relied on the generic transition behavior

Separating the two flows to make (3) non-generic is the best immediate
coarse of action.

DC can discern SSAMPO3 very easily from SDE.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67812fbbb006..a1652130e4be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2376,7 +2376,7 @@ static bool is_surface_in_context(
 	return false;
 }
 
-static enum surface_update_type get_plane_info_update_type(const struct dc_surface_update *u)
+static enum surface_update_type get_plane_info_update_type(const struct dc *dc, const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
@@ -2455,7 +2455,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 		/* todo: below are HW dependent, we should add a hook to
 		 * DCE/N resource and validated there.
 		 */
-		if (u->plane_info->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
+		if (!dc->debug.skip_full_updated_if_possible) {
 			/* swizzled mode requires RQ to be setup properly,
 			 * thus need to run DML to calculate RQ settings
 			 */
@@ -2547,7 +2547,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	update_flags->raw = 0; // Reset all flags
 
-	type = get_plane_info_update_type(u);
+	type = get_plane_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	type = get_scaling_info_update_type(dc, u);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e659f4fed19f..78ebe636389e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1060,6 +1060,7 @@ struct dc_debug_options {
 	bool enable_ips_visual_confirm;
 	unsigned int sharpen_policy;
 	unsigned int scale_to_sharpness_policy;
+	bool skip_full_updated_if_possible;
 };
 
 
-- 
2.34.1


