Return-Path: <stable+bounces-144094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4387AB49F2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC743A3B9E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796AE1D6DB4;
	Tue, 13 May 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctLkWoMw"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5719D8B2
	for <stable@vger.kernel.org>; Tue, 13 May 2025 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106017; cv=fail; b=FR/GYkcncKZPNmw7jC8BSQqiBLt7ejbr93Yy3VEkkBZaFdQpWjJo18uuMaP3lWWkmY/pxelMVqD7AuQrraE+dEhZvSp5V1fLh0O3qHdc/xWx+j2eOGPcdA/ZBkePN5MKMxwMY/kk3JDqPU37gPC5rKWVwiU4GUKu3Ojz7CJ+p9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106017; c=relaxed/simple;
	bh=IC3D8MjaZP4rS9rxqj6AIG7XI7ZPJzuuOMI7zBlLJBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfQr4IagRPkGFuu+h0uUU2oJf2rb6eYOY/3QsmOGZV8xdn6Ipo6kV91rgm2xrZqVy2l031zhdJ+zIPUbBX/RxhIaAG46+H43mrybfsx2So7IfAti6bVr1JyDHDs0jEHjvhiwO9MubpxKGFuw79hBIN7DMGJNObtUQJxGr0XJgug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctLkWoMw; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMZAbQZwZYO+VGf/PPUscGA2FBlDylrda8iU5QSsEiL6cLCf9dpSyJNvTg1rm9SQDCPZ2esnoJsGCsQ3Ya2GrsmbMVCTNNC1ijB5zycFiWghEhuurf5ufqO0bGo2WZfVsbkfSX9FJiBXCUTAno7QYVbrWUsIEo8kAVqEhyz4XLnk/Ulmreyp89f1Vs8q0CmOIB5V+UtwDSGg4YwJBmTKDlXm6QKRXpaGlucwtrZUEANytvOWqc7JVInPU59RqHwr+4/q0dPkIUeiYYHkSkBsw9qLbTubXBCc9BIO9Y1TfBcwxrfaysFZJOAnQAoFSVHpC4FdnB6TPylx46m2yRGefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nCia4LSlyxLcmzF3bmn313yZhlA1MQqFbk8js91hVo=;
 b=I6pkGgLXJXdgkr4t1wPW5S1xlwHDfmJf+8QfpwrbVW/cP04X3ZImckAtGKVt37ECBh+Mw00SYbxZX21oHqsRrY5AFYe+NdLWTZ1PtnbSsWjgAJ/NgzOK7yqQXSTZIo3hyUv2d7xlLFq0WGMtXckp6XLlODh5u1erXfWa51O6AIl6XUHGwmU08JALFKgVzjha0mHEfLx8uDC6r1yBHuLp/ck/h5zFDOS5ehuheijvJ2G7X26xVH4X+h8m0DdM27A6+fQ7pEFtCNmHZqOHQRU8eowxEGqcaZGwS2v9mnRJ5dqP2u5q5/V8Eyypnk0Ddv4sv4hcdgiqdZGJdlNl0ogWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nCia4LSlyxLcmzF3bmn313yZhlA1MQqFbk8js91hVo=;
 b=ctLkWoMw6YzOMXmoG9QYNTZ+u0j0BOWwM19KE7cHoPxeIXdtVmtIjjPh6U39a71eAY3uu1WEthhka2rF9jAdMtJnEj6HR7hk/8bZvrHoHygaXTTIdwWz1UkM4I5D6BvrNTZwG62NsQC9jOXGz1G2RRe6V4r/Ww9IFS27Rcb+KJg=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 03:13:30 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::2f) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Tue,
 13 May 2025 03:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 03:13:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 22:13:28 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 22:13:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: "amd-gfx @ lists . freedesktop . org--cc=Harry Wentland"
	<harry.wentland@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>
