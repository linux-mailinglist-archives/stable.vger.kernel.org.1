Return-Path: <stable+bounces-132756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8BA8A25B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DD63BF996
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B829A3E9;
	Tue, 15 Apr 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GlKYfoVJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5E2BEC51
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729192; cv=fail; b=LrQuR1D1a4E+EVOyd5w5Sc7UUQuKp012RbPqbhrIh++CPJfas7BkaofyZpJ6aUdJ7YMndl9M3kQyS3q9csuPzbwZEk+nW8Iy6KKrQYqYUglTl8gyN6YKKhCa/HRwmoO2kNoqxLnYguHSKssODh9wEWMktGILftY9x5bEKd+TJxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729192; c=relaxed/simple;
	bh=QDmaJ1HzpSlNnftQl5brWnXx4q2adoGKRH8X/Jy8zNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b77SnJ15sylXPFxCZV0mMco3PGnImXsdVRE3sbcr5ebi/vnCRRN53aRS3G64RfYH3furcpHztMjJ60NA9Cg+YAh5ZdxVyNIoJ7+JtWErLUUs6JChFp7gX8TzNAQ5zsoRIvTxLocx/TtaUh7Q7eQ9s5zwN6gn9OoWiwLwHv3hkck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GlKYfoVJ; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBhZCYpJRQGa9Xwkt+OcO7rKyndWWaTckpiv13HhIBG4U+JK/B4lnFi55lP9kREDH2k4roOpJR5ehsFJ0FJ0DRRWIO0BSekNQs48C/SFiyabTR0zyn1X4yQ9Eofh65yEHDwLnHJA1QiTnzCF5pdHQ4but2QxZRIDM+F21GFh/Wk/GeTdUl8fZW01f5s80wN5GC9hPxd9d09pLTKHdZxCC5PX6zyb0Bb1BFxfz/rVoAF4HjxLfxbLol6ifdWi5jOxk+3m8Zy5yjckJuU0J3bD5KJjLB8pDPO8SwCLO1tSsVXBuw3yPew82fsQgJIx+1CaKn/NSW0f40wcvUeajmfuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/xZ3Jm5Qhzs1lRjm76lJGEB6XyewX15AbybibjjXGc=;
 b=rUnNAl3s6H2pdXg+GqPlwrfaUO8NqTQiNHZNq+qmJeTD64Ps20iJvsaafOP3DUc3AUmmm7FuRqjUzQGHIZpZbxpKp8aJrUoMPE1V7l6AzMzud+oeYItspekbddCZuTArpl9L+/ztNRBvgX84eX0FfuPxNJeof8DjIMmILdhMZKovrHA5noQYi4Z2YfLYJNNhjVsXwM/QQCzr50GphRxjI6M7Bg38iOaZ0n9SjfZwJVohcFsqvTZch6M4YlPUviSCHqKcZLFp2O9pcEPxVuw/lj9n6f3/Z4jYq32q3ysM7OYQ2g+dj4MP5HvpHAzlZToq3aHuPpcNMDZrQOdWCrufZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/xZ3Jm5Qhzs1lRjm76lJGEB6XyewX15AbybibjjXGc=;
 b=GlKYfoVJylIhiLomPTRMLidSNR7P4IOtkb5QDQcEHbwAvMz4zbnNSG4Te8Jzx6cjSy5cJi8A9nIyQFlERt4Gqw0o8vufVB/GiFLdsYgU5lfQFhPi/tpqFaIQn29XxLcY8rFIhfumZUKzoqwHohtVEEXDUPdTZ8AyP3yH4cbcf2E=
