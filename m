Return-Path: <stable+bounces-127424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EBA792D0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 18:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C802D16B72D
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8D18B47E;
	Wed,  2 Apr 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R8Hzs5XS"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDE27735
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610429; cv=fail; b=nYlHjJHVLYoF5V/fyIsYlu68MCY2pe+CK588Esk13UMmCqSIAt0BurDH1s5by8ba7ItqYcKsbPkPs0bhz4bLnPkDNSmPbsJhjsE9J9tHEQM5Db5COpdeQHT55ElwbED+MhZDh5mOQJuzuE0qaNybAStxypvBIHAAhoWzADrytIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610429; c=relaxed/simple;
	bh=bqVfRbzn95Gvhj2wXqevSjjHOSgluCqDLHukDzN3Jw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHcL8NoMtP/IUuASWO3mw4oyZGu7OUPrhh3DOvnrapgC/CnvMOstA39Qg57AnHLuMR8wSkdMeZKR6WDLPgONA815jmAru1E77/V07SFpeOVE7s6+6m7VrScJhAAWmATC/+EBB5qxiH6hVin2qYeGzYQ94C5v6PX3JFESPsN+eP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R8Hzs5XS; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE5W6g8aVhVqaqybxnsqw0ANiO6tkzVJSMzQeCPLeuJOZuIDDtUvkdkzmhf0k3osKGOqEhXa5t+mrqRy/Hq5ldvpWh2reoqEXVxb3m9tqB/ve11wBeorsq9VaAhLMtu7fDGhmNFyTSgKesNHiqgoiuyCz0e3FQooHCpXoFabl+OXUClDMHyGl1XQ+zBPa1qopj8jsoGmI2px5tKN3kOqepF4/JDjG8lwoq3SbBOid6DUBDiIqvrz/kSWVXOVmxvCywuAeqv25iyIEoG6PjDvK1p008dbSTqX9FresPn/2qLIFgN8E7biu+uJHg2e9qrphHnwTI5lftyxRQbUXDZMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYQLYyjfy0m9kCzajtBAkRJjTfviYHcKR7Q4rpsJvng=;
 b=PzvOw0+RlCy+8z1xq6fPtObaX6rYugBt6KQGpRQ20vtUdmLooraRIyOpeykR6XoGtKfvigjFm9mQwRb9yUKVO8JFLSLwrvkEM2dTGZFeZtn1IJOzK7uAIuI1XcSyZq+fRxrreQ462Q0RDxggeWtVGCzdDgJ0/RiarDYGvJsASApRAFdK93j2OI39ZGrCk2ZAi4+EkOihFzTdGVNuZUAVZA5CptQNqajFMxVjym4y0BvDckEXYCdo1bOCsUBz9EfH2Ys+sTBMymoec/Iyo5udm617yfYroRUiX/DYXbZ2HBqrfATHSRQ48rbvn+q38b7z9cWcfbeV84DbJHq7dofQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYQLYyjfy0m9kCzajtBAkRJjTfviYHcKR7Q4rpsJvng=;
 b=R8Hzs5XS0J+g5wXUM30biYOQIV/eTyYMqaOI84jtfzUPwsB8ay1gwnhm07rhC+kUY8ivfjaEFQGiugYblQRcGt3GfmaZf2ECX8czc7jtNY+CK/29lt2azoaC2DExiccjrvjWoUsdNCzRzrbdT7gAnLFSTimKHMGZYduSCQFtyvI=
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 16:13:43 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::e2) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 16:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:42 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:42 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Add HP Elitebook 645 to the quirk list for eDP on DP1
Date: Wed, 2 Apr 2025 12:13:12 -0400
Message-ID: <20250402161320.983072-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3fc3a4-d1d0-4724-740f-08dd720156ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+o1q+f9YqzQZYdo2JlxMnSWvFkdIKeYI1fYgq7TomARFUhbQ7M1w8Ps+bUqU?=
 =?us-ascii?Q?IiWLb7LmMqMg/REX1h7zrTl0LQXAN+4mDfwowHKEcFWUCS3miGPAz7EK0Ztj?=
 =?us-ascii?Q?2sEVyqA9krXJJ0Vx0mIQ0rP7wX3bsVu/GRQQJn5EkWS4ccQqQkxh4qeP6PBz?=
 =?us-ascii?Q?Sr4w0CHOsmCXRpVUpQ1dxxoHb90L5AUT71DTcs1ExfPzzILAjbki+TDKeetU?=
 =?us-ascii?Q?o/BLZbZ4NgEarhlYVNiPA3KWpOW0Ab2xfskXxkV+bjgyo/qCdYBjWdYeuwLY?=
 =?us-ascii?Q?3+VCRH25pIsQodFKjdxV4ngN5uQG2pndIH4ekkW+OhfxQOCxKHgBJ5hF16DF?=
 =?us-ascii?Q?wjtG90wSGMgQkYwqKpCA+uxkMUgSKZFiWaqQYH+/RrP9V90n09np3cdPh+h5?=
 =?us-ascii?Q?nufZYHkhoCaevstDjXPhxQsLbnLDJNle+rGsSZWmLOPHFUR1iZbxj4+mhmfT?=
 =?us-ascii?Q?lcc/iz4mgSZGVHLlWw46qR5FhgwMN5K1WafitxcfAAW3xSL7vprnQx5pPUeU?=
 =?us-ascii?Q?tCKd6Y+gt+pA+NA6Y/y+BeMnTflG3vXtk/4G+Zxubtc80V3EQllfDLH7vmKa?=
 =?us-ascii?Q?YlhlE9w7R6xJZXujNMjiF2bGVrOR30XRefC35pv2uW5l0+6qp8HkE94T7RHd?=
 =?us-ascii?Q?2zUApmNBNYZiQPO3L2rmyyzDiuELhi5iXbMITjMluTlDDo+dL2N6ZfI1NPte?=
 =?us-ascii?Q?bm+kmeF4dNzzz4eeiOt4sxqRQ4QEGLHwtHq4/+zXF2kydipROhvr9Dtu9Ahw?=
 =?us-ascii?Q?g4WQAv1rWb+OeeeDaLvhXpGAwR3sTuihXyb7hSwLhiRDA8VR5LoYpFDn0DiW?=
 =?us-ascii?Q?ObSeIQW8UXpkw+xbWrXN9GGBgHkk+nXyqOdodbcOjp5bo/6kLF9/4WwxWBLI?=
 =?us-ascii?Q?DGzoO/MRsNH9QlcJwohcuHXY5qcgksOHP+OJATt2NZefdQ9Wgy1vS04eYixq?=
 =?us-ascii?Q?gilHp/DuXUSbHoMGHHsGz3OTPqewXV0rXNkp55+IsUF8oRHVV/91s5dnHIss?=
 =?us-ascii?Q?WJDbRIOoDVasjg3ND4v+Xn7fTyMgGLa54bA7+fHMinPwNdyPnENzSQAZDfjI?=
 =?us-ascii?Q?WPqvIrpgyuPeXUqtML/cH7h+mSUWc0LWE7JhxEdBD0MBunNGheMI/ZlZeFII?=
 =?us-ascii?Q?dL2s8Izozh3qYSkAgshlefvOAtaopGXSLgeexY79AdASLdVJL1rZ8jSxKhb5?=
 =?us-ascii?Q?s6FxLp6iWlkMNvB8y7eILV4b9XC+K80hUZb4OgMVPu77jiYbM4kFZSWIJHeH?=
 =?us-ascii?Q?lCY5WCAyvov8DLgt3pAe23jg50NY+qiiqupsTPD0WkBUowa83fRPgxWsKXKt?=
 =?us-ascii?Q?zs5jngyYuKq70tqcczI6LyAbaRpbdozfJMHLZTu5VZsX5nv7j6qv6Bqp8FDj?=
 =?us-ascii?Q?RrLb7knpyzmtio+lpLwhUbbMf+DoWksq/ZFoSjDS53rYMr+KP24CO8WH6zvu?=
 =?us-ascii?Q?GIRjFq3+JLU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:43.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3fc3a4-d1d0-4724-740f-08dd720156ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
HP Elitebook 645 has DP0 and DP1 swapped.

[How]
Add HP Elitebook 645 to DP0/DP1 swap quirk list.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3701

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b2bb2f92db00..8665bd3cb75a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1760,6 +1760,13 @@ static const struct dmi_system_id dmi_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite mt645 G8 Mobile Thin Client"),
 		},
 	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 645 14 inch G11 Notebook PC"),
+		},
+	},
 	{
 		.callback = edp0_on_dp1_callback,
 		.matches = {
-- 
2.34.1