CC: Wayne Lin <Wayne.Lin@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
Date: Tue, 13 May 2025 11:13:05 +0800
Message-ID: <20250513031311.834319-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c30972-3bad-4406-4c9f-08dd91cc22e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5PPawEsWSlreMA5yWZj/cZSjnreB+DsMWgCr80PJzxnLGA413mvm2ZNIfmWk?=
 =?us-ascii?Q?6b2yXyM39+JC4kmfXNnRs3M37cDbZoDlUL4fVc9gAGsTJyCJqkRinJQjYgJ8?=
 =?us-ascii?Q?wVxL7nYYPR1/vODvNdY8e3NEw5MSHxcqGO2hLQ3lF2zzSKA7IZpu1e4UGmGw?=
 =?us-ascii?Q?jjIWRZNE1r7CcL15eN9sj3tNPfQD4hgAHhjFrSiLniqA9MB9gvQj/H7Dpu7n?=
 =?us-ascii?Q?RwUtLioGtTltSPSlV9kWm5DDshBDrwLhPLBJT/eeIw+fslTCXHXXSYQaC3gM?=
 =?us-ascii?Q?rE5zWdOCFcDBdZZRSHOhq+ZvbNeplh3ZOmAFsw6lKL2s50ps3zEufTdKX+yb?=
 =?us-ascii?Q?u2PTSnk3j30ULspcEqDkerMvrxxflUbg4/fo8mcoOHNjFdJYZDaHY9+WWsOG?=
 =?us-ascii?Q?ARdHyjCl+Kp/1rqb/MnTw8KJBLpSA63h3uYGFX+StakPFxvDkrijvY+rgo3r?=
 =?us-ascii?Q?DKh4kgK9Vw4jr+5IzpusGtInIMk4qUugaIW5E7u8jrJygmVod/XS1UTE/Sw5?=
 =?us-ascii?Q?y2ZB9dLAO7ibve8Uq5MmO6nhCEESc9/byuH2AoANuq+Ba5BRWwPMrj8uAM9w?=
 =?us-ascii?Q?aFDGAXuGu0rxf9PNN+BwYQVwFP+XxHu4wNRqreS4TMMGOjMiE2IgWcNC9ncK?=
 =?us-ascii?Q?WKQgvRfsp95KGqzK7x97iEFdIirk26XGLGKOyyfoHd+rJPnZDkrSaHQ+OXKB?=
 =?us-ascii?Q?GzPn0m/My/DIJUMtGU4FGyIRa2Z5Mg2giTcWm/MRSRzcxshhX4/qMTRXwixM?=
 =?us-ascii?Q?VOjuYJHzqwcWQbTnYJNx+HSMjr4N95JhZlSSlMvzq8WHEF/OoD7us3t3lPoc?=
 =?us-ascii?Q?jm50uM6tOs9ZAkuefOA6+iTIgArI/dwOFUWXAaNbQcPkK85J7rz2DM97o0BK?=
 =?us-ascii?Q?O7RVc4XRFzW1f0STfx88ZSojMzsTmencukCWgE4eID+HVmCDp4a+o8hQA/2f?=
 =?us-ascii?Q?vMTfzVt4UetY8aP84XXuDr0kV6eAA8ZdbCAntr8jijn8OEt46IJ1wNQ6DVTs?=
 =?us-ascii?Q?jhIyvcUSAMoafijT0YhrpHag+aBlsjqr7vb3Dm0vR1JdjuU0t+pNLsI3I/jj?=
 =?us-ascii?Q?CtNuHL2Y8McIW0Rib71uQyjE/jMnqIDr0EbxHRmBwkW7supGXE3UTIrmpBmp?=
 =?us-ascii?Q?9zcnypWREkvc0wO+OaNyo4s5ZB4WhHPgX8qEVAzsOKMQ9XOe5okExeEYnfUg?=
 =?us-ascii?Q?qroPuDfG3XzhCA5kdy7+OiHyACENGIhGU+uMcOnEuP56SWLDJsAGCVr5rdzC?=
 =?us-ascii?Q?r+otUElmFchsw2phNVpMqlL0p7Dk0aHznX/zwv0AkaJdTBPd9sdgmDC0pZur?=
 =?us-ascii?Q?jJCIhIb6XdOPWN72XFWRHdsSc2TGmrn2D5120MVeGF6AFiyR+tP2HjsxJJB8?=
 =?us-ascii?Q?VZQ1uPdl1WjGD5Lbf1kw95IC5Dsq3P4bCGA6UBL0ZDPoLPCyhDZOLjcc1C5a?=
 =?us-ascii?Q?yLY5afk0iEXD57WIWftm0Zz2if4Df9nipwQXd+RQIl+iAGh3oljB+9/bU+8X?=
 =?us-ascii?Q?YjOCz4v97foV3bqFc/hPociZ/E3YJO058ibP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 03:13:29.9725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c30972-3bad-4406-4c9f-08dd91cc22e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

It's expected that we'll encounter temporary exceptions
during aux transactions. Adjust logging from drm_info to
drm_dbg_dp to prevent flooding with unnecessary log messages.

Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0d7b72c75802..25e8befbcc47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (payload.write && result >= 0) {
 		if (result) {
 			/*one byte indicating partially written bytes*/
-			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
 			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
@@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;
-- 
2.43.0


