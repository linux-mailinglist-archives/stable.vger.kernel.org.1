Return-Path: <stable+bounces-118620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6DA3FA77
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264A91891C12
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2F20FAAC;
	Fri, 21 Feb 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j1StKD95"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617481F4275
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153733; cv=fail; b=JsLqvM0SSBsbU9Exh9PpXevehEnx7kWW0QMf/fXM8IWdWnqN/dwQDsD6se3DjZUsqWchyQQilLYuvSf7F31RIOzgSOqPTLO3MfJ0EvZHOcQyDyzFgRFz04fPnaDx1aOLxuvYre380bzxcp1hI2ygMXSzppKXKx+dHYF7XnbkV/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153733; c=relaxed/simple;
	bh=NTmtifc2geJUpHgl9oLfPoMW7dP1hXOaVVqUbmLfLu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQf55ZypIxq50u0TYfcFyQqpFkCJvHZ7u+sA6LJXLZrfuMgP2n4CCSH9fMJ7WS+OQK58AhF7IlKngON9+b6Vy8ZiJGt1Wf+QEiOh0Q6v7tG8dc2cwcAvrOmftxrCXpZrDaCz3bBqRLe4jGf+QcW+yNTzg8twqNdGsNl/UW/3uQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j1StKD95; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0oAt9I2KwXUGd/ZP6zaf9p42TuvYRZaZprYCJSgnBkyWbd4/bGv1/eZ1YCWWABIj0Fu2lONF8M3m62VD1A2MAwaMBf+jFDJoLzs1M7BnEVca7R47MTV4BAvGka8qCmNrxTDE6PujU4awbfGgT8xpB+wz3GMc5O3skic5JiNtUI8yfUY19jsSKAW0/jY2Y77RzKf4gmKamEY8TNJlep+mW8D3oU8gJc6L3SfSRRBjV4nyoQFSBpoPmCNkBo277eP4x81EuaI3rYfSM7YY+H64K49ZP6jdfVziaeYHHNsbEOrHCvkJIMilHHhwoQNy4o5uipFDWfUdPI40NN+9bM4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=HbjJ1NGDLhWkMyxnKTPAV+NgH/7ngj34q681vpiGh7y/QASM80j4KDFB5NfjVQIzo6Yu9v7h/JdYD38Oc51ZdDks40sqoHP+yBvOuwgS1cVy+ajcNRVCklZjyDn4IAv0yH6N2mlIbE1Rluv5h46WmS2jfeYlr6FgYPjv34nf1iRnHMe/DwY93jt+p4o2QeTcZ4/ssAiwXr7tdGoayDatYfNrxnYsXgJHjNuPbjsCKzNHqIKjpkJogPvYftFXeupQp+IcNR3ENUHP8QgHpM1JBenzUee6Lv9gCmEoME4SW43T9KOl9cuudV2lDIPa+Ekb3u49HSooqTAi5GNc9mK4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofj2Ga56Sh9kH5dV1b2zWP46zUSeNNrdUFbTI6mzmfk=;
 b=j1StKD95iTIJ8vG2PY/oU64QY1Nzw0yDetA7Um+a7YZGCIqiCNN8Orm9JYGKr4PMxVpNfl90RppK8kS7VGDeFf98binlN9S2pMJr/ssbEfH/QTixBKVTxNCY8cnns8rtbVmIEx+7/FfKmfrVwcm9ZAfKWfpzXsU2CdP/4vve108=
Received: from PH7PR17CA0070.namprd17.prod.outlook.com (2603:10b6:510:325::10)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:08 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::3d) by PH7PR17CA0070.outlook.office365.com
 (2603:10b6:510:325::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:08 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:02 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 02/24] drm/amd/display: Disable PSR-SU on eDP panels
