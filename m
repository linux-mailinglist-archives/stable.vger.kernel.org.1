Return-Path: <stable+bounces-169472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2218DB2577F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF61C7A5CE3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5F2F659D;
	Wed, 13 Aug 2025 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZScLwcKq"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282672D0C80
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127713; cv=fail; b=MXN43VKanM8XAdZ88iPJwhBUL/BUTWOjViN0kd6ri+c9FAmdZgZwpy7nWXpMZaIc0g4WA0/4uX15SoCFbd1bXpJ2euvRN6UzwvQVTfyd80tLfGJ1EYeeiHWzi0b/Lacce0g5bwaEKaq8tq5UtERshTAVL8sslCJW2N/XE+rcy3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127713; c=relaxed/simple;
	bh=hAn/WpPLyN/aqK2nrcL7iqKpzcd9V4hJSmAwSdzReKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1hzEYlF6eTeZfO9614/fjHw7oZYGvPAllZlbAFwJYdNDPwpl+PIjiNXqc9BCJLGnd0Wgg9rskWg90O5zmVPedI+ar7LUZIHTSjBCxX6AEFq8orrjVJkwdUBzU1UeKi4XMlu5ZtXXn7BaG5IJT+eqnY6GhgKURHT3tAEezukuz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZScLwcKq; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNOqpq3Ow55iI4Gt//o9qvolgTPPYQnIbSQqEbEYZVbN35ybtUVBUHTUg0whyOvt9AnaHVVHnE/ePOBJ7vDcHPOqOgAWLrbbsHkZVlTJUCBPJyFO17U6m3v/7qZ3C8bmdt1KH7YWVVg6uDyFeiM1sgj1lZ2OwIpsv++WlNb93fdgL7nsN2J/E+ccNnMI1FJ9nGmx5lDJCA43AbdUU+hJ/v3E9XmXLaPou+Up5iUmjkqZivRQjFjN0XMlevB2V0bK1H4FxpJeKU0SfOihzbeq9hNGa6UzvUahl9FdejRI9j9gbiK6m6Ygf8KH3adShRjV9zgXav3Q+ifo5l1svM61qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnA02e47peo1KK1YDyTgd6W1xvoOtS0AFvOA+crvKd8=;
 b=GM8cgT+itpXkzlFfjz0cEl+ftVDGvRtPSXZJZya1NcoLr6G8PpoGbknO6QqoRw/lgssO7zEbfWInzujHzXo+TomEQcuF6jx9sJQp+kWPkWKGvL89vJwLmWp0Hn+yT+chZgGSpMk0cBq7Ib9nWhEkk6wO6XEMlHudkHQSxxmFmC+2BOP1nzp41wAWibUYmjzYTrUzRzOU4hLt5Qw1D2B5bp6uXLHFwR0mHrBKpIbkOY5KMHtg3ErnolEpwS4pIyjf4OAA6MV36v2rgSDj5sOtCtMp/jbs35a00EMgMypAHj42fXcoy/UNi5GE5Wld9lruuxD45DJwEY+tWtVC+ojRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnA02e47peo1KK1YDyTgd6W1xvoOtS0AFvOA+crvKd8=;
 b=ZScLwcKqjIPrYXzGS42uKmJ3j2teix5BAsrU7ic2fa2Na/HmemGH3fvTISRFa60SjvIa8dL5OnWLuuxnn1BHxNpwQvmnj+J837xEDbCk3T0P8dvNEYqoeKPrBzX4+FrWq4hL8BLxPMw3Thk12i9eve95D391kiI2T09y0XswayE=
Received: from DS7PR03CA0112.namprd03.prod.outlook.com (2603:10b6:5:3b7::27)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 23:28:20 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::5) by DS7PR03CA0112.outlook.office365.com
 (2603:10b6:5:3b7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:28:20 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:28:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 08/11] drm/amd/display: Avoid a NULL pointer dereference
