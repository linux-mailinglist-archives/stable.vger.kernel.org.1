Return-Path: <stable+bounces-85105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2299E0BC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81DB1C21A91
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A91CC143;
	Tue, 15 Oct 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3sVQWyUJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFF1CACDB
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980270; cv=fail; b=uM7bWf899A6Qh0ZijwZtz5dy2qxlk1nrShDZnOo8ZzJ5ln9DLLKff9Es4iVU2Pe3T3NPHUE+Yxhyp9gcpxIQCfT1uVKbHVJSeF3zbT5ChHSjw8W1agFLxhZzGgmET2Jc3o3qkfaKWUD78nZwbPDZt7jehf6Im7AgaOj3fzLUgJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980270; c=relaxed/simple;
	bh=GvjhVup8IQKljYvxUTw6lcvcpYceW8vTSahG9YsGUIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSzMW3b12Gg2lndsS24ATKGlrla/XrBFmkTibir+Kj384Fq4ptLSOIB5KO7lhNzwM7wJn9VpdPIAYu+pc+haX6ALpDspvYV+AGkkgyQJ0yzmtkblwlvJ25W5SSPUelfKwQxctVg4mGIUsCu4+fDA602lD5+iOedwWy4GtDC9lbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3sVQWyUJ; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewIworxzg9iHryVxFer7AJBV482QA0TXhYx8jxlQa8oYMu4rI+4MTXzfw3L+8wZVvRC6Uyhv6Aqne62JLQ8GsvTIhC0dasdgZS/z1NIdYmaODkbBwnfEjvqS0pFBxq7GjO8vlZPdyiud4Ug9+v90PDUr4gYAeP9GVabDxFexlhLp6KrxnPlmGoTQ0Qi6BIBuWKxOF8p8d160CUpid8XrEslxRjJdcrsTpoM7mdefYHLxWjoOwoLo+uMBh0SP6fbLkHnZLbpLUwlZm9caGQXLB5Nj1oYrqonHsDCYYj1qGCnmK/9mIei1+Xk13WOB0OH48dxUdpz4+A3/57p8vTSY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kzg8otwXnHAPQUE4dT7hQJar7X2HuD2lsxRdOCL+ve4=;
 b=FEIYLkPJbHvIYKH8px3R6jfuqjXObpoobaJPOQsAUEwSZ6boD/vsQ1f78/BSOKa8eMuoxGz1uRCQKnS+/rnsXh0yIEFKS+7Zcgye0BnXzRq3N4OooyarplQx1kA9seuMVPcxys1A4+OaNYulnp20H5eAyFgAQAuh8XgGYwGh/Bm9PyJR8adNy4p00PE/sGZQA/tUrNbIt1JKgwP7HT5JnjE1iA/KbdT6qjQgncQjieDKoyZG34KrZr3HkmuUyyCVaMXd29+l7Fu4BFZW7e5Nzykx3TfWyyLLXkeEH7qwxJV7gdH4K3xU/A8bk6Ul1UyWWpgRNb0JMWVpE+YI/KZxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzg8otwXnHAPQUE4dT7hQJar7X2HuD2lsxRdOCL+ve4=;
 b=3sVQWyUJT4vlQIhknHUbZWg0BrxAxZFEm32OrW182H+TbIkeuD3q1moOJeZi7Qa+reNDyiO0M44MvWEZ5QbbcR36wyNjYSqTaIwCvW2MhwvCuQUDyBGR5+/DhTn2XemRXs1ZCuAAM1yjh86VNVo/9kazjEIpQyPCHAwp8U8zsks=
