Return-Path: <stable+bounces-60478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809929342AF
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41181C213F6
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB1180A94;
	Wed, 17 Jul 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kEWG95cY"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AE28DD1
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245165; cv=fail; b=q73psR6hQ1EKgKlDfmaztMOjdOYIQBQV4AywZFf0HglsTzlm7bDAVCeA2jcfu6hSiQ8cjxHfNPRXwWcOK3RAtrmegpcB0g/hCof+3brYAaWXtAqyKD/T0PXTQdfE8ysoILrAOvas6BPzKi6X2hGTyNOKYdSm2OLi0e2Q8EguQyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245165; c=relaxed/simple;
	bh=cnz1k4NvHo/JzNe8ZB3/rGhkspafcV6kA8JezkWzJzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwX/5VqiREZZrMZGl412Ut2Ye7I7QCPbJhJAtfjIdqE08yzV7OSD+HrGPdFEPJrlu4OQ9XU5mUSI0s5RXpSNOIMm6R9F0WRjwaucTzBdgXttef/Z9pkY/LSbChJNx9dIhKn7Gzqs2IBaQKJxINBHWC6oycwlxE70dCKR0i2wWmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kEWG95cY; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djg8fzxOWkZaXfnykGnYYtusxiKP1uRctb6sDM+jjKSckaFKVjR7/5Gk/52Vg9eKzG5zNzRxzDA15DInVgShFqG0AGkv1XBsOqiNKJN2jm6FJgUmJ4fg1gttjhYAs4iai27YrXMwqOw9D5/wi6VlAoV9dZMO2UYYzeEdgaFbUyVVyzW5ZfPk1QNkdl2F+tQUgKwoz9St8DYBYgGAGM5TtTOLtdMnwot3JIrtgAiLfWReXy2eBQxjFhQOJIOu0NyUrcz3I00oz2dNhGPDC2b18H7uk/wbfqNWH0xAmfLzxv/bQ1WJCTOfQPsW77Nir+r2DmWHVWN9FEKi3ZZGGTy7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pLdGHxUrVViUY75nzvAQW6JGAszVeBQDJM1VfwbijY=;
 b=WcnS8rtjRgzXA3PhKTcyiXw5B5bhPCT9LxkAq0XhGJSgNZgeAqadBFVDK+cNXLADQwQY+H88Qr/G1zpgdkGdhWCbubLxksoMg4Vjj7rQ1DkhsupyE/gbuTTiXj0rSFKaTLF71/APNkjpTJ23LCt/kQWoKeznfbXk1Wvbr269Gb0eWqvndY73MkRkqJVGJoO94yQuhFhRx0jQ/Q7etFPBdnqOjP20jVBIp5rBybyFlEQrNauxmjbBkZRJEHu9aM/iRHngyPVm7O1gcaR3z1loL/eu6wUI75uWYktDuj0mfso6CJ0+3KlLtLDaEGrwavBId8mdX/qSEI9EPXtCciCASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pLdGHxUrVViUY75nzvAQW6JGAszVeBQDJM1VfwbijY=;
 b=kEWG95cYzxs4j+NR0FymyfPUPKxYH7woVNfWI6MWi2WPwO1qzmfZ6T6bfZVGrO4t+CBGVWgECf39hVovhwaTdQTBQX62Vgl9uHnRBE5W40EtWYv1TvFl2CV9vbzg7Z+jetd7j+d+dTKuWhdOUZ3fCT7EHotuf9+/QIX8ENkhYbk=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 17 Jul 2024 19:39:20 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::c3) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:19 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sung Joon Kim
	<sungjoon.kim@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Xi Liu
	<xi.liu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Check for NULL pointer