Date: Wed, 13 Aug 2025 17:18:16 -0600
Message-ID: <20250813232532.2661638-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: eef7e4f2-fe8e-4824-7632-08dddac116b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thc2O3rZSxPOLdVGMSkJzgGHWN9BkP3t8ec8liShQ5D9Onoc4VAlgEOWZdTO?=
 =?us-ascii?Q?EjS1c5+DES/XiMtM6p+U/zw8u+aF9/wDQhty+LDcrDb4CDgDGlkvyMfQktHU?=
 =?us-ascii?Q?GSl5U4sWmJAXF03exzhuVzU39LZtpanjRcd+/MpRUqqXxDcty8lJFiigPx19?=
 =?us-ascii?Q?meCyXoWU78Nz4hJc4KF6BsjLD/szUrUCOHIoEGP8DaQ/QUVknVa4ehqANV0t?=
 =?us-ascii?Q?WguFQK3JuleewIbFQnO4KnCSXDilflzMlmPWJVFzty4LYSk6soIALRATdUIx?=
 =?us-ascii?Q?yVHt0OjNKoEXxsm71EvlQK+v7it/oXZYBwTxET/ITKW/daL86kNXNAIaSDBp?=
 =?us-ascii?Q?LxJSeMt9f2bZ3amwZ6XNokUSr2Ejbl2cL80XM70iWLvBmdX2lOPCpI3NcQfm?=
 =?us-ascii?Q?IdtmUblR4cZT0IGaN1zmPv3P0KRfNjXOIn+sg/cprTAqOURgNL+Oo3k3AhgK?=
 =?us-ascii?Q?ARZJc/Ejg3sY/IEghB22U85kiDzuuRWJh7yRmbRlE1hiVDC1LckI2KymGQpf?=
 =?us-ascii?Q?zweoH/nS2WmlZdDCbN5Ai/eK7lebRUEUoPM2s5cgA0nFs9oqfd+7kgbUr0cM?=
 =?us-ascii?Q?pONJwxB4N4yuQ85jsazNAJRZY1J+ff9wzY2nEreA72eljLU82GozfUi0z4Le?=
 =?us-ascii?Q?UCGDc4mhO6yyQQEWBLr+3PLlk2rJNzcTlQz7V7YkKY0K76YjnFbkeHxyIhyK?=
 =?us-ascii?Q?3VXJtCNSnetExJvLCaki7vg7h3PUyDWtybuU3GmSQ7kvLK1vOxrc8B/heIdN?=
 =?us-ascii?Q?1fv9afBbpqhLO8qRfJqi6Um6XvJMKAYjzGY+S82PwIYUP1r1CQfeuede6rXj?=
 =?us-ascii?Q?z1DJd0IwAy5YuBLHOylCyfHgU9/pjAEQeR/6dwwu534eNmOWy2I+zdKj/Rwr?=
 =?us-ascii?Q?xU/MyIqXvlQGdE9jHam9mIkSvD5Rvbu6lk1vMttiQmRl5bvg1w/TNN9OIy2l?=
 =?us-ascii?Q?wwh8n12p4bOqEfVhjJ+0/iPVcgpTsVWbvlq/WbKI/yijP08E0QDrFYkMQOFk?=
 =?us-ascii?Q?p3Jg7xh2/25WoX4XFi87nhet9EwPDQFoq/lCfUgj1G8u/Y44kg+668Y2pi8N?=
 =?us-ascii?Q?EZJivK/rrjLOEyILnDYljLYvLzXHA744bW1aJVc/g8HgChIO4q4yiv5bQ1Zd?=
 =?us-ascii?Q?wms+iuMPlc30Bj/hQ7cWbZ3hgQ7miCJWhG6fjZjaj2UXYVjRnlvRK5Y1q79r?=
 =?us-ascii?Q?Z4q3mNeP9JNrJcp0LBKd//v+6lg+WQGRV21fDXDS8AmgaI61luQ1uO2E8YG9?=
 =?us-ascii?Q?3ftKdgdhdj1AqUZ1uWNmzD/qjmATMlZVzsXcQXOvgxGZ4Ap2NfESK6YOXlb2?=
 =?us-ascii?Q?/aWff525JajXZo2YcAoQ6IM3JEdGqdWx423upbfrJ1XQxsUYUbCugW4vcO/Z?=
 =?us-ascii?Q?DZfYMPDSg5zMxMnJSTwySijGOtgbuPWsgX6lj12orXX5vjizAk9D/T2YsKg8?=
 =?us-ascii?Q?u3e/iwVARo2tKqYAt++xZ6Uiekg81sT2yL4BEesl2EWfX1r8NJW4k+KhuPBn?=
 =?us-ascii?Q?uNxm/ruDMS+sFOrniZ/IjqZWY+Qb4diZiKWA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:28:20.0006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef7e4f2-fe8e-4824-7632-08dddac116b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
Although unlikely drm_atomic_get_new_connector_state() or
drm_atomic_get_old_connector_state() can return NULL.

[HOW]
Check returns before dereference.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 176f420effd9..b944abea306d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7836,6 +7836,9 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
+	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
+		return -EINVAL;
+
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
 	if (conn->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
-- 
2.43.0


