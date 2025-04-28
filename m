Return-Path: <stable+bounces-136896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B34A9F2FB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21531A80574
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E6269D16;
	Mon, 28 Apr 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ew+uA95Q"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBA20CCDF
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848675; cv=fail; b=QeMV9j6ZHqkdfv1keUiUpQvsUmvstCvixbdklefLNMnP0L0QSPTnyAaUGl/BO30AZOKJRy8dOlfYGMPl0zN9dLJmswyem+3XHxyWAr/PVZiKg0y7Vj3yXCVyaZA28XvgTxulJELspLgnnb0Gwn75BJrGzGvlJLyZebo/CDwT+O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848675; c=relaxed/simple;
	bh=qWFJpIvr3UgGJrHwuZ/lcvYljluIftR/rsQ6SfB09rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR58F+PEF47GWjS2fra413EFRLnvDTUEzD1a0BqI/FuA/N4IXkQG9dxBfKUjBexhPVhqyrXUAI7wNurg/g5MqG3BoEghimTIj/qmZD7g2BnFt9weh9v7O5zz34weaV1dPvGAittRdQqmWHw/qIWHX75k52ONeG8YujJj5IxLto8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ew+uA95Q; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUp6tVsty7yDFWSYitCB2/SRoe1q00iFplm+xAmfeDKEuYmhG5RZx9tZHgq3xtUkykDlvywxO6ZxAtVusjl0x06E8N9M/yuT1G9D4qgMQ4d4+5OGCMeA1tn0WltYKVZeI0WGQgGivnVL/z00SK9JLJshjQwTyTPpbQqt9qqvl6GhadcOSerxH0d/Pna/qOF5x5D6hcdcrxZtvPTqYG6I72qVXeMd/YwpyDP4Lza4smr9ORj1twSRSqhQYg0koT40sNop+l3AR2KBhqdXzR7MZXYc/qvDt8SPazMADls6EkEsKi/V5Egt7qjxwc9x6ydM3xYzGLfUY12zDwcGiJFonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLcIXdvbcjRz8fJg+NUpsAJr2/c2SJ2FNrKi2dyVOAI=;
 b=kGNLK+bb03KduTDhvIrKz2fYyD1FD7/BubleJ613V9p5mEAsHPFNo7GiLcMEFhlai8qlYmKcDp0QPZewMpcX3m6R/6X87Tt825s15y28/7jXoIsGusSEvME1IPx7lqWt2MQIA4Pq7xHA+871NWts/WWNI8EncwGhL6veprJbqncpPsqKL7ATBMgWktFkNC9ZuoNwF+uzJryhOAKx/3ZE/1gVXE/qK3ksOi2xVMJOntXfAUPhatgvkVAO5OCyOil7l9JymRS0KFA8NWmqFKBgutmhtL7jfCJ6jvzOOtHlIgVT8BnLG/xBm3atpUeeZFRgtkWjZUy+oUgxrBb4UGMQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLcIXdvbcjRz8fJg+NUpsAJr2/c2SJ2FNrKi2dyVOAI=;
 b=Ew+uA95QEpZlTmBoXiVD+La3q1SixFH7Qakc3wDw1exIylKnx+jB4d1JytuAeTwmA+ZhUk4oVjStExgKiA4HaR6Jt9akqWDt5MnYXxvV+zsBz9TDpd2XCiHGVyWpqmyZ+Mnk3fXSQ5IYCaqgJD0Mp80CQf3ntSCq8a4Uj89t7/I=
Received: from CH5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610:1f0::26)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:57:49 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::dd) by CH5PR05CA0013.outlook.office365.com
 (2603:10b6:610:1f0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Mon,
 28 Apr 2025 13:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:48 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:40 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 26/28] drm/amd/display: Fix wrong handling for AUX_DEFER case