Date: Wed, 17 Jul 2024 19:38:41 +0000
Message-ID: <20240717193901.8821-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b45a71-c57b-477d-80d4-08dca6982711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Ov2arKWY5lZ3to+wmMa0MxiFTGzsS1nQ9PqypaaQ3mI5UtroV8ziJBJx82h?=
 =?us-ascii?Q?dhJ9HXw10RUeFTu5g6otY645h7OUS7Uh3Lr54Cuzyvo8q10jGs+P9AmQjOAc?=
 =?us-ascii?Q?5wXM48W4Jq6xQCDah5cvnf+C9B0orbbkicZc1h8Kxz9zEZf55T/6QdzB8OJI?=
 =?us-ascii?Q?GD84NdK9bBxt+B/+mr60psApDIwLZiKxQju8XuYzeC4oRm3pPAsXCDvyvMS3?=
 =?us-ascii?Q?eFJyNZWepf6adG45NlEfkFub7nTePkaYPqaPGy649sCZQpTMenWISxnhebx0?=
 =?us-ascii?Q?PxFm0hzFcqP5L1YC2sDeyV9AmQHTPr7S/PPKs2PaniyTW/Ie5dXHS7Hwy36d?=
 =?us-ascii?Q?R0HJwWrGw9ruwn4soXO7HjcTfiAAtS8DplUOk9A4txHtgBosGHinQox0hfZ2?=
 =?us-ascii?Q?WEW/4W5ju+A+eQ7j0e0fwgpf3S53jicHyV7ye1gaWP20ab7zJjYQi/BghPbn?=
 =?us-ascii?Q?F3eh2GQeFsfB4BlRSwv70zXqQ4zqQSFmhl3RiZvHu2z8UengNt3vAZihUGbR?=
 =?us-ascii?Q?k5Npsu3ZK3TvF/v3tLbSFirwb/7GiUoGhsaxiMKpjTgaOYiiEw04lI2BwreA?=
 =?us-ascii?Q?THGVR5cAVAz3um+pWAbdeoYRmLas0CPaqfu+glO2J0Zc/tY7ntmCRWJxvD/W?=
 =?us-ascii?Q?aQFw7srCGix8/PCCJ5SEyOK4ZXv0un4P7GjQEC4H/uhyZUamsgnbiOsogqWB?=
 =?us-ascii?Q?f7qPedA92woV1VGK6zANppnFVYU+9K5gEFobllgdjkZHHoVzUzEJsqyPM3wG?=
 =?us-ascii?Q?RbR1rsO3XuM0j4bX2p1XKyw+JJCGzQCd32L6B2OpA0VvopfI1eLKIk7DbE7e?=
 =?us-ascii?Q?AGurHcAfLu5AXpxoc9SsDvigKkjqyJ4jRV3GH7I3k4OXQRQUrMb+Lszj9zbH?=
 =?us-ascii?Q?QQ1USFsr5L+z6a/0QYTHMgEyO8f4ojnQNnI6dnVMIUALGdJU0zq1ltNG2LpS?=
 =?us-ascii?Q?uuiGF0DE98uG5wljgvRzWVCGQXaW4nNf+aGZDayor+lFz5RJY1jT3GVkyO5J?=
 =?us-ascii?Q?W41TyR+1KqIZTF/o2n0SG6TBF9J2mJVbeLGXr4fYwqigDwBNKT7gaSTk2cRp?=
 =?us-ascii?Q?S0HoDpOywJOHWx3TXU0P/bU3/CyxXb2nn5wPjV/9VVufCRTIb7k8Q67niMJD?=
 =?us-ascii?Q?uKAZzeafuHMLEJMXUPYUJzw7jxyVeR41+LGGW1WfkcgTXmtJD/Q7DJ/DLa47?=
 =?us-ascii?Q?IsTnwHL7iI11BBCxDhmW2ycqKxA1JRVYW0wyiWE/UTnOMRV79DyqHTxFGo0U?=
 =?us-ascii?Q?0qaklEAHN2+eVoAXEH/ARv7emAKAl0MuIVFGv9AbmPlZ/ih4mvmWW2bQHx4m?=
 =?us-ascii?Q?mhXE7qFLUMcuGOEbAhLEaWwTnvThks34pJtyMBtgTBJrsFjGMoi31BgxdKPI?=
 =?us-ascii?Q?eQAhZ87XCYmcQhQ2NJTcy5IXoYqVKXtuwocZF78Eyobl7F7vW/wm6DAh5+1e?=
 =?us-ascii?Q?0IbROPtKXGa6Jozi6MUGWWe8ItDn3Xo7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:19.9372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b45a71-c57b-477d-80d4-08dca6982711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
Need to make sure plane_state is initialized
before accessing its members.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Xi (Alex) Liu <xi.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 067f6555cfdf..ccbb15f1638c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -143,7 +143,8 @@ const struct dc_plane_status *dc_plane_get_status(
 		if (pipe_ctx->plane_state != plane_state)
 			continue;
 
-		pipe_ctx->plane_state->status.is_flip_pending = false;
+		if (pipe_ctx->plane_state)
+			pipe_ctx->plane_state->status.is_flip_pending = false;
 
 		break;
 	}
-- 
2.39.2


