Return-Path: <stable+bounces-40385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81B8AD0D9
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C1328C430
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5A15359F;
	Mon, 22 Apr 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MmA3450g"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E5153579
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799847; cv=fail; b=nytLJ67Nh9uMGYuZzlTaMcq8j49fF7viNkcVYjxGH+bD5uTTtDf/Ak43A/lv2pNRkBqNSnqmhT7BLlCWdhUK5lynOg6iiL6ZJAPuu4nL7DlYAKHquK8L4QktGeRkClSFgF/0HkDJ2tB+68Bw+QG7yHfwMWAfaNcX4lKIa++1Rtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799847; c=relaxed/simple;
	bh=oSZKoqCJw+F1OZF6GYgf73cqAVWbQTL2LqCPp9tYXDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drhhT0wn/qzH8JFyjdSmAIMtK7g7LcoicYfg1oxqgfNjCtE35S9wuJABWHEZ0V+KZl8TdzhgxwSXnwY9f190b20AM+TWI2Tt8kiEjDhvuuXVbOBcSWtvz68RWuXHbAMQlBE9cS1J8/TFrQfGuuzRVpB/bB6LQkMPQohKbx5mhgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MmA3450g; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCf7mcTq8qRZofzZToIFtX79e0jJJPfd4TtDVXLASMF/7jzFYIQKGd2Kg+UmeujHT9BDx9tBD5qUqHDda+mVJAGpcMVYWtDBEL3ciuosXUMGBIKWM/2jWfQXtqIDq7xQgrz09FT4OAWiwEHuWfaumllnl7NgubEJwy4+o7mR4rUAIa5qlMo3/0a+NBsKrhf+Y6AiEAT0XTJL/FjkIulAR5CnIsysh1BMJuFykON3EV6YBcfKcqItzH8uuid9lP63Un3zGknb98OAbRWjsZpsy4J8wUESHbSGjfZJdh9ksHqib3e1nDRStnJNSah0r6ziaW4ZtG7OAZfWxXH98MwuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyFCnMguKY6MVcsJEKaR7UFSZWs/3Idsj8OOJi0HVQw=;
 b=niHrVTvNeGkjoRa/HlSBf9h9z0Wn3cXf7je6spzbJUCvyz75ZtjfYySWS5w2+Icj5KpCL4QhlOQLB5riCa8wJvbFQ158ltcbCgSOafSMqflS/lqYYjIQp+/VZKlS3GN6DH1DUPKZ/TGTGCZQKtMsvIb/rLi2fI4ebxHZf5nfGlS3jgRDGs2l19FBet2RD/lXaR/LFq9bk/A6P+VUJi41yp5bAleqxpW7Drl2IhzHdlgBZ2T3ThiVvQOjaozPZgq7n8aUoMxOTwA1B67RNCUltvCTCJKrnchbSddcR1e0YKSfGvWLBQ1jikjQ60jx8EiAj4z2oRDTluyIR8UIvbBWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyFCnMguKY6MVcsJEKaR7UFSZWs/3Idsj8OOJi0HVQw=;
 b=MmA3450gPR04tDFeOv1bfRwBye4KZpfVYXzKkhiypvMdSmfjRZxuFDVsFUu0eS8ArgX++f8CByO8K25O/xUZP6hCxRyVVyiypYGeUXuL5qRngzAygkLBJ9z4VltoZh4yFDwu+7PtZQjfxEEh4QDL6skNqCf1aLNCp2nWMG4kDs0=
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:42 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::52) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:41 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, <stable@vger.kernel.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>
Subject: [PATCH 25/37] drm/amd/display: Fix incorrect DSC instance for MST
Date: Mon, 22 Apr 2024 11:27:34 -0400
Message-ID: <20240422152817.2765349-26-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: a4eb2538-aef2-474a-e128-08dc62e12bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3OuesRktiRqWxU5vWotKT33NmyrduUwV3HNpshswwvtWVMW4T7z8nFFskJio?=
 =?us-ascii?Q?e3DT1xrPYjgAeLS+wAFep0jFI9tngLdBlUwkGa9+QkJI4egtntCknyuxjA/q?=
 =?us-ascii?Q?KKUw2xq3/n21rBjUnvAxFkUDWZJt6QfFIVTQmHDi0eMEAkjVnEn+hVf9v/mZ?=
 =?us-ascii?Q?b3mhh+j1e8d6YL8j4JXMBnDoCIawuArwxAKki+d9QUySvyd77biJ7DsreMiu?=
 =?us-ascii?Q?9SJY1QkEttNp0yQFXeQ7qIhr51/7/qJD0iYFhvzHo1j5K6WSvZGtuMYec83h?=
 =?us-ascii?Q?4ekrqzU31ouXP6j5bt9vgXwja04+qWRlr81OuQM+DpzSOUQi4oA/P7oubr3R?=
 =?us-ascii?Q?nLQdtUfbbcnSdwTnmHTt4BnvgT3C+OI/pFNVNXhKMLjUz231H9I7NPkEHGWm?=
 =?us-ascii?Q?slWZna70KDKtT+He2o3j5O9zqq6GuAkOFUSy9ndAs1/RD/VEQG/sOFatwHdh?=
 =?us-ascii?Q?c3RAdoeO/ag67qSgydYNIOr6NtZ52eUVEZ9EMm6Z5dYvnyuSLWAT4Ks+ud3l?=
 =?us-ascii?Q?rd1WwUfO+WPUsx8+kFSPRaFrHLrS72pRbZB6en30y9Pi6kp4UwAtSW3Vbo0R?=
 =?us-ascii?Q?35fS9/+5/3cd4sAOiRz9640GB9FkcgOY5WhacXGBMeeE2aaX+DS4cA7Egp0M?=
 =?us-ascii?Q?CNbsUB7cCpwRi8rB1xVYYUM3r4N3XfRUVuf6xwZB4zwXxapyDjlNrrFrP6Xx?=
 =?us-ascii?Q?PUget1k4NGjjsNSHtF76vlN/mYUYb39Bjz2FwohG2WA1CYflzCYON4boPPLl?=
 =?us-ascii?Q?ktEXhygchHZ+c3lulOEXORWokwtmv2NHPAb13DVU+mJAgIPjB6CSxct6jAFS?=
 =?us-ascii?Q?WQfniy6li+wx86Z0W2vWn+zSfI5oV6VhH5+AAdtvjjBf8TJ5TQGKKDnSRv0t?=
 =?us-ascii?Q?29DQUAa44qMqmZLk/Xj6JQ6uXVh62RtkfmpQOjtGMmCFp5xqKhBg5hkZz/r4?=
 =?us-ascii?Q?eXezjywpTTVeO6ijqAP7+PKCG//xtqDwXPb0T3DLFIIlUt04QDTtVmBZTT5K?=
 =?us-ascii?Q?Cw//9sZQtW6ArdcnGlPDIgefo/qv7Gen6W9YADzg90bIBuwERBjXD+N74dIy?=
 =?us-ascii?Q?XuyWvN6sjsnVEfA4U86IEUlx6g5g0HEoKjNEFR9PlL3jHXbe6hRNrv+oHmbr?=
 =?us-ascii?Q?F7lLfPV8tpCSMCIyxiGtzebPPn22/2MHYrTQGuPKDkEc+DXsrmodzBDnH8i1?=
 =?us-ascii?Q?jBCSDHuWDF4cnrz7OuJ+AutJO6tHbo0K+VbaVGNj6+2gKDBrSj5ARtPt3INY?=
 =?us-ascii?Q?hOwIshUO3lGXto0QqUEI2uj3JLgZD6ibSYucJpMttJyQhEjY42hs+/EyHTQd?=
 =?us-ascii?Q?lKsq4Lv03DEInyBHSp6FLFatmKq4HFaB6dz+4q91/o+4HDhSwQWgRO8m7cxt?=
 =?us-ascii?Q?II2OkKMXkiK+D2W+bigyE2GtMKSv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:41.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eb2538-aef2-474a-e128-08dc62e12bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] DSC debugfs, such as dp_dsc_clock_en_read,
use aconnector->dc_link to find pipe_ctx for display.
Displays connected to MST hub share the same dc_link.
DSC instance is from pipe_ctx. This causes incorrect
DSC instance for display connected to MST hub.

[How] Add aconnector->sink check to find pipe_ctx.

CC: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 48 ++++++++++++++-----
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index eee4945653e2..c7715a17f388 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1495,7 +1495,9 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1596,7 +1598,9 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1681,7 +1685,9 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1780,7 +1786,9 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1865,7 +1873,9 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -1964,7 +1974,9 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2045,7 +2057,9 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2141,7 +2155,9 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2220,7 +2236,9 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2276,7 +2294,9 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2347,7 +2367,9 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
@@ -2418,7 +2440,9 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
-		    pipe_ctx->stream->link == aconnector->dc_link)
+		    pipe_ctx->stream->link == aconnector->dc_link &&
+		    pipe_ctx->stream->sink &&
+		    pipe_ctx->stream->sink == aconnector->dc_sink)
 			break;
 	}
 
-- 
2.44.0