Received: from PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::11)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:59:44 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::38) by PH8P221CA0050.outlook.office365.com
 (2603:10b6:510:346::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:41 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
	<Roman.Li@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Force full update in gpu reset
Date: Tue, 15 Apr 2025 10:58:53 -0400
Message-ID: <20250415145908.3790253-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: d249bb14-d006-41c1-5d37-08dd7c2e27ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8oGxK2YRHBpqVluII6lhoh/+MszKWo6xTmTWw7Z6A/hemfEiUFdr3S06bYMc?=
 =?us-ascii?Q?N4OgIjksWPsF/udjm/RLn63I+CRpWkOEVw+MAAJlXH+1m8dDpO6zZebRZ8kp?=
 =?us-ascii?Q?QAkiwSdPEbyaCWSpPsQWapUt/iIMvD9BcEzEeFs1HguYArAB5hlUJZgHNhg1?=
 =?us-ascii?Q?8DcSgbgdIWk28draYYZ1LYjMeSU3KM1B2pWkC2as/Ts3vJ2WfOTRc1cshHUD?=
 =?us-ascii?Q?w7e1i52acVk42is8SLr38TNKzctZ/Svv/2fRzh/oWKsFaN0bM7AG/lBet3ND?=
 =?us-ascii?Q?5VK+14lK2O0g1X1uTeS/MqlyFHyDoBuPMU61pzmLi/tSd/QmzL6M1ErmAyob?=
 =?us-ascii?Q?XbmIX3te4WBAzjzlPvzxLOf69L4jYLM7JYcvWRe6MZxHWJLRozKABIRw9Li/?=
 =?us-ascii?Q?pXTo/zbAcrjsk/vnMsXKmdh/XLGM/c/9DhrLpVPoHN4kCAaTRPzqaaoyZoL8?=
 =?us-ascii?Q?mGetZUVEMIKWqpzaoMqwdAOByBUPB6tO6Rdf+om9umjf5N4Yb76kJxNWb/9s?=
 =?us-ascii?Q?XCVoPf8OPCvFPe/dTCogHo5YIARTb3JLeR2YRNzW/rXGzV6MroK/YXFGaM49?=
 =?us-ascii?Q?mzyYUwaJipZn/RnkplXRoYa+8KA0/Wc3krsiiITDHt/kcLkEsF9YHa8cSa+N?=
 =?us-ascii?Q?TeBrXtVt2xTz0WC4Wv8jqnY1zmX0tICj8rj0CsCq/V4x5puODznkOyfXaC4w?=
 =?us-ascii?Q?Ni6wOPwNZisIy45qazEP/79NxVNf8tLEcWK66S714pK2BEUpS1M18ZjS2A96?=
 =?us-ascii?Q?u9iRHSHgYwzAs+g9emoN6mWJio2ckIGcH7w2zlVU2UYFiH663CdQQOtAsxkI?=
 =?us-ascii?Q?CwcXWWeOKMgIst3FqxT9JV1jjruG7ESbbRKU+VzvVj9hnMLWxVv7YpzfvBNH?=
 =?us-ascii?Q?674X7Ab444XMBgeisLRsCygDK+LZjxCJ0ENb0eam5aA9wZHXQrnGIb8trJMY?=
 =?us-ascii?Q?IiDeXT8ugxz1FNkpjhscHmX6xh0zOA+TkoSiyxmtxuxDLuGHQ6syvWlng8De?=
 =?us-ascii?Q?oc6B3n99clu4mAAZIl0zV5IY3INFbQ3LpE3H82tLprpVhjkEk0rn2WFOFivy?=
 =?us-ascii?Q?HlM9TmOBNykNJywDCaEJNoGdlgHvOC3F+TLTYiSi0aEXfP3W4O/yjEYqCVPX?=
 =?us-ascii?Q?TVAc+riieTAlgjdpsKFcBJ3zwh4ugi1p0Jjz31a1QUDfoVRXcgDWDFlTPxah?=
 =?us-ascii?Q?p5paKwr+Z38yNIvU5oi0gSpFDsDiERpoW+ImMbhdhLwkT+pNaanEOOExye9S?=
 =?us-ascii?Q?Fl10Rwx/gLUMFwYZ3PqSD0shLLw5W/y3j3cE78kKWCs4HNLhIxN0/TRWSMkc?=
 =?us-ascii?Q?OnfJabv5xPhyY8TfKLd8ESS2YbDZyC8jjxjoKja1Y0Y0vP4Lr8T41JxjoKZg?=
 =?us-ascii?Q?SX5eAwJrMIBM4QHtgTWe5BMJl5UEPuIVx+DQE2liH1prsNT0XPFw/Oqe9o+c?=
 =?us-ascii?Q?IZIDLAE9/1ucGKdbaaRb/9wUzOvrcquOTcrebJrzMG/EE1UQGbjnV2hoI3P9?=
 =?us-ascii?Q?vr12J0V1hgqQaNJSmjTcOfLsPJpiBB6hiTPp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:43.1866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d249bb14-d006-41c1-5d37-08dd7c2e27ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

From: Roman Li <Roman.Li@amd.com>

[Why]
While system undergoing gpu reset always do full update
to sync the dc state before and after reset.

[How]
Return true in should_reset_plane() if gpu reset detected

Cc: <stable@vger.kernel.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dace1e42f412..46e0de6cc277 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11122,6 +11122,9 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	    state->allow_modeset)
 		return true;
 
+	if (amdgpu_in_reset(adev) && state->allow_modeset)
+		return true;
+
 	/* Exit early if we know that we're adding or removing the plane. */
 	if (old_plane_state->crtc != new_plane_state->crtc)
 		return true;
-- 
2.34.1


