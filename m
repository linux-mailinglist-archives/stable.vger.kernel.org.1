Return-Path: <stable+bounces-195385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACCC75E6A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9E5034A1C3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD03370E9;
	Thu, 20 Nov 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQq4jDxz"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1F2FB99A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662845; cv=fail; b=igWDVrPNXMDuSMMPW/WR51mkmvLLF4ScPpOCshrPRkG5DOlNXkXbidmwt4XziXhFcyK+rsvk0afD9cx6125pEe5Jj/nXgLHeq8WAWsfNRV9nm08dwVbrfiA1gLAURBXhhOUqOzK6doaLfbb9ECCTTpB/bTCbCUGxOe70sO2WTF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662845; c=relaxed/simple;
	bh=ZBMhf1HN+V30dNsk5f+lGRYEFks9kpp6jm0EKQtl4FY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNuwrUI15SyyrPBrYbYHMswZaN3H6NMFXMmhS/9Noxnufi4VHkQxNl/U2UekneOCQTwxfsUjb4Pm4Jx0MVK/BgtRp4pwMfYHgmXwIwYRNetD3u/sqQs6qRuLxq8oN/50KKdu5qtOWbgHazf5gsTHzBRzaVvpkbstm+0nS7m1j8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQq4jDxz; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T89ixPIAIXc4CKJlPp6mN3nb4yTdaKqeN/9luGNsDsriO+3eAmlHk2jOadooCBlWUQGmrWYp+InfsslByImMVMmRVG6AQQTJWRYAG5xI/eBmfDaOcLFxxgDNNTk90hjZE0pXq2hwyoKy0oOb5RWuc8V/ZQdiG7+bU+nvR7hprsY3bz/cF3kBE2PnM1AZDqkrDeAO6rBIUuucujzZJZ4QHcYptmq3Fbbqv9bboQ3svkVzuwoosqIgg/7TELXDgxd1O/XCILKyQNSTGFDKvH2S0e/lghljWzVq15DUltmpcEnemJfU6iZMF/OrYf+uIV/aznfRKc4VLOzolKjUQexMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDFjqOU55HS0x4O/OG5K5Sh1/gMZx868GYoGuOjbMsM=;
 b=WoY8YaZXOaC94EazvUKtLuDBZbvYh9h/gsAUlWeTcUY+SLOBPFJ0AXyS6kHoZD72MJkJksMguLjt/s32+/KB7E9iJctvTZsqUiX6eVcLc8C5HCG4bedjsLK9PUt8TsCrxmavfNXe/ZnjzZohLYDEbYIPceyKI5cGbB1WdsjR7a7SfgY2keseMYW2KVuiBztG/m7tw38DyBrXrv7hsJJWxtdItpuhEA+4tunTsuK/OWtq8V5yocL2m8tW2FuqfPrtSfBpP2iZcS8a0BTjmo7pVQpN6lQ9kK+H2cskUQuHiuuZn6AhFKMPQcYEWC0Mr6qGAnDI5yM1k7mjOUD1JKwiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDFjqOU55HS0x4O/OG5K5Sh1/gMZx868GYoGuOjbMsM=;
 b=wQq4jDxzUOXa3VqwFKld8BI9n9uI1MqSDPKAu4aNdskC7Ai3gcox6OflXI+GSiPYleO6z1hTfxGygksDjKLyVRZSfvBI5hKuiJI1+8vrA9mxHZgUNFko07OWaXwPpUyZSY6QfXaJzqZaECBgVoyCRpK2BI/na7xPKWPonYqJkPU=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:20:40 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::68) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:20:40 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:20:37 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 15/26] drm/amd/display: Increase EDID read retries