Date: Fri, 21 Feb 2025 11:01:23 -0500
Message-ID: <20250221160145.1730752-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff8fa4d-b47e-49ec-1eb9-08dd5291180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ga8JaoYCGyDM3dJq85jVk6RkG1mZQbEMYDNsA6DSrQbeBAkX3haJFDwtFVfy?=
 =?us-ascii?Q?3aEotkQkoJXZf0PRCVGw7WooUDNb0McS2pr2c0GdDp+S2oiTxVdHZ1lZKTgV?=
 =?us-ascii?Q?cFTiF53Uoym/gmhgUMWkJFk97xa6DDPcJod4LzgENlYHag5SOTjMfiXob9MK?=
 =?us-ascii?Q?Gl7Tw8b98a3q6fZIYNXPtX8ok6Euo1WXlrTmS71hAjIHoPHZ1elcKIS0UnmJ?=
 =?us-ascii?Q?zV3a73ZEnb7onkIJmXXsGqqf09QSrzh5feNypIdeUQ6AAr3Ny5n7R1HXE9oP?=
 =?us-ascii?Q?46qWC81MaTGA3K8ID0YPFswxIx6Z4per1fQYYLXvwdgL2Uhjl/Ru3nDM5ftz?=
 =?us-ascii?Q?tuYEQsbo/Z8ekmYAvjo7kC2iZ2Z888yfgxRzeI6sbzpsryUtRq3fjZ5NOc5F?=
 =?us-ascii?Q?Bppj9FFj70rykedhU32djSYmaLAsC00A76MxyXzLdbcltRLqLE0mfkXkP3l+?=
 =?us-ascii?Q?locbjHLMHhn4KqfAsTBOIp5wAGD6agrNXaOn02HawDr8UokDAVHh9TlWZiEq?=
 =?us-ascii?Q?eYs+TKK3ynLDEg1fLKxE75xBcueFP5tYiDlBpVOW3XYS9UM8pXKGfqrZdnaM?=
 =?us-ascii?Q?vB2smeCpM0wtCF4tOakUgSVVGdcC46EDQGXMMbw1Iv6TBBUjcU7tyDgHrVA0?=
 =?us-ascii?Q?8pHIVS+082I7CcFufMQGzv17/guq6Wfds2LxZZlLvIc/7AwH59zwiU9yDXIc?=
 =?us-ascii?Q?QDX0/0DvW903F3WpUo7/UFQ8MSIDhGcmHlRvL3BUYZvdkBHcRY6BuMxQivqu?=
 =?us-ascii?Q?F49O5rX7eAgofjX5aRm3YF6gT2fKAe55wfNxw9QOBDHNd991teXmkqWk4bOe?=
 =?us-ascii?Q?FQvCuKVOeLkelh8OtVlS6l4aJaZU5hgZdn2sL+s6ibK6OZGHQCZSOUMj3Jcu?=
 =?us-ascii?Q?bpPxrR95wuF79N+h+vzOjgNIGX3oHp+/u8qX9F/ZLeEJGxLyB9MJ+k0JFJ44?=
 =?us-ascii?Q?prSbvYUGC/+GvfkWwhl1WXWDIWrwpk902QB6bRygWALjf43XndE94Qf8oraM?=
 =?us-ascii?Q?2JacC1agPbndy8qEZw+p248vJ3LfMyXIxkYrChx/yFt0oloIcxVn1cak3gCT?=
 =?us-ascii?Q?cZIrrbJMJvXdb02vYDeTbx3k/PLDsEkSQYfn0cGkd5dOddSsqm0aRve7aNjP?=
 =?us-ascii?Q?EASJ49ObGIeD9ak5N9NYEwjdp6iivZV2Xpyq7fcLOokESQFvzmWdF8BuRHVK?=
 =?us-ascii?Q?VO4i2lpXWeUjBXQdkqkPyLhAGPOsKUZrYXN3iewbm5DskK+fGo827GasfyNS?=
 =?us-ascii?Q?N7Z+pcjbmB4Y+5VRIz/J9FGrUbWZpzJynZEtKN0XKzYpE6sZkJKjR2RRbeIp?=
 =?us-ascii?Q?j7jokzcKTNN+ztlxxAk2rXOKzKZfdCmAgB7544g3kA4teyp/cAvSgCHzfH+Q?=
 =?us-ascii?Q?ljGpCHP6g5u+CRTHKZ80M1uQykOvDEeO267D7sKda/PuLAj17kqUVIrVe5bK?=
 =?us-ascii?Q?HjDRVsrrOwI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:08.2099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff8fa4d-b47e-49ec-1eb9-08dd5291180c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
PSR-SU may cause some glitching randomly on several panels.

[How]
Temporarily disable the PSR-SU and fallback to PSR1 for
all eDP panels.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3388
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 45858bf1523d..e140b7a04d72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -54,7 +54,8 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_PSR_SU)
 		return false;
 
-	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
+	/* Temporarily disable PSR-SU to avoid glitches */
+	return false;
 }
 
 /*
-- 
2.34.1