Received: from PH0PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:e::23)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 08:17:45 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::1b) by PH0PR07CA0048.outlook.office365.com
 (2603:10b6:510:e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 08:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:17:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:43 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:17:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Alex Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle optimizations
Date: Tue, 15 Oct 2024 16:17:04 +0800
Message-ID: <20241015081713.3042665-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 377baf7a-541b-4268-3035-08dcecf1d8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oR4/IKhwjQjNmuTxYhNSE6Pc74nCsbOliox8ZF+91Crd6WmcTGMwTJWeiJT9?=
 =?us-ascii?Q?AJiOdMrKNXjrs+UAZYIQol1BEuex+++Q3UWMk000OzEfoyjU/2tio1GghZ56?=
 =?us-ascii?Q?EtK7TqwItJ8wQLmLLTtn8QdHLfzNGOG0Ru+n+D2/avmfYwWviJEP/vPS7FlS?=
 =?us-ascii?Q?R265uxxsfogVZDy1dwxX80aslijz02HG6YIeKym9LGt3/DdXKEuiP5qfxlw/?=
 =?us-ascii?Q?1TFfBccy1kU2E999UVT8y2eQoa+tc8zMif4SomZiU/WCYIGExHuZs4QJEZVc?=
 =?us-ascii?Q?0ynmetUTSHZShVqPoDHFeYpg+uo45grse0jJY5/lvEiPGF5AL97n9ATek+p6?=
 =?us-ascii?Q?Y2QjjHtItQTkkSUt3IozlNTfX3aL/ZpHi5ZYQc9spFNSSprDCDYT9NVYO70s?=
 =?us-ascii?Q?8iL//R1xv8VmnpSLOJmKxfWxtgz5ahoW1T3XnuAmIusYfmLfrg4aaKdU+7tU?=
 =?us-ascii?Q?arFElAsNzgVcpCaeV3LwVf4ilVExuTCgC7MJ5XzVN9rvP3OIS5Ijo10j4/gh?=
 =?us-ascii?Q?vSc6mZVkHbM0XXf6sOWupjDcH60vqv06JZ/2wDu+U72lMALcxtam7VVa72zq?=
 =?us-ascii?Q?on726DFwMA6JJ6eq5gKQJfVzVQ/46LEbUv/WSNj4/ayxo2Ukv1lHtL32CIQD?=
 =?us-ascii?Q?C6VIp09omCi4BTdYrB5f4WRvQrdCJdG1b6FoXQ7AYhNsuwpkc/Nv5IiF8Sj2?=
 =?us-ascii?Q?Leu5cvGuvR+VHOjoz1aGycui4W6U5lKjhiGtr48522lRRkyq3myqAlIMSr9N?=
 =?us-ascii?Q?UTM3myVFjEg7B6+ZBAhij5TkM03tMNqpaAdv81VAjbow1dfAqCP2jw4NOEr4?=
 =?us-ascii?Q?xWauGWD0n7d/K9HBGFAdzDNa0Fyv6Y+IQAvOKKfwFR8miOprQ1UlOgXwTGdU?=
 =?us-ascii?Q?fGjFeRg7/i/e0ic8uYC3+du36+9xTvWi1DD09qyHL59MYzzqk+ukK3eGx/EQ?=
 =?us-ascii?Q?AqaziK4J2lnXe06C3NMXAOYiJDa+d5om5PFk6iXlkTgTqaGp9hwQEmJdrRqy?=
 =?us-ascii?Q?5WjaBeGqsoN3IexrY1FVLk2UBl27yUbdaO7TNysYd2tLNp6eiT5zemo7yoKZ?=
 =?us-ascii?Q?xoP0rlssjVftNkmiHF0SYir73fxRu4RPu5S1xaOwbklN8xoSrkUK9+oLcn08?=
 =?us-ascii?Q?pmO6Hno+LyZt5CFGtRzTSHqTaKOhMY1AwjpKV8t6AQKFMfrwfYQq2PRsYgXm?=
 =?us-ascii?Q?sPbcS8mX1fV63JyvSS2QEJc1f8r38g6Uu3D/IDgAbo+0AmhxBZqOlGsO1k2h?=
 =?us-ascii?Q?Io1RD5f54cGe7XwMZ1v+KNN4WlZZEQH5v3//zWPZyVBrMKbV9LtbKwf90WIv?=
 =?us-ascii?Q?4Wkgu38bdQNkO4v1e3ZLlGBiI8kNcz8E5+pMGuCmXDfWt96vJlWQA2fJyr1Q?=
 =?us-ascii?Q?GmryGjwdBTokUyikhza2LV1Emg0y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:17:44.7762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377baf7a-541b-4268-3035-08dcecf1d8de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
vblank immediate disable currently does not work for all asics. On
DCN401, the vblank interrupts never stop coming, and hence we never
get a chance to trigger idle optimizations.

Add a workaround to enable immediate disable only on APUs for now. This
adds a 2-frame delay for triggering idle optimization, which is a
negligible overhead.

Fixes: db11e20a1144 ("drm/amd/display: use a more lax vblank enable policy for older ASICs")
Fixes: 6dfb3a42a914 ("drm/amd/display: use a more lax vblank enable policy for DCN35+")

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a4882b16ace2..6ea54eb5d68d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8379,7 +8379,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
 		    IP_VERSION(3, 5, 0) ||
 		    acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED) {
+		    DC_PSR_VERSION_UNSUPPORTED ||
+		    !(adev->flags & AMD_IS_APU)) {
 			timing = &acrtc_state->stream->timing;
 
 			/* at least 2 frames */
-- 
2.37.3