Date: Thu, 20 Nov 2025 11:03:11 -0700
Message-ID: <20251120181527.317107-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b7808c-efce-4d6c-0ef7-08de286182ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YDwJl5YwqnXasZeGJFQRc5D1xMifKggibCDhZl5f0G7aVE915NyOZO2iQQs5?=
 =?us-ascii?Q?BdflaF+dzUlkDemTsrFjZl1cKrHHLp5rL5IgRI/YAo4MEDnjB7TDfYqeMhM6?=
 =?us-ascii?Q?afw/bbg8O81PmKO990nJYtxFO/b5bxY/JPXHeq3B4OwHePWTCnZEIv64YwpD?=
 =?us-ascii?Q?aYJUY1iOeGhUtZfXg4dWdWtm8DTRPh1AfG3Udb35+jt9Gm7BuRDFgAuUIe7M?=
 =?us-ascii?Q?WIF8+PwU8oEejqx4y6DDWVTrBQ2zURxgtBWGTCarGHv9P+r/xR325i+4NGE1?=
 =?us-ascii?Q?lZwzVZzRfWYPyyo6lD8wXDKYOTQ6bjj49NNyp/DVuP7cb+l5M0yvpEROunOA?=
 =?us-ascii?Q?WIRfb5Czv1WwbTX2fjLkOXxwdm5BgmDSoFcu+lZ0F9ac70TWMZmAfZm/L0Ag?=
 =?us-ascii?Q?D+SSdEm+8NS8P+ROSb7pANZv3BJ7mGu6ePO5nEKQTf1rQez/KNlIVxVIj+eD?=
 =?us-ascii?Q?Uk2n0AXeq2zVwEcMuhS9yKnEgFNwm0Mq9YTk7nUvbDZOZ92LYQKdMXosimxV?=
 =?us-ascii?Q?R1NXyecq4TsxjAlUrNQo/oiUk1lxlKc1unLKyTbiexZAUo/Iq73h1O5VZeHH?=
 =?us-ascii?Q?1kEtHrX5wdo6ubbDIC7HBG8tCs2mjrcK7GKfZof40mVW0mwHDhuZ+J8lsJE+?=
 =?us-ascii?Q?Kh8En3uZdnRvCvZefHWZ9rSZwbXuQ8rlJ35zD0vcv5+mU7CaVToLx/TGbOur?=
 =?us-ascii?Q?1SgVfaretfhhjXwgMQEYZ5y/l3QoWhLWqN4mmByd98XtXUccwGo/14DLHPm5?=
 =?us-ascii?Q?+74NbPhT3SQdTaBr2apberauRnOnjQcNAcjpI8xRtKV4MUNAx0HjuD6uSvfM?=
 =?us-ascii?Q?ouiFKTgMk6We2EO7EGo7yRQLW4vQb2wRGC0FQ4i4eZ27a74RfzF/YaY3iKP6?=
 =?us-ascii?Q?UsBksaou7X1lTcD+zqpTsu1+b6xyIh7TOpQWPBPya8+7IK+awdWEp1f3d4/4?=
 =?us-ascii?Q?MDLMwIzWV6ZbdT1IXxD1BjNXX8OJ0dc1yhbzfucuZUiDPz+4OiGTwoHItCeq?=
 =?us-ascii?Q?R5P/iLSnNMYwOF2b8CJEWBO8h/tF2xo4790CngdrMzTmag3+Wm67zxdWbrtl?=
 =?us-ascii?Q?sP2PqUIUfTszSEiP7N7U1pO8F29ZyDgJAZrkx83SMi9GtN0B4oPjGvoSeE9i?=
 =?us-ascii?Q?t9LHKCiV9mx6YAztOrPvnZKLUpQ2VDOi5/Vl6f6rYjuvjIFrgkCYW8sWMm1z?=
 =?us-ascii?Q?0/H60cWPZpqdvx0eofMQPIsqSYugGofCk+NbdYMKG9R8NxHQhb1t37KYtaDS?=
 =?us-ascii?Q?gXUPfj92d8eWUd8ttzVtiDGUmZbuUoAlZoL5U2G0LLCqBCVOT2FVxLcrd9Db?=
 =?us-ascii?Q?Or6cb3VSfslEY6kbBAMcucoCfpceR1ko4V/JC12fmBoUSBQsXFfIM2tgWw9o?=
 =?us-ascii?Q?9+UI0qKZ5MqCbldzzkM7T9aVo9TzE3JbuJOJF0+WtnHlRePhFRmDlDMkoRbZ?=
 =?us-ascii?Q?9F036WAHBkVU2W3GDVKfh1Q/xsatWwyd3eFdxRVcL723J3m7uUyolwkmfTlU?=
 =?us-ascii?Q?qdyOI0YxIBFggFSy68M07rkFTNlD79ZjkoJIevTDXSjBtp3qbNXZcluMdrPv?=
 =?us-ascii?Q?Dv+7H8scXsDJ495kWGc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:20:40.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b7808c-efce-4d6c-0ef7-08de286182ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[WHY]
When monitor is still booting EDID read can fail while DPCD read
is successful.  In this case no EDID data will be returned, and this
could happen for a while.

[HOW]
Increase number of attempts to read EDID in dm_helpers_read_local_edid()
to 25.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4672

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 582a1c04f035..e5e993d3ef74 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1006,8 +1006,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
 	struct i2c_adapter *ddc;
-	int retry = 3;
-	enum dc_edid_status edid_status;
+	int retry = 25;
+	enum dc_edid_status edid_status = EDID_NO_RESPONSE;
 	const struct drm_edid *drm_edid;
 	const struct edid *edid;
 
@@ -1037,7 +1037,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		}
 
 		if (!drm_edid)
-			return EDID_NO_RESPONSE;
+			continue;
 
 		edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 		if (!edid ||
@@ -1055,7 +1055,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 						&sink->dc_edid,
 						&sink->edid_caps);
 
-	} while (edid_status == EDID_BAD_CHECKSUM && --retry > 0);
+	} while ((edid_status == EDID_BAD_CHECKSUM || edid_status == EDID_NO_RESPONSE) && --retry > 0);
 
 	if (edid_status != EDID_OK)
 		DRM_ERROR("EDID err: %d, on connector: %s",
-- 
2.43.0