Date: Mon, 28 Apr 2025 21:50:56 +0800
Message-ID: <20250428135514.20775-27-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 801f45cc-87d8-4bad-0aad-08dd865ca96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5HY0aGS0FMBJg8TtzUW4LQ8gKChVs+nFqrWaJye3Qhlhq1vyS70c5RjM4DJ?=
 =?us-ascii?Q?LwE33YFY7ZT3UW9enXwg0P00rlEQRpvfaIVyvzkxJF5Emi/QYpEyF5pjNk2T?=
 =?us-ascii?Q?rUvtUUCp0AS46gXqr8CZliX69y6nwnOf8MDbF8r6TZv0ydkCQGtIcRHlDXyg?=
 =?us-ascii?Q?FpBop8PGdCW2Vt0UxNx5BSmAp0PAo/88diSoXESqIkG5RJCvrft08GOKEKHc?=
 =?us-ascii?Q?FkppRWgfBuhqsiNJNpJaEIrh5GhmsUEBwVMgIbGPEnqxvEoI1FpbdIEd0f3J?=
 =?us-ascii?Q?IT/cl15vmUNAlKYL59t9M7BAWW0KYelSHtrP3kW0UjHBam+lGPYopMzNkkOJ?=
 =?us-ascii?Q?r1xqupUKddyrFdWwrwZqyC4xuF+KKni5X3vzo38m30F8lxZkxBZiVK9x71dx?=
 =?us-ascii?Q?bDReNjXF7HtOxCQ4/9A9H3s3WVeCiwJKgRu2Qd9MT31W9CBmr0N6L3Do4VE+?=
 =?us-ascii?Q?JQGKxfdcZ8EzODMWk/qPRbcDog0Td3mrbxhhzIfGPQc8z0ih7CX0DppNR+kn?=
 =?us-ascii?Q?3GmDIPIoZ9FIdiGl97Z6nIisGswWqg7SMArd7SwB7051d87o14w863BxN5Oq?=
 =?us-ascii?Q?JMrq5cJrWkY8kcFS/2lNv6W0xCURnkJUM9m8H+Q7i2JAUMqEt94vIs26n2UB?=
 =?us-ascii?Q?qqm2jAbbbTXIsVCYGYTG6f7cqd2oKua8ULPha0j1nIkKqvLoJ9pX7tGbuxr9?=
 =?us-ascii?Q?1aqC75X5uC/XRjQ+HB5QCbtHBwGkzqftdkrCMGKgqkceQjKBRVfiRudbcs0H?=
 =?us-ascii?Q?PeEsAOdUCxQ8PLzlDy2kelGkyB69P8Okcz3aaTvpPhAKUYfg/DsKVHivQiqP?=
 =?us-ascii?Q?Nkp3Yxmva1iMsVFKRHWWzfAkRLx2r7lviuHmhDHhVmpehB0VyzEIUpfhxFvi?=
 =?us-ascii?Q?/N/FHelt147zwuKRjCp9gylOk0Z9rotI5EaY9UDgaCZPsNW0Vp5OkTTbtufJ?=
 =?us-ascii?Q?Yy472E2V6xXQOL98FF+EnLy7Dv+JvJhZdFEn5Fahi5kukM0WMGMfWrVFpQCd?=
 =?us-ascii?Q?4ijRVlSCqQUkjekooRlzkUSvWbYmPBeiXRw+VwuOTLRz5PAliLKE3+yZXSaz?=
 =?us-ascii?Q?USGO49JrpTOuMN8N+2Fz6ORvTkwfAZqnG1sxuw1ydy99gYmzN0BrtfNpWICq?=
 =?us-ascii?Q?YaGzUxf8zNwUEIM+csK/+JUABzQog0/Mjtxxct5r7q1usYwB22Kt+umaEM+a?=
 =?us-ascii?Q?Ob0YOhcdzAJnDVBqTFqAFWMvCIWvmqjLORZkMXjvE9Q8kBI5R5uNRHkD4ug9?=
 =?us-ascii?Q?FCCKF3DuPXNgF2ttZP8d+EF930In3SoZ2L8+AJ2FTII04TK61yG6PrNkvC/t?=
 =?us-ascii?Q?wvREWwvmRDZDYF1725FXir97c9Xqo8NN2Ko+8Q6kxzfMQ/5GuN39BD8Dw9h1?=
 =?us-ascii?Q?7QkN4SqO7UBj+vzo/XGdsEWev06sDGOCQvKUpvxWxtR7emQVnwUL7FMazSi7?=
 =?us-ascii?Q?0d631oYm6qgEmLgff9qcrBwagy+82/08gekpxEKq8ZGhRfSeQvD464lnQn0j?=
 =?us-ascii?Q?4ZhtjW65XjwThg/Bt2FviOqlSgg250EfzXcq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:49.3583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801f45cc-87d8-4bad-0aad-08dd865ca96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
We incorrectly ack all bytes get written when the reply actually is defer.
When it's defer, means sink is not ready for the request. We should
retry the request.

[How]
Only reply all data get written when receive I2C_ACK|AUX_ACK. Otherwise,
reply the number of actual written bytes received from the sink.
Add some messages to facilitate debugging as well.

Fixes: ad6756b4d773 ("drm/amd/display: Shift dc link aux to aux_payload")
Cc: stable@vger.kernel.org
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d8dcfb3efaaa..d19aea595722 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -51,6 +51,9 @@
 
 #define PEAK_FACTOR_X1000 1006
 
+/*
+ * This function handles both native AUX and I2C-Over-AUX transactions.
+ */
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
@@ -87,15 +90,25 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-			result = 0;
+			result = msg->size;
 			operation_result = AUX_RET_SUCCESS;
 		}
 	}
 
-	if (payload.write && result >= 0)
-		result = msg->size;
+	/*
+	 * result equals to 0 includes the cases of AUX_DEFER/I2C_DEFER
+	 */
+	if (payload.write && result >= 0) {
+		if (result) {
+			/*one byte indicating partially written bytes. Force 0 to retry*/
+			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			result = 0;
+		} else if (!payload.reply[0])
+			/*I2C_ACK|AUX_ACK*/
+			result = msg->size;
+	}
 
-	if (result < 0)
+	if (result < 0) {
 		switch (operation_result) {
 		case AUX_RET_SUCCESS:
 			break;
@@ -114,6 +127,13 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
+		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+	}
+
+	if (payload.reply[0])
+		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+			payload.reply[0]);
+
 	return result;
 }
 
-- 
2.43.0


